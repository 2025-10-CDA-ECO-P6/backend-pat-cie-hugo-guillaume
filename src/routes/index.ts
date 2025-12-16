import { Router } from 'express';
import animalRoutes from './animal.routes';
import ownerRoutes from './owner.routes';

const router = Router();

router.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK' });
});

// Montage des routes
router.use('/animaux', animalRoutes);
router.use('/proprietaires', ownerRoutes);


export default router;