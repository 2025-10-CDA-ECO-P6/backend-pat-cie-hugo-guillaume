import { Router } from 'express';
import * as controller from '../controllers/veterinarian.controller';

const router = Router();

router.get('/', controller.getAll);        // GET /api/veterinaires
router.get('/:id', controller.getOne);     // GET /api/veterinaires/:id
router.post('/', controller.create);       // POST /api/veterinaires
router.put('/:id', controller.update);     // PUT /api/veterinaires/:id
router.delete('/:id', controller.remove);  // DELETE /api/veterinaires/:id

export default router;








