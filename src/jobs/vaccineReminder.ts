import cron from 'node-cron';
import prisma from '../prismaClient'; 




// Tt les jours a 9h
export const vaccineReminderJob = cron.schedule('0 9 * * *', async () => {
  console.log('Vérification des rappels de vaccins...');

  const today = new Date();
  const targetDate = new Date();
  targetDate.setDate(today.getDate() + 7);

  const startOfDay = new Date(targetDate.setHours(0, 0, 0, 0));
  const endOfDay = new Date(targetDate.setHours(23, 59, 59, 999));

  try {
    const vaccinationsToRemind = await prisma.etreVaccine.findMany({
      where: {
        date_rappel: {
          gte: startOfDay,
          lte: endOfDay
        },
        statut: { not: 'RAPPEL_ENVOYE' } 
      },
      include: {
        vaccin: true,
        visite: {
          include: {
            animal: {
              include: {
                proprietaire: true
              }
            }
          }
        }
      }
    });

    for (const record of vaccinationsToRemind) {
      const email = record.visite.animal.proprietaire.email;
      const animalNom = record.visite.animal.nom;
      const vaccinNom = record.vaccin.nom;

      console.log(`Envoi email à ${email} pour ${animalNom} (Vaccin: ${vaccinNom})`);
      
    }
  } catch (error) {
    console.error('Erreur lors du job de rappel :', error);
  }
});