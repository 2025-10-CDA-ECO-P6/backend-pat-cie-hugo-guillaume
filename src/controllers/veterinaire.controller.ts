import { Request, Response, NextFunction } from 'express';
import * as service from '../services/veterinaire.service';

export const getAll = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await service.getAll();
    res.json(result);
  } catch (error) { next(error); }
};

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await service.create(req.body);
    res.status(201).json(result);
  } catch (error) { next(error); }
};

export const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = parseInt(req.params.id);
    const result = await service.update(id, req.body);
    res.json(result);
  } catch (error) { next(error); }
};

export const remove = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = parseInt(req.params.id);
    await service.remove(id);
    res.status(204).send();
  } catch (error) { next(error); }
};