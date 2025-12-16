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

-- Données tests

INSERT INTO proprietaire (nom, prenom, telephone, email, adresse) VALUES
('Dupont', 'Jean', '0601020304', 'jean.dupont@email.com', '10 rue de la Paix, Paris'),
('Martin', 'Sophie', '0699887766', 'sophie.martin@email.com', '5 avenue des Champs, Lyon');

INSERT INTO veterinaire (nom, prenom, specialite, telephone, email) VALUES
('Curie', 'Marie', 'Chirurgie', '0123456789', 'dr.curie@vet.com'),
('Pasteur', 'Louis', 'Infectiologie', '0987654321', 'dr.pasteur@vet.com');

INSERT INTO animal (nom, espece, race, sexe, date_naissance, poids, proprietaire_id) VALUES
('Rex', 'Chien', 'Berger Allemand', 'M', '2020-05-15', 32.5, 1),
('Mina', 'Chat', 'Siamois', 'F', '2021-08-20', 4.2, 1),
('Bugs', 'Lapin', 'Nain', 'M', '2022-01-10', 1.5, 2);

INSERT INTO vaccin (type, nom, description, duree_validite_mois) VALUES
('Virus', 'Rabisin', 'Rage', 12),
('Virus', 'Leucogen', 'Leucose féline', 12),
('Bactérie', 'Pneumodog', 'Toux du chenil', 12);

INSERT INTO traitement (nom, dosage, frequence) VALUES
('Amoxicilline', '200mg', 'Matin et Soir'),
('Metacam', '1.5mg', 'Une fois par jour');

INSERT INTO visite (date_visite, motif, compte_rendu, animal_id, veterinaire_id) VALUES
('2023-10-01', 'Vaccination annuelle', 'Animal en bonne santé', 1, 1);

INSERT INTO etre_vaccine (date_vaccination, date_rappel, statut, lot, visite_id, vaccin_id) VALUES
('2023-10-01', '2024-10-01', 'EFFECTUE', 'LOT-A123', 1, 1);

INSERT INTO visite (date_visite, motif, compte_rendu, animal_id, veterinaire_id) VALUES
('2023-11-15', 'Toux persistante', 'Infection respiratoire légère', 2, 2);

INSERT INTO suivre (date_debut, date_fin, observation, visite_id, traitement_id) VALUES
('2023-11-15', '2023-11-22', 'Bien surveiller la prise alimentaire', 2, 1);