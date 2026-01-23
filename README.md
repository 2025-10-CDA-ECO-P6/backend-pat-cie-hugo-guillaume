# Backend Pat & Cie - Gestion Vétérinaire

## Description du Projet

**Pat & Cie** est une application backend de gestion vétérinaire développée en TypeScript avec Node.js et Express. Le système permet la gestion complète des animaux de compagnie, des visites vétérinaires, des vaccinations et des traitements médicaux.

Ce projet fait partie du parcours **CDA (Concepteur Développeur d'Applications)** - Promotion ECO P6 2025-10.

## Fonctionnalités Principales

- **Gestion des utilisateurs** avec trois rôles distincts :
  - Administrateur (`ADMIN`)
  - Vétérinaire (`VETERINAIRE`)
  - Propriétaire d'animaux (`PROPRIETAIRE`)
  
- **Gestion des animaux** : enregistrement des informations complètes (nom, espèce, race, poids, photo, etc.)
  
- **Gestion des visites vétérinaires** : suivi des consultations avec compte-rendu et motif

- **Suivi des vaccinations** : administration des vaccins avec dates de rappel et statut

- **Gestion des traitements** : prescription et suivi des traitements médicaux

- **Authentification JWT** : sécurisation des routes avec système de tokens

- **Documentation API** : interface Swagger auto-générée

## Stack Technique

### Backend
- **Runtime** : Node.js avec TypeScript
- **Framework** : Express.js v5.2
- **ORM** : Prisma v7.1
- **Base de données** : PostgreSQL (Neon Database)
- **Authentification** : JWT + bcrypt
- **Validation** : Express-validator & Zod

### DevOps & Outils
- **Documentation API** : Swagger UI Express + swagger-autogen
- **Dev Server** : Nodemon + tsx
- **CORS** : Configuration pour les requêtes cross-origin
- **WebSockets** : Support ws pour la communication temps réel
- **Tâches planifiées** : node-cron

## Installation

### Prérequis
- Node.js (v18 ou supérieur)
- PostgreSQL ou compte Neon Database
- Git

### Étapes d'installation

1. **Cloner le repository**
```bash
git clone https://github.com/2025-10-CDA-ECO-P6/backend-pat-cie-hugo-guillaume.git
cd backend-pat-cie-hugo-guillaume
```

2. **Installer les dépendances**
```bash
npm install
```

3. **Configurer les variables d'environnement**
```bash
cp .env.example .env
```
Éditer le fichier `.env` avec vos propres valeurs (base de données, secrets JWT, etc.)

4. **Synchroniser le schéma Prisma**
```bash
npx prisma db pull
npx prisma generate
```

5. **Générer la documentation Swagger**
```bash
npx tsx swagger-gen.ts
```

## Utilisation

### Mode Développement
```bash
npm run dev
```
Lance l'application avec hot-reload. Le script exécute automatiquement :
- Synchronisation du schéma Prisma
- Génération du client Prisma
- Génération de la documentation Swagger
- Démarrage du serveur avec nodemon

### Mode Production
```bash
npm run build
npm start
```

## Documentation API

Une fois l'application lancée, accédez à la documentation Swagger interactive :
```
http://localhost:<PORT>/api-docs
```

## Architecture de la Base de Données

Le projet utilise un schéma relationnel avec les tables principales :

- **utilisateur** : Gestion des comptes (propriétaires, vétérinaires, admins)
- **animal** : Informations sur les animaux de compagnie
- **visite** : Enregistrement des consultations vétérinaires
- **vaccin** : Catalogue des vaccins disponibles
- **traitement** : Catalogue des traitements médicaux
- **etre_vaccine** : Table de liaison pour les vaccinations effectuées
- **suivre** : Table de liaison pour les traitements administrés

## Contributeurs

Ce projet a été développé par :

| Contributeur | Contributions principales |
|--------------|--------------------------|
| **Hugo** | Architecture du projet, configuration Prisma/TypeScript, routes API, système d'authentification, restrictions d'accès basées sur les rôles, gestion des visites et vétérinaires |
| **Guillaume Broquet** (guibrok) | CRUD utilisateurs, vaccins et traitements, tests, scripts SQL initiaux, structure initiale du projet |

### Historique des Développements

- **Phase 1** : Initialisation du projet avec TypeScript, Prisma et structure de base
- **Phase 2** : Création du schéma de base de données et configuration Prisma
- **Phase 3** : Développement des endpoints CRUD (propriétaires, vétérinaires)
- **Phase 4** : Ajout des fonctionnalités de visite vétérinaire
- **Phase 5** : Implémentation des vaccins et traitements
- **Phase 6** : Système d'authentification et restrictions d'accès
- **Phase 7** : Migration vers Neon Database
- **Phase 8** : Améliorations et corrections (dernière mise à jour : typos dans les contrôleurs)

## Structure du Projet

```
backend-pat-cie-hugo-guillaume/
├── src/
│   ├── app.ts              # Point d'entrée de l'application
│   ├── config/             # Configuration (DB, JWT, etc.)
│   ├── controllers/        # Contrôleurs des routes
│   ├── middleware/         # Middlewares (auth, validation)
│   ├── routes/             # Définition des routes
│   ├── services/           # Logique métier
│   ├── types/              # Types TypeScript
│   └── jobs/               # Tâches planifiées (cron)
├── prisma/
│   └── schema.prisma       # Schéma de base de données
├── tests/                  # Tests unitaires et d'intégration
├── database/               # Scripts SQL et documentation DB
├── .env                    # Variables d'environnement (non versionné)
├── package.json            # Dépendances et scripts
└── tsconfig.json           # Configuration TypeScript
```

## Sécurité

- Hashage des mots de passe avec bcrypt
- Authentification par JWT
- Validation des entrées utilisateur
- Restrictions d'accès basées sur les rôles
- Variables d'environnement pour les secrets


## Liens Utiles

- [Repository GitHub](https://github.com/2025-10-CDA-ECO-P6/backend-pat-cie-hugo-guillaume)
- [Issues](https://github.com/2025-10-CDA-ECO-P6/backend-pat-cie-hugo-guillaume/issues)

---

*Développé par Hugo et Guillaume - Promotion CDA ECO P6 2025-10*
