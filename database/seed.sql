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