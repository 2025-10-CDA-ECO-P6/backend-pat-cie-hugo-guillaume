import prisma from '../prismaClient';
import type { Prisma } from '@prisma/client';

export const getAll = async () => {
  return await prisma.veterinaire.findMany({
    orderBy: { nom: 'asc' }
  });
};

export const getById = async (id: number) => {
  return await prisma.veterinaire.findUnique({
    where: { id }
  });
};

export const create = async (data: Prisma.VeterinaireCreateInput) => {
  return await prisma.veterinaire.create({ data });
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