--Fonction : chiffre d’affaires total
-------------------------------------
CREATE OR REPLACE FUNCTION fn_chiffre_affaires()
RETURNS NUMERIC AS $$
BEGIN
    RETURN (SELECT SUM(total) FROM vente);
END;
$$ LANGUAGE plpgsql;

--Fonction : total ventes par client
------------------------------------
CREATE OR REPLACE FUNCTION fn_total_client(p_id_client INT)
RETURNS NUMERIC AS $$
BEGIN
    RETURN (
        SELECT SUM(total)
        FROM vente
        WHERE id_client = p_id_client
    );
END;
$$ LANGUAGE plpgsql;
