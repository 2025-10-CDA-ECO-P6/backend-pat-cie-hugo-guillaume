import { prisma } from '../prismaClient';

const userPublicFields = {
  nom: true,
  prenom: true,
  email: true,
  telephone: true,
  adresse: true
};

export const getAll = async (page: number, limit: number, search?: string) => {
  const skip = (page - 1) * limit;

  const whereClause = search
    ? {
        OR: [
          { nom: { contains: search, mode: 'insensitive' as const } },
          { espece: { contains: search, mode: 'insensitive' as const } },
        ],
      }
    : {};

  const animals = await prisma.animal.findMany({
    skip,
    take: limit,
    where: whereClause,
    include: {
      utilisateur: {
        select: userPublicFields
      },
      visite: {
        include: {
            utilisateur: {
                select: userPublicFields
            }
        }
      }, 
    },
    orderBy: { date_naissance: 'desc' },
  });

  const total = await prisma.animal.count({ where: whereClause });

  return {
    data: animals,
    meta: {
      total,
      page,
      limit,
      totalPages: Math.ceil(total / limit),
    },
  };
};

export const getById = async (id: number) => {
  const animal = await prisma.animal.findUnique({
    where: { id },
    include: {
      utilisateur: {
        select: userPublicFields
      },
      visite: {
        include: {
            utilisateur: {
                select: userPublicFields
            }
        }
      }
    },
  });

  if (animal) {
    return {
      ...animal,
      ownerId: animal.utilisateurId 
    };
  }
  
  return null;
};

export const create = async (data: any) => {
  return await prisma.animal.create({
    data: {
      ...data,
      date_naissance: data.date_naissance ? new Date(data.date_naissance) : undefined,
    },
  });
};

export const update = async (id: number, data: any) => {
  return await prisma.animal.update({
    where: { id },
    data: {
      ...data,
      date_naissance: data.date_naissance ? new Date(data.date_naissance) : undefined,
    },
  });
};

export const remove = async (id: number) => {
  return await prisma.animal.delete({
    where: { id },
  });
};