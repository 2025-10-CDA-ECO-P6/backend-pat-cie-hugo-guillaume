import { Router } from 'express';
import * as controller from '../controllers/user.controller';

const router = Router();

router.get('/', controller.getAll);        // GET /api/users - Liste avec pagination et filtres
router.get('/:id', controller.getOne);     // GET /api/users/:id - Détails avec relations
router.post('/', controller.create);       // POST /api/users - Création
router.put('/:id', controller.update);     // PUT /api/users/:id - Modification
router.delete('/:id', controller.remove);  // DELETE /api/users/:id - Soft delete

export default router;