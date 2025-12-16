import { Router } from 'express';
import * as controller from '../controllers/vaccine.controller';

const router = Router();

router.get('/', controller.getAll);        // GET /api/vaccins
router.get('/:id', controller.getOne);     // GET /api/vaccins/:id
router.post('/', controller.create);       // POST /api/vaccins
router.put('/:id', controller.update);     // PUT /api/vaccins/:id
router.delete('/:id', controller.remove);  // DELETE /api/vaccins/:id

export default router;