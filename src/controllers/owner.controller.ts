import type { Request, Response, NextFunction } from 'express';
import * as service from '../services/owner.service';

export const getAll = async (req: Request, res: Response, next: NextFunction) => {
  try {
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
    const id = Number(req.params.id);
    const owner = await service.getById(id);
    
    if (!owner) {
      res.status(404).json({ error: "Propriétaire non trouvé" });
      return;
    }
    res.json(owner);
  } catch (error) {
    next(error);
  }
};

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const newOwner = await service.create(req.body);
    res.status(201).json(newOwner);
  } catch (error) {
    next(error);
  }
};

export const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = Number(req.params.id);
    const updatedOwner = await service.update(id, req.body);
    res.json(updatedOwner);
  } catch (error) {
    next(error);
  }
};

export const remove = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = Number(req.params.id);
    await service.remove(id);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
};