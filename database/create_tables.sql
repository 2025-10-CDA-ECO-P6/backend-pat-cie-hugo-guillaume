DROP TABLE IF EXISTS "suivre" CASCADE;
DROP TABLE IF EXISTS "etre_vaccine" CASCADE;
DROP TABLE IF EXISTS "visite" CASCADE;
DROP TABLE IF EXISTS "animal" CASCADE;
DROP TABLE IF EXISTS "utilisateur" CASCADE;
DROP TABLE IF EXISTS "vaccin" CASCADE;
DROP TABLE IF EXISTS "traitement" CASCADE;
DROP TABLE IF EXISTS "proprietaire" CASCADE;
DROP TABLE IF EXISTS "veterinaire" CASCADE;
DROP TYPE IF EXISTS "Role";

CREATE TYPE "Role" AS ENUM ('ADMIN', 'VETERINAIRE', 'PROPRIETAIRE');

CREATE TABLE "utilisateur" (
    "id" SERIAL PRIMARY KEY,
    "email" TEXT NOT NULL UNIQUE,
    "mot_de_passe" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'PROPRIETAIRE',
    "nom" TEXT NOT NULL,
    "prenom" TEXT NOT NULL,
    "telephone" TEXT,
    "adresse" TEXT,
    "specialite" TEXT,
    "creation" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actif" BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE "animal" (
    "id" SERIAL PRIMARY KEY,
    "nom" TEXT NOT NULL,
    "espece" TEXT NOT NULL,
    "race" TEXT,
    "sexe" TEXT,
    "date_naissance" TIMESTAMP(3),
    "poids" DECIMAL(65,30),
    "photo" TEXT,
    "utilisateur_id" INTEGER NOT NULL,
    CONSTRAINT "animal_utilisateur_fkey" FOREIGN KEY ("utilisateur_id") REFERENCES "utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "visite" (
    "id" SERIAL PRIMARY KEY,
    "date_" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "compte_rendu" TEXT,
    "motif" TEXT,
    "animal_id" INTEGER NOT NULL,
    "veterinaire_id" INTEGER NOT NULL,
    CONSTRAINT "visite_animal_fkey" FOREIGN KEY ("animal_id") REFERENCES "animal"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "visite_veterinaire_fkey" FOREIGN KEY ("veterinaire_id") REFERENCES "utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "vaccin" (
    "id" SERIAL PRIMARY KEY,
    "type" TEXT,
    "nom" TEXT NOT NULL,
    "description" TEXT,
    "duree_validite_mois" INTEGER NOT NULL
);

CREATE TABLE "traitement" (
    "id" SERIAL PRIMARY KEY,
    "nom" TEXT NOT NULL,
    "dosage" TEXT,
    "frequence" TEXT
);

CREATE TABLE "etre_vaccine" (
    "id" SERIAL PRIMARY KEY,
    "date_vaccination" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "date_rappel" TIMESTAMP(3),
    "statut" TEXT DEFAULT 'EFFECTUE',
    "lot" TEXT,
    "visite_id" INTEGER NOT NULL,
    "vaccin_id" INTEGER NOT NULL,
    CONSTRAINT "etre_vaccine_visite_fkey" FOREIGN KEY ("visite_id") REFERENCES "visite"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "etre_vaccine_vaccin_fkey" FOREIGN KEY ("vaccin_id") REFERENCES "vaccin"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "suivre" (
    "id" SERIAL PRIMARY KEY,
    "date_debut" TIMESTAMP(3) NOT NULL,
    "date_fin" TIMESTAMP(3),
    "observation" TEXT,
    "visite_id" INTEGER NOT NULL,
    "traitement_id" INTEGER NOT NULL,
    CONSTRAINT "suivre_visite_fkey" FOREIGN KEY ("visite_id") REFERENCES "visite"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "suivre_traitement_fkey" FOREIGN KEY ("traitement_id") REFERENCES "traitement"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

