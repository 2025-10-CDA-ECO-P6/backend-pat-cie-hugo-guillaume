# TODO LIST - Backend Patte & Cie

## 1. Base de données & Modélisation (Prisma)
- [x] Initialiser le projet et connecter Neon (PostgreSQL)
- [x] Créer le `schema.prisma` 
- [x] **Livrable :** Script SQL

## 2. API & CRUDs (Services, Controllers, Routes)

### Animal
- [x] GET /animal 
- [x] GET /animal/:id 
- [x] POST /animal (Création)
- [x] PUT /animal/:id
- [x] DELETE /animal/:id

### Propriétaires
- [X] GET /proprietaires (Liste + Recherche par nom)
- [X] GET /proprietaires/:id (Détails + Liste des animaux associés)
- [X] POST /proprietaires (Création)
- [X] PUT /proprietaires/:id
- [X] DELETE /proprietaires/:id

### Vétérinaires
- [X] GET /veterinaires
- [X] POST /veterinaires
- [X] PUT /veterinaires/:id
- [X] DELETE /veterinaires/:id

### Visites (Cœur du métier)
- [X] POST /visites (Créer une visite liée à un Animal et un Vétérinaire)
- [X] GET /visites/animal/:animalId (Historique médical d'un animal)
- [X] GET /visites/:id (Détails complets)

### Soins (Vaccins & Traitements)
- [X] CRUD simple pour la table de référence `Vaccin` (Types de vaccins disponibles)
- [X] CRUD simple pour la table de référence `Traitement` (Types de médicaments)

## 3. Sécurité & Qualité
- [X] **Validation :** Implémenter Zod dans les contrôleurs pour valider les `req.body`
- [X] **Auth :** Mettre en place un Middleware d'authentification simple (Header `x-api-key` ou Bearer Token statique)
- [X] **Gestion d'erreurs :** Vérifier que le middleware global capture bien les erreurs Prisma

## 4. Tâches Planifiées (Cron Job)
- [x] Structure du Cron Job (`src/jobs/vaccineReminder.ts`)
- [X] **Logique :** Implémenter l'envoi réel d'email ou simulé
- [X] **Mise à jour :** Passer le statut du vaccin à "RAPPEL_ENVOYE" une fois le mail parti

## 5. Documentation
- [x] Configurer Swagger UI + Création automatique de la doc swagger

## 6. Déploiement (Render)
- [X] Pousser le code final sur GitHub
- [X] Créer le projet "Web Service" sur Render
- [X] Ajouter les variables d'environnement sur Render (`DATABASE_URL`, `API_KEY`, etc.)
- [X] Vérifier que le serveur démarre et que Swagger est accessible en ligne
