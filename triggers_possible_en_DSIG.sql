--Trigger 1 : Mise à jour automatique du stock après vente
-----------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_update_stock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE stock
    SET quantite = quantite - NEW.quantite
    WHERE id_produit = NEW.id_produit;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_stock
AFTER INSERT ON ligne_vente
FOR EACH ROW
EXECUTE FUNCTION fn_update_stock();

--Trigger 2 : Alerte stock bas + audit automatique
---------------------------------------------------
CREATE OR REPLACE FUNCTION fn_audit_stock()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantite <= NEW.seuil_alerte THEN
        INSERT INTO audit_stock (
            id_produit,
            action,
            ancienne_quantite,
            nouvelle_quantite
        )
        VALUES (
            NEW.id_produit,
            'STOCK_BAS',
            OLD.quantite,
            NEW.quantite
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_audit_stock
AFTER UPDATE ON stock
FOR EACH ROW
EXECUTE FUNCTION fn_audit_stock();

--Trigger 3 : Client fidèle automatique
----------------------------------------
CREATE OR REPLACE FUNCTION fn_fidelite_client()
RETURNS TRIGGER AS $$
DECLARE total_achat NUMERIC;
BEGIN
    SELECT SUM(total)
    INTO total_achat
    FROM vente
    WHERE id_client = NEW.id_client;

    IF total_achat >= 500 THEN
        UPDATE client
        SET fidelite = TRUE
        WHERE id_client = NEW.id_client;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_fidelite_client
AFTER INSERT ON vente
FOR EACH ROW
EXECUTE FUNCTION fn_fidelite_client();


