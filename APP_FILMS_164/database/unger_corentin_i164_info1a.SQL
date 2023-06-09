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

-- Listage de la structure de table unger_corentin_i164_info1a. t_categorie
DROP TABLE IF EXISTS `t_categorie`;
CREATE TABLE IF NOT EXISTS `t_categorie` (
  `IDCate` int NOT NULL AUTO_INCREMENT,
  `CateNom` varchar(50) NOT NULL,
  PRIMARY KEY (`IDCate`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_categorie : ~2 rows (environ)
INSERT INTO `t_categorie` (`IDCate`, `CateNom`) VALUES
	(1, 'Protéines'),
	(2, 'Vitamines'),
	(3, 'Vêtements & Accessoires');

-- Listage de la structure de table unger_corentin_i164_info1a. t_commande
DROP TABLE IF EXISTS `t_commande`;
CREATE TABLE IF NOT EXISTS `t_commande` (
  `IDCom` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`IDCom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_commande : ~0 rows (environ)

-- Listage de la structure de table unger_corentin_i164_info1a. t_entrepot
DROP TABLE IF EXISTS `t_entrepot`;
CREATE TABLE IF NOT EXISTS `t_entrepot` (
  `IDEntrepot` int NOT NULL AUTO_INCREMENT,
  `IDLo` int NOT NULL,
  `EntrepotNom` varchar(20) NOT NULL,
  `EntrepotAdresse` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`IDEntrepot`),
  KEY `FOREIGN KEY` (`IDLo`),
  CONSTRAINT `FK_t_entrepot_t_localite` FOREIGN KEY (`IDLo`) REFERENCES `t_localite` (`IDLo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_entrepot : ~1 rows (environ)
INSERT INTO `t_entrepot` (`IDEntrepot`, `IDLo`, `EntrepotNom`, `EntrepotAdresse`) VALUES
	(1, 1, 'Maison', '1 rue du stade');

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

-- Listage des données de la table unger_corentin_i164_info1a.t_fournisseur : ~0 rows (environ)

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

-- Listage des données de la table unger_corentin_i164_info1a.t_livraison : ~0 rows (environ)

-- Listage de la structure de table unger_corentin_i164_info1a. t_livraison_produit
DROP TABLE IF EXISTS `t_livraison_produit`;
CREATE TABLE IF NOT EXISTS `t_livraison_produit` (
  `IDLiPro` int NOT NULL AUTO_INCREMENT,
  `FKLivr` int NOT NULL,
  `FKPro` int NOT NULL,
  `LiProQuantite` int NOT NULL,
  PRIMARY KEY (`IDLiPro`),
  KEY `FOREIGN KEY` (`FKLivr`,`FKPro`) USING BTREE,
  KEY `FK_t_livraison_produit_t_produit` (`FKPro`) USING BTREE,
  CONSTRAINT `FK_t_livraison_produit_t_livraison` FOREIGN KEY (`FKLivr`) REFERENCES `t_livraison` (`IDLivr`),
  CONSTRAINT `FK_t_livraison_produit_t_produit` FOREIGN KEY (`FKPro`) REFERENCES `t_produit` (`IDPro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_livraison_produit : ~0 rows (environ)

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_localite : ~0 rows (environ)
INSERT INTO `t_localite` (`IDLo`, `IDPa`, `LOCodePostal`, `LOCanton`, `LORegion`) VALUES
	(1, 1, 1222, 'efef', NULL);

-- Listage de la structure de table unger_corentin_i164_info1a. t_marque
DROP TABLE IF EXISTS `t_marque`;
CREATE TABLE IF NOT EXISTS `t_marque` (
  `IDMarque` int NOT NULL AUTO_INCREMENT,
  `MarqueNom` varchar(50) NOT NULL,
  PRIMARY KEY (`IDMarque`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_marque : ~0 rows (environ)
INSERT INTO `t_marque` (`IDMarque`, `MarqueNom`) VALUES
	(1, 'Bulk');

-- Listage de la structure de table unger_corentin_i164_info1a. t_pays
DROP TABLE IF EXISTS `t_pays`;
CREATE TABLE IF NOT EXISTS `t_pays` (
  `IDPa` int NOT NULL AUTO_INCREMENT,
  `PaNom` varchar(20) NOT NULL,
  PRIMARY KEY (`IDPa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_pays : ~0 rows (environ)
INSERT INTO `t_pays` (`IDPa`, `PaNom`) VALUES
	(1, 'Test');

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

-- Listage des données de la table unger_corentin_i164_info1a.t_personne : ~0 rows (environ)

-- Listage de la structure de table unger_corentin_i164_info1a. t_produit
DROP TABLE IF EXISTS `t_produit`;
CREATE TABLE IF NOT EXISTS `t_produit` (
  `IDPro` int NOT NULL AUTO_INCREMENT,
  `FKCate` int DEFAULT NULL,
  `FKMarque` int DEFAULT NULL,
  `ProNom` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `ProPrixFR` decimal(20,6) DEFAULT NULL,
  `ProPrixCH` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`IDPro`),
  KEY `IDCate` (`FKCate`) USING BTREE,
  KEY `FK_t_produit_t_marque` (`FKMarque`) USING BTREE,
  CONSTRAINT `FK_t_produit_t_categorie` FOREIGN KEY (`FKCate`) REFERENCES `t_categorie` (`IDCate`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_t_produit_t_marque` FOREIGN KEY (`FKMarque`) REFERENCES `t_marque` (`IDMarque`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1122 DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_produit : ~63 rows (environ)
INSERT INTO `t_produit` (`IDPro`, `FKCate`, `FKMarque`, `ProNom`, `ProPrixFR`, `ProPrixCH`) VALUES
	(1, 1, 1, 'Protéine Whey en Poudre', 22.000000, 26.000000),
	(2, 1, 1, 'L\'isolat de Whey', 30.000000, 34.000000),
	(856, 1, 1, 'Protéine Vegan en Poudre', 21.000000, NULL),
	(857, NULL, 1, 'Collagène et vitamine C', 28.000000, NULL),
	(858, NULL, 1, 'Clear Whey Isolate', 31.000000, NULL),
	(859, NULL, 1, 'Isolat de Protéine de Pois', 13.000000, NULL),
	(860, NULL, 1, 'Protéines véganes gourmet', 32.000000, 33.000000),
	(861, NULL, 1, 'Brownie Protéiné Vegan', 3.000000, NULL),
	(862, NULL, 1, 'Vegan Mass Gainer', 56.000000, 56.000000),
	(863, NULL, 1, 'Oméga-3 6 9 végétaliens - Huile d’Ahiflower 750mg', 30.000000, 30.000000),
	(864, NULL, 1, 'Protéine Clear Vegan', 33.000000, NULL),
	(865, NULL, 1, 'Tout-en-Un Végan', 80.000000, 80.000000),
	(866, NULL, 1, 'Complexe multivitamines', 19.000000, NULL),
	(867, NULL, 1, 'Gélules d\'Oméga 3 Haute Puissance 1000 mg', 22.000000, NULL),
	(868, NULL, 1, 'ZMA , capsules 810 mg', 24.000000, 24.000000),
	(869, NULL, 1, 'Gélules de 500 mg d’ashwagandha KSM-66', 12.000000, NULL),
	(870, NULL, 1, 'Gélules d\'Oméga 3, Huile de Poisson, 1000 mg', 10.000000, 10.000000),
	(871, NULL, 1, 'Comprimés de Bisglycinate de Magnésium 500 mg', 10.000000, 10.000000),
	(872, NULL, 1, 'Créatine monohydrate', 9.000000, 9.000000),
	(874, NULL, 1, 'Gainer Prise de masse', 25.000000, NULL),
	(875, NULL, 1, 'BCAA instantanés en poudre', 12.000000, 12.000000),
	(876, NULL, 1, 'Gainer Masse Sèche', 29.000000, NULL),
	(877, NULL, 1, 'Créatine Monohydrate Creapure®', 10.000000, NULL),
	(878, NULL, 1, 'ZMA® , capsules 810 mg', 24.000000, NULL),
	(879, NULL, 1, 'Gélules de 500 mg d’ashwagandha KSM-66®', 12.000000, NULL),
	(880, NULL, 1, 'Thé vert matcha en poudre', 17.000000, NULL),
	(881, NULL, 1, 'OptiZinc® , comprimés 30 mg', 11.000000, NULL),
	(882, NULL, 1, 'Micro Algue Spiruline en poudre', 10.000000, NULL),
	(883, NULL, 1, 'MSM (méthylsulfonylméthane) en poudre', 8.000000, NULL),
	(884, NULL, 1, 'Brûle-graisses Thermogène, Formulation complète', 22.000000, NULL),
	(885, NULL, 1, 'Sirop zéro calorie', 8.000000, NULL),
	(886, NULL, 1, 'Nouilles de Régime 200g', 4.000000, NULL),
	(887, NULL, 1, 'Pâtes de Régime 200g', 4.000000, NULL),
	(888, NULL, 1, 'Sirop Barista zéro calorie', 11.000000, NULL),
	(889, NULL, 1, 'Riz de Régime', 4.000000, NULL),
	(890, NULL, 1, 'Beurre de cacahuètes 100% naturel 1kg', 10.000000, 15.000000),
	(891, NULL, 1, 'Graines de chia', 9.000000, NULL),
	(892, NULL, 1, 'LiquiFlav', 10.000000, NULL),
	(893, NULL, 1, 'Baies de Goji déshydratées', 15.000000, NULL),
	(894, NULL, 1, 'Canneberges déshydratées', 9.000000, NULL),
	(895, NULL, 1, 'Barre Protéinée MACRO MUNCH', 4.000000, NULL),
	(896, NULL, 1, 'Shaker Iconic', 6.000000, NULL),
	(897, NULL, 1, 'T-shirt d’entraînement', 20.000000, 20.000000),
	(1080, NULL, 1, 'Casquette de baseball Bulk×New Era FORTY', 23.000000, NULL),
	(1081, NULL, 1, 'Foam Roller', 19.000000, NULL),
	(1083, NULL, 1, 'Mini Shaker Iconic', 5.000000, NULL),
	(1084, NULL, 1, 'Shaker Classic', 6.000000, NULL),
	(1085, NULL, 1, 'Shaker en acier inoxydable Deluxe™', 14.000000, NULL),
	(1086, NULL, 1, 'Ceinture de levage', 37.000000, 36.000000),
	(1087, NULL, 1, 'Shaker en acier 750 ml Bulk × Barratt', 14.000000, 14.000000),
	(1088, NULL, 1, 'Gourde d\'eau 2,2 L', 10.000000, 10.000000),
	(1089, NULL, 1, 'Sangles de levage Premium', 10.000000, 10.000000),
	(1090, NULL, 1, 'Shaker XL Iconic™', 8.000000, 9.000000),
	(1091, NULL, 1, 'Sangles de levage', 6.000000, 6.000000),
	(1092, NULL, 1, 'Genouillères de qualité supérieure', 35.000000, 33.490000),
	(1093, NULL, 1, 'Craie liquide 50 ml', 5.000000, NULL),
	(1094, NULL, 1, 'Pilulier', 2.490000, 2.490000),
	(1095, NULL, 1, 'Protège-poignets Premium', 15.000000, 15.000000),
	(1096, NULL, 1, 'Capsules Végétariennes', 7.490000, NULL),
	(1097, NULL, 1, 'Capsules en gélatine', 6.000000, 5.490000),
	(1098, NULL, 1, 'Gourde de sport', 5.000000, NULL),
	(1099, NULL, 1, 'Protection pour barre de squat', 12.490000, NULL),
	(1100, NULL, 1, 'Boîte vide', 4.490000, NULL);

-- Listage de la structure de table unger_corentin_i164_info1a. t_produit_stocker_entrepot
DROP TABLE IF EXISTS `t_produit_stocker_entrepot`;
CREATE TABLE IF NOT EXISTS `t_produit_stocker_entrepot` (
  `IDProEntrepot` int NOT NULL AUTO_INCREMENT,
  `FKPro` int NOT NULL,
  `FKEntrepot` int NOT NULL,
  `ProEntrepotQuantité` int DEFAULT NULL,
  PRIMARY KEY (`IDProEntrepot`),
  KEY `FK_t_produit_stocker_entrepot_t_produit` (`FKPro`) USING BTREE,
  KEY `FK_t_produit_stocker_entrepot_t_entrepot` (`FKEntrepot`),
  CONSTRAINT `FK_t_produit_stocker_entrepot_t_entrepot` FOREIGN KEY (`FKEntrepot`) REFERENCES `t_entrepot` (`IDEntrepot`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_t_produit_stocker_entrepot_t_produit` FOREIGN KEY (`FKPro`) REFERENCES `t_produit` (`IDPro`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_produit_stocker_entrepot : ~0 rows (environ)

-- Listage de la structure de table unger_corentin_i164_info1a. t_type
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE IF NOT EXISTS `t_type` (
  `IDType` int NOT NULL AUTO_INCREMENT,
  `TypeNom` varchar(50) NOT NULL,
  `FKCate` int DEFAULT NULL,
  PRIMARY KEY (`IDType`),
  KEY `FK_t_type_t_categorie` (`FKCate`),
  CONSTRAINT `FK_t_type_t_categorie` FOREIGN KEY (`FKCate`) REFERENCES `t_categorie` (`IDCate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table unger_corentin_i164_info1a.t_type : ~0 rows (environ)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
