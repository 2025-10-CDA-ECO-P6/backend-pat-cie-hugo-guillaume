import { Router } from 'express';
import animalRoutes from './animal.routes';
import veterinarianRoutes from './veterinarian.routes';

const router = Router();

router.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK' });
});

// Montage des routes
router.use('/animaux', animalRoutes);
router.use('/veterinaires', veterinarianRoutes);


export default router;