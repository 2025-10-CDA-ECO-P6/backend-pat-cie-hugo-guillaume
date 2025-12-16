DROP TABLE IF EXISTS be_treated CASCADE;
DROP TABLE IF EXISTS be_vaccinated CASCADE;
DROP TABLE IF EXISTS treatment CASCADE;
DROP TABLE IF EXISTS vaccine CASCADE;
DROP TABLE IF EXISTS visit CASCADE;
DROP TABLE IF EXISTS veterinarian CASCADE;
DROP TABLE IF EXISTS animal CASCADE;
DROP TABLE IF EXISTS owner CASCADE;

CREATE TABLE owner (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255) NOT NULL UNIQUE,
    address TEXT
);

COMMENT ON TABLE owner IS 'Propriétaires des animaux';
COMMENT ON COLUMN owner.id IS 'Identifiant unique UUID';
COMMENT ON COLUMN owner.email IS 'Email unique et obligatoire';

CREATE TABLE animal (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    species VARCHAR(255) NOT NULL,
    breed VARCHAR(255),
    sex CHAR(1) NOT NULL,
    birth_date DATE NOT NULL,
    weight DECIMAL(5,2),
    photo_url VARCHAR(255),
    owner_id UUID NOT NULL,

    CONSTRAINT fk_animal_owner FOREIGN KEY (owner_id) 
        REFERENCES owner(id) 
        ON DELETE CASCADE,  -- Si on supprime le propriétaire, on supprime ses animaux
    CONSTRAINT chk_sex CHECK (sex IN ('M', 'F')),
    CONSTRAINT chk_weight CHECK (weight > 0),
    CONSTRAINT chk_birth_date CHECK (birth_date <= CURRENT_DATE)
);

COMMENT ON TABLE animal IS 'Animaux de compagnie';
COMMENT ON COLUMN animal.sex IS 'M = Mâle, F = Femelle';
COMMENT ON COLUMN animal.weight IS 'Poids en kilogrammes';

CREATE TABLE veterinarian (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    specialty VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(255) UNIQUE
);

COMMENT ON TABLE veterinarian IS 'Vétérinaires de la clinique';
COMMENT ON COLUMN veterinarian.specialty IS 'Spécialité du vétérinaire (optionnel)';

CREATE TABLE visit (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    visit_date TIMESTAMP NOT NULL,
    reason VARCHAR(255),
    report TEXT,
    animal_id UUID NOT NULL,
    veterinarian_id UUID NOT NULL,

    CONSTRAINT fk_visit_animal FOREIGN KEY (animal_id) 
        REFERENCES animal(id) 
        ON DELETE CASCADE,  -- Si on supprime l'animal, on supprime ses visites
    CONSTRAINT fk_visit_veterinarian FOREIGN KEY (veterinarian_id) 
        REFERENCES veterinarian(id) 
        ON DELETE RESTRICT,  -- On ne peut pas supprimer un véto qui a des visites
    CONSTRAINT chk_visit_date CHECK (visit_date <= CURRENT_TIMESTAMP)
);

COMMENT ON TABLE visit IS 'Visites vétérinaires';
COMMENT ON COLUMN visit.report IS 'Compte-rendu de la visite';

CREATE TABLE vaccine (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    validity_duration_months INTEGER NOT NULL,

    CONSTRAINT chk_validity_duration CHECK (validity_duration_months > 0)
);

COMMENT ON TABLE vaccine IS 'Référentiel des vaccins disponibles';
COMMENT ON COLUMN vaccine.type IS 'Type de vaccin (ex: Rage, Parvovirus) - UNIQUE';
COMMENT ON COLUMN vaccine.validity_duration_months IS 'Durée de validité en mois';

CREATE TABLE treatment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(150) NOT NULL, 
    dosage VARCHAR(100),
    frequency VARCHAR(100)
);

COMMENT ON TABLE treatment IS 'Référentiel des traitements disponibles';
COMMENT ON COLUMN treatment.dosage IS 'Dosage recommandé du traitement';


CREATE TABLE be_vaccinated (
    visit_id UUID NOT NULL,
    vaccine_id UUID NOT NULL,
    vaccination_date DATE NOT NULL,
    reminder_date DATE,
    status VARCHAR(20) DEFAULT 'up_to_date',
    batch_number VARCHAR(50),

    PRIMARY KEY (visit_id, vaccine_id),

    CONSTRAINT fk_be_vaccinated_visit FOREIGN KEY (visit_id) 
        REFERENCES visit(id) 
        ON DELETE CASCADE,  -- Si on supprime la visite, on supprime les vaccinations associées
    CONSTRAINT fk_be_vaccinated_vaccine FOREIGN KEY (vaccine_id) 
        REFERENCES vaccine(id) 
        ON DELETE RESTRICT,  -- On ne peut pas supprimer un vaccin utilisé

    CONSTRAINT chk_reminder_date CHECK (reminder_date IS NULL OR reminder_date > vaccination_date),
    CONSTRAINT chk_status CHECK (status IN ('up_to_date', 'to_renew', 'expired'))
);

COMMENT ON TABLE be_vaccinated IS 'Historique des vaccinations effectuées';
COMMENT ON COLUMN be_vaccinated.status IS 'Statut : up_to_date, to_renew, expired';
COMMENT ON COLUMN be_vaccinated.batch_number IS 'Numéro de lot du vaccin utilisé';

CREATE TABLE be_treated (
    visit_id UUID NOT NULL,
    treatment_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    observations TEXT,

    PRIMARY KEY (visit_id, treatment_id),

    CONSTRAINT fk_treated_visit FOREIGN KEY (visit_id) 
        REFERENCES visit(id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_treated_treatment FOREIGN KEY (treatment_id) 
        REFERENCES treatment(id) 
        ON DELETE RESTRICT,
    
    CONSTRAINT chk_end_date CHECK (end_date IS NULL OR end_date >= start_date)
);

COMMENT ON TABLE be_treated IS 'Historique des traitements prescrits';
COMMENT ON COLUMN be_treated.end_date IS 'Date de fin (NULL si traitement en cours)';
COMMENT ON COLUMN be_treated.observations IS 'Notes sur le déroulement du traitement';

CREATE INDEX idx_animal_owner ON animal(owner_id);
CREATE INDEX idx_visit_animal ON visit(animal_id);
CREATE INDEX idx_visit_veterinarian ON visit(veterinarian_id);
CREATE INDEX idx_vaccination_visit ON be_vaccinated(visit_id);
CREATE INDEX idx_vaccination_vaccine ON be_vaccinated(vaccine_id);
CREATE INDEX idx_treated_visit ON be_treated(visit_id);
CREATE INDEX idx_treated_treatment ON be_treated(treatment_id);

CREATE INDEX idx_animal_name ON animal(name);
CREATE INDEX idx_owner_name ON owner(last_name, first_name);
CREATE INDEX idx_visit_date ON visit(visit_date DESC);
CREATE INDEX idx_vaccination_reminder ON be_vaccinated(reminder_date);
CREATE INDEX idx_vaccination_status ON be_vaccinated(status);

COMMENT ON INDEX idx_vaccination_reminder IS 'Index pour trouver rapidement les vaccins à renouveler';
COMMENT ON INDEX idx_vaccination_status IS 'Index pour filtrer par statut de vaccination';

-- DONNÉES D'EXEMPLE (pour tester)

-- Insertion des propriétaires
INSERT INTO owner (id, last_name, first_name, phone, email, address) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'Dupont', 'Marie', '0601020304', 'marie.dupont@email.com', '12 rue des Fleurs, 75001 Paris'),
('550e8400-e29b-41d4-a716-446655440002', 'Martin', 'Pierre', '0602030405', 'pierre.martin@email.com', '45 avenue de la République, 69001 Lyon'),
('550e8400-e29b-41d4-a716-446655440003', 'Bernard', 'Sophie', '0603040506', 'sophie.bernard@email.com', '78 boulevard Saint-Michel, 33000 Bordeaux');

-- Insertion des vétérinaires
INSERT INTO veterinarian (id, last_name, first_name, specialty, phone, email) VALUES
('660e8400-e29b-41d4-a716-446655440001', 'Leblanc', 'Jean', 'Chirurgie', '0610203040', 'jean.leblanc@patteetcie.fr'),
('660e8400-e29b-41d4-a716-446655440002', 'Rousseau', 'Claire', 'Dermatologie', '0611213141', 'claire.rousseau@patteetcie.fr'),
('660e8400-e29b-41d4-a716-446655440003', 'Moreau', 'Thomas', 'Médecine générale', '0612223242', 'thomas.moreau@patteetcie.fr');

-- Insertion des animaux
INSERT INTO animal (id, name, species, breed, sex, birth_date, weight, photo_url, owner_id) VALUES
('770e8400-e29b-41d4-a716-446655440001', 'Rex', 'Chien', 'Berger Allemand', 'M', '2020-03-15', 32.50, 'https://example.com/photos/rex.jpg', '550e8400-e29b-41d4-a716-446655440001'),
('770e8400-e29b-41d4-a716-446655440002', 'Minou', 'Chat', 'Européen', 'F', '2019-07-22', 4.20, 'https://example.com/photos/minou.jpg', '550e8400-e29b-41d4-a716-446655440001'),
('770e8400-e29b-41d4-a716-446655440003', 'Max', 'Chien', 'Labrador', 'M', '2021-01-10', 28.00, 'https://example.com/photos/max.jpg', '550e8400-e29b-41d4-a716-446655440002'),
('770e8400-e29b-41d4-a716-446655440004', 'Luna', 'Chat', 'Siamois', 'F', '2022-05-18', 3.80, 'https://example.com/photos/luna.jpg', '550e8400-e29b-41d4-a716-446655440003');

-- Insertion des vaccins (référentiel)
INSERT INTO vaccine (id, type, name, description, validity_duration_months) VALUES
('880e8400-e29b-41d4-a716-446655440001', 'Rage', 'Rabisin', 'Vaccin contre la rage', 12),
('880e8400-e29b-41d4-a716-446655440002', 'Parvovirus', 'Virbagen Parvo', 'Vaccin contre le parvovirus canin', 12),
('880e8400-e29b-41d4-a716-446655440003', 'Typhus', 'Leucofeligen', 'Vaccin contre le typhus félin', 12),
('880e8400-e29b-41d4-a716-446655440004', 'Coryza', 'Purevax RCP', 'Vaccin contre le coryza félin', 12);

-- Insertion des traitements (référentiel)
INSERT INTO treatment (id, name, dosage, frequency) VALUES
('990e8400-e29b-41d4-a716-446655440001', 'Amoxicilline', '500mg', '2 fois par jour'),
('990e8400-e29b-41d4-a716-446655440002', 'Anti-inflammatoire', '10mg/kg', '1 fois par jour'),
('990e8400-e29b-41d4-a716-446655440003', 'Vermifuge', '1 comprimé', 'Dose unique'),
('990e8400-e29b-41d4-a716-446655440004', 'Antiparasitaire externe', '1 pipette', '1 fois par mois');

-- Insertion des visites
INSERT INTO visit (id, visit_date, reason, report, animal_id, veterinarian_id) VALUES
('aa0e8400-e29b-41d4-a716-446655440001', '2024-01-15 10:30:00', 'Vaccination annuelle', 'Animal en bonne santé. Vaccination effectuée sans problème.', '770e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001'),
('aa0e8400-e29b-41d4-a716-446655440002', '2024-03-20 14:00:00', 'Problème de peau', 'Dermite allergique. Traitement prescrit pour 10 jours.', '770e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440002'),
('aa0e8400-e29b-41d4-a716-446655440003', '2024-06-10 09:15:00', 'Contrôle de routine', 'Examen complet. RAS. Vermifuge administré.', '770e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440003'),
('aa0e8400-e29b-41d4-a716-446655440004', '2024-11-05 16:45:00', 'Vaccination', 'Première visite. Vaccination typhus et coryza.', '770e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440001');

-- Insertion des vaccinations
INSERT INTO be_vaccinated (visit_id, vaccine_id, vaccination_date, reminder_date, status, batch_number) VALUES
('aa0e8400-e29b-41d4-a716-446655440001', '880e8400-e29b-41d4-a716-446655440001', '2024-01-15', '2025-01-15', 'to_renew', 'RAB2024-001'),
('aa0e8400-e29b-41d4-a716-446655440001', '880e8400-e29b-41d4-a716-446655440002', '2024-01-15', '2025-01-15', 'to_renew', 'PAR2024-045'),
('aa0e8400-e29b-41d4-a716-446655440004', '880e8400-e29b-41d4-a716-446655440003', '2024-11-05', '2025-11-05', 'up_to_date', 'TYP2024-123'),
('aa0e8400-e29b-41d4-a716-446655440004', '880e8400-e29b-41d4-a716-446655440004', '2024-11-05', '2025-11-05', 'up_to_date', 'COR2024-456');

-- Insertion des traitements prescrits
INSERT INTO be_treated (visit_id, treatment_id, start_date, end_date, observations) VALUES
('aa0e8400-e29b-41d4-a716-446655440002', '990e8400-e29b-41d4-a716-446655440002', '2024-03-20', '2024-03-30', 'Bien toléré, amélioration visible après 3 jours'),
('aa0e8400-e29b-41d4-a716-446655440002', '990e8400-e29b-41d4-a716-446655440001', '2024-03-20', '2024-03-27', 'Traitement complet sans effets secondaires'),
('aa0e8400-e29b-41d4-a716-446655440003', '990e8400-e29b-41d4-a716-446655440003', '2024-06-10', '2024-06-10', 'Vermifuge administré, bien supporté');


-- REQUÊTES DE VÉRIFICATION

-- Compter le nombre d'entrées dans chaque table
SELECT 
    'owner' as table_name, COUNT(*) as count FROM owner
UNION ALL
SELECT 'animal', COUNT(*) FROM animal
UNION ALL
SELECT 'veterinarian', COUNT(*) FROM veterinarian
UNION ALL
SELECT 'visit', COUNT(*) FROM visit
UNION ALL
SELECT 'vaccine', COUNT(*) FROM vaccine
UNION ALL
SELECT 'treatment', COUNT(*) FROM treatment
UNION ALL
SELECT 'be_vaccinated', COUNT(*) FROM be_vaccinated
UNION ALL
SELECT 'be_treated', COUNT(*) FROM be_treated;