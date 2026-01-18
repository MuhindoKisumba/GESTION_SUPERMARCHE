--Creation des rôles fonctionnels, pas des utilisateurs directement.
--------------------------------------------------------------------
-- Administrateur du système
CREATE ROLE role_admin;

-- Caissier (vente uniquement)
CREATE ROLE role_caissier;

-- Gestionnaire (stock + produits)
CREATE ROLE role_gestionnaire;

-- Auditeur (lecture seule)
CREATE ROLE role_auditeur;

--CRÉATION DES UTILISATEURS POSTGRES
------------------------------------
CREATE USER admin_sm WITH PASSWORD 'Admin@2026';
CREATE USER caissier_sm WITH PASSWORD 'Cash@2026';
CREATE USER gestion_sm WITH PASSWORD 'Gest@2026';
CREATE USER audit_sm WITH PASSWORD 'Audit@2026';

--ASSOCIATION UTILISATEURS → RÔLES
----------------------------------
GRANT role_admin TO admin_sm;
GRANT role_caissier TO caissier_sm;
GRANT role_gestionnaire TO gestion_sm;
GRANT role_auditeur TO audit_sm;

--DROITS PAR DÉFAUT SUR LA BASE
-------------------------------
-- Connexion à la base
GRANT CONNECT ON DATABASE supermarche TO role_admin, role_caissier, role_gestionnaire, role_auditeur;

-- Accès au schéma public
GRANT USAGE ON SCHEMA public TO role_admin, role_caissier, role_gestionnaire, role_auditeur;

--DROITS DÉTAILLÉS PAR RÔLE
--ROLE_ADMIN (TOUT)
----------------------------
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO role_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO role_admin;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO role_admin;

--ROLE_CAISSIER (VENTE UNIQUEMENT)
----------------------------------
GRANT SELECT, INSERT ON vente TO role_caissier;
GRANT SELECT, INSERT ON ligne_vente TO role_caissier;
GRANT SELECT, INSERT ON paiement TO role_caissier;

-- Lecture clients et produits
GRANT SELECT ON client, produit TO role_caissier;

--ROLE_GESTIONNAIRE (STOCK & PRODUITS)
--------------------------------------
GRANT SELECT, INSERT, UPDATE ON produit TO role_gestionnaire;
GRANT SELECT, INSERT, UPDATE ON stock TO role_gestionnaire;
GRANT SELECT, INSERT ON fournisseur, categorie TO role_gestionnaire;

-- Lecture audit
GRANT SELECT ON audit_stock TO role_gestionnaire;

--ROLE_AUDITEUR (LECTURE SEULE)
--------------------------------
GRANT SELECT ON
client,employe,produit,
categorie,fournisseur,stock,vente,ligne_vente,
paiement,audit_stock
TO role_auditeur;

--REVOKE (BONNE PRATIQUE DSIG)
--Exemple : retirer un droit dangereux
----------------------------------------
REVOKE DELETE ON vente FROM role_caissier;
REVOKE UPDATE ON stock FROM role_caissier;

--DROITS AUTOMATIQUES SUR NOUVELLES TABLES
--Important en production & DSIG
------------------------------------------
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO role_auditeur;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT ON TABLES TO role_caissier;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON TABLES TO role_admin;

--TESTS DE SÉCURITÉ (À METTRE DANS LE RAPPORT)
----------------------------------------------
-- Connexion caissier
SET ROLE role_caissier;
INSERT INTO vente (id_client, id_employe, total) VALUES (1,1,50); -- OK
DELETE FROM vente WHERE id_vente = 1; -- ERREUR

-- Connexion auditeur
SET ROLE role_auditeur;
SELECT * FROM paiement; -- OK
INSERT INTO paiement (...) VALUES (...); -- ERREUR

