import prisma from '../prismaClient';
import { Prisma } from '@prisma/client';


export const create = async (data: Prisma.ProprietaireCreateInput) => {
  return await prisma.proprietaire.create({
    data,
    include: { animaux: true }
  });
};

export const getAll = async (page: number, limit: number, search?: string) => {
  const skip = (page - 1) * limit;
  

  const where: Prisma.ProprietaireWhereInput = search ? {
    OR: [
      { nom: { contains: search, mode: 'insensitive' } },
      { prenom: { contains: search, mode: 'insensitive' } },
      { email: { contains: search, mode: 'insensitive' } }
    ]
  } : {};

  const [data, total] = await Promise.all([
    prisma.proprietaire.findMany({
      skip,
      take: limit,
      where,
      include: { 
        animaux: {
          select: {
            id: true,
            nom: true,
            espece: true
          }
        }
      },
      orderBy: { id: 'desc' }
    }),
    prisma.proprietaire.count({ where })
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
  return await prisma.proprietaire.findUnique({
    where: { id },
    include: { 
      animaux: {
        include: {
          visites: {
            take: 5,
            orderBy: { date_visite: 'desc' }
          }
        }
      }
    }
  });
};

export const update = async (id: number, data: Prisma.ProprietaireUpdateInput) => {
  return await prisma.proprietaire.update({
    where: { id },
    data,
    include: { animaux: true }
  });
};

export const remove = async (id: number) => {
  return await prisma.proprietaire.delete({
    where: { id }
  });
};