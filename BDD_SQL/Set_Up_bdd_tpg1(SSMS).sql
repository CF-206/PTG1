-- ************************************************************************************
-- SCRIPT CORRIGÉ : ORDRE DE SUPPRESSION DES TABLES INVERSÉ
-- Les tables "enfants" (avec des FOREIGN KEYs) sont supprimées AVANT leurs "parents".
-- ************************************************************************************

-- Crée la base de données si elle n'existe pas
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'bdd_tpg1')
BEGIN
    CREATE DATABASE [bdd_tpg1];
END
GO

-- Sélectionne la base de données pour les opérations suivantes
USE [bdd_tpg1];
GO

-- 1. SUPPRESSION DES TABLES (dans l'ordre inverse des dépendances)

-- Suppression de la table 'festivalier_activite' (enfant de 'festivalier' et 'activite')
IF OBJECT_ID('festivalier_activite', 'U') IS NOT NULL
    DROP TABLE [festivalier_activite];
GO

-- Suppression de la table 'chat' (enfant de 'festivalier')
IF OBJECT_ID('chat', 'U') IS NOT NULL
    DROP TABLE [chat];
GO

-- Suppression des tables "parents"
IF OBJECT_ID('activite', 'U') IS NOT NULL
    DROP TABLE [activite];
GO

IF OBJECT_ID('concert', 'U') IS NOT NULL
    DROP TABLE [concert];
GO

IF OBJECT_ID('festivalier', 'U') IS NOT NULL
    DROP TABLE [festivalier];
GO


-- 2. CRÉATION DES TABLES (dans n'importe quel ordre, sans les FKs)

-- Structure de la table 'activite'
CREATE TABLE [activite] (
    [act_id] INT IDENTITY(1,1) NOT NULL,
    [act_nom] VARCHAR(20) NOT NULL,
    [act_description] VARCHAR(500) NOT NULL,
    [act_numero] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([act_id])
);
GO

-- Structure de la table 'festivalier'
CREATE TABLE [festivalier] (
    [fest_id] INT IDENTITY(1,1) NOT NULL,
    [fest_nom] VARCHAR(20) NOT NULL,
    [fest_prenom] VARCHAR(20) NOT NULL,
    [fest_date_naissance] DATE NOT NULL,
    [fest_email] VARCHAR(50) NOT NULL,
    [fest_password] VARCHAR(100) NOT NULL,
    PRIMARY KEY CLUSTERED ([fest_id])
);
GO

-- Structure de la table 'chat'
CREATE TABLE [chat] (
    [chat_id] INT IDENTITY(1,1) NOT NULL,
    [fest_id] INT NOT NULL,
    [chat_message] VARCHAR(255) NOT NULL,
    PRIMARY KEY CLUSTERED ([chat_id])
);
GO

-- Structure de la table 'concert'
CREATE TABLE [concert] (
    [con_id] INT IDENTITY(1,1) NOT NULL,
    [con_duree] TIME NOT NULL,
    [con_nom_performeur] VARCHAR(255) NOT NULL,
    PRIMARY KEY CLUSTERED ([con_id])
);
GO

-- Structure de la table 'festivalier_activite'
CREATE TABLE [festivalier_activite] (
    [fest_act_id] INT IDENTITY(1,1) NOT NULL,
    [fest_id] INT NOT NULL,
    [act_id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([fest_act_id])
);
GO


-- 3. AJOUT DES CONTRAINTES DE CLÉ ÉTRANGÈRE (FOREIGN KEYs)

-- Contraintes pour la table 'chat'
ALTER TABLE [chat]
    ADD CONSTRAINT [FK_chat_festivalier] FOREIGN KEY ([fest_id])
    REFERENCES [festivalier] ([fest_id])
    ON DELETE CASCADE
    ON UPDATE CASCADE;
GO

-- Contraintes pour la table 'festivalier_activite'
ALTER TABLE [festivalier_activite]
    ADD CONSTRAINT [FK_festact_festivalier] FOREIGN KEY ([fest_id])
    REFERENCES [festivalier] ([fest_id])
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE [festivalier_activite]
    ADD CONSTRAINT [FK_festact_activite] FOREIGN KEY ([act_id])
    REFERENCES [activite] ([act_id])
    ON DELETE CASCADE
    ON UPDATE CASCADE;
GO