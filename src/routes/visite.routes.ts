import { Router } from 'express';
import * as controller from '../controllers/visite.controller';

const router = Router();

router.post('/', controller.create);
router.get('/:id', controller.getOne);

router.get('/animal/:animalId', controller.getByAnimal);

export default router;
