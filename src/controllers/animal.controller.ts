import type { Request, Response, NextFunction } from 'express';
import * as service from '../services/animal.service';

export const getAll = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const role = req.user?.role;
    if (role !== 'VETERINAIRE') {
      res.status(401);
      return;
    }
    const page = Number(req.query.page) || 1;
    const limit = Number(req.query.limit) || 10;
    const search = req.query.search as string;
    
    const result = await service.getAll(page, limit, search);
    res.json(result);
  } catch (error) {
    next(error);
  }
};

export const getOne = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const role = req.user?.role;
    const id = Number(req.params.id);
    const animal = await service.getById(id);

    if (role !== 'VETERINAIRE' && req.user?.id !== animal?.ownerId) {
      res.status(401).json({ error: "Unauthorized" });
      return;
    }
    
    if (!animal) {
      res.status(404).json({ error: "Animal non trouvé" });
      return;
    }
    res.json(animal);
  } catch (error) {
    next(error);
  }
};

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const newAnimal = await service.create(req.body);
    res.status(201).json(newAnimal);
  } catch (error) {
    next(error);
  }
};

export const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const role = req.user?.role;
    if (role !== 'VETERINAIRE') {
      res.status(401);
      return;
    }
    const id = Number(req.params.id);
    const updatedAnimal = await service.update(id, req.body);
    res.json(updatedAnimal);
  } catch (error) {
    next(error);
  }
};

// DELETE
export const remove = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const role = req.user?.role;
    if (role !== 'VETERINAIRE') {
      res.status(401);
      return;
    }
    
    const id = Number(req.params.id);
    await service.remove(id);
    res.status(204).send(); 
  } catch (error) {
    next(error);
  }
};