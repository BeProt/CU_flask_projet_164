-- OM 2021.02.17
-- FICHIER MYSQL POUR FAIRE FONCTIONNER LES EXEMPLES
-- DE REQUETES MYSQL
-- Database: unger_corentin_i164_info1a

-- Destruction de la BD si elle existe.
-- Pour être certain d'avoir la dernière version des données

DROP DATABASE IF EXISTS unger_corentin_i164_info1a;

-- Création d'un nouvelle base de donnée

CREATE DATABASE IF NOT EXISTS unger_corentin_i164_info1a;

-- Utilisation de cette base de donnée

USE unger_corentin_i164_info1a;
-- --------------------------------------------------------
-- --------------------------------------------------------
-- Hôte :                        localhost
-- Version du serveur:           5.1.72-community - MySQL Community Server (GPL)
-- SE du serveur:                Win32
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Export de la structure de la base pour unger_corentin_i164_info1a
CREATE DATABASE IF NOT EXISTS `unger_corentin_i164_info1a` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `unger_corentin_i164_info1a`;

-- Export de la structure de la table unger_corentin_i164_info1a. t_adresse
CREATE TABLE IF NOT EXISTS `t_adresse` (
  `id_adresse` int(11) NOT NULL AUTO_INCREMENT,
  `nom_adresse` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_adresse`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Export de données de la table unger_corentin_i164_info1a.t_adresse : 2 rows
/*!40000 ALTER TABLE `t_adresse` DISABLE KEYS */;
INSERT INTO `t_adresse` (`id_adresse`, `nom_adresse`) VALUES
	(1, '1 rue du stade'),
	(2, '29 Av. des Pâquis');
/*!40000 ALTER TABLE `t_adresse` ENABLE KEYS */;

-- Export de la structure de la table unger_corentin_i164_info1a. t_entrepôts
CREATE TABLE IF NOT EXISTS `t_entrepôts` (
  `id_entrepôt` int(11) NOT NULL AUTO_INCREMENT,
  `nom_entrepôt` varchar(50) NOT NULL,
  `id_adresse` int(11) NOT NULL,
  PRIMARY KEY (`id_entrepôt`),
  KEY `FKAdresseEntrepot` (`id_adresse`)
) ENGINE=MyISAM AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;

-- Export de données de la table unger_corentin_i164_info1a.t_entrepôts : 2 rows
/*!40000 ALTER TABLE `t_entrepôts` DISABLE KEYS */;
INSERT INTO `t_entrepôts` (`id_entrepôt`, `nom_entrepôt`, `id_adresse`) VALUES
	(100, 'MaisonFamille', 1),
	(101, 'AppartementPapa', 2);
/*!40000 ALTER TABLE `t_entrepôts` ENABLE KEYS */;

-- Export de la structure de la table unger_corentin_i164_info1a. t_pays
CREATE TABLE IF NOT EXISTS `t_pays` (
  `id_pays` int(11) NOT NULL AUTO_INCREMENT,
  `Nom_pays` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_pays`)
) ENGINE=MyISAM AUTO_INCREMENT=2002 DEFAULT CHARSET=latin1;

-- Export de données de la table unger_corentin_i164_info1a.t_pays : 2 rows
/*!40000 ALTER TABLE `t_pays` DISABLE KEYS */;
INSERT INTO `t_pays` (`id_pays`, `Nom_pays`) VALUES
	(2000, 'France'),
	(2001, 'Suisse');
/*!40000 ALTER TABLE `t_pays` ENABLE KEYS */;

-- Export de la structure de la table unger_corentin_i164_info1a. t_personne
CREATE TABLE IF NOT EXISTS `t_personne` (
  `id_personne` int(11) NOT NULL AUTO_INCREMENT,
  `nom_personne` varchar(255) DEFAULT NULL,
  `prenom_personne` varchar(255) DEFAULT NULL,
  `Date_naiss_personne` date DEFAULT NULL,
  `sexe_personne` int(11) DEFAULT NULL,
  `id_adresse` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_personne`),
  KEY `FKPersonneAdresse` (`id_adresse`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Export de données de la table unger_corentin_i164_info1a.t_personne : 2 rows
/*!40000 ALTER TABLE `t_personne` DISABLE KEYS */;
INSERT INTO `t_personne` (`id_personne`, `nom_personne`, `prenom_personne`, `Date_naiss_personne`, `sexe_personne`, `id_adresse`) VALUES
	(1, 'Unger', 'Corentin', '2006-10-15', 0, 2),
	(2, 'Mendes', 'Steph', '1990-11-12', NULL, NULL);
/*!40000 ALTER TABLE `t_personne` ENABLE KEYS */;

-- Export de la structure de la table unger_corentin_i164_info1a. t_personne_avoir_adresse
CREATE TABLE IF NOT EXISTS `t_personne_avoir_adresse` (
  `id_personne_avoir_adresse` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Export de données de la table unger_corentin_i164_info1a.t_personne_avoir_adresse : 0 rows
/*!40000 ALTER TABLE `t_personne_avoir_adresse` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_personne_avoir_adresse` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
