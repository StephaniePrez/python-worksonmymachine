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
  `id` int NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ambito_tipo`
--

LOCK TABLES `ambito_tipo` WRITE;
/*!40000 ALTER TABLE `ambito_tipo` DISABLE KEYS */;
INSERT INTO `ambito_tipo` VALUES (1,'Nacional'),(2,'Internacional');
/*!40000 ALTER TABLE `ambito_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competencia`
--

DROP TABLE IF EXISTS `competencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competencia` (
  `id` int NOT NULL,
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
INSERT INTO `competencia` VALUES (1,1,'Torneos nacionales era amateur',1,1),(2,2,'Copas nacionales era amateur',1,1),(3,2,'Copas rioplatenses era amateur',2,1),(4,1,'Torneos nacionales era profesional',1,2),(5,2,'Copas nacionales era profesional',1,2),(6,2,'Copas FIFA internacionales era profesional',2,2),(7,2,'Copas Conmebol internacionales era profesional',2,2),(8,2,'Copas rioplatenses era profesional',2,2);
/*!40000 ALTER TABLE `competencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competencia_tipo`
--

DROP TABLE IF EXISTS `competencia_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competencia_tipo` (
  `id` int NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competencia_tipo`
--

LOCK TABLES `competencia_tipo` WRITE;
/*!40000 ALTER TABLE `competencia_tipo` DISABLE KEYS */;
INSERT INTO `competencia_tipo` VALUES (1,'Torneo'),(2,'Copa');
/*!40000 ALTER TABLE `competencia_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consagraciones_equipo`
--

DROP TABLE IF EXISTS `consagraciones_equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consagraciones_equipo` (
  `id` int NOT NULL,
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
INSERT INTO `consagraciones_equipo` VALUES (1,1,1,0),(2,1,2,0),(3,1,3,0),(4,1,4,3),(5,1,5,0),(6,1,6,0),(7,1,7,2),(8,1,8,0),(9,2,1,0),(10,2,2,0),(11,2,3,0),(12,2,4,0),(13,2,5,0),(14,2,6,0),(15,2,7,0),(16,2,8,0),(17,3,1,0),(18,3,2,1),(19,3,3,0),(20,3,4,1),(21,3,5,1),(22,3,6,0),(23,3,7,0),(24,3,8,0),(25,4,1,0),(26,4,2,0),(27,4,3,0),(28,4,4,0),(29,4,5,0),(30,4,6,0),(31,4,7,0),(32,4,8,0),(33,5,1,0),(34,5,2,0),(35,5,3,0),(36,5,4,0),(37,5,5,0),(38,5,6,0),(39,5,7,0),(40,5,8,0),(41,6,1,6),(42,6,2,6),(43,6,3,2),(44,6,4,29),(45,6,5,11),(46,6,6,3),(47,6,7,15),(48,6,8,2),(49,7,1,0),(50,7,2,0),(51,7,3,0),(52,7,4,0),(53,7,5,1),(54,7,6,0),(55,7,7,0),(56,7,8,0),(57,8,1,0),(58,8,2,0),(59,8,3,0),(60,8,4,0),(61,8,5,0),(62,8,6,0),(63,8,7,2),(64,8,8,0),(65,9,1,0),(66,9,2,0),(67,9,3,0),(68,9,4,0),(69,9,5,0),(70,9,6,0),(71,9,7,0),(72,9,8,0),(73,10,1,1),(74,10,2,0),(75,10,3,0),(76,10,4,5),(77,10,5,4),(78,10,6,1),(79,10,7,5),(80,10,8,0),(81,11,1,1),(82,11,2,0),(83,11,3,0),(84,11,4,0),(85,11,5,1),(86,11,6,0),(87,11,7,0),(88,11,8,0),(89,12,1,0),(90,12,2,0),(91,12,3,0),(92,12,4,0),(93,12,5,0),(94,12,6,0),(95,12,7,0),(96,12,8,0),(97,13,1,4),(98,13,2,3),(99,13,3,0),(100,13,4,1),(101,13,5,5),(102,13,6,0),(103,13,7,0),(104,13,8,0),(105,14,1,2),(106,14,2,2),(107,14,3,0),(108,14,4,14),(109,14,5,3),(110,14,6,2),(111,14,7,16),(112,14,8,2),(113,15,1,0),(114,15,2,0),(115,15,3,0),(116,15,4,0),(117,15,5,0),(118,15,6,0),(119,15,7,0),(120,15,8,0),(121,16,1,0),(122,16,2,0),(123,16,3,0),(124,16,4,0),(125,16,5,0),(126,16,6,0),(127,16,7,0),(128,16,8,0),(129,17,1,0),(130,17,2,0),(131,17,3,0),(132,17,4,2),(133,17,5,2),(134,17,6,0),(135,17,7,2),(136,17,8,0),(137,18,1,0),(138,18,2,2),(139,18,3,0),(140,18,4,2),(141,18,5,2),(142,18,6,0),(143,18,7,2),(144,18,8,0),(145,19,1,0),(146,19,2,0),(147,19,3,0),(148,19,4,0),(149,19,5,0),(150,19,6,0),(151,19,7,0),(152,19,8,0),(153,20,1,9),(154,20,2,9),(155,20,3,3),(156,20,4,9),(157,20,5,6),(158,20,6,1),(159,20,7,2),(160,20,8,0),(161,21,1,1),(162,21,2,1),(163,21,3,1),(164,21,4,37),(165,21,5,15),(166,21,6,1),(167,21,7,11),(168,21,8,5),(169,22,1,0),(170,22,2,5),(171,22,3,0),(172,22,4,4),(173,22,5,2),(174,22,6,0),(175,22,7,1),(176,22,8,0),(177,23,1,3),(178,23,2,0),(179,23,3,2),(180,23,4,12),(181,23,5,2),(182,23,6,0),(183,23,7,3),(184,23,8,0),(185,24,1,0),(186,24,2,0),(187,24,3,0),(188,24,4,0),(189,24,5,0),(190,24,6,0),(191,24,7,0),(192,24,8,0),(193,25,1,0),(194,25,2,0),(195,25,3,0),(196,25,4,0),(197,25,5,0),(198,25,6,0),(199,25,7,1),(200,25,8,0),(201,26,1,0),(202,26,2,0),(203,26,3,0),(204,26,4,0),(205,26,5,1),(206,26,6,0),(207,26,7,0),(208,26,8,0),(209,27,1,0),(210,27,2,0),(211,27,3,0),(212,27,4,0),(213,27,5,0),(214,27,6,0),(215,27,7,0),(216,27,8,0),(217,28,1,0),(218,28,2,0),(219,28,3,0),(220,28,4,10),(221,28,5,1),(222,28,6,1),(223,28,7,4),(224,28,8,0);
/*!40000 ALTER TABLE `consagraciones_equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `id` int NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo`
--

LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
INSERT INTO `equipo` VALUES (1,'Argentinos Juniors'),(2,'Atlético Tucumán'),(3,'Banfield'),(4,'Barracas Central'),(5,'Belgrano Córdoba'),(6,'Boca'),(7,'Central Córdoba (Rosario)'),(8,'Defensa y Justicia'),(9,'Deportivo Riestra'),(10,'Estudiantes de La Plata'),(11,'Gimnasia y Esgrima de La Plata'),(12,'Godoy Cruz'),(13,'Huracán'),(14,'Independiente'),(15,'Independiente Rivadavia'),(16,'Instituto'),(17,'Lanús'),(18,'Newell\'s'),(19,'Platense'),(20,'Racing'),(21,'River'),(22,'Rosario Central'),(23,'San Lorenzo'),(24,'Sarmiento'),(25,'Talleres'),(26,'Tigre'),(27,'Unión'),(28,'Vélez');
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `era_tipo`
--

DROP TABLE IF EXISTS `era_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `era_tipo` (
  `id` int NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `era_tipo`
--

LOCK TABLES `era_tipo` WRITE;
/*!40000 ALTER TABLE `era_tipo` DISABLE KEYS */;
INSERT INTO `era_tipo` VALUES (1,'Amateur'),(2,'Profesional');
/*!40000 ALTER TABLE `era_tipo` ENABLE KEYS */;
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

-- Dump completed on 2024-07-03 21:21:58
