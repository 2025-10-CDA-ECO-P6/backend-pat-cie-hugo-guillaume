import prisma from '../prismaClient';
import { Prisma } from '@prisma/client';

export const create = async (data: Prisma.VeterinaireCreateInput) => {
  return await prisma.veterinaire.create({
    data
  });
};

export const getAll = async (page: number, limit: number, search?: string) => {
  const skip = (page - 1) * limit;

  const where: Prisma.VeterinaireWhereInput = search ? {
    OR: [
      { nom: { contains: search, mode: 'insensitive' } },
      { prenom: { contains: search, mode: 'insensitive' } },
      { specialite: { contains: search, mode: 'insensitive' } },
      { email: { contains: search, mode: 'insensitive' } }
    ]
  } : {};

  const [data, total] = await Promise.all([
    prisma.veterinaire.findMany({
      skip,
      take: limit,
      where,
      include: {
        _count: {
          select: { visites: true }
        }
      },
      orderBy: { id: 'desc' }
    }),
    prisma.veterinaire.count({ where })
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
  return await prisma.veterinaire.findUnique({
    where: { id },
    include: {
      visites: {
        take: 10,
        orderBy: { date_visite: 'desc' },
        include: {
          animal: {
            select: {
              id: true,
              nom: true,
              espece: true
            }
          }
        }
      },
      _count: {
        select: { visites: true }
      }
    }
  });
};

export const update = async (id: number, data: Prisma.VeterinaireUpdateInput) => {
  return await prisma.veterinaire.update({
    where: { id },
    data
  });
};

export const remove = async (id: number) => {
  return await prisma.veterinaire.delete({
    where: { id }
  });
};