import prisma from '../prismaClient';
import { Prisma } from '@prisma/client';


export const create = async (data: Prisma.AnimalCreateInput) => {
  return await prisma.animal.create({
    data,
    include: { proprietaire: true } 
  });
};

export const getAll = async (page: number, limit: number, search?: string) => {
  const skip = (page - 1) * limit;
  
  const where: Prisma.AnimalWhereInput = search ? {
    OR: [
      { nom: { contains: search, mode: 'insensitive' } },
      { espece: { contains: search, mode: 'insensitive' } }
    ]
  } : {};

  const [data, total] = await Promise.all([
    prisma.animal.findMany({
      skip,
      take: limit,
      where,
      include: { proprietaire: true },
      orderBy: { id: 'desc' }
    }),
    prisma.animal.count({ where })
  ]);

  return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
};

export const getById = async (id: number) => {
  return await prisma.animal.findUnique({
    where: { id },
    include: { proprietaire: true, visites: true } 
  });
};

export const update = async (id: number, data: Prisma.AnimalUpdateInput) => {
  return await prisma.animal.update({
    where: { id },
    data,
    include: { proprietaire: true }
  });
};

export const remove = async (id: number) => {
  return await prisma.animal.delete({
    where: { id }
  });
};