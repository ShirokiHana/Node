-- MySQL dump 10.13  Distrib 26.7.0, for macos26.6 (arm64)
--
-- Host: 127.0.0.1    Database: supplier_db
-- ------------------------------------------------------
-- Server version	26.7.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'e90e32b4-a196-11f1-880c-315723a8e378:1-268';

--
-- Table structure for table `parts`
--

DROP TABLE IF EXISTS `parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parts` (
  `part_id` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` int unsigned NOT NULL,
  `part_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `part_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`part_id`),
  KEY `idx_supplier_parts_supplier` (`supplier_id`),
  KEY `idx_supplier_parts_name` (`part_name`),
  CONSTRAINT `fk_supplier_parts_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_supplier_part_price` CHECK ((`price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parts`
--

LOCK TABLES `parts` WRITE;
/*!40000 ALTER TABLE `parts` DISABLE KEYS */;
INSERT INTO `parts` (`part_id`, `supplier_id`, `part_name`, `part_type`, `price`, `created_at`, `updated_at`) VALUES (1,1,'Oil Filter P9192','Filter',12.50,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(2,3,'Air Filter S 0334','Filter',18.90,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(3,2,'Front Brake Pads','Brakes',64.99,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(4,2,'Rear Brake Discs','Brakes',89.50,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(5,5,'H7 Halogen Headlight Bulb','Lighting',9.75,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(6,7,'12V Car Battery 60Ah','Battery',119.99,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(7,1,'Cabin Filter R2420','Filter',16.40,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(8,1,'Fuel Filter N2045','Filter',24.80,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(9,8,'Front Brake Pads GDB 1550','Brakes',62.30,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(10,10,'Front Fog Light Assembly Left','Lighting',76.30,'2026-10-03 04:44:52','2026-10-04 23:38:06'),(11,1,'Oil Filter P 3312','Filter',11.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(12,1,'Air Filter S 0442','Filter',19.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(13,3,'Cabin Filter R 2510','Filter',17.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(14,3,'Fuel Filter WK 820','Filter',28.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(15,4,'Oil Filter OC 593','Filter',10.95,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(16,4,'Air Filter LX 2045','Filter',22.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(17,4,'Cabin Filter LAK 181','Filter',24.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(18,4,'Fuel Filter KL 228','Filter',31.75,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(19,1,'Oil Filter 0986AF0012','Filter',13.20,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(20,3,'Air Filter C 35 154','Filter',25.30,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(21,3,'Cabin Filter CU 26009','Filter',21.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(22,11,'Oil Filter LS 923','Filter',9.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(23,11,'Air Filter A1234','Filter',18.75,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(24,11,'Cabin Filter AH 405','Filter',16.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(25,11,'Fuel Filter CS 701','Filter',26.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(26,2,'Front Brake Pads P 85 020','Brakes',69.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(27,2,'Rear Brake Pads P 85 121','Brakes',58.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(28,2,'Front Brake Discs 09.A047.11','Brakes',112.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(29,2,'Rear Brake Discs 08.C307.11','Brakes',94.75,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(30,8,'Rear Brake Pads GDB 1654','Brakes',54.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(31,8,'Front Brake Discs DF 4427','Brakes',98.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(32,8,'Rear Brake Discs DF 4245','Brakes',82.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(33,12,'Front Brake Pads 8DB 355 018','Brakes',71.20,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(34,12,'Rear Brake Pads 13.0460-2890','Brakes',60.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(35,12,'Front Brake Discs 24.0125-0155','Brakes',119.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(36,12,'Rear Brake Discs 24.0110-0352','Brakes',87.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(37,1,'Brake Fluid DOT 4 1L','Brakes',14.95,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(38,8,'Brake Shoe Set GS 8210','Brakes',48.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(39,2,'Brake Wear Sensor GIC 501','Brakes',19.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(40,5,'H4 Halogen Headlight Bulb','Lighting',8.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(41,5,'H1 Halogen Headlight Bulb','Lighting',7.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(42,5,'H7 RacingVision Bulb','Lighting',29.95,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(43,5,'W5W LED Bulb Pair','Lighting',13.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(44,6,'P21W Indicator Bulb','Lighting',4.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(45,6,'PY21W Amber Indicator Bulb','Lighting',5.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(46,6,'H7 Night Breaker Bulb','Lighting',31.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(47,6,'H4 Original Bulb','Lighting',9.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(48,6,'D1S Xenon Bulb','Lighting',74.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(49,5,'D2S Xenon Bulb','Lighting',79.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(50,1,'LED Number Plate Light','Lighting',18.20,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(51,1,'Rear Light Bulb P21/5W','Lighting',6.25,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(52,5,'Fog Light H11 Bulb','Lighting',15.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(53,6,'Interior LED Light Set','Lighting',22.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(54,10,'Side Indicator Light','Lighting',17.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(55,7,'12V Car Battery 45Ah','Battery',89.99,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(56,7,'12V Car Battery 52Ah','Battery',99.99,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(57,7,'12V Car Battery 74Ah','Battery',139.99,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(58,7,'12V Car Battery 95Ah','Battery',169.99,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(59,7,'12V AGM Battery 70Ah','Battery',189.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(60,7,'12V EFB Battery 65Ah','Battery',154.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(61,1,'12V Car Battery 44Ah','Battery',86.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(62,1,'12V Car Battery 72Ah','Battery',149.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(63,1,'12V AGM Battery 80Ah','Battery',209.00,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(64,9,'12V Car Battery 50Ah','Battery',92.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(65,9,'12V Car Battery 65Ah','Battery',132.75,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(66,9,'12V Car Battery 77Ah','Battery',158.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(67,9,'12V Start-Stop AGM Battery 70Ah','Battery',195.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(68,15,'12V Motorcycle Battery 12Ah','Battery',64.99,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(69,3,'Oil Filter HU 719/7 X','Filter',14.20,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(70,4,'Oil Filter OX 188D','Filter',13.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(71,11,'Oil Filter LS 867B','Filter',11.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(72,1,'Oil Filter 0 451 103 336','Filter',12.95,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(73,3,'Air Filter C 30 005','Filter',23.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(74,4,'Air Filter LX 1780','Filter',21.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(75,11,'Air Filter A 1158','Filter',17.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(76,1,'Air Filter 1 457 433 011','Filter',20.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(77,3,'Cabin Filter CU 2939','Filter',20.30,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(78,4,'Cabin Filter LA 239','Filter',19.75,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(79,11,'Cabin Filter AH 389','Filter',15.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(80,1,'Cabin Filter 1 987 432 547','Filter',18.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(81,3,'Activated Carbon Cabin Filter CUK 2939','Filter',29.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(82,4,'Activated Carbon Cabin Filter LAK 239','Filter',28.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(83,3,'Fuel Filter WK 842/2','Filter',32.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(84,4,'Fuel Filter KL 169','Filter',29.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(85,11,'Fuel Filter FC 702','Filter',27.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(86,1,'Fuel Filter 0 450 905 273','Filter',30.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(87,16,'Diesel Fuel Filter HDF 581','Filter',35.20,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(88,16,'Oil Filter E818H D238','Filter',15.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(89,2,'Front Brake Pads P 85 146','Brakes',74.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(90,2,'Rear Brake Pads P 85 154','Brakes',61.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(91,2,'Front Brake Disc Set 09.B436.11','Brakes',128.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(92,2,'Rear Brake Disc Set 08.A202.11','Brakes',102.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(93,8,'Front Brake Pads GDB 1956','Brakes',66.70,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(94,8,'Rear Brake Pads GDB 2053','Brakes',57.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(95,8,'Front Brake Disc Set DF 7910','Brakes',107.30,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(96,8,'Rear Brake Disc Set DF 6842','Brakes',88.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(97,12,'Front Brake Pads 13.0470-7258','Brakes',76.20,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(98,12,'Rear Brake Pads 13.0460-7201','Brakes',63.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(99,12,'Front Brake Disc Set 24.0128-0173','Brakes',124.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(100,12,'Rear Brake Disc Set 24.0112-0186','Brakes',96.20,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(101,13,'Front Brake Pads 573070J','Brakes',68.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(102,13,'Rear Brake Pads 2455401','Brakes',55.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(103,1,'Brake Caliper Front Left','Brakes',145.00,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(104,1,'Brake Caliper Front Right','Brakes',145.00,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(105,8,'Brake Master Cylinder','Brakes',98.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(106,2,'Rear Brake Drum','Brakes',72.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(107,12,'Brake Hose Front','Brakes',18.70,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(108,8,'Electronic Parking Brake Motor','Brakes',132.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(109,6,'H3 Halogen Fog Light Bulb','Lighting',7.20,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(110,5,'H8 Halogen Fog Light Bulb','Lighting',14.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(111,6,'H9 Halogen Headlight Bulb','Lighting',16.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(112,6,'H11 Night Breaker Bulb','Lighting',27.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(113,5,'HB3 Halogen Bulb','Lighting',13.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(114,5,'HB4 Halogen Bulb','Lighting',14.20,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(115,6,'D3S Xenon Bulb','Lighting',84.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(116,5,'D4S Xenon Bulb','Lighting',82.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(117,6,'W21W Signal Bulb','Lighting',6.80,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(118,5,'R5W Rear Light Bulb','Lighting',4.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(119,1,'C5W Festoon Interior Bulb','Lighting',3.95,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(120,6,'T10 LED Bulb Pair','Lighting',12.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(121,5,'H7 LED Retrofit Bulb Set','Lighting',119.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(122,6,'H4 LED Retrofit Bulb Set','Lighting',109.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(123,10,'LED Daytime Running Light','Lighting',48.70,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(124,10,'Front Fog Light Assembly Right','Lighting',76.30,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(125,14,'Rear Tail Light Assembly Left','Lighting',138.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(126,14,'Rear Tail Light Assembly Right','Lighting',138.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(127,1,'LED Work Light 12V','Lighting',44.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(128,7,'12V Car Battery 40Ah','Battery',82.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(129,7,'12V Car Battery 55Ah','Battery',108.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(130,7,'12V Car Battery 80Ah','Battery',151.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(131,7,'12V Car Battery 100Ah','Battery',178.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(132,7,'12V Start-Stop AGM Battery 95Ah','Battery',239.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(133,1,'12V Car Battery 36Ah','Battery',78.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(134,1,'12V Car Battery 55Ah','Battery',109.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(135,1,'12V Car Battery 70Ah','Battery',142.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(136,1,'12V Car Battery 90Ah','Battery',174.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(137,1,'12V EFB Battery 75Ah','Battery',179.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(138,9,'12V Car Battery 40Ah','Battery',80.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(139,9,'12V Car Battery 55Ah','Battery',111.60,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(140,9,'12V Car Battery 80Ah','Battery',162.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(141,9,'12V AGM Battery 95Ah','Battery',229.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(142,15,'12V Motorcycle Battery 9Ah','Battery',52.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(143,15,'12V Motorcycle Battery 14Ah','Battery',72.40,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(144,15,'12V Motorcycle Battery 18Ah','Battery',89.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(145,7,'12V Leisure Battery 75Ah','Battery',168.50,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(146,9,'12V Leisure Battery 100Ah','Battery',214.90,'2026-10-06 00:16:44','2026-10-06 00:16:44'),(147,1,'12V Auxiliary Battery 12Ah','Battery',58.30,'2026-10-06 00:16:44','2026-10-06 00:16:44');
/*!40000 ALTER TABLE `parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_order_items`
--

DROP TABLE IF EXISTS `supplier_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_order_items` (
  `supplier_order_item_id` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier_order_id` int unsigned NOT NULL,
  `part_id` int unsigned NOT NULL,
  `quantity` int unsigned NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`supplier_order_item_id`),
  UNIQUE KEY `uq_supplier_order_items_order_part` (`supplier_order_id`,`part_id`),
  KEY `idx_supplier_order_items_part` (`part_id`),
  CONSTRAINT `fk_supplier_order_items_order` FOREIGN KEY (`supplier_order_id`) REFERENCES `supplier_orders` (`supplier_order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_supplier_order_items_part` FOREIGN KEY (`part_id`) REFERENCES `parts` (`part_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_supplier_order_items_quantity` CHECK ((`quantity` > 0)),
  CONSTRAINT `chk_supplier_order_items_unit_price` CHECK ((`unit_price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_order_items`
--

LOCK TABLES `supplier_order_items` WRITE;
/*!40000 ALTER TABLE `supplier_order_items` DISABLE KEYS */;
INSERT INTO `supplier_order_items` (`supplier_order_item_id`, `supplier_order_id`, `part_id`, `quantity`, `unit_price`) VALUES (1,1,1,5,12.50),(2,2,2,4,18.90),(3,3,3,3,64.99),(4,4,4,2,89.50),(5,5,5,10,9.75),(6,6,6,2,119.99),(7,7,7,6,16.40),(8,8,8,4,24.80),(9,9,9,3,62.30),(10,10,10,2,76.30),(11,2,11,5,11.90),(12,3,26,3,69.90),(13,4,77,4,20.30),(14,5,35,2,119.90),(15,6,46,6,31.80),(16,7,115,2,84.90),(17,8,57,2,139.99),(18,9,141,1,229.50),(19,10,22,7,9.80),(20,11,125,1,138.90),(21,21,147,3,58.30),(22,28,37,5,14.95),(23,28,103,2,145.00),(24,28,104,1,145.00),(25,29,63,3,209.00),(26,29,103,1,145.00),(27,29,147,3,58.30),(28,30,63,5,209.00),(29,30,103,2,145.00),(30,30,119,4,3.95),(31,31,147,1,58.30),(32,32,147,1,58.30),(33,34,133,1,78.50),(34,50,63,1,209.00),(35,51,1,3,12.50),(36,52,63,1,209.00),(37,53,63,1,209.00),(44,56,1,2,12.50),(45,57,1,2,12.50),(46,58,1,2,12.50),(47,59,1,2,12.50),(48,60,1,2,12.50),(49,61,1,2,12.50),(50,63,1,2,12.50),(51,65,1,2,12.50),(52,66,1,2,12.50),(53,67,1,2,12.50),(54,68,1,2,12.50),(55,69,1,2,12.50),(56,70,1,2,12.50),(57,71,1,2,12.50),(58,72,1,2,12.50),(59,73,1,2,12.50),(60,74,1,2,12.50),(61,75,1,2,12.50),(62,76,1,2,12.50),(63,77,1,2,12.50),(64,78,1,2,12.50),(65,79,1,2,12.50),(66,80,1,2,12.50),(67,81,1,2,12.50),(68,82,1,2,12.50),(69,83,1,2,12.50),(70,84,1,2,12.50),(71,85,1,2,12.50),(72,86,1,2,12.50),(73,87,4,2,89.50),(74,88,1,1,12.50);
/*!40000 ALTER TABLE `supplier_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_orders`
--

DROP TABLE IF EXISTS `supplier_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_orders` (
  `supplier_order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` int unsigned NOT NULL,
  `issued_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expected_arrival_at` timestamp NOT NULL,
  `status` enum('pending','ready','received','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`supplier_order_id`),
  KEY `idx_supplier_orders_supplier` (`supplier_id`),
  KEY `idx_supplier_orders_arrival` (`expected_arrival_at`),
  KEY `idx_supplier_orders_status` (`status`),
  CONSTRAINT `fk_supplier_orders_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_orders`
--

LOCK TABLES `supplier_orders` WRITE;
/*!40000 ALTER TABLE `supplier_orders` DISABLE KEYS */;
INSERT INTO `supplier_orders` (`supplier_order_id`, `supplier_id`, `issued_at`, `expected_arrival_at`, `status`) VALUES (1,1,'2026-10-03 08:00:00','2026-10-03 08:05:00','received'),(2,3,'2026-10-03 08:10:00','2026-10-03 08:55:00','received'),(3,2,'2026-10-03 08:20:00','2026-10-03 08:50:00','received'),(4,2,'2026-10-03 08:30:00','2026-10-03 09:00:00','received'),(5,5,'2026-10-03 08:40:00','2026-10-03 09:40:00','received'),(6,7,'2026-10-03 08:50:00','2026-10-03 09:30:00','received'),(7,1,'2026-10-03 09:00:00','2026-10-03 09:40:00','received'),(8,1,'2026-10-03 09:10:00','2026-10-03 09:40:00','received'),(9,8,'2026-10-03 09:20:00','2026-10-03 09:40:00','received'),(10,10,'2026-10-03 09:30:00','2026-10-03 10:15:00','received'),(11,1,'2026-10-06 00:16:59','2026-10-06 00:21:59','pending'),(12,2,'2026-10-06 00:16:59','2026-10-06 00:16:59','pending'),(13,3,'2026-10-06 00:16:59','2026-10-06 00:16:59','pending'),(14,4,'2026-10-06 00:16:59','2026-10-06 00:16:59','pending'),(15,5,'2026-10-06 00:16:59','2026-10-06 00:16:59','pending'),(16,6,'2026-10-06 00:16:59','2026-10-06 00:16:59','pending'),(17,7,'2026-10-06 00:16:59','2026-10-06 00:16:59','pending'),(18,8,'2026-10-06 00:16:59','2026-10-06 00:16:59','pending'),(19,9,'2026-10-06 00:16:59','2026-10-06 00:16:59','pending'),(20,10,'2026-10-06 00:16:59','2026-10-06 00:16:59','pending'),(21,1,'2026-10-09 02:41:08','2026-10-09 04:11:08','pending'),(28,1,'2026-10-09 04:54:53','2026-10-09 08:54:53','pending'),(29,1,'2026-10-09 06:20:21','2026-10-09 09:50:21','pending'),(30,1,'2026-10-09 06:37:52','2026-10-09 12:07:52','pending'),(31,1,'2026-10-09 06:45:28','2026-10-09 07:15:28','pending'),(32,1,'2026-10-09 06:46:13','2026-10-09 07:16:13','pending'),(34,1,'2026-10-09 06:48:50','2026-10-09 07:18:50','received'),(50,1,'2026-10-22 12:23:22','2026-10-22 12:53:22','pending'),(51,1,'2026-10-22 12:23:37','2026-10-22 13:53:37','pending'),(52,1,'2026-10-22 12:24:11','2026-10-22 12:54:11','pending'),(53,1,'2026-10-22 14:11:03','2026-10-22 14:41:03','pending'),(56,1,'2026-10-22 16:47:40','2026-10-22 17:47:40','pending'),(57,1,'2026-10-22 16:53:05','2026-10-22 17:53:05','pending'),(58,1,'2026-10-22 16:53:05','2026-10-22 17:53:05','pending'),(59,1,'2026-10-22 16:53:06','2026-10-22 17:53:06','pending'),(60,1,'2026-10-22 16:53:07','2026-10-22 17:53:07','pending'),(61,1,'2026-10-22 16:53:07','2026-10-22 17:53:07','pending'),(63,1,'2026-10-22 16:56:14','2026-10-22 17:56:14','pending'),(65,1,'2026-10-22 16:59:32','2026-10-22 17:59:32','pending'),(66,1,'2026-10-22 17:02:37','2026-10-22 18:02:37','pending'),(67,1,'2026-10-22 17:36:16','2026-10-22 18:36:16','received'),(68,1,'2026-10-22 17:46:45','2026-10-22 18:46:45','pending'),(69,1,'2026-10-22 17:54:30','2026-10-22 18:54:30','pending'),(70,1,'2026-10-22 17:54:33','2026-10-22 18:54:33','pending'),(71,1,'2026-10-23 12:14:16','2026-10-23 13:14:16','pending'),(72,1,'2026-10-23 12:14:17','2026-10-23 13:14:17','pending'),(73,1,'2026-10-23 13:13:16','2026-10-23 14:13:16','pending'),(74,1,'2026-10-23 13:13:18','2026-10-23 14:13:18','pending'),(75,1,'2026-10-23 13:15:09','2026-10-23 14:15:09','pending'),(76,1,'2026-10-23 13:15:18','2026-10-23 14:15:18','pending'),(77,1,'2026-10-23 13:15:23','2026-10-23 14:15:23','pending'),(78,1,'2026-10-23 14:12:55','2026-10-23 15:12:55','pending'),(79,1,'2026-10-23 14:13:59','2026-10-23 15:13:59','pending'),(80,1,'2026-10-23 14:14:44','2026-10-23 15:14:44','received'),(81,1,'2026-10-23 15:03:50','2026-10-23 16:03:50','received'),(82,1,'2026-10-23 15:04:48','2026-10-23 16:04:48','received'),(83,1,'2026-10-23 15:04:51','2026-10-23 16:04:51','received'),(84,1,'2026-10-24 06:16:43','2026-10-24 07:16:43','received'),(85,1,'2026-10-24 06:31:20','2026-10-24 07:31:20','received'),(86,1,'2026-10-24 06:31:25','2026-10-24 07:31:25','received'),(87,2,'2026-10-24 14:38:50','2026-10-24 15:38:50','received'),(88,1,'2026-10-24 14:39:13','2026-10-24 15:09:13','received');
/*!40000 ALTER TABLE `supplier_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `created_at`) VALUES (1,'Bosch Automotive Portugal','2026-10-03 04:44:52'),(2,'Brembo Parts Iberia','2026-10-03 04:44:52'),(3,'Mann-Filter Distribution','2026-10-03 04:44:52'),(4,'Mahle Aftermarket','2026-10-03 04:44:52'),(5,'Philips Automotive Lighting','2026-10-03 04:44:52'),(6,'Osram Automotive','2026-10-03 04:44:52'),(7,'Varta Batteries Portugal','2026-10-03 04:44:52'),(8,'TRW Automotive Components','2026-10-03 04:44:52'),(9,'Exide Technologies','2026-10-03 04:44:52'),(10,'Valeo Service Portugal','2026-10-03 04:44:52'),(11,'Purflux Filters Portugal','2026-10-06 00:16:14'),(12,'ATE Brake Systems Iberia','2026-10-06 00:16:14'),(13,'Textar Braking Solutions','2026-10-06 00:16:14'),(14,'Magneti Marelli Portugal','2026-10-06 00:16:14'),(15,'Yuasa Battery Distribution','2026-10-06 00:16:14'),(16,'Hengst Filter Systems','2026-10-06 00:16:14'),(17,'General Auto Parts Distribution','2026-10-06 00:16:14'),(19,'Test Again','2026-10-15 07:14:41'),(20,'Too NEW Parts & Co.','2026-10-18 12:45:42');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-24 18:10:42
