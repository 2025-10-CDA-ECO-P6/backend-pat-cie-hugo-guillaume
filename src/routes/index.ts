import { Router } from 'express';
import animalRoutes from './animal.routes';
import userRoutes from './user.routes';
import visiteRoutes from './visite.routes';           
import vaccineRoutes from './vaccine.routes';
import treatmentRoutes from './treatment.routes';

const router = Router();

router.use('/animaux', animalRoutes);
router.use('/users', userRoutes);
router.use('/visites', visiteRoutes);           
router.use('/vaccins', vaccineRoutes);
router.use('/traitements', treatmentRoutes);

export default router;