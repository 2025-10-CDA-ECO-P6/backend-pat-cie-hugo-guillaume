import { Router } from 'express';
import animalRoutes from './animal.routes';
import ownerRoutes from './owner.routes';
import veterinaireRoutes from './veterinaire.routes'; 
import visiteRoutes from './visite.routes';           
import vaccineRoutes from './vaccine.routes';
import treatmentRoutes from './treatment.routes';


const router = Router();

router.use('/animaux', animalRoutes);
router.use('/proprietaires', ownerRoutes);
router.use('/veterinaires', veterinaireRoutes); 
router.use('/visites', visiteRoutes);           
router.use('/vaccins', vaccineRoutes);
router.use('/traitements', treatmentRoutes);


export default router;