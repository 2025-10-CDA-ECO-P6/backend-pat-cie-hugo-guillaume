import express from 'express';
import cors from 'cors';
import router from './routes/index'; // Assure-toi que le chemin est bon
import { vaccineReminderJob } from './jobs/vaccineReminder';
import { createRequire } from "module";
const require = createRequire(import.meta.url);
const swaggerFile = require("./swagger-output.json");
import 'dotenv/config';
import swaggerUi from 'swagger-ui-express';
import authRoutes from './routes/auth.routes';
import { authenticateToken } from './middleware/auth.middleware';
const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);

app.use('/api', authenticateToken, router);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerFile));


app.use((err: any, req: express.Request, res: express.Response, next: express.NextFunction) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Une erreur interne est survenue' });
});

vaccineReminderJob.start();

app.listen(PORT, () => {
  console.log(`\n Serveur démarré avec succès !`);
  console.log(`➜  API URL :   http://localhost:${PORT}/api`);
  console.log(`➜  Swagger :   http://localhost:${PORT}/api-docs`);
  console.log(`➜  Cron Job :  Actif (Relance vaccinale)\n`);
});

export default app;