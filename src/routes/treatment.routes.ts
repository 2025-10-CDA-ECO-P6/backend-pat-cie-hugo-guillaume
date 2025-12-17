import { Router } from 'express';
import * as controller from '../controllers/treatment.controller';

const router = Router();

router.get('/', controller.getAll);        // GET /api/traitements
router.get('/:id', controller.getOne);     // GET /api/traitements/:id
router.post('/', controller.create);       // POST /api/traitements
router.put('/:id', controller.update);     // PUT /api/traitements/:id
router.delete('/:id', controller.remove);  // DELETE /api/traitements/:id

export default router;








