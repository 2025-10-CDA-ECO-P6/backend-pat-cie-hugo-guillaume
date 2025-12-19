import { Router } from 'express';
import * as animalController from '../controllers/animal.controller';

const router = Router();

router.get('/', animalController.getAll);
router.get('/:id', animalController.getById); 
router.post('/', animalController.create);
router.put('/:id', animalController.update);
router.delete('/:id', animalController.remove);

export default router;