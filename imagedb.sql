-- MySQL dump 10.13  Distrib 8.0.19, for Linux (x86_64)
--
-- Host: localhost    Database: image
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `macip`
--

DROP TABLE IF EXISTS `macip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `macip` (
  `bootmac` varchar(45) NOT NULL,
  `hostname` varchar(45) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `netmask` varchar(45) DEFAULT NULL,
  `gateway` varchar(45) DEFAULT NULL,
  `dns` varchar(45) DEFAULT NULL,
  `osrootpw` varchar(200) DEFAULT NULL,
  `osuser` varchar(45) DEFAULT NULL,
  `osuserpw` varchar(200) DEFAULT NULL,
  `ipmiip` varchar(45) DEFAULT NULL,
  `ipminetmask` varchar(45) DEFAULT NULL,
  `ipmigateway` varchar(45) DEFAULT NULL,
  `ipmiuser` varchar(45) DEFAULT NULL,
  `ipmipasswd` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`bootmac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `macip`
--

LOCK TABLES `macip` WRITE;
/*!40000 ALTER TABLE `macip` DISABLE KEYS */;
INSERT INTO `macip` VALUES ('a4bf015bea6e','Img-test','192.168.0.2','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.102','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf015bf874','Img-test','192.168.0.3','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.103','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf015bf892','Img-test','192.168.0.4','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.104','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf015bf94b','Img-test','192.168.0.5','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.105','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf015bfa22','Img-test','192.168.0.6','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.106','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf015bfa95','Img-test','192.168.0.7','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.107','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf015bfab3','Img-test','192.168.0.8','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.108','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016022dd','Img-test','192.168.0.9','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.109','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016022f1','Img-test','192.168.0.10','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.110','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01602300','Img-test','192.168.0.11','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.111','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01602319','Img-test','192.168.0.12','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.112','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0160231e','Img-test','192.168.0.13','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.113','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01602337','Img-test','192.168.0.14','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.114','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0160235a','Img-test','192.168.0.15','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.115','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0160235f','Img-test','192.168.0.16','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.116','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016101e6','Img-test','192.168.0.17','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.117','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016101f0','Img-test','192.168.0.18','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.118','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610222','Img-test','192.168.0.19','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.119','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610245','Img-test','192.168.0.20','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.120','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610259','Img-test','192.168.0.21','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.121','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610272','Img-test','192.168.0.22','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.122','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161027c','Img-test','192.168.0.23','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.123','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161029a','Img-test','192.168.0.24','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.124','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016102a9','Img-test','192.168.0.25','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.125','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016102d1','Img-test','192.168.0.26','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.126','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016102e5','Img-test','192.168.0.27','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.127','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016102fe','Img-test','192.168.0.28','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.128','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610308','Image-Test','192.168.0.1','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.101','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161032b','Img-test','192.168.0.29','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.129','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161033a','Img-test','192.168.0.30','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.130','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610344','Img-test','192.168.0.31','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.131','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161034e','Img-test','192.168.0.32','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.132','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610367','Img-test','192.168.0.33','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.133','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161036c','Img-test','192.168.0.34','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.134','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610371','Img-test','192.168.0.35','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.135','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610385','Img-test','192.168.0.36','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.136','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016103a3','Img-test','192.168.0.37','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.137','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016103b2','Img-test','192.168.0.38','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.138','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016103bc','Img-test','192.168.0.39','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.139','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016103c1','Img-test','192.168.0.40','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.140','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016103d0','Img-test','192.168.0.41','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.141','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016103da','Img-test','192.168.0.42','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.142','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016103df','Img-test','192.168.0.43','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.143','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016103f8','Img-test','192.168.0.44','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.144','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610402','Img-test','192.168.0.45','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.145','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610407','Img-test','192.168.0.46','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.146','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610420','Img-test','192.168.0.47','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.147','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610425','Img-test','192.168.0.48','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.148','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610439','Img-test','192.168.0.49','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.149','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161043e','Img-test','192.168.0.50','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.150','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610448','Img-test','192.168.0.51','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.151','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161044d','Img-test','192.168.0.52','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.152','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161046b','Img-test','192.168.0.53','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.153','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf01610475','Img-test','192.168.0.54','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.154','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf0161048e','Img-test','192.168.0.55','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.155','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016104a2','Img-test','192.168.0.56','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.156','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016104a7','Img-test','192.168.0.57','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.157','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016104ac','Img-test','192.168.0.58','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.158','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016104bb','Img-test','192.168.0.59','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.159','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016104c5','Img-test','192.168.0.60','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.160','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016104ca','Img-test','192.168.0.61','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.161','255.255.255.0','192.168.0.254','root','rootroot'),('a4bf016104cf','Img-test','192.168.0.62','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.162','255.255.255.0','192.168.0.254','root','rootroot'),('ac1f6ba1198b','Img-test','10.10.10.201','255.255.255.0','10.10.10.1','8.8.8.8','rootpw','nick','amax','10.10.10.202','255.255.255.0','10.10.10.1','root','rootroot');
/*!40000 ALTER TABLE `macip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitlist`
--

DROP TABLE IF EXISTS `unitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unitlist` (
  `mac` varchar(45) NOT NULL,
  `mbsn` varchar(45) NOT NULL DEFAULT 'blanksn',
  `ipmimac` varchar(45) NOT NULL,
  `allmaclist` varchar(450) NOT NULL,
  `hostname` varchar(45) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `netmask` varchar(45) NOT NULL,
  `gateway` varchar(45) NOT NULL,
  `dns` varchar(45) NOT NULL,
  `osrootpw` varchar(200) NOT NULL,
  `osuser` varchar(45) NOT NULL,
  `osuserpw` varchar(45) NOT NULL,
  `ipmiip` varchar(45) NOT NULL,
  `ipminetmask` varchar(45) NOT NULL,
  `ipmigateway` varchar(45) NOT NULL,
  `ipmiuser` varchar(45) NOT NULL,
  `ipmipasswd` varchar(200) NOT NULL,
  PRIMARY KEY (`mac`),
  UNIQUE KEY `mac_UNIQUE` (`mac`),
  UNIQUE KEY `ipmimac_UNIQUE` (`ipmimac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitlist`
--

LOCK TABLES `unitlist` WRITE;
/*!40000 ALTER TABLE `unitlist` DISABLE KEYS */;
INSERT INTO `unitlist` VALUES ('a4-bf-01-61-03-08','QSBP00202471','a4bf0161030c','1c:34:da:4a:40:09, a4:bf:01:61:03:08, a4:bf:01:61:03:09, 00:00:11:06:fe:80:00:00:00:00:00:00:1c:34:da:03:00:4a:40:08','Image-Test','192.168.0.1','255.255.255.0','192.168.0.254','8.8.8.8','rootroot','amax','rootroot','192.168.0.101','255.255.255.0','192.168.0.254','root','rootroot'),('ac-1f-6b-a1-19-8b','UM196S005458','ac1f6ba1c6d2','ac:1f:6b:a1:19:8a, ac:1f:6b:a1:19:8b','Img-test','10.10.10.201','255.255.255.0','10.10.10.1','8.8.8.8','rootroot','amax','rootroot','10.10.10.202','255.255.255.0','10.10.10.1','root','rootroot');
/*!40000 ALTER TABLE `unitlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-14 22:33:31
