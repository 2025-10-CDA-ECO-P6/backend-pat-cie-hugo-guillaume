import prisma from '../prismaClient';
import { Prisma } from '@prisma/client';

/**
 * Crée un nouveau traitement dans le référentiel
 */
export const create = async (data: Prisma.TraitementCreateInput) => {
  return await prisma.traitement.create({
    data
  });
};

export const getAll = async (page: number, limit: number, search?: string) => {
  const skip = (page - 1) * limit;
  const where: Prisma.TraitementWhereInput = search ? {
    OR: [
      { nom: { contains: search, mode: 'insensitive' } },
      { dosage: { contains: search, mode: 'insensitive' } },
      { frequence: { contains: search, mode: 'insensitive' } }
    ]
  } : {};

  const [data, total] = await Promise.all([
    prisma.traitement.findMany({
      skip,
      take: limit,
      where,
      include: {
        _count: {
          select: { prescriptions: true }
        }
      },
      orderBy: { id: 'desc' }
    }),
    prisma.traitement.count({ where })
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
  return await prisma.traitement.findUnique({
    where: { id },
    include: {
      prescriptions: {
        take: 10,
        orderBy: { date_debut: 'desc' },
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
        select: { prescriptions: true }
      }
    }
  });
};

export const update = async (id: number, data: Prisma.TraitementUpdateInput) => {
  return await prisma.traitement.update({
    where: { id },
    data
  });
};

export const remove = async (id: number) => {
  return await prisma.traitement.delete({
    where: { id }
  });
};