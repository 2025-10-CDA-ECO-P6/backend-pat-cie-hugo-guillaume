import type { Request, Response, NextFunction } from 'express';
import * as service from '../services/treatment.service';

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
    const treatment = await service.getById(id);
    
    if (!treatment) {
      res.status(404).json({ error: "Traitement non trouvé" });
      return;
    }
    res.json(treatment);
  } catch (error) {
    next(error);
  }
};

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const newTreatment = await service.create(req.body);
    res.status(201).json(newTreatment);
  } catch (error) {
    next(error);
  }
};

export const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = Number(req.params.id);
    const updatedTreatment = await service.update(id, req.body);
    res.json(updatedTreatment);
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