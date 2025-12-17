import prisma from '../prismaClient';
import type { Prisma } from '@prisma/client';

export const create = async (data: Prisma.VisiteCreateInput) => {
  return await prisma.visite.create({
    data,
    include: {
      animal: true,
      veterinaire: true
    }
  });
};

export const getById = async (id: number) => {
  return await prisma.visite.findUnique({
    where: { id },
    include: {
      animal: true,
      veterinaire: true,
      vaccinations: { include: { vaccin: true } }, 
      prescriptions: { include: { traitement: true } } 
    }
  });
};

export const getHistoryByAnimalId = async (animalId: number) => {
  return await prisma.visite.findMany({
    where: { animalId },
    orderBy: { date_visite: 'desc' }, 
    include: {
      veterinaire: true, 
      vaccinations: { include: { vaccin: true } },
      prescriptions: { include: { traitement: true } }
    }
  });
};