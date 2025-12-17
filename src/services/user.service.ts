import prisma from '../prismaClient';
import { Prisma } from '@prisma/client';

export const create = async (data: Prisma.UtilisateurCreateInput) => {
  return await prisma.utilisateur.create({
    data,
    select: {
      id: true,
      email: true,
      role: true,
      nom: true,
      prenom: true,
      telephone: true,
      adresse: true,
      specialite: true,
      creation: true,
      actif: true,
      mot_de_passe: false
    }
  });
};

export const getAll = async (page: number, limit: number, search?: string, role?: string) => {
  const skip = (page - 1) * limit;
  
  const where: Prisma.UtilisateurWhereInput = {
    AND: [
      search ? {
        OR: [
          { email: { contains: search, mode: 'insensitive' } },
          { nom: { contains: search, mode: 'insensitive' } },
          { prenom: { contains: search, mode: 'insensitive' } }
        ]
      } : {},
      role ? { role: role as any } : {},
      { actif: true }
    ]
  };

  const [data, total] = await Promise.all([
    prisma.utilisateur.findMany({
      skip,
      take: limit,
      where,
      select: {
        id: true,
        email: true,
        role: true,
        nom: true,
        prenom: true,
        telephone: true,
        adresse: true,
        specialite: true,
        creation: true,
        actif: true,
        mot_de_passe: false,
        _count: {
          select: {
            animaux: true,
            visites_veterinaire: true
          }
        }
      },
      orderBy: { creation: 'desc' }
    }),
    prisma.utilisateur.count({ where })
  ]);

  return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
};

export const getById = async (id: number) => {
  return await prisma.utilisateur.findUnique({
    where: { id },
    select: {
      id: true,
      email: true,
      role: true,
      nom: true,
      prenom: true,
      telephone: true,
      adresse: true,
      specialite: true,
      creation: true,
      actif: true,
      mot_de_passe: false,
      animaux: {
        select: {
          id: true,
          nom: true,
          espece: true,
          race: true,
          date_naissance: true
        }
      },
      visites_veterinaire: {
        take: 10,
        orderBy: { date_: 'desc' },
        select: {
          id: true,
          date_: true,
          motif: true,
          animal: {
            select: {
              nom: true,
              espece: true
            }
          }
        }
      },
      _count: {
        select: {
          animaux: true,
          visites_veterinaire: true
        }
      }
    }
  });
};

export const update = async (id: number, data: Prisma.UtilisateurUpdateInput) => {
  return await prisma.utilisateur.update({
    where: { id },
    data,
    select: {
      id: true,
      email: true,
      role: true,
      nom: true,
      prenom: true,
      telephone: true,
      adresse: true,
      specialite: true,
      creation: true,
      actif: true,
      mot_de_passe: false
    }
  });
};

export const deactivate = async (id: number) => {
  return await prisma.utilisateur.update({
    where: { id },
    data: { actif: false }
  });
};

export const remove = async (id: number) => {
  return await prisma.utilisateur.delete({
    where: { id }
  });
};