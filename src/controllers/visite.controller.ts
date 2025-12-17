import { Request, Response, NextFunction } from 'express';
import * as service from '../services/visite.service';

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await service.create(req.body);
    res.status(201).json(result);
  } catch (error) { next(error); }
};

export const getOne = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = parseInt(req.params.id);
    const result = await service.getById(id);
    if (!result) return res.status(404).json({ error: 'Visite non trouvée' });
    res.json(result);
  } catch (error) { next(error); }
};

export const getByAnimal = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const animalId = parseInt(req.params.animalId);
    const result = await service.getHistoryByAnimalId(animalId);
    res.json(result);
  } catch (error) { next(error); }
};