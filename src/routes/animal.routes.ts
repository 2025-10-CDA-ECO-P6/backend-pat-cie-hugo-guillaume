import { Router } from 'express';
import * as controller from '../controllers/animal.controller';

const router = Router();

router.get('/', controller.getAll);        // GET /api/animaux
router.get('/:id', controller.getOne);     // GET /api/animaux/1
router.post('/', controller.create);       // POST /api/animaux
router.put('/:id', controller.update);     // PUT /api/animaux/1
router.delete('/:id', controller.remove);  // DELETE /api/animaux/1

export default router;