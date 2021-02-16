-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: classroomdb
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assmtdata`
--

DROP TABLE IF EXISTS `assmtdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assmtdata` (
  `assmtid` int(11) NOT NULL AUTO_INCREMENT,
  `assmtname` varchar(100) DEFAULT NULL,
  `ownerid` int(11) DEFAULT NULL,
  `postdate` date DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `duetime` time(6) DEFAULT '23:59:00.000000',
  PRIMARY KEY (`assmtid`),
  KEY `ownerid` (`ownerid`),
  CONSTRAINT `assmtdata_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `userdata` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assmtdata`
--

LOCK TABLES `assmtdata` WRITE;
/*!40000 ALTER TABLE `assmtdata` DISABLE KEYS */;
INSERT INTO `assmtdata` VALUES (1,'Test Assignment 1',5,'2020-10-17','2020-10-17','23:59:00.000000'),(2,'Assignment 1',5,'2021-02-16','2020-02-16','15:59:00.000000'),(3,'Assignment 1.1',5,'2021-02-16','2020-01-16','15:00:00.000000');
/*!40000 ALTER TABLE `assmtdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assmtqns`
--

DROP TABLE IF EXISTS `assmtqns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assmtqns` (
  `questionid` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL,
  `op1` varchar(255) DEFAULT NULL,
  `op2` varchar(255) DEFAULT NULL,
  `op3` varchar(255) DEFAULT NULL,
  `op4` varchar(255) DEFAULT NULL,
  `ans` int(11) DEFAULT NULL,
  `assmtid` int(11) DEFAULT NULL,
  PRIMARY KEY (`questionid`),
  KEY `assmtid` (`assmtid`),
  CONSTRAINT `assmtqns_ibfk_1` FOREIGN KEY (`assmtid`) REFERENCES `assmtdata` (`assmtid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assmtqns`
--

LOCK TABLES `assmtqns` WRITE;
/*!40000 ALTER TABLE `assmtqns` DISABLE KEYS */;
INSERT INTO `assmtqns` VALUES (1,'What is life?','Empty','More Empty','Empty Infinite','Correct Answer',4,1),(2,'What is red?','Red','Orange','Blue','Green',1,3);
/*!40000 ALTER TABLE `assmtqns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classrooms`
--

DROP TABLE IF EXISTS `classrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `classrooms` (
  `ClassID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` varchar(50) NOT NULL,
  `Ownerid` int(11) NOT NULL,
  PRIMARY KEY (`ClassID`),
  KEY `Ownerid` (`Ownerid`),
  CONSTRAINT `classrooms_ibfk_1` FOREIGN KEY (`Ownerid`) REFERENCES `userdata` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classrooms`
--

LOCK TABLES `classrooms` WRITE;
/*!40000 ALTER TABLE `classrooms` DISABLE KEYS */;
INSERT INTO `classrooms` VALUES (1,'Internet Programming',5),(2,'Distributed Systems',5),(3,'CNS',5),(5,'IP',5),(6,'Python Programming',5);
/*!40000 ALTER TABLE `classrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `materials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mname` varchar(50) NOT NULL,
  `url` varchar(300) NOT NULL,
  `classid` int(11) DEFAULT NULL,
  `ownerid` int(11) NOT NULL,
  `dateupload` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `mtype` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `classid` (`classid`),
  KEY `ownerid` (`ownerid`),
  CONSTRAINT `materials_ibfk_1` FOREIGN KEY (`classid`) REFERENCES `classrooms` (`ClassID`),
  CONSTRAINT `materials_ibfk_2` FOREIGN KEY (`ownerid`) REFERENCES `classrooms` (`Ownerid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES (1,'Notes 1','C:\\Users\\Sathya\\Documents\\REC Academic Files\\REC Semester 5\\Graphics and Multimedia\\CG-TEXTBOOK-DONALDHEARN-M.PAULINE BAKER.pdf',1,5,'2020-10-10 12:57:12','Material');
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionbank`
--

DROP TABLE IF EXISTS `questionbank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `questionbank` (
  `questionid` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) DEFAULT NULL,
  `op1` varchar(255) DEFAULT NULL,
  `op2` varchar(255) DEFAULT NULL,
  `op3` varchar(255) DEFAULT NULL,
  `op4` varchar(255) DEFAULT NULL,
  `ans` int(11) DEFAULT NULL,
  `testid` int(11) DEFAULT NULL,
  PRIMARY KEY (`questionid`),
  KEY `testid` (`testid`),
  CONSTRAINT `questionbank_ibfk_1` FOREIGN KEY (`testid`) REFERENCES `testdata` (`testid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionbank`
--

LOCK TABLES `questionbank` WRITE;
/*!40000 ALTER TABLE `questionbank` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionbank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentclass`
--

DROP TABLE IF EXISTS `studentclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `studentclass` (
  `userid` int(11) NOT NULL,
  `classID` int(11) NOT NULL,
  PRIMARY KEY (`userid`,`classID`),
  KEY `classID` (`classID`),
  CONSTRAINT `studentclass_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `userdata` (`UserID`),
  CONSTRAINT `studentclass_ibfk_2` FOREIGN KEY (`classID`) REFERENCES `classrooms` (`ClassID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentclass`
--

LOCK TABLES `studentclass` WRITE;
/*!40000 ALTER TABLE `studentclass` DISABLE KEYS */;
INSERT INTO `studentclass` VALUES (4,1),(4,2);
/*!40000 ALTER TABLE `studentclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testdata`
--

DROP TABLE IF EXISTS `testdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `testdata` (
  `testid` int(11) NOT NULL AUTO_INCREMENT,
  `testname` varchar(50) DEFAULT NULL,
  `ownerid` int(11) DEFAULT NULL,
  `testdate` date DEFAULT NULL,
  `starttime` time(6) DEFAULT NULL,
  `endtime` time(6) DEFAULT NULL,
  PRIMARY KEY (`testid`),
  KEY `ownerid` (`ownerid`),
  CONSTRAINT `testdata_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `userdata` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testdata`
--

LOCK TABLES `testdata` WRITE;
/*!40000 ALTER TABLE `testdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `testdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdata`
--

DROP TABLE IF EXISTS `userdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userdata` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `mail_id` varchar(50) DEFAULT NULL,
  `ph_no` varchar(12) DEFAULT NULL,
  `pwd` varchar(225) DEFAULT NULL,
  `role` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdata`
--

LOCK TABLES `userdata` WRITE;
/*!40000 ALTER TABLE `userdata` DISABLE KEYS */;
INSERT INTO `userdata` VALUES (4,'Sathya','test@test.com','7010550145','pbkdf2:sha256:150000$Tu5QHp7i$472721b929a49cf264b10134b2355c38fdb6b5c8c1ec1ef6482b01841523af77','3'),(5,'Sathya 2','test2@test.com','8754375722','pbkdf2:sha256:150000$pV3HXzMb$c2ed9f3456595c2bbadd6d42b79c258928a0db793820a70bd72cbabc73f089d6','2'),(6,'Admin','info.returnSolution@gmail.com','7010551045','pbkdf2:sha256:150000$OSFjoY9u$f659dda783e0677bdc0d6d5deffb21729923d1c2b938554ee4d83205c4a52d61','1'),(9,'Admin','testadmin@test.com','988','pbkdf2:sha256:150000$gi6TsSy5$120ccc0c3f05065420c5cdc4c7afae0f554def8afcd9a741f18fe403b9114dc9','Owner');
/*!40000 ALTER TABLE `userdata` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-16 14:14:48
