-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 21 oct. 2025 à 16:24
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bdd_tpg1`
--

-- --------------------------------------------------------

--
-- Structure de la table `activite`
--

DROP TABLE IF EXISTS `activite`;
CREATE TABLE IF NOT EXISTS `activite` (
  `act_id` int NOT NULL AUTO_INCREMENT,
  `act_nom` varchar(20) NOT NULL,
  `act_description` varchar(500) NOT NULL,
  `act_numero` int NOT NULL,
  PRIMARY KEY (`act_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `chat`
--

DROP TABLE IF EXISTS `chat`;
CREATE TABLE IF NOT EXISTS `chat` (
  `chat_id` int NOT NULL AUTO_INCREMENT,
  `fest_id` int NOT NULL,
  `chat_message` varchar(255) NOT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `fest_id` (`fest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `concert`
--

DROP TABLE IF EXISTS `concert`;
CREATE TABLE IF NOT EXISTS `concert` (
  `con_id` int NOT NULL AUTO_INCREMENT,
  `con_duree` time NOT NULL,
  `con_nom_performeur` varchar(255) NOT NULL,
  PRIMARY KEY (`con_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `festivalier`
--

DROP TABLE IF EXISTS `festivalier`;
CREATE TABLE IF NOT EXISTS `festivalier` (
  `fest_id` int NOT NULL AUTO_INCREMENT,
  `fest_nom` varchar(20) NOT NULL,
  `fest_prenom` varchar(20) NOT NULL,
  `fest_date_naissance` date NOT NULL,
  `fest_email` varchar(50) NOT NULL,
  `fest_password` varchar(100) NOT NULL,
  PRIMARY KEY (`fest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `festivalier_activite`
--

DROP TABLE IF EXISTS `festivalier_activite`;
CREATE TABLE IF NOT EXISTS `festivalier_activite` (
  `fest_act_id` int NOT NULL AUTO_INCREMENT,
  `fest_id` int NOT NULL,
  `act_id` int NOT NULL,
  PRIMARY KEY (`fest_act_id`),
  KEY `fest_id` (`fest_id`,`act_id`),
  KEY `act_id` (`act_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `chat_ibfk_1` FOREIGN KEY (`fest_id`) REFERENCES `festivalier` (`fest_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `festivalier_activite`
--
ALTER TABLE `festivalier_activite`
  ADD CONSTRAINT `festivalier_activite_ibfk_1` FOREIGN KEY (`fest_id`) REFERENCES `festivalier` (`fest_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `festivalier_activite_ibfk_2` FOREIGN KEY (`act_id`) REFERENCES `activite` (`act_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
