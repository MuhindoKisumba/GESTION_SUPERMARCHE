# Projet DSIG – Gestion d’un Supermarché (PostgreSQL)

## Présentation générale

Ce projet consiste à concevoir et implémenter une **base de données relationnelle complète** pour la gestion d’un supermarché en utilisant le SGBD **PostgreSQL**.
Il est réalisé dans le cadre du cours **DSIG (Développement des Systèmes d’Information et de Gestion)**.

Le projet couvre :

* la modélisation des données
* les contraintes d’intégrité
* les triggers
* les procédures stockées
* les fonctions SQL
* les sous-requêtes
* la sécurité (rôles, privilèges, GRANT / REVOKE)

---

## Structure de la base de données

### Base de données

* **Nom :** `supermarche`

### Tables principales

* `categorie`
* `fournisseur`
* `produit`
* `client`
* `employe`
* `stock`
* `vente`
* `ligne_vente`
* `paiement`
* `audit_stock`
* `utilisateur`

Chaque table respecte les règles de normalisation avec des clés primaires, étrangères et contraintes métier.

---

## Description des tables

### categorie

Gestion des catégories de produits.

### fournisseur

Informations sur les fournisseurs (contact, pays, adresse).

### produit

Gestion des produits avec prix d’achat, prix de vente, catégorie et fournisseur.

### client

Gestion des clients avec système de fidélité automatique.

### employe

Informations sur les employés du supermarché.

### stock

Suivi des quantités disponibles et seuils d’alerte.

### vente

Enregistrement des ventes effectuées.

### ligne_vente

Détail des produits vendus par vente.

### paiement

Gestion des paiements (Cash, Mobile Money, Carte).

### audit_stock

Journalisation des opérations sensibles sur le stock (DSIG).

### utilisateur

Gestion des utilisateurs applicatifs et de leurs rôles.

---

## Sécurité et gestion des rôles

### Rôles fonctionnels

* `role_admin` : contrôle total du système
* `role_caissier` : ventes et paiements
* `role_gestionnaire` : produits et stock
* `role_auditeur` : lecture seule

### Sécurité implémentée

* GRANT / REVOKE
* Séparation des responsabilités
* Privilèges par table
* Droits automatiques sur nouvelles tables

---

## Triggers (Automatisation)

### Triggers implémentés

* Mise à jour automatique du stock après une vente
* Audit automatique du stock lorsque le seuil est atteint
* Fidélisation automatique des clients selon leurs achats

Les triggers assurent la cohérence et la traçabilité des données.

---

## Procédures stockées

### Procédures disponibles

* `sp_enregistrer_vente` : enregistrement d’une vente
* `sp_ajouter_stock` : approvisionnement du stock

Elles centralisent la logique métier côté base de données.

---

## Fonctions SQL

* `fn_chiffre_affaires()` : calcul du chiffre d’affaires global
* `fn_total_client(id_client)` : total des achats par client

Utilisées pour les rapports et statistiques.

---

## Sous-requêtes DSIG

Exemples inclus :

* Produits en rupture de stock
* Clients au-dessus de la moyenne d’achat
* Produit le plus vendu
* Employés les plus performants

---

## Instructions d’installation

1. Ouvrir PostgreSQL (psql ou pgAdmin)
2. Exécuter le script SQL complet dans l’ordre
3. Vérifier la création des tables, triggers et rôles
4. Tester les accès avec `SET ROLE`

---

## Objectifs pédagogiques atteints

* Maîtrise de PostgreSQL
* Utilisation avancée de SQL
* Sécurité des bases de données
* Automatisation via triggers
* Bonnes pratiques DSIG

---


## Perspectives d’évolution

* Interface web (PHP / Django / Laravel)
* Gestion multi-supermarchés
* Promotions et remises
* Table historique des prix
* Tableau de bord décisionnel

---
## Auteur

* **Nom :** Muhindo Kisumba Abdiel
* **Cours :** DSIG
* **SGBD :** PostgreSQL

