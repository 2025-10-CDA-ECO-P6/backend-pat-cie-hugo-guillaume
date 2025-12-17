import { Router } from 'express';
import * as controller from '../controllers/owner.controller';

const router = Router();

router.get('/', controller.getAll);        // GET /api/proprietaires
router.get('/:id', controller.getOne);     // GET /api/proprietaires/1
router.post('/', controller.create);       // POST /api/proprietaires
router.put('/:id', controller.update);     // PUT /api/proprietaires/1
router.delete('/:id', controller.remove);  // DELETE /api/proprietaires/1

export default router;