-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: afa-lens
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ambito_tipo`
--

DROP TABLE IF EXISTS `ambito_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ambito_tipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ambito_tipo`
--

LOCK TABLES `ambito_tipo` WRITE;
/*!40000 ALTER TABLE `ambito_tipo` DISABLE KEYS */;
INSERT INTO `ambito_tipo` (`nombre`) VALUES ('Nacional'),('Internacional');
/*!40000 ALTER TABLE `ambito_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competencia`
--

DROP TABLE IF EXISTS `competencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` int DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `ambito` int DEFAULT NULL,
  `era` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo` (`tipo`),
  KEY `ambito` (`ambito`),
  KEY `era` (`era`),
  CONSTRAINT `competencia_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `competencia_tipo` (`id`),
  CONSTRAINT `competencia_ibfk_2` FOREIGN KEY (`ambito`) REFERENCES `ambito_tipo` (`id`),
  CONSTRAINT `competencia_ibfk_3` FOREIGN KEY (`era`) REFERENCES `era_tipo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competencia`
--

LOCK TABLES `competencia` WRITE;
/*!40000 ALTER TABLE `competencia` DISABLE KEYS */;
INSERT INTO `competencia` (`tipo`, `nombre`, `ambito`, `era`)
VALUES 
(1,'Torneos nacionales era amateur',1,1),
(2,'Copas nacionales era amateur',1,1),
(2,'Copas rioplatenses era amateur',2,1),
(1,'Torneos nacionales era profesional',1,2),
(2,'Copas nacionales era profesional',1,2),
(2,'Copas FIFA internacionales era profesional',2,2),
(2,'Copas Conmebol internacionales era profesional',2,2),
(2,'Copas rioplatenses era profesional',2,2);
/*!40000 ALTER TABLE `competencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competencia_tipo`
--

DROP TABLE IF EXISTS `competencia_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competencia_tipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competencia_tipo`
--

LOCK TABLES `competencia_tipo` WRITE;
/*!40000 ALTER TABLE `competencia_tipo` DISABLE KEYS */;
INSERT INTO `competencia_tipo` (`nombre`) VALUES ('Torneo'),('Copa');
/*!40000 ALTER TABLE `competencia_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consagraciones_equipo`
--

DROP TABLE IF EXISTS `consagraciones_equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consagraciones_equipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `equipo` int DEFAULT NULL,
  `competencia` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipo` (`equipo`),
  KEY `competencia` (`competencia`),
  CONSTRAINT `consagraciones_equipo_ibfk_1` FOREIGN KEY (`equipo`) REFERENCES `equipo` (`id`),
  CONSTRAINT `consagraciones_equipo_ibfk_2` FOREIGN KEY (`competencia`) REFERENCES `competencia` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consagraciones_equipo`
--

LOCK TABLES `consagraciones_equipo` WRITE;
/*!40000 ALTER TABLE `consagraciones_equipo` DISABLE KEYS */;
INSERT INTO `consagraciones_equipo` (`equipo`, `competencia`, `cantidad`) VALUES (1,1,0),(1,2,0),(1,3,0),(1,4,3),(1,5,0),(1,6,0),(1,7,2),(1,8,0),(2,1,0),(2,2,0),(2,3,0),(2,4,0),(2,5,0),(2,6,0),(2,7,0),(2,8,0),(3,1,0),(3,2,1),(3,3,0),(3,4,1),(3,5,1),(3,6,0),(3,7,0),(3,8,0),(4,1,0),(4,2,0),(4,3,0),(4,4,0),(4,5,0),(4,6,0),(4,7,0),(4,8,0),(5,1,0),(5,2,0),(5,3,0),(5,4,0),(5,5,0),(5,6,0),(5,7,0),(5,8,0),(6,1,6),(6,2,6),(6,3,2),(6,4,29),(6,5,11),(6,6,3),(6,7,15),(6,8,2),(7,1,0),(7,2,0),(7,3,0),(7,4,0),(7,5,1),(7,6,0),(7,7,0),(7,8,0),(8,1,0),(8,2,0),(8,3,0),(8,4,0),(8,5,0),(8,6,0),(8,7,2),(8,8,0),(9,1,0),(9,2,0),(9,3,0),(9,4,0),(9,5,0),(9,6,0),(9,7,0),(9,8,0),(10,1,1),(10,2,0),(10,3,0),(10,4,5),(10,5,4),(10,6,1),(10,7,5),(10,8,0),(11,1,1),(11,2,0),(11,3,0),(11,4,0),(11,5,1),(11,6,0),(11,7,0),(11,8,0),(12,1,0),(12,2,0),(12,3,0),(12,4,0),(12,5,0),(12,6,0),(12,7,0),(12,8,0),(13,1,4),(13,2,3),(13,3,0),(13,4,1),(13,5,5),(13,6,0),(13,7,0),(13,8,0),(14,1,2),(14,2,2),(14,3,0),(14,4,14),(14,5,3),(14,6,2),(14,7,16),(14,8,2),(15,1,0),(15,2,0),(15,3,0),(15,4,0),(15,5,0),(15,6,0),(15,7,0),(15,8,0),(16,1,0),(16,2,0),(16,3,0),(16,4,0),(16,5,0),(16,6,0),(16,7,0),(16,8,0),(17,1,0),(17,2,0),(17,3,0),(17,4,2),(17,5,2),(17,6,0),(17,7,2),(17,8,0),(18,1,0),(18,2,2),(18,3,0),(18,4,2),(18,5,2),(18,6,0),(18,7,2),(18,8,0),(19,1,0),(19,2,0),(19,3,0),(19,4,0),(19,5,0),(19,6,0),(19,7,0),(19,8,0),(20,1,9),(20,2,9),(20,3,3),(20,4,9),(20,5,6),(20,6,1),(20,7,2),(20,8,0),(21,1,1),(21,2,1),(21,3,1),(21,4,37),(21,5,15),(21,6,1),(21,7,11),(21,8,5),(22,1,0),(22,2,5),(22,3,0),(22,4,4),(22,5,2),(22,6,0),(22,7,1),(22,8,0),(23,1,3),(23,2,0),(23,3,2),(23,4,12),(23,5,2),(23,6,0),(23,7,3),(23,8,0),(24,1,0),(24,2,0),(24,3,0),(24,4,0),(24,5,0),(24,6,0),(24,7,0),(24,8,0),(25,1,0),(25,2,0),(25,3,0),(25,4,0),(25,5,0),(25,6,0),(25,7,1),(25,8,0),(26,1,0),(26,2,0),(26,3,0),(26,4,0),(26,5,1),(26,6,0),(26,7,0),(26,8,0),(27,1,0),(27,2,0),(27,3,0),(27,4,0),(27,5,0),(27,6,0),(27,7,0),(27,8,0),(28,1,0),(28,2,0),(28,3,0),(28,4,10),(28,5,1),(28,6,1),(28,7,4),(28,8,0);
/*!40000 ALTER TABLE `consagraciones_equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo`
--

LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
INSERT INTO `equipo` (`nombre`) VALUES
('Argentinos Juniors'),
('Atlético Tucumán'),
('Banfield'),
('Barracas Central'),
('Belgrano Córdoba'),
('Boca'),
('Central Córdoba (Rosario)'),
('Defensa y Justicia'),
('Deportivo Riestra'),
('Estudiantes de La Plata'),
('Gimnasia y Esgrima de La Plata'),
('Godoy Cruz'),
('Huracán'),
('Independiente'),
('Independiente Rivadavia'),
('Instituto'),
('Lanús'),
('Newell''s'),
('Platense'),
('Racing'),
('River'),
('Rosario Central'),
('San Lorenzo'),
('Sarmiento'),
('Talleres'),
('Tigre'),
('Unión'),
('Vélez');
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `era_tipo`
--

DROP TABLE IF EXISTS `era_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `era_tipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `era_tipo`
--

LOCK TABLES `era_tipo` WRITE;
/*!40000 ALTER TABLE `era_tipo` DISABLE KEYS */;
INSERT INTO `era_tipo` (`nombre`) VALUES ('Amateur'), ('Profesional');
/*!40000 ALTER TABLE `era_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hinchas`
--

DROP TABLE IF EXISTS `hinchas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hinchas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `equipo` int DEFAULT NULL,
  `escudo` varchar(100) DEFAULT NULL,
  `afiliados` int DEFAULT NULL,
  `sedes` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipo` (`equipo`),
  CONSTRAINT `hinchas_ibfk_1` FOREIGN KEY (`equipo`) REFERENCES `equipo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hinchas`
--

LOCK TABLES `hinchas` WRITE;
/*!40000 ALTER TABLE `hinchas` DISABLE KEYS */;
INSERT INTO `hinchas` (`equipo`, `escudo`, `afiliados`, `sedes`) VALUES
(21, 'rv.png', 100000, 95),
(6, 'bj.png', 95000, 50),
(5, 'cabc.png', 90000, 40),
(14, 'cai.png', 15000, 97),
(23, 'casla.png', 55000, 20),
(10, 'edlp.png', 88000, 20),
(13, 'hur.png', 56000, 20),
(17, 'lan.png', 45000, 20),
(20, 'rac.png', 54000, 20),
(22, 'rc.png', 65000, 20),
(28, 'vs.png', 14000, 20);
/*!40000 ALTER TABLE `hinchas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'afa-lens'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-04 15:55:44
