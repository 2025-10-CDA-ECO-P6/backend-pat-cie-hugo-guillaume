import prisma from '../prismaClient';
import { Prisma } from '@prisma/client';

export const create = async (data: Prisma.VaccinCreateInput) => {
  return await prisma.vaccin.create({
    data
  });
};

export const getAll = async (page: number, limit: number, search?: string) => {
  const skip = (page - 1) * limit;

  const where: Prisma.VaccinWhereInput = search ? {
    OR: [
      { nom: { contains: search, mode: 'insensitive' } },
      { type: { contains: search, mode: 'insensitive' } },
      { description: { contains: search, mode: 'insensitive' } }
    ]
  } : {};

  const [data, total] = await Promise.all([
    prisma.vaccin.findMany({
      skip,
      take: limit,
      where,
      include: {
        _count: {
          select: { vaccinations: true }
        }
      },
      orderBy: { id: 'desc' }
    }),
    prisma.vaccin.count({ where })
  ]);

  return { 
    data, 
    total, 
    page, 
    limit, 
    totalPages: Math.ceil(total / limit) 
  };
};

export const getById = async (id: number) => {
  return await prisma.vaccin.findUnique({
    where: { id },
    include: {
      vaccinations: {
        take: 10,
        orderBy: { date_vaccination: 'desc' },
        include: {
          visite: {
            include: {
              animal: {
                select: {
                  id: true,
                  nom: true,
                  espece: true
                }
              }
            }
          }
        }
      },
      _count: {
        select: { vaccinations: true }
      }
    }
  });
};

export const update = async (id: number, data: Prisma.VaccinUpdateInput) => {
  return await prisma.vaccin.update({
    where: { id },
    data
  });
};

export const remove = async (id: number) => {
  return await prisma.vaccin.delete({
    where: { id }
  });
};