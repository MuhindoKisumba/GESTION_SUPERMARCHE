-- ===============================
-- BASE : GESTION_SUPERMARCHE
-- ===============================

CREATE DATABASE supermarche;

-- ===============================
-- TABLE : CATEGORIE
-- ===============================
CREATE TABLE categorie (
    id_categorie SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- ===============================
-- TABLE : FOURNISSEUR
-- ===============================
CREATE TABLE fournisseur (
    id_fournisseur SERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    telephone VARCHAR(20),
    email VARCHAR(100),
    adresse TEXT,
    pays VARCHAR(50)
);

-- ===============================
-- TABLE : PRODUIT
-- ===============================
CREATE TABLE produit (
    id_produit SERIAL PRIMARY KEY,
    code_produit VARCHAR(30) UNIQUE NOT NULL,
    nom VARCHAR(150) NOT NULL,
    prix_achat NUMERIC(10,2) CHECK (prix_achat > 0),
    prix_vente NUMERIC(10,2) CHECK (prix_vente > 0),
    id_categorie INT REFERENCES categorie(id_categorie),
    id_fournisseur INT REFERENCES fournisseur(id_fournisseur),
    date_expiration DATE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- TABLE : CLIENT
-- ===============================
CREATE TABLE client (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    telephone VARCHAR(20),
    email VARCHAR(100),
    fidelite BOOLEAN DEFAULT FALSE,
    date_inscription DATE DEFAULT CURRENT_DATE
);

-- ===============================
-- TABLE : EMPLOYE
-- ===============================
CREATE TABLE employe (
    id_employe SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    fonction VARCHAR(50),
    salaire NUMERIC(10,2),
    date_embauche DATE,
    actif BOOLEAN DEFAULT TRUE
);

-- ===============================
-- TABLE : STOCK
-- ===============================
CREATE TABLE stock (
    id_stock SERIAL PRIMARY KEY,
    id_produit INT UNIQUE REFERENCES produit(id_produit) ON DELETE CASCADE,
    quantite INT CHECK (quantite >= 0),
    seuil_alerte INT DEFAULT 5
);

-- ===============================
-- TABLE : VENTE
-- ===============================
CREATE TABLE vente (
    id_vente SERIAL PRIMARY KEY,
    date_vente TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_client INT REFERENCES client(id_client),
    id_employe INT REFERENCES employe(id_employe),
    total NUMERIC(10,2) DEFAULT 0
);

-- ===============================
-- TABLE : LIGNE_VENTE
-- ===============================
CREATE TABLE ligne_vente (
    id_ligne SERIAL PRIMARY KEY,
    id_vente INT REFERENCES vente(id_vente) ON DELETE CASCADE,
    id_produit INT REFERENCES produit(id_produit),
    quantite INT CHECK (quantite > 0),
    prix_unitaire NUMERIC(10,2),
    sous_total NUMERIC(10,2)
);

-- ===============================
-- TABLE : PAIEMENT
-- ===============================
CREATE TABLE paiement (
    id_paiement SERIAL PRIMARY KEY,
    id_vente INT REFERENCES vente(id_vente),
    mode_paiement VARCHAR(30)
        CHECK (mode_paiement IN ('CASH','M_PESA','AIRTEL_MONEY','ORANGE_MONEY','CARTE')),
    montant NUMERIC(10,2),
    date_paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- TABLE : AUDIT_STOCK (DSIG)
-- ===============================
CREATE TABLE audit_stock (
    id_audit SERIAL PRIMARY KEY,
    id_produit INT,
    action VARCHAR(50),
    ancienne_quantite INT,
    nouvelle_quantite INT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
go
CREATE TABLE utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    nom_utilisateur VARCHAR(50) UNIQUE NOT NULL,
    mot_de_passe TEXT NOT NULL,
    role VARCHAR(30) NOT NULL
        CHECK (role IN ('ADMIN','CAISSIER','GESTIONNAIRE','AUDITEUR')),
    actif BOOLEAN DEFAULT TRUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

