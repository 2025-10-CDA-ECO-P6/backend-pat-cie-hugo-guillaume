import type { Request, Response, NextFunction } from 'express';
import * as service from '../services/user.service';

export const getAll = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const page = Number(req.query.page) || 1;
    const limit = Number(req.query.limit) || 10;
    const search = req.query.search as string;
    const role = req.query.role as string;
    
    const result = await service.getAll(page, limit, search, role);
    res.json(result);
  } catch (error) {
    next(error);
  }
};

export const getOne = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = Number(req.params.id);
    const user = await service.getById(id);
    
    if (!user) {
      res.status(404).json({ error: 'Utilisateur non trouvé' });
      return;
    }
    
    res.json(user);
  } catch (error) {
    next(error);
  }
};

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const newUser = await service.create(req.body);
    res.status(201).json(newUser);
  } catch (error) {
    next(error);
  }
};

export const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = Number(req.params.id);
    const updatedUser = await service.update(id, req.body);
    res.json(updatedUser);
  } catch (error) {
    next(error);
  }
};

export const remove = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = Number(req.params.id);
    await service.deactivate(id);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
};