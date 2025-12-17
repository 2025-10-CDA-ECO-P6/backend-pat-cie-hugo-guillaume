INSERT INTO "vaccin" ("nom", "type", "duree_validite_mois", "description") VALUES
('Rage', 'Virus', 12, 'Obligatoire pour voyager'),
('Typhus', 'Virus', 12, 'Essentiel pour les chats'),
('Leucose', 'Virus', 12, 'Recommandé pour les chats sortants'),
('CHPPi', 'Cocktail', 12, 'Carré, Hépatite, Parvovirose pour chiens');

INSERT INTO "traitement" ("nom", "dosage", "frequence") VALUES
('Amoxicilline', '200mg', 'Matin et Soir'),
('Metacam', '1.5mg', 'Une fois par jour'),
('Vermifuge Drontal', '1 comprimé', 'Une seule prise');

INSERT INTO "utilisateur" ("email", "mot_de_passe", "role", "nom", "prenom", "specialite", "adresse") 
VALUES ('veto@pattecie.com', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6LrahZCp3.Tl1I3y', 'VETERINAIRE', 'House', 'Gregory', 'Chirurgie', 'Clinique Princeton');

INSERT INTO "utilisateur" ("email", "mot_de_passe", "role", "nom", "prenom", "telephone", "adresse") 
VALUES ('proprio@gmail.com', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6LrahZCp3.Tl1I3y', 'PROPRIETAIRE', 'Michu', 'Germaine', '0606060606', '12 rue des Fleurs');

INSERT INTO "animal" ("nom", "espece", "race", "sexe", "date_naissance", "poids", "utilisateur_id")
VALUES ('Rex', 'Chien', 'Berger Allemand', 'M', '2020-05-15', 32.5, 2);

INSERT INTO "visite" ("date_", "motif", "compte_rendu", "animal_id", "veterinaire_id")
VALUES (NOW(), 'Consultation annuelle', 'Animal en bonne santé. Vaccination effectuée.', 1, 1);

INSERT INTO "etre_vaccine" ("visite_id", "vaccin_id", "date_rappel", "lot")
VALUES (1, 1, NOW() + INTERVAL '1 year', 'LOT-A452');

INSERT INTO "suivre" ("visite_id", "traitement_id", "date_debut", "observation")
VALUES (1, 3, NOW(), 'A donner ce soir dans la gamelle');