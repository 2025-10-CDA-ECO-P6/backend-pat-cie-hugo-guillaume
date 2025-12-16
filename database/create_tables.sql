-- Clean si des trucs existent déjà
DROP TABLE IF EXISTS suivre CASCADE;
DROP TABLE IF EXISTS etre_vaccine CASCADE;
DROP TABLE IF EXISTS visite CASCADE;
DROP TABLE IF EXISTS animal CASCADE;
DROP TABLE IF EXISTS proprietaire CASCADE;
DROP TABLE IF EXISTS veterinaire CASCADE;
DROP TABLE IF EXISTS vaccin CASCADE;
DROP TABLE IF EXISTS traitement CASCADE;

-- Creation tables

CREATE TABLE proprietaire (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    telephone VARCHAR(20),
    email VARCHAR(150) UNIQUE NOT NULL,
    adresse TEXT
);

CREATE TABLE veterinaire (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    specialite VARCHAR(100),
    telephone VARCHAR(20),
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE animal (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    espece VARCHAR(50) NOT NULL,
    race VARCHAR(50),
    sexe CHAR(1) CHECK (sexe IN ('M', 'F')),
    date_naissance DATE,
    poids DECIMAL(5,2),
    photo TEXT, 
    proprietaire_id INT NOT NULL, 
    CONSTRAINT fk_animal_proprietaire FOREIGN KEY (proprietaire_id) REFERENCES proprietaire(id) ON DELETE CASCADE
);

CREATE TABLE visite (
    id SERIAL PRIMARY KEY,
    date_visite DATE NOT NULL DEFAULT CURRENT_DATE,
    compte_rendu TEXT,
    motif VARCHAR(200),
    animal_id INT NOT NULL,     
    veterinaire_id INT NOT NULL, 
    CONSTRAINT fk_visite_animal FOREIGN KEY (animal_id) REFERENCES animal(id) ON DELETE CASCADE,
    CONSTRAINT fk_visite_vet FOREIGN KEY (veterinaire_id) REFERENCES veterinaire(id) ON DELETE SET NULL
);

CREATE TABLE vaccin (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50),
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    duree_validite_mois INT NOT NULL
);

--  Lien Visite <-> Vaccin)
CREATE TABLE etre_vaccine (
    id SERIAL PRIMARY KEY,
    date_vaccination DATE NOT NULL DEFAULT CURRENT_DATE,
    date_rappel DATE,
    statut VARCHAR(50) DEFAULT 'EFFECTUE', 
    lot VARCHAR(50),
    visite_id INT NOT NULL, 
    vaccin_id INT NOT NULL, 
    CONSTRAINT fk_ev_visite FOREIGN KEY (visite_id) REFERENCES visite(id) ON DELETE CASCADE,
    CONSTRAINT fk_ev_vaccin FOREIGN KEY (vaccin_id) REFERENCES vaccin(id) ON DELETE RESTRICT
);

CREATE TABLE traitement (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    dosage VARCHAR(100),
    frequence VARCHAR(100)
);

CREATE TABLE suivre (
    id SERIAL PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin DATE,
    observation TEXT,
    visite_id INT NOT NULL,
    traitement_id INT NOT NULL, 
    CONSTRAINT fk_suivre_visite FOREIGN KEY (visite_id) REFERENCES visite(id) ON DELETE CASCADE,
    CONSTRAINT fk_suivre_traitement FOREIGN KEY (traitement_id) REFERENCES traitement(id) ON DELETE RESTRICT
);