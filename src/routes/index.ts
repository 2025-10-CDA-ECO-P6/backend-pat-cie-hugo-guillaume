import { Router } from 'express';
import animalRoutes from './animal.routes';
import veterinaireRoutes from './veterinaire.routes'; 
import visiteRoutes from './visite.routes';           

const router = Router();

router.use('/animaux', animalRoutes);
router.use('/veterinaires', veterinaireRoutes); 
router.use('/visites', visiteRoutes);           

export default router;