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
- [ ] GET /proprietaires (Liste + Recherche par nom)
- [ ] GET /proprietaires/:id (Détails + Liste des animaux associés)
- [ ] POST /proprietaires (Création)
- [ ] PUT /proprietaires/:id
- [ ] DELETE /proprietaires/:id

### Vétérinaires
- [ ] GET /veterinaires
- [ ] POST /veterinaires
- [ ] PUT /veterinaires/:id
- [ ] DELETE /veterinaires/:id

### Visites (Cœur du métier)
- [ ] POST /visites (Créer une visite liée à un Animal et un Vétérinaire)
- [ ] GET /visites/animal/:animalId (Historique médical d'un animal)
- [ ] GET /visites/:id (Détails complets)

### Soins (Vaccins & Traitements)
- [ ] CRUD simple pour la table de référence `Vaccin` (Types de vaccins disponibles)
- [ ] CRUD simple pour la table de référence `Traitement` (Types de médicaments)

## 3. Sécurité & Qualité
- [ ] **Validation :** Implémenter Zod dans les contrôleurs pour valider les `req.body`
- [ ] **Auth :** Mettre en place un Middleware d'authentification simple (Header `x-api-key` ou Bearer Token statique)
- [ ] **Gestion d'erreurs :** Vérifier que le middleware global capture bien les erreurs Prisma

## 4. Tâches Planifiées (Cron Job)
- [x] Structure du Cron Job (`src/jobs/vaccineReminder.ts`)
- [ ] **Logique :** Implémenter l'envoi réel d'email ou simulé
- [ ] **Mise à jour :** Passer le statut du vaccin à "RAPPEL_ENVOYE" une fois le mail parti

## 5. Documentation
- [x] Configurer Swagger UI + Création automatique de la doc swagger

## 6. Déploiement (Render)
- [ ] Pousser le code final sur GitHub
- [ ] Créer le projet "Web Service" sur Render
- [ ] Ajouter les variables d'environnement sur Render (`DATABASE_URL`, `API_KEY`, etc.)
- [ ] Vérifier que le serveur démarre et que Swagger est accessible en ligne
