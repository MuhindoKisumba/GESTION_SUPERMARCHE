--Procédure : enregistrer une vente complète
---------------------------------------------
CREATE OR REPLACE PROCEDURE sp_enregistrer_vente(
    p_id_client INT,
    p_id_employe INT,
    p_total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO vente (id_client, id_employe, total)
    VALUES (p_id_client, p_id_employe, p_total);
END;
$$;

--Procédure : approvisionnement stock
-------------------------------------
CREATE OR REPLACE PROCEDURE sp_ajouter_stock(
    p_id_produit INT,
    p_quantite INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE stock
    SET quantite = quantite + p_quantite
    WHERE id_produit = p_id_produit;
END;
$$;


