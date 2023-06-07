-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour unger_corentin_i164_info1a
DROP DATABASE IF EXISTS `unger_corentin_i164_info1a`;
CREATE DATABASE IF NOT EXISTS `unger_corentin_i164_info1a` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `unger_corentin_i164_info1a`;

-- Listage de la structure de table unger_corentin_i164_info1a. t_commande
DROP TABLE IF EXISTS `t_commande`;
CREATE TABLE IF NOT EXISTS `t_commande` (
  `IDCom` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`IDCom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table unger_corentin_i164_info1a. t_entrepot
DROP TABLE IF EXISTS `t_entrepot`;
CREATE TABLE IF NOT EXISTS `t_entrepot` (
  `IDEntrepot` int NOT NULL AUTO_INCREMENT,
  `IDLo` int NOT NULL,
  `EntrepotNom` varchar(20) NOT NULL,
  `EntrepotAdresse` varchar(50) NOT NULL,
  PRIMARY KEY (`IDEntrepot`),
  KEY `FOREIGN KEY` (`IDLo`),
  CONSTRAINT `FK_t_entrepot_t_localite` FOREIGN KEY (`IDLo`) REFERENCES `t_localite` (`IDLo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table unger_corentin_i164_info1a. t_fournisseur
DROP TABLE IF EXISTS `t_fournisseur`;
CREATE TABLE IF NOT EXISTS `t_fournisseur` (
  `IDFou` int NOT NULL AUTO_INCREMENT,
  `IDLo` int DEFAULT NULL,
  `FNom` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `FAdresse` varchar(50) DEFAULT NULL,
  `FNomcontact` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDFou`) USING BTREE,
  KEY `FOREIGN KEY` (`IDLo`),
  CONSTRAINT `FK_t_fournisseur_t_localite` FOREIGN KEY (`IDLo`) REFERENCES `t_localite` (`IDLo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table unger_corentin_i164_info1a. t_livraison
DROP TABLE IF EXISTS `t_livraison`;
CREATE TABLE IF NOT EXISTS `t_livraison` (
  `IDLivr` int NOT NULL AUTO_INCREMENT,
  `IDFou` int NOT NULL,
  `LIMontantPrix` int NOT NULL,
  `LIDate` date NOT NULL,
  PRIMARY KEY (`IDLivr`) USING BTREE,
  KEY `FOREIGN KEY` (`IDFou`) USING BTREE,
  CONSTRAINT `FK_t_livraison_t_fournisseur` FOREIGN KEY (`IDFou`) REFERENCES `t_fournisseur` (`IDFou`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table unger_corentin_i164_info1a. t_livraison_produit
DROP TABLE IF EXISTS `t_livraison_produit`;
CREATE TABLE IF NOT EXISTS `t_livraison_produit` (
  `IDLiPro` int NOT NULL AUTO_INCREMENT,
  `IDLivr` int NOT NULL,
  `IDPro` int NOT NULL,
  `LiProQuantite` int NOT NULL,
  PRIMARY KEY (`IDLiPro`),
  KEY `FOREIGN KEY` (`IDLivr`,`IDPro`) USING BTREE,
  KEY `FK_t_livraison_produit_t_produit` (`IDPro`),
  CONSTRAINT `FK_t_livraison_produit_t_livraison` FOREIGN KEY (`IDLivr`) REFERENCES `t_livraison` (`IDLivr`),
  CONSTRAINT `FK_t_livraison_produit_t_produit` FOREIGN KEY (`IDPro`) REFERENCES `t_produit` (`IDPro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table unger_corentin_i164_info1a. t_localite
DROP TABLE IF EXISTS `t_localite`;
CREATE TABLE IF NOT EXISTS `t_localite` (
  `IDLo` int NOT NULL AUTO_INCREMENT,
  `IDPa` int DEFAULT NULL,
  `LOCodePostal` smallint DEFAULT NULL,
  `LOCanton` varchar(50) DEFAULT NULL,
  `LORegion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDLo`),
  KEY `FOREIGN KEY` (`IDPa`) USING BTREE,
  CONSTRAINT `FK_t_localite_t_pays` FOREIGN KEY (`IDPa`) REFERENCES `t_pays` (`IDPa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table unger_corentin_i164_info1a. t_pays
DROP TABLE IF EXISTS `t_pays`;
CREATE TABLE IF NOT EXISTS `t_pays` (
  `IDPa` int NOT NULL AUTO_INCREMENT,
  `PaNom` varchar(20) NOT NULL,
  PRIMARY KEY (`IDPa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table unger_corentin_i164_info1a. t_personne
DROP TABLE IF EXISTS `t_personne`;
CREATE TABLE IF NOT EXISTS `t_personne` (
  `IDPers` int NOT NULL AUTO_INCREMENT,
  `IDLo` int NOT NULL,
  `PersNom` varchar(30) NOT NULL,
  `Persprenom` varchar(50) NOT NULL,
  `PersSexe` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDPers`),
  KEY `FOREIGN KEY` (`IDLo`),
  CONSTRAINT `FK_t_personne_t_localite` FOREIGN KEY (`IDLo`) REFERENCES `t_localite` (`IDLo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table unger_corentin_i164_info1a. t_produit
DROP TABLE IF EXISTS `t_produit`;
CREATE TABLE IF NOT EXISTS `t_produit` (
  `IDPro` int NOT NULL AUTO_INCREMENT,
  `ProNom` varchar(50) NOT NULL,
  `ProPrix` int NOT NULL,
  PRIMARY KEY (`IDPro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Les données exportées n'étaient pas sélectionnées.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
