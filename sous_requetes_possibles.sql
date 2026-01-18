--1. Produits en rupture de stock
---------------------------------
SELECT *
FROM produit
WHERE id_produit IN (
    SELECT id_produit
    FROM stock
    WHERE quantite <= seuil_alerte
);

--2. Clients ayant dépensé plus que la moyenne
----------------------------------------------
SELECT *
FROM client
WHERE id_client IN (
    SELECT id_client
    FROM vente
    GROUP BY id_client
    HAVING SUM(total) > (
        SELECT AVG(total) FROM vente
    )
);

--3. Produit le plus vendu
---------------------------
SELECT nom
FROM produit
WHERE id_produit = (
    SELECT id_produit
    FROM ligne_vente
    GROUP BY id_produit
    ORDER BY SUM(quantite) DESC
    LIMIT 1
);

--4. Employés ayant réalisé plus de 5 ventes
--------------------------------------------
SELECT *
FROM employe
WHERE id_employe IN (
    SELECT id_employe
    FROM vente
    GROUP BY id_employe
    HAVING COUNT(*) > 5
);

