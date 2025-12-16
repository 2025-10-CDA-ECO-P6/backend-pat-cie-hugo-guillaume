import type { Request, Response, NextFunction } from 'express';
import * as service from '../services/vaccine.service';

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
    const vaccine = await service.getById(id);
    
    if (!vaccine) {
      res.status(404).json({ error: "Vaccin non trouvé" });
      return;
    }
    res.json(vaccine);
  } catch (error) {
    next(error);
  }
};

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const newVaccine = await service.create(req.body);
    res.status(201).json(newVaccine);
  } catch (error) {
    next(error);
  }
};

export const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = Number(req.params.id);
    const updatedVaccine = await service.update(id, req.body);
    res.json(updatedVaccine);
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