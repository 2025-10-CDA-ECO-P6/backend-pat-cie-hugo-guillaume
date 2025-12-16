import { Router } from 'express';
import animalRoutes from './animal.routes';

const router = Router();

router.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK' });
});

// Montage des routes
router.use('/animaux', animalRoutes);


export default router;