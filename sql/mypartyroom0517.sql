-- MariaDB dump 10.19  Distrib 10.5.11-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: mypartyroom
-- ------------------------------------------------------
-- Server version	10.5.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `adminid` int(11) NOT NULL AUTO_INCREMENT,
  `admin_userid` varchar(30) NOT NULL,
  `pwd` char(60) NOT NULL,
  `writeday` datetime DEFAULT NULL,
  `admin_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`adminid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'pkc','1234','2025-03-20 12:47:20','관리자');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer` (
  `answerid` int(11) NOT NULL AUTO_INCREMENT,
  `answer_title` varchar(100) DEFAULT NULL,
  `answer_text` text NOT NULL,
  `writeday` datetime DEFAULT NULL,
  PRIMARY KEY (`answerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyerinfo`
--

DROP TABLE IF EXISTS `buyerinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buyerinfo` (
  `buyerinfoid` int(11) NOT NULL AUTO_INCREMENT,
  `buycode` char(10) NOT NULL,
  PRIMARY KEY (`buyerinfoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyerinfo`
--

LOCK TABLES `buyerinfo` WRITE;
/*!40000 ALTER TABLE `buyerinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyerinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dae`
--

DROP TABLE IF EXISTS `dae`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dae` (
  `daeid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `daecode` char(2) DEFAULT NULL,
  PRIMARY KEY (`daeid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dae`
--

LOCK TABLES `dae` WRITE;
/*!40000 ALTER TABLE `dae` DISABLE KEYS */;
INSERT INTO `dae` VALUES (1,'서울','01'),(2,'인천/부천','02'),(3,'경기','03'),(4,'부산','04'),(5,'대구/경상','05'),(6,'대전/충청','06'),(7,'광주/전라','07');
/*!40000 ALTER TABLE `dae` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fna`
--

DROP TABLE IF EXISTS `fna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fna` (
  `fnaid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `writeday` datetime DEFAULT NULL,
  `rnum` int(11) DEFAULT NULL,
  `img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `adminid` int(11) DEFAULT NULL,
  `admin_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fnaid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fna`
--

LOCK TABLES `fna` WRITE;
/*!40000 ALTER TABLE `fna` DISABLE KEYS */;
INSERT INTO `fna` VALUES (1,'예약은 언제부터 가능한가요?','2025-04-03 15:56:22',1,NULL,'파티룸 예약은 최대 3개월 전부터 가능합니다. 주말과 공휴일은 빠르게 예약이 마감되니 서둘러 예약하시기 바랍니다.',1,1,'관리자'),(2,'예약 취소 시 환불 규정은 어떻게 되나요?','2025-04-03 15:56:22',2,NULL,'이용 7일 전 취소: 100% 환불\n이용 5일 전 취소: 80% 환불\n이용 3일 전 취소: 50% 환불\n이용 1일 전 취소: 환불 불가\n당일 취소: 환불 불가\n\n단, 천재지변이나 당사의 귀책사유로 인한 취소는 100% 환불됩니다.',1,1,'관리자'),(3,'기본 제공되는 시설과 장비는 무엇인가요?','2025-04-03 15:56:22',3,NULL,'모든 파티룸에는 기본적으로 블루투스 스피커, Wi-Fi, 에어컨, 냉장고, 전자레인지가 제공됩니다. 룸별로 추가 제공되는 시설은 각 룸 상세페이지에서 확인하실 수 있습니다.',1,1,'관리자'),(4,'음식 반입이 가능한가요?','2025-04-03 15:56:22',4,NULL,'네, 외부 음식 반입이 가능합니다. 다만, 퇴실 시 음식물 쓰레기 처리와 정리는 고객님께서 해주셔야 합니다. 추가 청소비가 발생할 수 있습니다.',1,1,'관리자'),(5,'최대 인원은 몇 명인가요?','2025-04-03 15:56:22',5,NULL,'파티룸별로 최대 수용 인원이 다릅니다. 기본적으로 소형룸은 6-8명, 중형룸은 10-15명, 대형룸은 20명까지 이용 가능합니다. 최대 인원 초과 시 추가 요금이 발생하거나 입장이 제한될 수 있습니다.',1,1,'관리자'),(6,'주차 시설이 있나요?','2025-04-03 15:56:22',6,NULL,'네, 모든 지점에 무료 주차 공간이 마련되어 있습니다. 다만, 주말이나 성수기에는 주차 공간이 제한될 수 있으니 가급적 대중교통 이용을 권장드립니다.',1,1,'관리자'),(7,'예약 시간 연장이 가능한가요?','2025-04-03 15:56:22',7,NULL,'당일 예약 상황에 따라 가능합니다. 연장을 원하시면 이용 중에 카운터 또는 고객센터로 문의해 주세요. 시간당 추가 요금이 발생합니다.',1,1,'관리자'),(8,'파티룸 내 흡연이 가능한가요?','2025-04-03 15:56:22',8,NULL,'모든 파티룸은 금연 구역입니다. 지정된 흡연 구역 외 실내 흡연 시 청소비가 추가 청구되며, 다음 예약에 차질이 생길 경우 손해배상이 청구될 수 있습니다.',1,1,'관리자'),(9,'파티 용품 대여가 가능한가요?','2025-04-03 15:56:22',9,NULL,'생일파티, 브라이덜 샤워 등 각종 이벤트에 필요한 파티 용품을 대여해 드립니다. 예약 시 미리 문의하시면 준비해 드립니다. 용품별로 대여료가 다르니 홈페이지에서 확인해 주세요.',1,1,'관리자'),(10,'영업 시간은 어떻게 되나요?','2025-04-03 15:56:22',10,NULL,'오전 10시부터 오후 11시까지 운영합니다. 24시간 운영하는 특정 지점도 있으니 예약 전 확인해 주세요. 체크인은 예약 시간 10분 전부터 가능합니다.',1,1,'관리자');
/*!40000 ALTER TABLE `fna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gumae`
--

DROP TABLE IF EXISTS `gumae`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gumae` (
  `gumaeid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rcode` char(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card1` int(11) DEFAULT NULL,
  `halbu1` int(11) DEFAULT NULL,
  `bank1` int(11) DEFAULT NULL,
  `card2` int(11) DEFAULT NULL,
  `tel` int(11) DEFAULT NULL,
  `bank2` int(11) DEFAULT NULL,
  `jumuncode` char(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  `sudan` int(11) DEFAULT NULL,
  `review` int(11) DEFAULT NULL,
  PRIMARY KEY (`gumaeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gumae`
--

LOCK TABLES `gumae` WRITE;
/*!40000 ALTER TABLE `gumae` DISABLE KEYS */;
/*!40000 ALTER TABLE `gumae` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jjim`
--

DROP TABLE IF EXISTS `jjim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jjim` (
  `jjimid` int(11) NOT NULL AUTO_INCREMENT,
  `created_day` datetime DEFAULT NULL,
  `modified_day` datetime DEFAULT NULL,
  PRIMARY KEY (`jjimid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jjim`
--

LOCK TABLES `jjim` WRITE;
/*!40000 ALTER TABLE `jjim` DISABLE KEYS */;
/*!40000 ALTER TABLE `jjim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `memberid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(30) NOT NULL,
  `pwd` char(60) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `created_day` datetime DEFAULT NULL,
  `modified_day` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  PRIMARY KEY (`memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'hong123','123456','hong123@test.com','01012345678','2025-03-24 10:57:50','2025-03-24 10:57:50','2025-05-12 19:39:53','홍길동',0),(2,'deleteTest','1234','testest@test.test','010-1111-1111','2025-05-12 19:58:20','2025-05-12 19:58:20',NULL,'삭제테스트이름',0);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `menuid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `menu_pic` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `writeday` datetime DEFAULT NULL,
  PRIMARY KEY (`menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice` (
  `noticeid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `writeday` datetime DEFAULT NULL,
  `content` text DEFAULT NULL,
  `state` int(11) DEFAULT 0 COMMENT 'state 媛믪씠 1?대㈃ 怨듭???ы빆 ?곷떒',
  `adminid` int(11) DEFAULT NULL,
  `admin_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`noticeid`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (1,'공지 테스트 1','2025-03-21 15:21:41','공지 테스트 본문 1',0,1,'관리자'),(2,'공지 테스트 2','2025-03-21 15:21:41','공지 테스트 본문 2',0,1,'관리자'),(3,'공지 테스트 3','2025-03-21 15:21:41','공지 테스트 본문 3',0,1,'관리자'),(4,'공지 테스트 4','2025-03-21 15:21:41','공지 테스트 본문 4',0,1,'관리자'),(5,'공지 테스트 5','2025-03-21 15:21:41','공지 테스트 본문 5',0,1,'관리자'),(6,'공지 테스트 6','2025-03-21 15:21:41','공지 테스트 본문 6',0,1,'관리자'),(7,'공지 테스트 7','2025-03-21 15:21:41','공지 테스트 본문 7',0,1,'관리자'),(8,'공지 테스트 8','2025-03-21 15:21:41','공지 테스트 본문 8',0,1,'관리자'),(9,'공지 테스트 9','2025-03-21 15:21:41','공지 테스트 본문 9',0,1,'관리자'),(10,'공지 테스트 10','2025-03-21 15:21:41','공지 테스트 본문 10',0,1,'관리자'),(11,'공지 테스트 11','2025-03-21 15:21:41','공지 테스트 본문 11',0,1,'관리자'),(12,'공지 테스트 12','2025-03-21 15:21:41','공지 테스트 본문 12',0,1,'관리자'),(13,'공지 테스트 13','2025-03-21 15:21:41','공지 테스트 본문 13',0,1,'관리자'),(14,'공지 테스트 14','2025-03-21 15:21:41','공지 테스트 본문 14',0,1,'관리자'),(15,'공지 테스트 15','2025-03-21 15:21:41','공지 테스트 본문 15',0,1,'관리자'),(16,'공지 테스트 16','2025-03-21 15:21:41','공지 테스트 본문 16',0,1,'관리자'),(17,'공지 테스트 17','2025-03-21 15:21:41','공지 테스트 본문 17',0,1,'관리자'),(18,'공지 테스트 18','2025-03-21 15:21:41','공지 테스트 본문 18',0,1,'관리자'),(19,'공지 테스트 19','2025-03-21 15:21:41','공지 테스트 본문 19',0,1,'관리자'),(20,'공지 테스트 20','2025-03-21 15:21:41','공지 테스트 본문 20',0,1,'관리자'),(21,'공지 테스트 21','2025-03-21 15:21:41','공지 테스트 본문 21',0,1,'관리자'),(22,'공지 테스트 22','2025-03-21 15:21:41','공지 테스트 본문 22',0,1,'관리자'),(23,'공지 테스트 23','2025-03-21 15:21:41','공지 테스트 본문 23',0,1,'관리자'),(24,'공지 테스트 24','2025-03-21 15:21:41','공지 테스트 본문 24',0,1,'관리자'),(25,'공지 테스트 25','2025-03-21 15:21:41','공지 테스트 본문 25',0,1,'관리자'),(26,'공지 테스트 26','2025-03-21 15:21:41','공지 테스트 본문 26',0,1,'관리자'),(27,'공지 테스트 27','2025-03-21 15:21:41','공지 테스트 본문 27',0,1,'관리자'),(28,'공지 테스트 28','2025-03-21 15:21:41','공지 테스트 본문 28',0,1,'관리자'),(29,'공지 테스트 29','2025-03-21 15:21:41','공지 테스트 본문 29',0,1,'관리자'),(30,'공지 테스트 30','2025-03-21 15:21:41','공지 테스트 본문 30',0,1,'관리자'),(31,'공지 테스트 31','2025-03-21 15:21:41','공지 테스트 본문 31',0,1,'관리자'),(32,'공지 테스트 32','2025-03-21 15:21:41','공지 테스트 본문 32',0,1,'관리자'),(33,'공지 테스트 33','2025-03-21 15:21:41','공지 테스트 본문 33',0,1,'관리자'),(34,'공지 테스트 34','2025-03-21 15:21:41','공지 테스트 본문 34',0,1,'관리자'),(35,'공지 테스트 35','2025-03-21 15:21:41','공지 테스트 본문 35',0,1,'관리자'),(36,'공지 테스트 36','2025-03-21 15:21:41','공지 테스트 본문 36',0,1,'관리자'),(37,'공지 테스트 37','2025-03-21 15:21:41','공지 테스트 본문 37',0,1,'관리자'),(38,'공지 테스트 38','2025-03-21 15:21:41','공지 테스트 본문 38',0,1,'관리자'),(39,'공지 테스트 39','2025-03-21 15:21:41','공지 테스트 본문 39',0,1,'관리자'),(40,'공지 테스트 40','2025-03-21 15:21:41','공지 테스트 본문 40',0,1,'관리자'),(41,'공지 테스트 41','2025-03-21 15:21:41','공지 테스트 본문 41',0,1,'관리자'),(42,'공지 테스트 42','2025-03-21 15:21:41','공지 테스트 본문 42',0,1,'관리자'),(43,'공지 테스트 43','2025-03-21 15:21:41','공지 테스트 본문 43',0,1,'관리자'),(44,'공지 테스트 44','2025-03-21 15:21:41','공지 테스트 본문 44',0,1,'관리자'),(45,'공지 테스트 45','2025-03-21 15:21:41','공지 테스트 본문 45',0,1,'관리자'),(46,'공지 테스트 46','2025-03-21 15:21:41','공지 테스트 본문 46',0,1,'관리자'),(47,'공지 테스트 47','2025-03-21 15:21:41','공지 테스트 본문 47',0,1,'관리자'),(48,'공지 테스트 48','2025-03-21 15:21:41','공지 테스트 본문 48',0,1,'관리자'),(49,'공지 테스트 49','2025-03-21 15:21:41','공지 테스트 본문 49',0,1,'관리자'),(50,'공지 테스트 50','2025-03-21 15:21:41','공지 테스트 본문 50',0,1,'관리자'),(51,'공지 테스트 51','2025-03-21 15:21:41','공지 테스트 본문 51',0,1,'관리자'),(52,'공지 테스트 52','2025-03-21 15:21:41','공지 테스트 본문 52',0,1,'관리자'),(53,'공지 테스트 53','2025-03-21 15:21:41','공지 테스트 본문 53',0,1,'관리자'),(54,'공지 테스트 54','2025-03-21 15:21:41','공지 테스트 본문 54',0,1,'관리자'),(55,'공지 테스트 55','2025-03-21 15:21:41','공지 테스트 본문 55',0,1,'관리자'),(56,'공지 테스트 56','2025-03-21 15:21:41','공지 테스트 본문 56',0,1,'관리자'),(57,'공지 테스트 57','2025-03-21 15:21:41','공지 테스트 본문 57',0,1,'관리자'),(58,'공지 테스트 58','2025-03-21 15:21:41','공지 테스트 본문 58',0,1,'관리자'),(59,'공지 테스트 59','2025-03-21 15:21:41','공지 테스트 본문 59',0,1,'관리자'),(60,'공지 테스트 60','2025-03-21 15:21:41','공지 테스트 본문 60',0,1,'관리자'),(61,'공지 테스트 61','2025-03-21 15:21:41','공지 테스트 본문 61',0,1,'관리자'),(62,'공지 테스트 62','2025-03-21 15:21:41','공지 테스트 본문 62',0,1,'관리자'),(63,'공지 테스트 63','2025-03-21 15:21:41','공지 테스트 본문 63',0,1,'관리자'),(64,'공지 테스트 64','2025-03-21 15:21:41','공지 테스트 본문 64',0,1,'관리자'),(65,'공지 테스트 65','2025-03-21 15:21:41','공지 테스트 본문 65',0,1,'관리자'),(66,'공지 테스트 66','2025-03-21 15:21:41','공지 테스트 본문 66',0,1,'관리자'),(67,'공지 테스트 67','2025-03-21 15:21:41','공지 테스트 본문 67',0,1,'관리자'),(68,'공지 테스트 68','2025-03-21 15:21:41','공지 테스트 본문 68',0,1,'관리자'),(69,'공지 테스트 69','2025-03-21 15:21:41','공지 테스트 본문 69',0,1,'관리자'),(70,'공지 테스트 70','2025-03-21 15:21:41','공지 테스트 본문 70',0,1,'관리자'),(71,'공지 테스트 71','2025-03-21 15:21:41','공지 테스트 본문 71',0,1,'관리자'),(72,'공지 테스트 72','2025-03-21 15:21:41','공지 테스트 본문 72',0,1,'관리자'),(73,'공지 테스트 73','2025-03-21 15:21:41','공지 테스트 본문 73',0,1,'관리자'),(74,'공지 테스트 74','2025-03-21 15:21:41','공지 테스트 본문 74',0,1,'관리자'),(75,'공지 테스트 75','2025-03-21 15:21:41','공지 테스트 본문 75',0,1,'관리자'),(76,'공지 테스트 76','2025-03-21 15:21:41','공지 테스트 본문 76',0,1,'관리자'),(77,'공지 테스트 77','2025-03-21 15:21:41','공지 테스트 본문 77',0,1,'관리자'),(78,'공지 테스트 78','2025-03-21 15:21:41','공지 테스트 본문 78',0,1,'관리자'),(79,'공지 테스트 79','2025-03-21 15:21:41','공지 테스트 본문 79',0,1,'관리자'),(80,'공지 테스트 80','2025-03-21 15:21:41','공지 테스트 본문 80',0,1,'관리자'),(81,'공지 테스트 81','2025-03-21 15:21:41','공지 테스트 본문 81',0,1,'관리자'),(82,'공지 테스트 82','2025-03-21 15:21:41','공지 테스트 본문 82',0,1,'관리자'),(83,'공지 테스트 83','2025-03-21 15:21:41','공지 테스트 본문 83',0,1,'관리자'),(84,'공지 테스트 84','2025-03-21 15:21:41','공지 테스트 본문 84',0,1,'관리자'),(85,'공지 테스트 85','2025-03-21 15:21:41','공지 테스트 본문 85',0,1,'관리자'),(86,'공지 테스트 86','2025-03-21 15:21:41','공지 테스트 본문 86',0,1,'관리자'),(87,'공지 테스트 87','2025-03-21 15:21:41','공지 테스트 본문 87',0,1,'관리자'),(88,'공지 테스트 88','2025-03-21 15:21:41','공지 테스트 본문 88',0,1,'관리자'),(89,'공지 테스트 89','2025-03-21 15:21:41','공지 테스트 본문 89',0,1,'관리자'),(90,'공지 테스트 90','2025-03-21 15:21:41','공지 테스트 본문 90',0,1,'관리자'),(91,'공지 테스트 91','2025-03-21 15:21:41','공지 테스트 본문 91',0,1,'관리자'),(92,'공지 테스트 92','2025-03-21 15:21:41','공지 테스트 본문 92',0,1,'관리자'),(93,'공지 테스트 93','2025-03-21 15:21:41','공지 테스트 본문 93',0,1,'관리자'),(94,'공지 테스트 94','2025-03-21 15:21:41','공지 테스트 본문 94',0,1,'관리자'),(95,'공지 테스트 95','2025-03-21 15:21:41','공지 테스트 본문 95',0,1,'관리자'),(96,'공지 테스트 96','2025-03-21 15:21:41','공지 테스트 본문 96',0,1,'관리자'),(97,'공지 테스트 97','2025-03-21 15:21:41','공지 테스트 본문 97',0,1,'관리자'),(98,'공지 테스트 98','2025-03-21 15:21:41','공지 테스트 본문 98',0,1,'관리자'),(99,'공지 테스트 99','2025-03-21 15:21:41','공지 테스트 본문 99',1,1,'관리자'),(100,'공지 테스트 100','2025-03-21 15:21:41','공지 테스트 본문 100',0,1,'관리자'),(128,'1','2025-05-14 03:10:34','1',0,1,'관리자'),(129,'1','2025-05-14 03:13:08','1',1,1,'관리자'),(130,'test','2025-05-14 03:16:05','test!',1,1,'관리자'),(131,'test2','2025-05-14 03:45:16','test2',0,1,NULL),(132,'test3','2025-05-14 03:47:32','test3',0,1,NULL),(133,'test4','2025-05-14 03:48:50','test4',0,1,NULL),(134,'test5','2025-05-14 03:52:33','test5',0,1,NULL),(135,'test6','2025-05-14 03:54:51','test6',1,1,'관리자'),(136,'test8','2025-05-14 21:27:28','test8',1,1,'관리자');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personalinquiry`
--

DROP TABLE IF EXISTS `personalinquiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personalinquiry` (
  `personalInquiryid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `writeday` datetime DEFAULT NULL,
  `answerwriteday` datetime DEFAULT NULL,
  `state` int(11) DEFAULT 0,
  `category` int(11) DEFAULT 0,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`personalInquiryid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personalinquiry`
--

LOCK TABLES `personalinquiry` WRITE;
/*!40000 ALTER TABLE `personalinquiry` DISABLE KEYS */;
INSERT INTO `personalinquiry` VALUES (1,'hong123','ㅇㅁㄴ','ㅇㄴㅁ','2025-04-03 17:48:04',NULL,0,1,NULL),(2,'hong123','','','2025-05-05 01:35:40',NULL,0,0,NULL),(3,'hong123',',','','2025-05-05 01:38:14',NULL,0,0,'1'),(4,'hong123',',','','2025-05-09 00:28:18',NULL,0,0,'1'),(5,'hong123','we,qwqeqewqe','wew','2025-05-12 19:28:51',NULL,0,1,NULL),(6,'hong123','환불언제해주나요','환불좀해줘!!','2025-05-17 01:10:54',NULL,0,1,NULL),(7,'hong123','시설이 너무 엉망이네요!!','제대로좀 하세요!','2025-05-17 01:14:06','2025-05-17 01:40:33',1,2,'test@testest.com');
/*!40000 ALTER TABLE `personalinquiry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseinfo`
--

DROP TABLE IF EXISTS `purchaseinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchaseinfo` (
  `purchaseinfoid` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT 0,
  `writeday` datetime DEFAULT NULL,
  PRIMARY KEY (`purchaseinfoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseinfo`
--

LOCK TABLES `purchaseinfo` WRITE;
/*!40000 ALTER TABLE `purchaseinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchaseinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna`
--

DROP TABLE IF EXISTS `qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qna` (
  `qnaid` int(11) NOT NULL AUTO_INCREMENT,
  `qnatitle` varchar(100) DEFAULT NULL,
  `text` text NOT NULL,
  `writeday` datetime DEFAULT NULL,
  PRIMARY KEY (`qnaid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna`
--

LOCK TABLES `qna` WRITE;
/*!40000 ALTER TABLE `qna` DISABLE KEYS */;
/*!40000 ALTER TABLE `qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `reservationid` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT 0,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `rcode` char(8) DEFAULT NULL,
  `card1` int(11) DEFAULT NULL,
  `halbu1` int(11) DEFAULT NULL,
  `bank1` int(11) DEFAULT NULL,
  `card2` int(11) DEFAULT NULL,
  `bank2` int(11) DEFAULT NULL,
  `jumuncode` char(12) DEFAULT NULL,
  `sudan` int(11) DEFAULT NULL,
  `review` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `tel` int(11) DEFAULT NULL,
  `writeday` datetime DEFAULT NULL,
  `purposeuse` varchar(1000) DEFAULT NULL,
  `requesttohost` varchar(1000) DEFAULT NULL,
  `reservprice` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `modified_at1` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`reservationid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,2,'2025-03-25 05:00:00','2025-03-25 13:00:00','r0101004',1,2,0,0,0,'j20250324001',NULL,NULL,'hong123',0,'2025-03-24 10:58:36','모임','없습니다.',160000,'2025-04-04 17:53:27','0000-00-00 00:00:00'),(2,0,'2025-04-30 12:00:00','2025-04-30 17:00:00','r0101004',0,0,0,0,0,'j20250402001',NULL,NULL,'hong123',0,'2025-04-02 16:51:02','','',100000,'2025-04-04 18:00:48','0000-00-00 00:00:00'),(3,2,'2025-04-23 07:00:00','2025-04-23 14:00:00','r0101002',0,0,0,0,0,'j20250417001',NULL,NULL,'hong123',0,'2025-04-17 00:43:00','','',140000,'2025-05-12 10:29:30','0000-00-00 00:00:00'),(4,1,'2025-04-30 07:00:00','2025-04-30 19:00:00','r0101002',0,0,0,0,0,'j20250422001',NULL,NULL,'hong123',0,'2025-04-22 22:18:50','','',240000,'2025-05-16 17:35:11','0000-00-00 00:00:00'),(5,0,'2025-05-01 13:00:00','2025-05-01 16:00:00','r0101003',0,0,0,0,0,'j20250430001',NULL,NULL,'hong123',0,'2025-04-30 22:06:56','','',60000,NULL,'0000-00-00 00:00:00'),(6,1,'2025-05-01 16:00:00','2025-05-01 19:00:00','r0101002',0,0,0,0,0,'j20250430002',NULL,NULL,'hong123',0,'2025-04-30 22:18:13','','',60000,'2025-05-16 17:36:11','0000-00-00 00:00:00'),(7,0,'2025-05-12 03:00:00','2025-05-12 11:00:00','r0101003',0,0,0,0,0,'j20250503001',NULL,NULL,'hong123',0,'2025-05-03 00:07:56','','',160000,NULL,'0000-00-00 00:00:00'),(8,0,'2025-05-05 19:00:00','2025-05-05 22:00:00','r0101003',0,0,0,0,0,'j20250505001',NULL,NULL,'hong123',0,'2025-05-05 01:12:08','','',60000,NULL,'0000-00-00 00:00:00'),(9,0,'2025-05-26 12:00:00','2025-05-26 17:00:00','r0101004',0,0,0,0,0,'j20250505002',NULL,NULL,'hong123',0,'2025-05-05 01:29:07','','',80000,NULL,'0000-00-00 00:00:00'),(10,0,'2025-05-13 19:00:00','2025-05-13 10:00:00','r0101003',0,0,0,0,0,'j20250506001',NULL,NULL,'hong123',0,'2025-05-06 19:18:15','','',140000,NULL,'0000-00-00 00:00:00'),(11,0,'2025-05-06 19:00:00','2025-05-06 10:00:00','r0101003',0,0,0,0,0,'j20250506002',NULL,NULL,'hong123',0,'2025-05-06 19:40:12','','',140000,NULL,'0000-00-00 00:00:00'),(12,0,'2025-05-25 19:00:00','2025-05-25 10:00:00','r0101003',0,0,0,0,0,'j20250506003',NULL,NULL,'hong123',0,'2025-05-06 19:40:21','','',140000,NULL,'0000-00-00 00:00:00'),(13,0,'2025-05-25 19:00:00','2025-05-25 21:00:00','r0101003',0,0,0,0,0,'j20250506004',NULL,NULL,'hong123',0,'2025-05-06 19:49:46','','',40000,NULL,'0000-00-00 00:00:00'),(14,0,'2025-05-07 16:00:00','2025-05-07 22:00:00','r0101003',0,0,0,0,0,'j20250506005',NULL,NULL,'hong123',0,'2025-05-06 19:50:13','123','1231',120000,NULL,'0000-00-00 00:00:00'),(15,0,'2025-05-08 04:00:00','2025-05-08 07:00:00','r0103001',0,0,0,0,0,'j20250508001',NULL,NULL,'hong123',0,'2025-05-08 03:22:18','','',69000,NULL,'0000-00-00 00:00:00'),(16,0,'2025-05-20 01:00:00','2025-05-20 07:00:00','r0101004',0,0,0,0,0,'j20250516001',NULL,NULL,NULL,0,'2025-05-16 00:18:45','','',120000,NULL,'0000-00-00 00:00:00');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `reviewid` int(11) NOT NULL AUTO_INCREMENT,
  `review_text` text DEFAULT NULL,
  `star` int(11) DEFAULT NULL,
  `writeday` datetime DEFAULT NULL,
  PRIMARY KEY (`reviewid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `roomid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` int(11) NOT NULL DEFAULT 0,
  `writeday` datetime DEFAULT NULL,
  `pic` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration_type` int(11) DEFAULT 0,
  `heart` int(11) DEFAULT 0,
  `rcode` char(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subpic` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `halin` int(11) DEFAULT 0,
  `keyword` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pkgname` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pkgprice` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pkgstart` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pkgend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adress` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roadadress` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mapx` double DEFAULT NULL,
  `mapy` double DEFAULT NULL,
  `caution` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refundpolicy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `officehour` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `closedday` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floor` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `car` int(11) DEFAULT 0,
  `elevator` int(11) DEFAULT 0,
  `fstatus` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ininfo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `play` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kitchen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `homepage` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subdesc` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bname` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hostname` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `halinprice` int(11) DEFAULT NULL,
  `hostemail` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bnum` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`roomid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'홍대파티룸 디연남공간',-1,'홍대에 위치한 풀파티룸!\r\n\r\n\r\n- 마당에서 프라이빗하게 즐기는 미국식 그릴 바베큐 \r\n- 간이 수영장\r\n- 파티룸 이용고객 단독 대관\r\n- 조리시설 완비\r\n\r\n\r\n\r\n § 수영장 이용료 별도 발생합니다 ( 10월 ~ 5월까지는 무료 이용가능합니다_ 옵션추가 x ),인원 및 보증금 안내',6,'2025-03-11 15:23:12','9a0e298cf449a.jpg',1,0,'r0101001','242822_7Bd0cTVv0T18.jpg/242822_32aZtq3eEfM9.jpg/242822_AYh7ZX7RtzqW.jpg/242822_B4Zc0iH7x3SC.jpg/242822_DHrQMWYi5gvg.jpg/242822_Ee69bYmt4t1B.jpg/242822_HQpXv4hGBOaF.jpg/242822_NXVdNJgBHPEH.jpg/242822_nY7MO6EgAmfw.jpg/242822_vf6RtejglW1n.jpg/242822_WsKySgsUFDbF.jpg/',0,'#홍대입구#바베큐#수영장','✨낮 패키지(12시~17시),✨밤 패키지(19시~익일10시),✨올데이 패키지(12시~22시),,,','60000,130000,150000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 마포구 동교동 113-78 1층','서울특별시 마포구 연희로 21-8 (동교동) 1층',126.926230031283,37.5607994773254,'인원 및 보증금 안내\r\n인원 안내\r\n기준 인원2명\r\n최대 인원6명\r\n기준 인원 추가 시(1인당)\r\n낮타임1만원\r\n밤타임, 올데이1만원\r\n보증금\r\n청소 보증금8만원\r\n■ 보증금은 차감 사유에 해당하지 않는 경우 전액 환급됩니다\r\n\r\n■ 보증금은 이용 요금과 별도로 안내드리며 입실일 기준 차주 수요일에 순차적으로 환급됩니다\r\n\r\n■ 보증금 차감 기준\r\n\r\n- 기본 정리 / 분리수거 / 설거지 등 정리 정돈 미실시\r\n\r\n- 무단 입실/ 늦은 퇴실 / 추가 인원 미고지\r\n\r\n- 오염 및 파손/ 실내 흡연 / 구토 후 미처리 등\r\n\r\n- 소등 및 사용 제품 전원을 끄지 않고 퇴실 시\r\n\r\n- 고기 및 생선 등 냄새 심한 음식 취사','0,-1,-1,-1,-1,-1,-1,-1,-1','24시간','무휴','1층',0,0,'0,7,8,9','1,2,3,4','0,2,5,7','0,1,2,3,4,5,6,7','01031231234','홍대에 위치한 풀파티룸!','https://thespace.com','홍대에 위치한 풀파티룸! - 마당에서 프라이빗하게 즐기는 미국식 그릴 바베큐 - 간이 수영장 - 파티룸 이용고객 단독 대관 - 조리시설 완비 § 수영장 이용료 별도 발생합니다 (10월 ~ 5월까지는 무료 이용가능합니다_ 옵션추가 x ),인원 및 보증금 안내;','더스페이스','홍길동',NULL,'host1@example.com','3883715890'),(2,'합정파티룸 라운지',20000,'@ 편리한 교통\r\n합정역 8번출구에서 도보 3분거리에 위치해 만남의 장소로 제격!\r\n\r\n@ 합정역 인근에서 가장 넓은 파티룸\r\n\r\n최대 40명까지 이용가능하며 한곳에 앉아서 즐길 수 있는 넓직한 공간을 자랑합니다.\r\n40명이 앉을 수 있는 테이블과 의자 소개팅 / 야유회 / 대학생MT / 세미나 등 각종 모임에 적합한 공간\r\n* 정원 초과 이용을 원하시는 경우 문의필요\r\n\r\n@ 100인치 빔프로젝터 + KT 셋탑\r\n고사양 빔프로젝터와 군더더기 없는 시청\r\nKT기가지니로 모든 OTT 구동 가능\r\n\r\n@ TJ 미디어 노래방 기능\r\n무선 블루투스 마이크를 이용한 노래방 기능 ( 23시까지 이용가능)\r\n\r\n@ 최신인기 보드게임 , 화이트보드 , 전자피아노\r\n\r\n@ 식기류, 컵, 잔, 냄비, 프라이팬, 조리도구 등 인원수에 맞춰서 모두 준비 완료\r\n\r\n@ 전자레인지, 제빙기, 정수기, 냉장고, 싱크대, 인덕션 2구, 전자레인지, 냉난방기, 실외 단독화장실\r\n\r\n* 제빙기의 경우 고객님께서 입실 후 직접 냉각해주셔야합니다\r\n\r\n즐거운 파티를 위한 최적의 장소 , 라운지로 여러분을 초대합니다\r\n\r\n@ 이용시간\r\n낮타임 12시 - 17시 [5시간]\r\n밤타임 19시 - 익일 9시 [14시간]\r\n3시간패키지 + 시간추가 가능 (금,토 제외)\r\n올데이패키지 ( 12-22 )\r\n\r\n우리끼리만 즐겁게 놀 수 있는 프라이빗 공간 쏘플파티룸\r\n\r\n@ 바닥난방 불가 / 스탠드 난방기 구비\r\n@ 노래방이용시간 오후 11시까지 (블루투스 마이크)\r\n\r\n@ 쏘플파티룸을 이용해야 하는 이유\r\n- 발 빠른 응대와 기분좋은 친절한 서비스\r\n- 각종 보드게임 구비 완료 / 어떤 음식이든 만들 수 있는 주방시설\r\n- 파티룸 사용 전,후 전문청소업체를 통한 깨끗한 청결 관리 + 정기방역\r\n- 대형 빔프로젝터 or TV 및 미러볼, 마이크, 음향시설 완비!\r\n- 남녀노소 누구나 안전하게 즐길 수 있는 공간!,',40,'2025-03-11 15:49:48','9a0e298cf449a.jpg',2,3,'r0101002','242822_7Bd0cTVv0T18.jpg/242822_32aZtq3eEfM9.jpg/242822_AYh7ZX7RtzqW.jpg/242822_B4Zc0iH7x3SC.jpg/242822_DHrQMWYi5gvg.jpg/242822_Ee69bYmt4t1B.jpg/242822_HQpXv4hGBOaF.jpg/242822_NXVdNJgBHPEH.jpg/242822_nY7MO6EgAmfw.jpg/242822_vf6RtejglW1n.jpg/242822_WsKySgsUFDbF.jpg/',0,'#합정역#홍대#대형#노래방','낮 타임 패키지 (12시-17시),밤 타임 패키지 (19시- 익일9시),올데이 패키지 (12시-22시),,,','70000,110000,120000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 마포구 합정동 387-1 4층','서울특별시 마포구 월드컵로3길 27 (합정동) 4층',126.91269444211161,37.54886401099841,'인원 및 보증금 안내\r\n인원 안내\r\n기준 인원6명\r\n최대 인원40명\r\n기준 인원 추가 시(1인당)\r\n낮타임, 3시간1만원\r\n밤타임, 올데이1만원\r\n보증금\r\n청소 보증금10만원\r\n■ 보증금은 차감 사유에 해당하지 않는 경우 전액 환급됩니다\r\n\r\n■ 보증금은 이용 요금과 별도로 안내드리며 입실일 기준 차주 수요일에 순차적으로 환급됩니다\r\n\r\n■ 보증금 차감 기준\r\n\r\n- 기본 정리 / 분리수거 / 설거지 등 정리 정돈 미실시\r\n\r\n- 무단 입실/ 늦은 퇴실 / 추가 인원 미고지\r\n\r\n- 오염 및 파손/ 실내 흡연 / 구토 후 미처리 등\r\n\r\n- 소등 및 사용 제품 전원을 끄지 않고 퇴실 시\r\n\r\n- 고기 및 생선 등 냄새 심한 음식 취사','0,-1,-1,-1,-1,-1,-1,-1,-1','24시간','무휴','4층',0,0,'0,5,8,9','0,2,3,5','0,1,2,5','0,1,2,3,4,5,7,8','01012342434','합정역 8번출구에서 도보 3분거리에 위치해 만남의 장소로 제격인 파티룸!','https://lumiroom.com','@ 편리한 교통 합정역 8번출구에서 도보 3분거리에 위치해 만남의 장소로 제격! @ 합정역 인근에서 가장 넓은 파티룸 최대 40명까지 이용가능하며 한곳에 앉아서 즐길 수 있는 넓직한 공간을 자랑합니다. 40명이 앉을 수 있는 테이블과 의자 소개팅 / 야유회 / 대학생MT / 세미나 등 각종 모임에 적합한 공간.','루미룸','이서준',NULL,'contact2@mail.com','5617952445'),(3,'홍대게임 그리드',20000,'홍대 게임파티룸 그리드 오픈\r\n\r\n\r\n\r\n게임의 게임에 의한 게임을 위한 홍대게임파티룸 그리드\r\n\r\n게임만 집중해서 하실 수 있도록 공간을 구성했습니다.\r\n\r\n\r\n\r\n먹고 자고 게임하고 한큐에 해결가능한 그리드 파티룸을 소개합니다.\r\n\r\n\r\n\r\n- 고성능 PC 6대\r\n\r\nGPU : RTX4060 / CPU : 라이젠 5600 / 32인치 게이밍 모니터/ 게이밍 키보드 마우스 / 사운드바\r\n\r\n게임 이용 편리하고 속도도 보장합니다.\r\n\r\n\r\n\r\n- 100인치 빔프로젝터 + U+ 셋탑\r\n\r\n고사양 빔프로젝터와 군더더기 없는 시청 가능합니다.\r\n\r\nU+셋탑박스 설치가 되어있어 모든 OTT 구동 가능\r\n\r\n\r\n\r\n- 홀덤포커테이블(10인)\r\n\r\n홀덤테이블 10인용이 구비되어있습니다. 포커집 카드도 풀세팅\r\n\r\n\r\n\r\n- 소음걱정 없는 TJ 미디어 노래방 기능\r\n\r\n노래방 반주에서 무선 블루투스 마이크로 만들어 내는 운치의 끝\r\n\r\n\r\n\r\n- 식기류, 컵, 와인잔, 잔, 냄비, 프라이팬, 조리도구 등 인원수에 맞춰서 모두 준비 완료\r\n\r\n\r\n\r\n- 흡연 가능한 출입구가 따로 있으며 화장실은 반계단 위에 있습니다.\r\n\r\n',16,'2025-03-11 16:54:49','c2e02627d5940.jpg',2,3,'r0101003','251914_2cTwAr0H65EJ.jpg/251914_2D4jGt9m8ta6.jpg/251914_9yo8kjS6GKVR.jpg/251914_784v5Zfq92ch.jpg/251914_ExbRvPyEhvJd.jpg/251914_eZfS208vJ7W4.jpg/251914_ggdtWb0bgRZD.jpg/251914_hdogw6ALP4Xn.jpg/251914_mSoQdvfsyitK.jpg/251914_nCEDaXdYp3mR.jpg/251914_TTHaRSmZsRoi.jpg/251914_Vs9ZKZFzboJh.png/',0,'#홍대#PC#빔프로젝터#노래방#보드게임','낮 타임 패키지 (12시-17시),밤 타임 패키지 (19시-익일10시),올데이 패키지 (12시-22시),,,','100000,140000,120000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 마포구 합정동 355-11 한스빌딩 한스빌딩 지하 1층 그리드 파티룸','서울특별시 마포구 독막로8길 19 (합정동) 한스빌딩 지하 1층 그리드 파티룸',126.918146505662,37.5470328525113,'인원 및 보증금 안내\r\n인원 안내\r\n기준 인원4명\r\n최대 인원12명\r\n기준 인원 추가 시(1인당)\r\n낮타임5천원\r\n밤타임, 올데이, 3시간1만원\r\n보증금\r\n청소 보증금8만원\r\n■ 보증금은 차감 사유에 해당하지 않는 경우 전액 환급됩니다\r\n\r\n■ 보증금은 이용 요금과 별도로 안내드리며 입실일 기준 차주 수요일에 순차적으로 환급됩니다\r\n\r\n■ 보증금 차감 기준\r\n\r\n- 기본 정리 / 분리수거 / 설거지 등 정리 정돈 미실시\r\n\r\n- 무단 입실/ 늦은 퇴실 / 추가 인원 미고지\r\n\r\n- 오염 및 파손/ 실내 흡연 / 구토 후 미처리 등\r\n\r\n- 소등 및 사용 제품 전원을 끄지 않고 퇴실 시\r\n\r\n- 고기 및 생선 등 냄새 심한 음식 취사','0,-1,-1,-1,-1,-1,-1,-1,-1','24시간','무휴','지하 1층',0,0,'0,2,5,7,8,9','0,2,3,5','0,1,2','0,1,2,3,4,5','01034321234','홍대 게임파티룸 그리드!','https://momentlab.com','홍대 게임파티룸 그리드 오픈 게임의 게임에 의한 게임을 위한 홍대게임파티룸 그리드 게임만 집중해서 하실 수 있도록 공간을 구성했습니다. 먹고 자고 게임하고 한큐에 해결가능한 그리드 파티룸을 소개합니다.','모먼트랩','박지훈',NULL,'info3@host.com','6438614862'),(4,'홍대파티룸 알파카',20000,'지인모임, 프라이빗한 데이트, 영상 시청, 보드게임모임,송년회/신년회\r\n\r\n\r\n\r\n월등히 저렴하고 합리적인 비용으로 한마디로 가성비 넘치는\r\n\r\n알파카파티룸에 여러분을 초대합니다.\r\n\r\n\r\n\r\n[파티룸 소개]\r\n\r\n\r\n\r\n- 65인치 대형 UHD TV + U+ 셋탑\r\n\r\n대형 TV와 U+셋탑박스 설치가 되어있어 모든 OTT 구동 가능\r\n\r\n4K 화질로 선명하고 푹신한 쇼파에서 편안한 관람 가능\r\n\r\n\r\n\r\n- 소음걱정 없는 TJ 미디어 노래방 기능\r\n\r\n노래방 반주에서 무선 블루투스 마이크로 만들어 내는 운치의 끝\r\n\r\n\r\n\r\n- 20여종의 최신인기 보드게임\r\n\r\n루미큐브, 로스트시티, 할리갈리, 바퀴벌레포커, 스페이스 크루, 뱅, 달무티, 텔레스트레이션, 커피러시, 사보타지, 시타델, 화투 ,술자리퀴즈왕, 클루, 젠가 ,젬블로 ( 보드게임 목록은 유동적으로, 기재된 내용과 일부 차이가 있을 수 있습니다. 이용 전 반드시 문의 부탁드립니다 )\r\n\r\n\r\n\r\n- 인생샷 남길 수 있는 공간 구성과 조명\r\n\r\n꽃과 알파카 스누피까지 귀엽고 예쁜 건 다 모아뒀으니 사진기 준비 필수\r\n\r\n보다 센치한 무드를 위하여 선셋 무드등 구비해두었습니다.\r\n\r\n\r\n\r\n- 보다 행복한 하루를 위한 파티용품 구비\r\n\r\n귀여운 생일가랜드와 패브릭포스터 화관 덩쿨\r\n\r\n\r\n\r\n- 식기류, 컵, 와인잔, 소주잔, 냄비, 프라이팬, 조리도구 등 인원수에 맞춰서 모두 준비 완료\r\n\r\n\r\n\r\n- 합정역 2분거리 메인거리에 위치해있어 배달 용이 / 포장 맛집 즐비\r\n\r\n( 맛집책자가 파티룸내부에 비치되어있습니다)',8,'2025-03-11 17:43:55','1cf4748edea2e.png',2,1,'r0101004','240821_2i6SDf31sfHh.png/240821_5DJqh9CnV1qw.png/240821_5mevL9Dvyw56.jpeg/240821_cSj8MeOjiPbf.jpg/240821_dO7coGo0H3jZ.png/240821_FsaxRTP2hwCM.jpg/240821_PGvdQjzWICP1.png/240821_uOYHgyhKNYbg.jpg/240821_5oEMMggYCdYj.png/',0,'#홍대#합정#합정역#노래방#보드게임','낮 타임 패키지 (12시-17시),밤타임 패키지 (19시-익일10시),올데이 패키지 (12시-22시),,,','80000,110000,120000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 마포구 서교동 394-93 4층 알파카 파티룸','서울특별시 마포구 양화로6길 19 (서교동) 4층 알파카 파티룸',126.915295517355,37.5492506318267,'인원 및 보증금 안내\r\n인원 안내\r\n기준 인원4명\r\n최대 인원8명\r\n기준 인원 추가 시(1인당)\r\n낮타임5천원\r\n밤타임, 올데이, 3시간1만원\r\n보증금\r\n청소 보증금8만원\r\n■ 보증금은 차감 사유에 해당하지 않는 경우 전액 환급됩니다\r\n\r\n■ 보증금은 이용 요금과 별도로 안내드리며 입실일 기준 차주 수요일에 순차적으로 환급됩니다\r\n\r\n■ 보증금 차감 기준\r\n\r\n- 기본 정리 / 분리수거 / 설거지 등 정리 정돈 미실시\r\n\r\n- 무단 입실/ 늦은 퇴실 / 추가 인원 미고지\r\n\r\n- 오염 및 파손/ 실내 흡연 / 구토 후 미처리 등\r\n\r\n- 소등 및 사용 제품 전원을 끄지 않고 퇴실 시\r\n\r\n- 고기 및 생선 등 냄새 심한 음식 취사','0,-1,-1,-1,-1,-1,-1,-1,-1','24시간','무휴','4층',0,1,'0,4,7,8,9,11','1,2,3,4,5','0,1,2','0,1,2,3,4,5','01012341234','지인모임, 프라이빗한 데이트, 영상 시청, 보드게임모임,송년회/신년회 가능한 파티룸','https://placeone.com','지인모임, 프라이빗한 데이트, 영상 시청, 보드게임모임,송년회/신년회 월등히 저렴하고 합리적인 비용으로 한마디로 가성비 넘치는 알파카파티룸에 여러분을 초대합니다. [파티룸 소개] - 65인치 대형 UHD TV + U+ 셋탑 대형 TV와 U+셋탑박스 설치가 되어있어 모든 OTT 구동 가능.','플레이스원','김민재',NULL,'user4@random.org','5339217284'),(5,'홍대파티룸 임페리얼',25000,'근처에서 제일 높은 7층 루프탑이 갖추어져 있는\r\n\r\n파티룸에서 가장 최고의 홍대 뷰를 즐겨보세요!\r\n\r\n\r\n\r\n미국 서부 느낌 내부 우드 월넛 인테리어 🐎\r\n\r\n\r\n\r\n- 눈코입이 모두 즐거운 대형 루프탑에서 즐기는 바베큐\r\n\r\n감탄사가 절로나오는 인근에서 가장 높은 건물 7층 대형 루프탑\r\n\r\n미국식 그릴로 사진도 예쁘게 나와요 : - )\r\n\r\n\r\n\r\n- 100인치 빔프로젝터 + U+ 셋탑\r\n\r\n고사양 빔프로젝터와 군더더기 없는 시청\r\n\r\nU+셋탑박스 설치가 되어있어 모든 OTT 구동 가능\r\n\r\n\r\n\r\n- 탁트인 통창\r\n\r\n내부에서도 밖을 바라볼 수 있어 확트인 개방감과 다양한 포토존\r\n\r\n\r\n\r\n- 사계절대비 철저한 준비\r\n\r\n따가운 햇살막이 대형 파라솔 (이용원하시는 경우 문의)\r\n\r\n부슬비에는 끄떡없는 그릴옆 간이파라솔\r\n\r\n세스코 월 정기방역 中\r\n\r\n\r\n\r\n- 소음걱정 없는 TJ 미디어 노래방 기능\r\n\r\n600W 시중에 판매되는 가장 고출력 블루투스마이크 2개 완비\r\n\r\n\r\n\r\n- 20여종의 최신인기 보드게임\r\n\r\n루미큐브, 스플렌더, 로스트시티, 할리갈리, 요트다이스, 라스베가스, 바퀴벌레포커, 스페이스크루, 뱅, 카탄, 달무티 등\r\n\r\n\r\n\r\n- 식기류, 컵, 잔, 냄비, 프라이팬, 조리도구 등 인원수에 맞춰서 모두 준비 완료\r\n\r\n\r\n\r\n- 냉장고, 싱크대, 인덕션 2구, 전자레인지, 냉난방기 2개, 실내화장실\r\n\r\n',16,'2025-03-12 09:51:12','7ccf6b2bf444e.jpg',2,0,'r0101005','254614_0eZG4Ve2Zhzw.jpg/254614_2cxw14rzeSwm.png/254614_4qbaI4gJSb4R.jpg/254614_9Eap63VGnF4S.jpg/254614_BD7zo57182qv.jpg/254614_CfURTJ6Lb4HV.jpg/254614_Cl4zLLAymqmV.jpg/254614_dHRznCi3FSC1.jpg/254614_hHVS0svPym2n.jpg/254614_Hi1V7o5TB5zP.jpg/254614_JylLbVHp3Tea.jpg/254614_pGfmkR91Nko8.jpg/254614_PNwUqQXCrcKq.jpg/254614_shzdIvQj0XdL.jpg/254614_WT3b02BCuLJJ.png/254614_YC6QR4ppSZj8.jpg/',0,'#홍대#상수역#루프탑#바베큐#노래방#도시뷰','🌞 Daytime Package (12:00 - 17:00),🌙 Nighttime Package (19:00 - 익일 10:00),🌞🌙 All Day Package (12:00 - 22:00),,,','100000,270000,180000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 마포구 서교동 408-29 테라빌딩 7층 임페리얼 파티룸 루프탑바베큐','서울특별시 마포구 어울마당로 44 (서교동) 7층 임페리얼 파티룸 루프탑바베큐',126.920863146626,37.5488579651271,'예약 시간 준수: 예약하신 시간에 맞춰 입·퇴실해 주시기 바랍니다. 다음 이용자를 위해 시간을 엄수해 주세요.​\r\n\r\n시설물 손상 방지: 파티룸 내 모든 시설과 비품은 소중히 다뤄주시고, 고의 또는 과실로 인한 손상 시 배상 책임이 발생할 수 있습니다.​\r\n\r\n소음 관리: 다른 손님과 주변 이웃을 위해 과도한 소음은 자제해 주시고, 특히 야간 시간대에는 더욱 주의해 주세요.​\r\n\r\n청결 유지: 사용하신 공간은 다음 손님을 위해 깨끗하게 정리해 주시고, 쓰레기는 분리수거 지침에 따라 처리해 주세요.​\r\n\r\n금연 및 화기 사용 금지: 파티룸 내에서는 금연이며, 화재 위험이 있는 물품(촛불, 폭죽 등)의 사용은 금지되어 있습니다.​\r\n\r\n인원 제한 준수: 예약 시 정해진 최대 수용 인원을 초과하지 않도록 해주세요. 인원 초과 시 추가 요금이 부과되거나 이용이 제한될 수 있습니다.​\r\n\r\n반려동물 동반 여부 확인: 반려동물 동반이 가능한지 사전에 확인해 주시고, 허용되지 않는 경우 반려동물 입장은 제한됩니다.​\r\n\r\n주류 및 음식물 반입 규정 확인: 주류나 음식물 반입이 가능한지 확인하시고, 허용된 경우에도 과도한 음주는 삼가해 주세요.​\r\n\r\n비상시 대응 방법 숙지: 비상구 위치와 소화기 사용법 등을 사전에 확인하여 안전사고에 대비해 주세요.​\r\n\r\n문의 및 불편 사항 신고: 이용 중 불편 사항이나 문의가 있을 경우, 즉시 관리자나 고객센터로 연락해 주세요.​\r\n\r\n위 사항들은 쏘플 파티룸 이용 시 일반적으로 고려해야 할 내용들입니다. 각 파티룸마다 세부 규정이 다를 수 있으므로, 예약 전 해당 파티룸의 이용 안내를 반드시 확인해 주시기 바랍니다.​','0,0,0,3,5,-1,-1,-1,-1','24시간','무휴','7층',0,1,'0,2,3,4,7,8,9,11','0,2,3,4,5','0,1,2','0,1,2,3,4,5','01077776666','근처에서 제일 높은 7층 루프탑이 갖추어져 있는 파티룸!','https://nesthouse.com','근처에서 제일 높은 7층 루프탑이 갖추어져 있는 파티룸에서 최고의 홍대 뷰를 즐겨보세요! 미국 서부 느낌 내부 우드 월넛 인테리어. 눈코입이 모두 즐거운 대형 루프탑에서 즐기는 바베큐. 감탄사가 절로나오는 인근에서 가장 높은 건물 7층 대형 루프탑.','네스트하우스','정수빈',NULL,'admin5@site.net','7380242140'),(6,'신촌파티룸 플레이션',25000,'🚗 고사양 pc 6대\r\n\r\ncpu : i5-13세대\r\n\r\nGPU : RTX4060ti\r\n\r\n모니터 : 32인치 커브드 게이밍 모니터\r\n\r\n게이밍 키보드  / 게이밍 마우스 \r\n\r\n\r\n\r\n🎁선명한 빔프로젝터  \r\n\r\n고객님 계정으로 ott 이용 가능\r\n\r\n\r\n\r\n🎶노래방 레트로 오락기까지! 게임파티룸 플레이션으로 ~ \r\n\r\n\r\n\r\n🎨화장실은 내부에 위치해있으며, 해당 파티룸은 취사 불가 ( 전자레인지 전기포트 구비 ) 합니다 ',8,'2025-03-12 10:01:20','f797359eec325.jpg',2,0,'r0101006','243516_CasD48LSuvDE.jpg/243516_MBe7jVHCwojf.jpg/243516_NnQNM45LCLEE.jpg/243516_Nx1Kdg8FNomC.jpg/243516_oNOgCXqDtKC5.jpg/243516_U5nOYMkBNxzy.jpg/243516_vmIObZLMIdfW.jpg/243516_Xgfz4vOpcQLb.jpg/243516_yEdSjYQfZPaT.jpg/243516_zdCNPypLxcmt.jpg/243516_ZqZ4Ylc58YgN.jpg/',0,'#신촌#PC6대#홀덤#노래방','낮타임,밤타임,올데이,,,','100000,230000,190000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 서대문구 창천동 33-5 지하2층','서울특별시 서대문구 연세로11길 5 (창천동) 지하2층',126.936467691497,37.558862610657,'안전하고 즐거운 시간을 위해 아래 유의사항을 꼭 확인해 주세요!\r\n예약된 입실 및 퇴실 시간을 엄수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n\r\n최대 수용 인원을 초과하지 말아주세요. 인원 초과 시 추가 요금이 부과되거나 이용이 제한될 수 있습니다.\r\n\r\n모든 시설(노래방, 보드게임, 빔프로젝터, 주방 등)은 정해진 사용 방법에 따라 이용해 주세요. 사용한 시설은 깨끗하게 정리해 주시기 바랍니다.\r\n\r\n냉장고 속 음식물, 쓰레기는 퇴실 전 반드시 정리해 주세요. 쓰레기는 분리수거해 주세요.\r\n\r\n밤 10시 이후 소음은 자제해 주시고, 실내에서는 금연입니다. 흡연은 지정된 구역에서만 가능합니다.\r\n\r\n화기 사용은 금지됩니다. (촛불, 폭죽, 불꽃놀이 등) 화재 예방을 위해 안전 수칙을 준수해 주세요.\r\n\r\n시설 이용 중 안전사고가 발생하면 즉시 관리자에게 신고해 주세요. 비상구와 소화기 위치는 사전 확인을 권장합니다.\r\n\r\n시설물이나 비품이 파손되었을 경우 즉시 관리자에게 알려주세요. 고의로 인한 손상은 배상 책임이 발생할 수 있습니다.\r\n\r\n퇴실 후 발견된 분실물은 일정 기간 보관 후 폐기됩니다.\r\n\r\n예약 취소는 최소 3일 전까지 가능합니다. 이후 취소 시 보증금은 환불되지 않습니다. 당일 취소나 노쇼(No-show) 시 이용 요금과 보증금은 환불 불가입니다.\r\n\r\n반려동물 동반은 사전 문의 필수입니다.\r\n\r\n주류 반입은 가능하나, 과음으로 인한 문제 발생 시 이용이 제한될 수 있습니다.\r\n\r\n모든 시설은 공용 공간이므로, 타인에 대한 배려를 부탁드립니다.\r\n\r\n⚠️ 유의사항을 지키지 않으면 입실 제한, 강제 퇴실, 보증금 차감 등의 불이익이 발생할 수 있습니다.\r\n🚨 안전하고 즐거운 시간을 보내실 수 있도록 협조 부탁드립니다!','0,1,2,3,4,5,-1,-1,-1','24시간','무휴','지하 2층',0,1,'0,4,8,9,11','0,1,2,3,6','0,1,2,3,4','0,2,4,5','01023231212','🎶노래방 레트로 오락기까지! 게임파티룸 플레이션으로 ~ ','https://atelierroom.com','고사양 pc 6대 CPU : i5-13세대 GPU : RTX4060ti 모니터 : 32인치 커브드 게이밍 모니터 게이밍 키보드 / 게이밍 마우스 🎁선명한 빔프로젝터 고객님 계정으로 ott 이용 가능 🎶노래방 레트로 오락기까지!','아틀리에룸','최예린',NULL,'support6@example.net','0883559157'),(7,'홍대파티룸 밍글',20000,'홍대 중심에 위치한 최대 30명이 넉넉하게 이용가능한 초대형 파티룸 !\r\n\r\n오늘의 파티가 소중한 추억 속 한 컷이 되길 바라는 마음을 가득 담아 공간 구성\r\n\r\n\r\n\r\n🎬100인치 빔프로젝터 + U+ 셋탑\r\n\r\n고사양 빔프로젝터와 군더더기 없는 시청을 위한 암막커튼설치 完\r\n\r\nU+셋탑박스 설치가 되어있어 모든 OTT 구동 가능\r\n\r\n\r\n\r\n🎤소음걱정 없는 TJ 미디어 노래방 기능\r\n\r\n고사양 앰프와 스피커에서 흘러나오는 MR과 실제 TJ 무선 마이크 완비 \r\n\r\n\r\n\r\n💍 보다 행복한 하루를 위한 파티용품 구비\r\n\r\n귀여운 생일가랜드와 패브릭포스터 꼬깔모자까지\r\n\r\n생일파티 세트 ( 오로라테이블보 모형디저트레이 트위스트초 촛대 등 )이용을 원하시는 경우 예약일 전일까지 카톡연락!\r\n\r\n(할로윈, 연말시즌엔 운영하지않습니다)\r\n\r\n\r\n\r\n👻모임 구성이 편안한 테이블\r\n\r\n4인용 테이블 8개가 구비되어있어 모임 유형에 맞춰서 손쉽게 변형 가능\r\n\r\n ( 문토 등 소셜링에도 용이)\r\n\r\n\r\n\r\n🎶20여종의 최신인기 보드게임 \r\n\r\n루미큐브, 로스트시티, 할리갈리, 바퀴벌레포커, 스페이스크루, 뱅, 달무티, 텔레스트레이션, 커피러시, 사보타지, 탑탑젠가, 해적통아저씨, 다빈치코드, 할리갈리컵스, 클루, 화투, 원카드, 잼블로\r\n\r\n( 보드게임 목록은 유동적으로, 기재된 내용과 일부 차이가 있을 수 있습니다. 이용 전 반드시 문의 부탁드립니다 )\r\n\r\n\r\n\r\n🎮다트 기계/ 오락실게임기\r\n\r\n설거지 내기, 간단한 아이스크림 내기에 적합한 다트 기계\r\n\r\n추억의 오락실게임 \'판도라박스\' 설치 총 999개의 게임 가능 \r\n\r\n ( 파이터 보글보글 등 )\r\n\r\n\r\n\r\n🎈냉난방기, 공기청정기, 스모그 기계\r\n\r\n냉난방기, 공기청정기, 클럽 스모그, 고데기 구비\r\n\r\n* 스모그기계 사용을 원하시는 경우 이용 전날까지 문의 必\r\n\r\n\r\n\r\n✨사이키한 조명, 대형 미러볼, 귀여운 포토존\r\n\r\n스마트조명으로 원하는 색으로 조정가능하며 대형 미러볼에서 나오는 오로라 조명으로 인생샷 생성 가능\r\n\r\n물결 웨이브 거울 포토존에서 딱 세장만 찍어보세요 \r\n\r\n',30,'2025-03-12 10:28:37','5b1109eb54330.jpg',2,0,'r0101007','251414_2jNyMplymBBS.jpg/251414_6Cr8x7YVhNOQ.jpg/251414_AxcdQoqBmdoI.jpg/251414_Cs80begQm44Y.jpg/251414_edMPzLA1srQ8.jpeg/251414_jBEcnZeid6zI.jpg/251414_KMyoKPxuMadd.jpg/251414_OJkzToNyrMRB.jpeg/251414_Rg8rzbOKllnW.jpeg/251414_ROkhkEF7bBlg.jpg/251414_UKWa9qjLCeZo.jpg/251414_YGgc3hE2bcEV.jpeg/',0,'#홍대#합정#홀덤테이블#대형#노래방#빔프로젝터','낮 타임 패키지 (12시-17시)예약,밤 타임 패키지 (19시-익일10시),올데이 패키지 (12시-22시),,,','80000,120000,120000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 마포구 서교동 408-29 테라빌딩 6층','서울특별시 마포구 어울마당로 44 (서교동) 테라빌딩 6층',126.920909220554,37.5488424087239,'모든 시설과 비품은 깨끗하게 사용해 주세요. 사용 후 원상복구는 필수입니다.\r\n시설물이나 비품이 파손되었을 경우, 즉시 관리자에게 신고해 주세요. 고의나 중대한 과실로 인한 손상은 배상 책임이 발생할 수 있습니다.\r\n실내에서는 금연이며, 흡연은 지정된 장소에서만 가능합니다.\r\n화기 사용은 엄격히 금지됩니다. (촛불, 폭죽, 불꽃놀이 등)\r\n노래방, 보드게임, 빔프로젝터 등은 사용 후 정리해 주세요.\r\n주방 사용 후에는 조리도구 및 식기류를 깨끗이 세척해 주세요.\r\n퇴실 전 사용한 공간은 깨끗하게 정리정돈해 주세요.\r\n쓰레기는 분리수거하여 지정된 장소에 배출해 주세요.\r\n청소 미흡 시 추가 청소 비용이 발생할 수 있습니다.\r\n밤 10시 이후에는 소음에 주의해 주세요. (야외 바베큐 및 노래방 사용 시 주의)\r\n과도한 소음으로 인한 민원이 발생할 경우, 경고 없이 강제 퇴실될 수 있습니다.\r\n블루투스 마이크는 적정한 음량으로 사용해 주세요.\r\n입실 전 비상구와 소화기 위치를 확인해 주세요.\r\n비상 상황 발생 시 관리자에게 즉시 연락해 주세요.\r\n안전을 위해 어린이와 반려동물은 보호자의 주의가 필요합니다.\r\n반려동물 동반은 사전 문의 필수입니다.\r\n주류 반입은 가능하지만, 과음으로 인한 문제 발생 시 이용이 제한될 수 있습니다.\r\n퇴실 후 남겨진 분실물은 일정 기간 보관 후 폐기됩니다.\r\n음식물은 반드시 냉장고에서 꺼내 정리해 주세요.\r\n','0,0,0,0,3,5,-1,-1,-1','24시간','무휴','6층',1,1,'0,5,8,9,11','0,3,4','0,1,2','0,1,2,3,4,5','01066665555','홍대 중심에 위치한 최대 30명이 넉넉하게 이용가능한 초대형 파티룸 !','https://urbanspot.com','홍대 중심에 위치한 최대 30명이 넉넉하게 이용가능한 초대형 파티룸! 오늘의 파티가 소중한 추억 속 한 컷이 되길 바라는 마음을 담아 구성된 공간. 100인치 빔프로젝터 + U+ 셋탑 고사양 빔프로젝터와 군더더기 없는 시청을 위한 암막커튼설치.','어반스팟','강다현',NULL,'booking7@roomservice.com','2277069671'),(8,'홍대파티룸 오렌지카운티',20000,'홍대 루프탑에서 바베큐를 즐길 수 있는 파티룸\r\n\r\n\r\n\r\n※ 당구대는 현재 파손으로 구비되어있지 않습니다.',30,'2025-03-12 10:36:46','03336652a48a2.jpg',2,0,'r0101008','233529_CHOzkKBjhMlQ.jpg/233529_f7Fl5YDUkeRF.jpg/233529_FS5oFiEB0n7M.jpg/233529_K14fXZqOmE1C.jpg/233529_kImYgOyUIdJg.jpg/233529_qwXQX1kHh7qC.jpg/233529_vgZS2lCIgrGl.jpg/233529_W1AzrmSpW4cA.jpg/233529_wfda1o738zeP.png/233529_wzAZZZqJMudV.jpg/233529_zDsLWBrhc6Xp.jpg/',0,'#홍대#합정#상수역#초대형#루프탑#바베큐','✨낮 패키지(12시~17시),✨밤 패키지(19시~익일10시),✨올데이 패키지(12시~22시),,,','90000,180000,160000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 마포구 서교동 408-26 5층','서울특별시 마포구 어울마당로 46 (서교동) 5층',126.920995781889,37.5490650132805,'시설물은 소중히 사용해 주세요. 시설물이나 비품이 파손되었을 경우 즉시 관리자에게 신고해 주세요. 고의 또는 중대한 과실로 인한 파손은 배상 책임이 발생할 수 있습니다. 퇴실 시에는 사용한 모든 시설물과 공간을 깨끗이 정리해 주시고, 쓰레기는 분리수거하여 지정된 장소에 배출해 주세요. 청소가 미흡할 경우 추가 청소 비용이 발생할 수 있습니다.\r\n\r\n실내에서는 금연이며, 흡연은 지정된 장소에서만 가능합니다. 화기 사용은 엄격히 금지됩니다. 촛불, 폭죽, 불꽃놀이 등은 절대 사용하실 수 없습니다. 주류 반입은 가능하지만 과음으로 인한 문제 발생 시 책임은 이용자에게 있습니다. 실내 및 야외에서 발생하는 소음은 주변 이웃과 다른 고객을 위해 자제해 주세요. 특히 밤 10시 이후에는 소음에 각별히 주의해 주세요. 소음으로 인한 민원이 발생할 경우, 경고 없이 강제 퇴실될 수 있습니다.\r\n\r\n안전을 위해 비상구와 소화기 위치를 사전에 확인해 주세요. 비상상황이 발생하면 즉시 관리자에게 연락해 주세요. 반려동물 동반은 사전 문의 필수이며, 허용되지 않는 경우 반려동물은 입장이 제한됩니다. 주차는 사전 문의 후 이용해 주세요. 주차 공간이 제한되어 있으므로, 사전 예약을 권장합니다.\r\n\r\n퇴실 시 남겨진 분실물은 일정 기간 보관 후 폐기됩니다. 퇴실 전 반드시 소지품을 확인해 주세요. 예약 취소는 최소 3일 전까지 가능하며, 이후 취소 시 보증금은 환불되지 않습니다. 당일 취소나 노쇼(No-show)의 경우 이용 요금과 보증금 모두 환불이 불가합니다.\r\n\r\n문제가 발생하거나 문의 사항이 있을 경우, 즉시 관리자(010-1234-5678)에게 연락해 주세요. 모든 이용자는 이 유의사항을 준수해야 하며, 위반 시 불이익이 발생할 수 있습니다. 쾌적하고 즐거운 이용을 위해 협조 부탁드립니다.','0,3,5,-1,-1,-1,-1,-1,-1','24시간','무휴','5층',1,1,'0,2,3,4,7,8,9,11','1,2,3','0,1,2,3','0,1,2,3,4,5','01011112222','홍대 루프탑에서 바베큐를 즐길 수 있는 파티룸','https://leaflounge.com','홍대 루프탑에서 바베큐를 즐길 수 있는 파티룸. ※ 당구대는 현재 파손으로 구비되어 있지 않습니다.','리프라운지','조윤서',NULL,'host8@xyz.com','8734671192'),(9,'신촌파티룸 5차원공간',15000,'✨ 신촌역 도보 8분이내 ! 편리한 접근성\r\n\r\n주변에는 다양한 편의시설과 맛집이 즐비해있어, 배달맛집 ／ 팝업 등 즐길 수 있는 요소까지 \r\n\r\n\r\n\r\n✨ 넓고 깔끔한 인테리어 \r\n\r\n최대 30명 ( 의자, 테이블 준비완료) 입실 가능\r\n\r\n대학생 MT, 동아리 모임, 생일 파티 등 다양한 모임을 주최할 수 있는 최적의 공간 \r\n\r\n친구들과/지인들과 소중한 시간을 함께 나누기에 충분한 공간 제공\r\n\r\n넓고 쾌적한 환경에서 자유롭게 소통하고 즐길 수 있습니다.\r\n\r\n\r\n\r\n📺 대형스크린 + U+ 셋탑\r\n\r\n100인치 스크린 U+셋탑박스 설치가 되어있어 모든 OTT 구동 가능\r\n\r\n\r\n\r\n🎤 소음걱정 없는 TJ 미디어 노래방 기능\r\n\r\n\r\n\r\n🎮 오락실게임기\r\n\r\n추억의 오락실게임 \'판도라박스\' 설치 총 999개의 게임 가능\r\n\r\n( 파이터 보글보글 등 )\r\n\r\n\r\n\r\n✨취사도구 / 그릇 / 취사시설 완비\r\n\r\n잔 숟가락 젓가락 그릇 취사시설이 모두 구비되어있어서 간단 요리 가능\r\n\r\n( 배달도 가능합니다 )\r\n\r\n\r\n\r\n모임을 위한 다양한 시설과 편의성을 갖춘 저희 파티룸에서 특별한 순간을 만들어보세요. \r\n\r\n예약 및 문의는 언제든지 환영합니다! 여러분의 소중한 모임을 위해 최선을 다하겠습니다..',30,'2025-03-12 10:48:58','08d034735f017.jpg',2,1,'r0101009','253806_CHVjt61dkx76.jpg/253806_EkAO98MFGaNX.jpg/253806_fXkh1YMPDKC3.jpg/253806_hoZeIDJLoRiJ.jpg/253806_lxf0IANyZBZw.jpg/253806_pvVlsS5TzmbQ.jpg/253806_quxIj0D6Ln7H.jpg/253806_SgeLS0k9BcbU.jpg/253806_t2L4wihYSu7k.jpg/253806_VM9OS0Cod6qm.jpg/253806_wyNbUjUcjbPq.jpg/253806_Yyan35fQqnvX.jpg/253806_ZFQu3PhvtLfH.jpg/253806_ziugdYUKo3Gc.jpg/',0,'#신촌#대형#노래방','낮 타임 패키지 (11시-16시)예약,밤 타임 패키지 (19시-익일9시),올데이 패키지 (11시-22시)예약,,,','70000,120000,120000,,,','11:00,19:00,11:00,,,','16:00,09:00,22:00,,,','서울특별시 서대문구 창천동 5-32 지하 1층','서울특별시 서대문구 연세로4길 61 (창천동) 지하 1층',126.939533144555,37.5585661705571,'입·퇴실 시간은 엄수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전에는 모든 시설 정리와 분리수거를 완료해 주세요.\r\n실내는 금연, 촛불, 폭죽 등 화기 사용은 금지입니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 강제 퇴실될 수 있습니다.\r\n반려동물은 사전 문의 필수입니다.\r\n예약 취소는 3일 전까지 가능하며, 이후에는 보증금 환불이 어렵습니다.\r\n위 사항을 준수하여 모두가 즐거운 시간을 보내시길 바랍니다.','0,0,0,0,0,0,-1,-1,-1','24시간','무휴','지하 1층',1,1,'0,5,8,9,11','1,2,3','0,1,2','0,2,3,4,5','01022223333','✨ 신촌역 도보 8분이내 ! 편리한 접근성','https://harmonyspace.com','✨ 신촌역 도보 8분이내 ! 편리한 접근성. 주변에는 다양한 편의시설과 맛집이 즐비해있어, 배달맛집, 팝업 등 즐길 수 있는 요소까지. 넓고 깔끔한 인테리어 최대 30명 입실 가능. 대학생 MT, 동아리 모임, 생일 파티 등 다양한 모임 가능.','하모니스페이스','배지훈',NULL,'info9@abc.net','6842147257'),(10,'홍대파티룸 브러쉬',15000,'20명이 넉넉하게 이용가능한 대형파티룸\r\n\r\n30여개의 보드게임 / 콘솔게임 / 전국파티룸 중 가장 고사양 빔 완비\r\n\r\n\r\n\r\n홍대거리 중심지에 위치한 우수한 접근성 홍대대형파티룸 브러쉬\r\n\r\n각종 파티, 원데이 클래스, 가족 및 동호회 모임, 온콘단관, 아이돌영상시청 ,스포츠 응원 등 다양한 활동이 가능합니다.\r\n\r\n\r\n\r\n[브러쉬파티룸 안내]\r\n\r\n\r\n\r\n- 최대 20명 (30평) / 모임 구성이 편리한 테이블\r\n\r\n4인용 테이블 3개 6인용 테이블 1개가 구비되어 있어 모임 유형에 맞춰서 손쉽게 변형 가능 ( 문토 등 소셜링에도 용이)\r\n\r\n\r\n\r\n- 4K 빔/ 입체음향 스피커, 우퍼\r\n\r\n홈시어터빔으로 일반 빔프로젝터가 따라 올 수 없는 최고의 4K 해상도 영상 감상\r\n\r\n삼성 11.1.4채널 스피커 탑재로 공간이 울리는 소리 체험\r\n\r\n최애가 눈 앞에서 살아 움직이는 온콘을 느껴보세요\r\n\r\n\r\n\r\n- 대형스크린 + U+ 셋탑\r\n\r\n100인치 스크린 U+셋탑박스 설치가 되어있어 모든 OTT 구동 가능\r\n\r\n\r\n\r\n- 20명이 이용해도 문제없는 초대형 바베큐 그릴\r\n\r\n 홍대 야경이 한눈에 들어오는 6층에서 즐기는 바베큐 (우천시 이용 불가)\r\n\r\n\r\n\r\n- 소음걱정 없는 TJ 미디어 노래방 기능\r\n\r\n\r\n\r\n- 오락실게임기\r\n\r\n추억의 오락실게임 \'판도라박스\' 설치 총 999개의 게임 가능\r\n\r\n( 파이터 보글보글 등 )\r\n\r\n\r\n\r\n- 20여종의 최신인기 보드게임\r\n\r\n루미큐브, 로스트시티, 할리갈리,바퀴벌레포커, 스페이스 크루, 뱅, 달무티, 텔레스트레이션, 커피러시, 사보타지, 해적왕, 젠가, 펭귄게임, 아발론, 방탈출 등\r\n\r\n (보드게임 목록은 유동적으로, 기재된 내용과 일부 차이가 있을 수 있습니다. 이용 전 반드시 문의 부탁드립니다 )\r\n\r\n\r\n\r\n- 인생샷 남길 수 있는 포토존 완비\r\n\r\n고급진 BAR 느낌에 화려한 조명으로 인생샷도 단체사진도 가능\r\n\r\n\r\n\r\n- 식기류, 컵, 와인잔, 소주잔, 냄비, 프라이팬, 조리도구 등 인원수에 맞춰서 모두 준비 완료\r\n\r\n\r\n\r\n-냉장고, 싱크대, 이동식 1구 인덕션, 전자레인지, 냉난방기, 실내화장실\r\n\r\n',20,'2025-03-12 10:55:43','ce332999cd4b1.jpg',2,0,'r0101010','253405_1qbpVJWcRHhk.jpg/253405_2MwU640Aipdm.jpg/253405_BIcOojUt4ssl.jpg/253405_fHLes1izS188.jpg/253405_frkOQMbhfqeu.jpg/253405_J8b4ewkKfITM.jpg/253405_LY4v9rb6oB8m.jpg/253405_mkBWqVoMJm4R.jpg/253405_najmWcqhfkwm.jpg/253405_Or5vuRYmcemE.jpg/253405_rxp5SXq2cWv1.jpg/253405_voeMKBtaa6yc.jpg/253405_yZZSwGxcIzfW.jpg/',0,'#홍대#빔프로젝터#테라스#바베큐#노래방','낮 타임 패키지 (12시-17시),밤 타임 패키지 (19시-익일10시),올데이 패키지 (12시-22시),,,','70000,120000,120000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 마포구 서교동 369-7 6층 홍대 브러쉬 루프탑바베큐','서울특별시 마포구 잔다리로6길 35 (서교동) 6층 홍대 브러쉬 루프탑바베큐',126.921128683536,37.5524565492281,'입·퇴실 시간은 엄수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설 및 비품은 파손 없이 사용해 주세요. 손상 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연, 화기(촛불, 폭죽 등) 사용은 금지입니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 취소는 3일 전까지 가능하며, 이후에는 보증금이 환불되지 않습니다.\r\n유의사항을 준수하여 안전하고 즐거운 시간을 보내시기 바랍니다.','0,0,0,0,0,0,-1,-1,-1','24시간','공휴일','6층',1,1,'0,2,3,4,7,8,9,11','1,2,3,5','0,1,2,4','0,1,2,3','01099994444','20명이 넉넉하게 이용가능한 대형파티룸','https://inspireroom.com','20명이 넉넉하게 이용가능한 대형파티룸. 30여개의 보드게임 / 콘솔게임 / 전국파티룸 중 가장 고사양 빔 완비. 홍대거리 중심지에 위치한 우수한 접근성.','인스파이어룸','윤하늘',NULL,'contact10@provider.org','8006723018'),(11,'신촌파티룸 신촌서강',16000,'1. 편리한 접근성 \r\n\r\n신촌역 3분거리 단독 층 이용 소음에서 FREE!!(새벽에도 ok) \r\n\r\n\r\n\r\n2. 생생한 노래방 \r\n\r\n노래방 사운드(마이크 소리) 제공 4채널 스피커/ 80만원 대 카날스 무선마이크 \r\n\r\n\r\n\r\n3. 풀 시설\r\n\r\n- 110인치 빔프로젝터(노트북) \r\n\r\n- 75인치TV(노래방, 데스크탑PC) \r\n\r\n- 65인치 게임 \r\n\r\n- TV(닌텐도wii 4인, 오락실게임) \r\n\r\n- 블루투스 스피커(마샬 스탠모어2) \r\n\r\n- 공기청정기 3대 \r\n\r\n\r\n\r\n4. 보드게임 파티장도 감탄하는 보드게임 리스트\r\n\r\n70여가지 보드게임 \r\n\r\n비치 없는 게임 사전 요청 시 구매하여 이용 당일까지 비치해드립니다 ( 이용 3일전까지 고지 필요) \r\n\r\n\r\n\r\n5. 장시간 이용 고객님들도 편~하게 \r\n\r\n놀다 지치면 바닥에 누워도 좋아(청결상태 GOOD!!) \r\n\r\n신발 벗고 출입(빈백 7개 비치, 호텔 슬리퍼 제공) \r\n\r\n\r\n\r\n6. 최대 20명 넓고 쾌적한 장소로 각종 모임에 최적화 \r\n\r\n\r\n\r\n7. 365 연중무휴 응대\r\n\r\n쏘플파티룸은 100개 지점을 운영하고있는 프랜차이즈로\r\n\r\n고객센터가 있어 실시간으로 응대가 가능합니다',20,'2025-03-12 11:04:37','89f2f93909207.jpg',2,0,'r0101011','243522_0gr5OAhArNmT.jpg/243522_0HJtvF3gZlC8.jpg/243522_aSLUurHCNvqk.jpg/243522_bpWexWNdhuGd.jpg/243522_Brw0ZVBkA9zZ.jpg/243522_dCHdG87Uwp7o.jpg/243522_Ea5XrP7Iy541.jpg/243522_ECNGqkqQ7d1S.jpg/243522_k8qu8ucakWRH.jpg/243522_qmAhzX3oPMdf.jpg/243522_Tpa7a9h5kozi.jpg/243522_u8ZNzSypVqMn.jpg/243522_X2ybvThkjBVG.jpg/',0,'#신촌#신촌역#서강역#노래방#빔프로젝터','데이 타임 패키지 (12시-17시),나이트 타임 패키지 (19시-익일10시),올데이 패키지 (12시-22시),,,','70000,120000,100000,,,','12:00,09:00,12:00,,,','17:00,10:00,22:00,,,',' 서울특별시 마포구 노고산동 31-75 지층 , 신촌서강 파티룸','서울특별시 마포구 고산길 15 (노고산동) 지층 , 신촌서강 파티룸',126.93797202098,37.5535849173409,'입·퇴실 시간은 반드시 준수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물과 비품은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연이며, 화기 사용(촛불, 폭죽 등)은 금지입니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 취소는 이용 전날까지 가능하며, 이후에는 보증금 환불이 어렵습니다.\r\n위 사항을 준수하여 모두가 즐거운 시간을 보내시기 바랍니다.','0,0,0,0,0,0,0,0,-1','24시간','무휴','1층',1,1,'0,5,8,9,11','1,2,3,4,5','0,1,2,5,6','0,1,2,3,4,5','01012344323','신촌역 3분거리 단독 층 이용 소음에서 FREE!!(새벽에도 ok) ','https://creativeden.com','신촌역 3분거리 단독 층 이용 소음에서 FREE!!(새벽에도 ok) 생생한 노래방 사운드 제공 4채널 스피커/ 80만원 대 카날스 무선마이크 풀 시설: 110인치 빔프로젝터, 75인치TV, 65인치 게임 TV, 닌텐도, 오락실게임.','크리에이티브덴','송도현',NULL,'service11@web.com','9507173625'),(12,'홍대파티룸 보타닉가든',19000,'홍대입구 도보 4분거리에 위치한 35평 규모의 초대형 프라이빗 루프탑 파티룸!\r\n\r\n\r\n\r\n프라이빗 단독공간 감성 캠핑 홍대파티룸\r\n\r\n홍대파티룸 보타닉가든에서만 즐길 수 있는 장점\r\n\r\n\r\n\r\n- 25평의 감성 옥탑에서 즐기는 바베큐\r\n\r\n홍대 야경을 바라보며 즐길 수 있는 초대형 바베큐 그릴과 테이블!\r\n\r\n가족단위, 동아리 MT, 계모임, 회사 워크샵 등 다양한 단체 모임을 즐기실 수 있습니다.\r\n\r\n12인용 대형 아메리칸 그릴 ( 훈제연기, 숯바베큐 이중방식 구이용)\r\n\r\n\r\n\r\n- 감성 캠핑 휴식 존\r\n\r\n피크닉 세트 포토존과 바베큐하면서 휴식도 가능한 감성가득한 공간 , 따가운 햇살에도 든든한 5M 초대형 어닝\r\n\r\n\r\n\r\n- 애견 동반 가능한 파티룸\r\n\r\n아이들과 함께 즐기는 바베큐장\r\n\r\n( 이용을 원하시는 경우 카톡 문의 )\r\n\r\n\r\n\r\n- 65인치 대형 UHD TV + U+ 셋탑\r\n\r\n대형 TV와 U+셋탑박스 설치가 되어있어 모든 OTT 구동 가능\r\n\r\n\r\n\r\n- 소음걱정 없는 TJ 미디어 노래방 기능\r\n\r\n노래방 반주에서 무선 블루투스 마이크로 만들어 내는 운치의 끝\r\n\r\n\r\n\r\n- 20여종의 최신인기 보드게임\r\n\r\n루미큐브, 로스트시티, 할리갈리, 바퀴벌레포커, 스페이스 크루, 뱅, 달무티, 텔레스트레이션, 커피러시, 사보타지, 시타델, 화투 ,술자리퀴즈왕, 클루, 젠가 ,젬블로 ( 보드게임 목록은 유동적으로, 기재된 내용과 일부 차이가 있을 수 있습니다. 이용 전 반드시 문의 부탁드립니다 )\r\n\r\n\r\n\r\n- 미니 다트판\r\n\r\n설거지 내기, 간단한 아이스크림 내기에 적합한 다트판\r\n\r\n\r\n\r\n- 간단히 몸만 오세요 : - )\r\n\r\n식기류, 컵, 와인잔, 소주잔, 냄비, 프라이팬, 조리도구 등 인원수에 맞춰서 모두 준비 완료\r\n\r\n\r\n\r\n보타닉가든에 계신 동안\r\n\r\n세상 제일 행복한 시간 되시길 바랍니다.\r\n\r\n',10,'2025-03-12 11:11:59','6dc715aad2f9d.jpg',2,0,'r0101012','245405_3Pe4zsuovxLn.jpg/245405_5LaFfL6sPuvM.jpg/245405_Bcm21PHWXqap.jpg/245405_be8Rn9hEmdoL.jpg/245405_c3IVruZKtWMQ.jpg/245405_EYY2HXnDFwbX.jpg/245405_fzrKNZBkZcA9.jpg/245405_P3qjuBPCgzb2.jpg/245405_PEU5TZedUpa5.jpg/245405_sHB9YLszgXes.jpg/245405_t3ILnYclncd0.jpg/245405_tCuZhnC2xFCQ.jpg/245405_UW5bjD2xYbVR.jpg/245405_VJNu0KLflCeV.jpg/245405_wOZ9PPEc8jIh.jpg/245405_xE0uclel9uIl.jpg/245405_xhVdfxAVAnVx.jpg/245405_ycs2Q0Rqcp8Y.jpg/245405_YfqiqFcboS7N.jpg/',0,'#홍대#홍대입구역#루프탑#노래방#바베큐','낮 타임 패키지 (12시-17시),밤 타임 패키지 (19시-익일10시),올데이 패키지 (12시-22시)예약,,,','80000,130000,120000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,',' 서울특별시 서대문구 창천동 510-8 YK tree 빌딩 4층 보타닉가든 파티룸','서울특별시 서대문구 신촌로 7 (창천동) 4층 보타닉가든 파티룸',126.927829578848,37.5586172605481,'입·퇴실 시간은 반드시 준수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물과 비품은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연이며, 화기 사용(촛불, 폭죽 등)은 금지입니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 취소는 5일 전까지 가능하며, 이후에는 환불이 어렵습니다.\r\n유의사항을 준수하여 즐겁고 안전한 시간을 보내시기 바랍니다.','0,0,0,0,-1,-1,-1,-1,-1','24시간','무휴','4층',1,1,'0,2,3,4,7,8,9,11','2,3,5','0,1,2','0,1,2,3,4,5','01010102020','홍대입구 도보 4분거리에 위치한 35평 규모의 초대형 프라이빗 루프탑 파티룸!','https://brickhouse.com','홍대입구 도보 4분거리에 위치한 35평 규모의 초대형 프라이빗 루프탑 파티룸. 프라이빗 단독공간 감성 캠핑 홍대파티룸. 25평의 감성 옥탑에서 즐기는 바베큐.','브릭하우스','이지우',NULL,'info12@randommail.com','3515699378'),(13,'홍대파티룸 마티니블루',15000,'홍대 테라스가 갖춰진 프라이빗하고 깔끔한 파티룸\r\n\r\n낮,밤 바베큐 이용 가능하며 고품격 우리만의 공간인 파티룸입니다.',8,'2025-03-12 11:18:12','84cda31eec1f3.jpeg',2,0,'r0101013','254926_1S3EJU5OdpKp.jpeg/254926_4D8z67GEDmD4.jpg/254926_5HOcaRywa9dG.jpg/254926_7nTXlbdyNqUQ.jpg/254926_7tN0BV8ZCD9g.jpg/254926_8ekrbPK2fC7R.jpg/254926_A60JIAILK7iJ.jpg/254926_cKb73mQ7zCbF.jpg/254926_gITlpRwH6Iau.jpeg/254926_HOdl5N6lfU7R.jpg/254926_IhXvJ9haaXrt.jpg/254926_iUmvbgFgnbZO.jpg/254926_jbmgolh2w2fs.jpg/254926_mBJ7ExaZdmMw.jpg/254926_rjogCfKwOH3s.jpeg/254926_tv77Ol1Byiha.jpeg/254926_WG0OK9NxsYG3.jpg/254926_wYRDAZYMYHKx.jpg/',0,'#홍대#상수역#바베큐#노래방#테라스','✨낮 패키지(12시~17시),✨밤 패키지 (19시~익일10시),✨올데이 패키지(12시~22시),,,','70000,100000,100000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 마포구 상수동 330-8 삼삼공빌딩 4층 , 홍대파티룸 마티니블루','서울특별시 마포구 독막로 92-15 (상수동) 4층 , 홍대파티룸 마티니블루',126.923225401624,37.5470118468825,'입·퇴실 시간은 반드시 준수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물과 비품은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연이며, 화기 사용(촛불, 폭죽 등)은 금지입니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 취소는 3일 전까지 가능하며, 이후에는 환불이 어렵습니다.\r\n유의사항을 준수하여 즐겁고 안전한 시간을 보내시기 바랍니다.\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n','0,0,0,0,0,0,-1,-1,-1','24시간','무휴','4층',0,1,'0,2,3,4,8,9,11','1,2,3,4,5','0,1,2','0,1,3,4,5','01076761234','홍대 테라스가 갖춰진 프라이빗하고 깔끔한 파티룸','https://midnightlounge.com','홍대 테라스가 갖춰진 프라이빗하고 깔끔한 파티룸. 낮,밤 바베큐 이용 가능하며 고품격 우리만의 공간인 파티룸입니다.','미드나잇라운지','권하영',NULL,'support13@mail.com','9056976324'),(14,'잠실파티룸 펜트하우스',19000,'잠실새내역 +신천 먹자골목 인접한 프라이빗 펜트하우스 파티룸\r\n(오늘의 파티가 소중한 추억 속 한 컷이 되길 바라는 마음을 가득 담아 공간 구성)\r\n\r\n※ 도심 한복판에서 즐기는 바베큐\r\n6인용 바베큐 그릴\r\n\r\n※ 주변 다양한 먹거리\r\n신천 먹자골목에 바로 인접하여 식사부터 디저트까지 포장 및 배달 OK!\r\n\r\n※ 단독 화장실\r\n\r\n※ 65인치 대형 TV +KT 인터넷\r\nkt 셋탑박스 설치가 되어있어 모든 OTT 구동 가능\r\n\r\n※ 소음걱정 없는 TJ 미디어 노래방 기능\r\n블루투스 마이크와 미러볼로 분위기 UP!\r\n\r\n※ 모임 구성이 편안한 테이블\r\n6인용 테이블 2개, 2인용 테이블 비치 되어 있어 모임 유형에 맞춰서 손쉽게 변형 가능\r\n\r\n※ 최신인기 보드게임\r\n루미큐브, 할리갈리, 탑탑젠가, 해적통아저씨, 다빈치코드, 화투, 카지노칩\r\n( 보드게임 목록은 기재된 내용과 일부 차이가 있을 수 있습니다. 이용 전 반드시 문의 부탁드립니다 )\r\n\r\n\r\n- 미성년자 이용 불가 ( 동의서 제출해주셔도 19세 미만은 이용 불가합니다 ) ',16,'2025-03-12 11:35:01','f238d830a8097.jpg',2,0,'r0102001','240028_d0lWIEx21h5T.jpg/240028_FDVcfCW5ucgx.jpg/240028_gp6RRIvaZkiL.jpg/240028_iDCpE8J3O9Sc.jpg/240028_khd7XzBizqQV.jpg/240028_MoF9Ua1EKRkn.jpg/240028_ql2z73lSWTDu.jpeg/240028_rwsxPGvesMIL.jpg/240028_wVXBByEydmRI.jpg/240028_ybakTV3qSom3.jpeg/240028_zdA6Ga5LKrXC.jpg/240028_zupBFc2IGM7K.jpg/',0,'#잠실#잠실새내역#대형#노래방#바베큐','낮 타임 패키지 (12시-17시),밤 타임 패키지 (18시-익일9시),올데이 패키지 (12시-22시),,,','80000,130000,110000,,,','12:00,18:00,12:00,,,','17:00,09:00,22:00,,,','서울특별시 송파구 잠실동 186-1','서울특별시 송파구 백제고분로7길 42-13 (잠실동)',127.083918823055,37.5102039576636,'입·퇴실 시간은 반드시 준수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물과 비품은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연이며, 화기 사용(촛불, 폭죽 등)은 금지입니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 취소는 이용일 기준 2일 전까지 가능하며, 이후에는 환불이 어렵습니다.\r\n유의사항을 준수하여 즐겁고 안전한 시간을 보내시기 바랍니다.','0,0,0,0,0,0,0,-1,-1','24시간','무휴','4층',1,1,'0,2,3,5,7,8,9,11','1,2,3,4','0,1,2','0,1,2,3,4,5','01044443333','잠실새내역 +신천 먹자골목 인접한 프라이빗 펜트하우스 파티룸','https://shinespace.com','잠실새내역 +신천 먹자골목 인접한 프라이빗 펜트하우스 파티룸. 도심 한복판에서 즐기는 바베큐, 단독 화장실, 65인치 대형 TV +KT 인터넷, 소음걱정 없는 TJ 미디어 노래방 기능.','샤인스페이스','서준호',NULL,'admin14@xyz.net','4737783795'),(15,'건대파티룸 퍼플피플',20000,'[건대에서 가장 다양한 놀이기구 완비]\r\n\r\n다트기계 탁구대 각종OTT 전자식다트 초대형빔프로젝터 각종보드게임\r\n\r\n[ 퍼플피플만의 장점 ]\r\n1. 주차1대 가능 (주차 상황보고 2대 추가가능)\r\n2. 50명 까지 이용 가능한 단체공간\r\n3. 청정기.소독기.정수기.가습기.온풍기\r\n4. 피아노 있는 파티룸\r\n5. 탁구대있는 파티룸\r\n6. 커다란 칠판있는 파티룸 세미나이용\r\n7. 노트북있는 파티룸\r\n8. 초대형 빔프로젝터있는 파티룸\r\n9. 신나는 노래방있는 파티룸\r\n10. 가장 다양한 보드게임보유',50,'2025-03-12 11:52:41','b1235d2b49902.jpg',2,0,'r0102002','231318_0P5Koirya13M.jpg/231318_2UylcjaUaoDE.jpg/231318_88SBayeYsUBU.jpg/231318_Bp1EGgrEitUy.jpg/231318_ejAV88ZFYfhH.jpg/231318_ghjg5wNgahyd.jpg/231318_gHqHPHbEPkB3.jpg/231318_IBL9PQM4g2js.jpg/231318_LkALbHiMGDaI.jpg/231318_NtsagUcKKdxc.jpg/231318_ocZUqWknLpHZ.jpg/231318_Pn2rWuN83c9S.jpg/231318_UARAl39OJr25.jpg/231318_UlkKWVcVaOxp.jpg/231318_v5A9qDnNWs06.jpg/231318_xUV2WjA4qLkp.jpg/231318_Xzzf4sf2Q0wB.jpg/231318_YFdDF0HfKhcZ.jpg/231318_yIQZ4roAteu2.jpg/',0,'#건대#어린이대공원역#탁구대·다트·홀덤#초대형#MT,모임','낮 타임 패키지 (12시-17시),밤 타임 패키지(19시-익일10시),올데이 패키지 (12시-22시),,,','800000,110000,120000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,',' 서울특별시 광진구 자양동 610-4 지하 1층','서울특별시 광진구 자양번영로 48 (자양동) 지하 1층',127.076112278136,37.5337740666526,'입·퇴실 시간은 반드시 준수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물과 비품은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연이며, 화기 사용(촛불, 폭죽 등)은 금지입니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 환불은 이용일 기준 5일 전까지 가능하며, 이후에는 환불이 어렵습니다.\r\n유의사항을 준수하여 즐겁고 안전한 시간을 보내시기 바랍니다.','0,0,0,0,5,-1,-1,-1,-1','24시간','무휴','지하 1층',1,1,'0,1,5,8,9,11','0,1,3,4,5','0,1,2,3','0,1,2,4,5,7','01055552222','건대에서 가장 다양한 놀이기구 완비','https://hiddenroom.com','[건대에서 가장 다양한 놀이기구 완비] 다트기계, 탁구대, 각종OTT, 전자식다트, 초대형빔프로젝터, 각종보드게임. 퍼플피플만의 장점: 주차 가능, 50명 까지 이용 가능한 단체공간.','히든룸','한지민',NULL,'booking15@host.com','6517990312'),(16,'쏘플파티룸 건대 캐치볼',17000,'화려한 분위기의 조명 파티 및 각종 모임 최적화 공간!\r\n최대 30명까지 입실 가능한 건대입구 초대형 파티룸\r\n\r\n어린이대공원역에서 도보 5분거리 !\r\n\r\n- 힙한 무드의 포토존\r\n- 대형 빔프로젝터와 TV까지 모두 완비\r\n- 바 테이블에서 라운지처럼 즐기는 파티\r\n- 방음부스 설치로 소음 걱정 NO!\r\n- 노래방 기능 완비\r\n- 탁구대\r\n- 화양제일골목시장에서 도보 7분거리 (맛있는 먹거리 포장해서 이용 가능)\r\n- 대형 상업용 냉장고 및 얼음 무료제공 (정수기 O)\r\n- 각종 보드게임 완비',30,'2025-03-12 12:04:41','32f10fe9069a1.jpeg',2,0,'r0102003','230626_0xNosTKyWh8j.jpg/230626_1ygz8rolhE2D.jpg/230626_19JDgzkvKcQ2.jpeg/230626_a9Ng9ETOP7eN.jpeg/230626_cmEn1KdKmxG8.jpeg/230626_fQ9vvTAUKCqI.jpeg/230626_LdsmNZw6BXOR.jpeg/230626_mdWHLngsIIuL.jpeg/230626_p1A5MfNFY49n.jpeg/230626_s0kQ9lP6HDxN.jpeg/230626_tP1LVWGUst3g.jpeg/230626_VGVvo8SNXdTk.jpeg/',0,'#건대#어린이대공원역#초대형#노래방#MT,모임','낮 타임 패키지 (12시-17시),밤 타임 패키지 (19시-익일10시),올데이 패키지 (12시-22시),,,','70000,130000,120000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 광진구 화양동 18-26 지하1층','서울특별시 광진구 동일로30길 51 (화양동) 지하1층',127.070224936167,37.5475712993219,'입·퇴실 시간을 꼭 지켜주세요. 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물 사용 시 주의해 주세요. 파손 시에는 배상 책임이 발생합니다.\r\n사용한 공간은 퇴실 전 정리정돈과 쓰레기 분리수거를 부탁드립니다.\r\n실내에서는 금연이며, 폭죽이나 촛불 등 화기 사용은 금지됩니다.\r\n밤 10시 이후에는 소음을 최소화해 주세요. 민원 발생 시 불이익이 있을 수 있습니다.\r\n예약 취소 시 5일 전까지 100% 환불, 4일 전 70%, 2일 전 30% 환불, 당일은 환불이 불가합니다.','0,0,0,0,3,3,7,7,-1','24시간','공휴일','지하1층',0,0,'0,4,7,8,9','0,1,2,3,4','0,1,2,3','0,1,2,4,5,7','01098765432','어린이대공원역에서 도보 5분거리 !','https://soulstudio.com','화려한 분위기의 조명 파티룸, 최대 30명 입실 가능, 다양한 포토존과 노래방, 각종 게임 완비','소울스튜디오','오태경',NULL,'user16@random.net','8376600480'),(17,'건대파티룸 플레이션',20000,'🚗초고사양 pc 6대 완비\r\n\r\nGPU : RTX4060 / CPU : 라이젠 5600 / 32인치 게이밍 모니터/ 게이밍 키보드 마우스 / 사운드바 게임 \r\n\r\n이용 편리하고 속도도 보장합니다.\r\n\r\n\r\n\r\n🎮 오락실게임기\r\n\r\n추억의 오락실게임 \'판도라박스\' 설치 총 999개의 게임 가능\r\n\r\n( 파이터 보글보글 등 )\r\n\r\n\r\n\r\n✨ 그릇 / 컵 완비\r\n\r\n잔 숟가락 젓가락 그릇 등 모두 구비되어 있어서 식사 가능 \r\n\r\n( 배달도 가능합니다 )',8,'2025-03-12 12:09:47','6d1fcf4b01a03.jpg',1,0,'r0102004','253310_B9ZYdcM1a5Yf.jpg/253310_HTWFJuw9M5Nx.jpg/253310_Ijqi048ouTAV.jpg/253310_PGUv7LGN13g0.jpg/253310_pRb1tYQlMVIg.jpg/253310_refLHZGoaHEY.jpg/253310_UC2LBfTW63fx.jpg/',0,'#건대입구역#PC6대#오락기',',,,,,',',,,,,',',,,,,',',,,,,','서울특별시 광진구 화양동 10-1 한아름건물','서울특별시 광진구 능동로13길 39 (화양동)',127.069757721395,37.543959020957,'입·퇴실 시간은 반드시 준수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물과 비품은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연이며, 화기 사용(촛불, 폭죽 등)은 금지됩니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 취소는 이용일 기준 4일 전까지 100% 환불, 2일 전 50%, 1일 전 10% 환불되며, 당일 취소는 환불이 불가합니다.\r\n유의사항을 준수하여 즐겁고 안전한 시간을 보내시기 바랍니다.','0,0,0,0,0,3,5,9,-1','24시간','무휴','1층',0,0,'0,5,8,9','3','0,4','0,2,3,4,5','01055551111','🚗초고사양 pc 6대 완비 파티룸!','https://mirrorroom.com','초고사양 PC 6대 완비, 추억의 오락실게임, 그릇과 컵 완비, 배달도 가능한 시설','미러룸','문지호',NULL,'contact17@domain.com','2329031771'),(18,'강동구파티룸 사막여우',16000,'길동역 5분 거리\r\n\r\n따뜻한 베이지 톤의 사막여우 파티룸\r\n\r\nTJ노래서비스 무료 이용 가능\r\n(소음걱정 XXX)\r\n\r\n실내 조리 가능하며 취사도구, 식기, 잔 등\r\n모두 구비\r\n\r\n매트리스와 담요 및 쇼파가 구비되어 있어\r\n잠시 휴식에도 좋은 공간!\r\n\r\n예쁜 사막여우 파티룸 포토존에서 인생사진을 건져보세요!\r\n\r\n1층에 바로 카페가 있어 음료 및 베이커리도 쉽게 구매 가능합니다.',15,'2025-03-12 12:16:34','28cb5c9b6f024.jpg',2,0,'r0102005','231619_9tqe8CKlp2El.jpg/231619_Ax78kfYgGul8.jpg/231619_EfkKRUOBwaUe.jpg/231619_FaCUrnyRD16X.jpg/231619_hpjQAGxBBn9g.jpg/231619_k7t7oZWcIFJT.jpg/231619_Laaz8ufgMVQZ.jpg/231619_Ldxrpe8WgHda.jpg/231619_lhOx1yy7e1CV.jpg/231619_LpWMgoB1YN6A.jpg/231619_m9oR64ndCO4D.jpg/231619_mlfESojGAaTA.jpg/231619_N39m3HeW8XWV.jpg/231619_oX7D8Hr3XtiQ.jpg/231619_t9xhSeLqqyOn.jpg/231619_xrNTgYbF0LoL.jpg/231619_ZKG8wwhMTnAy.jpg/',0,'#강동구#길동역#대형#노래방#생일파티','✨낮 패키지(12시~17시),✨밤 패키지(19시~익일10시),✨올데이 패키지(12시~22시),,,','70000,110000,110000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 강동구 길동 359-15 지하 1층 사막여우 파티룸','서울특별시 강동구 천중로50길 39 (길동) 지하 1층 사막여우 파티룸',127.142527579785,37.5390010954862,'입·퇴실 시간은 반드시 준수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물과 비품은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연이며, 화기 사용(촛불, 폭죽 등)은 금지됩니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 취소는 이용일 기준 4일 전까지 100% 환불, 3일 전 70%, 1일 전 30% 환불되며, 당일 취소는 환불이 불가합니다.\r\n유의사항을 준수하여 즐겁고 안전한 시간을 보내시기 바랍니다.','0,0,0,0,0,3,3,7,-1','24시간','무휴','지하1층',1,1,'0,1,5,6,8,9,11','1,2,3,4','0,1,2','0,1,2,3,4,5','01043214321','길동역 5분 거리 파티룸!','https://beyondspace.com','길동역 5분 거리, 따뜻한 베이지톤 인테리어, 노래방 서비스 제공, 실내 조리 가능','비욘드스페이스','신혜진',NULL,'info18@booking.net','6515357723'),(19,'잠실파티룸 셀렉트',15000,'최대 40명! 송파에서 유일한 대규모 파티룸!\r\n브라이덜 샤워, 동아리 등 각종 모임, 행사, 강의, 워크숍까지 \'소규모부터 대규모 인원\' 모두 수용가능한 송파구 단 하나의 선택 \'쏘플 파티룸 잠실 셀렉트\'\r\n\r\n🚗 더블 역세권(송파역/가락시장역) 도보 10분 거리\r\n요거트월드 옆 에스앤디 빌딩입니다.\r\n\r\n🎶 모든 곳이 포토존인 한 번에 즐기는 각양각색의 3가지 테마룸\r\nㅇ게임룸 : 다양한 각종 보드게임, 실내에서 즐기는 당구, 다트게임이 있는 힙하게 꾸며진 방\r\nㅇ감성룸 : 색상이 바뀌는 하와이안 선셋 무드등과 함께 아늑한 분위기에서 따뜻하게 쉴 수 있는 공간\r\nㅇ아지트룸 : 크고 푹신한 쇼파와 테이블이 있어 거실과 또 다른 느낌으로 더 편하게 놀 수 있는 넓은 방\r\n\r\n🎤 쏘플의 필수조건! 노래방기능 \r\n\r\n노래방 이용 가능한 65인치 대형TV와 4개의 대형 테이블이 있어 어떤 모임도 이용 가능한 넓은 거실\r\n\r\n\r\n🍗 바베큐 이용 가능한 테라스\r\n\r\n\r\n🎁 가볍게 몸만 오세요\r\n\r\n취사시설(인덕션, 팬, 냄비, 전자레인지, 전기포트 등)이 구비되어 있고 인원수대로 사용 가능한 모든 식기, 다양한 종류의 잔들이 있는 넓은 주방\r\n\r\n[전체시설 안내]\r\n- 65인치 TV, TJ노래서비스, 마이크, 미러볼, 노트북 연결 가능한 HDMI 선, 모든 OTT 이용 가능\r\n- 샤워기도 있는 깨끗한 실내 화장실\r\n- 담요, 매트리스 구비\r\n- 파티/인스타용 티아라왕관, 생일 머리띠, 꼬깔 등\r\n- 드라이기, 삼각대, 머리끈, 손소독제\r\n- 인스타 인생샷 가능한 거울 포토존\r\n- 보드게임\r\n(루미큐브, 할리갈리익스트림, 할리갈리딜럭스, 해적통아저씨, 포커, 젠가, 모두의마블, 펭귄파티, 캡틴블랙잭, 덤블링몽키, 스트림스, 픽셔너리, 뱅, 달무티, 블리츠, 사보타지, 딕싯, 입체4목, 피노키오)',40,'2025-03-12 12:24:34','199fec2708a7d.jpg',2,0,'r0102006','232226_1FNFEjrn2mbh.jpg/232226_5XFqx7RxKGFr.jpg/232226_9K7SWtdG2FSa.jpg/232226_B3fWt4rAw5Xn.jpg/232226_gEiqm5hZRwQc.jpg/232226_hOslkADpSfbl.jpg/232226_I8ShEJP5k4W9.jpg/232226_ibBPNHfIwSOb.jpg/232226_nSCRhAaET2ut.jpg/232226_wEsuclNmRZyK.jpg/232226_WzLrlbgvhuLv.jpg/232226_ybbemC0IecCy.jpg/',30,'#잠실#석촌역#바베큐#초대형','평일 런치 타임 11~16,평일 디너타임 19~익일02,평일올나잇 타임23:50~익일10,평일 풀 하우스 19시 ~ 익일10시,주말 런치 타임 11~16,주말 풀하우스 19시 ~ 익일10시','50000,80000,60000,140000,80000,160000','11:00,19:00,23:50,19:00,11:00,19:00','16:00,02:00,10:00,10:00,16:00,10:00','서울특별시 송파구 가락동 70-12 에스앤디빌딩','서울특별시 송파구 양재대로62길 13 (가락동)',127.118605929466,37.4985267500899,'입·퇴실 시간은 반드시 준수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물과 비품은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연이며, 화기 사용(촛불, 폭죽 등)은 금지됩니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 취소는 이용일 기준 3일 전까지 100% 환불, 2일 전 50%, 당일 취소는 환불이 불가합니다.\r\n유의사항을 준수하여 즐겁고 안전한 시간을 보내시기 바랍니다.','0,0,0,0,0,0,5,5,-1','24시간','무휴','5층',1,1,'2,3,4,6,9,11','1,2,3','0,1,2,4','0,1,2,3,4,5','01055558888','최대 40명! 송파에서 유일한 대규모 파티룸!','https://flowroom.com','송파에서 유일한 대규모 파티룸, 다양한 테마룸과 노래방 기능, 바베큐 가능한 테라스 제공','플로우룸','유나경',NULL,'support19@service.com','5589693612'),(20,'사당파티룸 올인원게임',23000,'[서울에서 가장 많은 PC 보유]\r\n\r\n- 고성능 PC 10대\r\nGPU : RTX4060 / CPU : 라이젠 5600 / 32인치 게이밍 모니터/ 게이밍 키보드 마우스 / 사운드바\r\n\r\n- 100인치 빔프로젝터\r\n2024년 최신형 빔프로텍터 스크린으로 스마트 ott 구동\r\n\r\n- 실제 노래방 기계 + 마이크\r\n소음 걱정 없고 음질 좋은 노래방 앰프 + 실제 노래방 기계\r\n별도 노래 공간\r\n\r\n- 플스5 / 닌텐도 스위치 듀얼 ( 25년 타이틀 추가 구매 )\r\n인기 게임타이틀 보유\r\n(철권, FC25, WWE 2k24, 뿌요뿌요, Astro Bot , 닌텐도 스위치 스포츠슈퍼 마리오, 마리오 카트8, 잇테이크투 등)\r\n\r\n- 20여개의 보드게임 완비\r\n\r\n-홀덤포커테이블(11인)\r\n11인용 대형 홀덤테이블가 구비되어있습니다. 포커집 카드도 풀세팅\r\n\r\n- 게이밍 조명\r\n게임에 집중하실 수 있게 게이밍 조명 (RGB ) 완비\r\n\r\n- 흡연 공간 / 화장실 확보\r\n흡연 가능한 출입구가 따로 있으며 화장실은 파티룸 내부 반계단 위에 있습니다. (실내 흡연 금지)\r\n\r\n※ 게임제한 안내 : 서든어택은 ip 충돌 문제로 이용 불가합니다.',16,'2025-03-12 12:38:18','0a28cf4e66712.jpg',2,0,'r0103001','255205_lucAqw9XMwAK.jpg/255205_lyS4T3kSZocg.jpg/255205_73Suc1ZIHebT.jpg/255205_NdoaKACPDDvF.jpg/255205_Sg7BpNcjWKQq.jpg/255205_mK13cmxj7YMJ.jpg/255205_aUm16KHkdbF2.jpg/255205_cnM8nX1cySug.jpg/255205_QfO939wF1nw4.jpg/255205_dkIhXRD1w2kU.jpg/255205_SCDxv0uhmfs4.jpg/255205_KJTljd2FnObU.jpg/255205_Q94BeuUI0y2W.jpg/255205_fb4qCtDFePxY.jpg/255205_f4XQWCmL4YiI.png/',0,'#사당역#이수역#PC10대#노래방#홀덤테이블','낮 타임 패키지 (12시-17시),밤 타임 패키지 (19시-익일 10시),올데이 패키지 (12시-22),,,','100000,190000,150000,,,','12:00,19:00,12:00,,,','17:00,10:00,22:00,,,','서울특별시 관악구 남현동 1057-25 지하1층','서울특별시 관악구 남현길 8 (남현동) 지하1층',126.977414934006,37.4761282165082,'입·퇴실 시간은 반드시 준수해 주세요. 시간 초과 시 추가 요금이 발생할 수 있습니다.\r\n시설물과 비품은 소중히 사용해 주세요. 파손 시 배상 책임이 발생할 수 있습니다.\r\n퇴실 전 청소와 분리수거를 완료해 주세요.\r\n실내는 금연이며, 화기 사용(촛불, 폭죽 등)은 금지됩니다.\r\n밤 10시 이후 소음은 자제해 주세요. 민원 발생 시 퇴실 조치될 수 있습니다.\r\n예약 취소는 이용일 기준 환불 규정에 따릅니다.\r\n유의사항을 준수하여 즐겁고 안전한 시간을 보내시기 바랍니다.','0,0,0,0,3,5,-1,-1,-1','24시간','무휴','지하1층',0,0,'0,4,8','0,2,3,6','0,1,2,3,4,6','0,1,2,3,4,5','01065436543','서울에서 가장 많은 PC 보유 파티룸','https://zenithspace.com','서울에서 가장 많은 PC 보유, 고성능 PC 10대, 플스5, 닌텐도, 최신 보드게임과 포커 테이블 완비','제니스페이스','노경민',NULL,'host20@example.org','8402395200');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomsubpic`
--

DROP TABLE IF EXISTS `roomsubpic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roomsubpic` (
  `roomsubpicid` int(11) NOT NULL AUTO_INCREMENT,
  `subpic` varchar(255) DEFAULT NULL,
  `writeday` datetime DEFAULT NULL,
  PRIMARY KEY (`roomsubpicid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomsubpic`
--

LOCK TABLES `roomsubpic` WRITE;
/*!40000 ALTER TABLE `roomsubpic` DISABLE KEYS */;
/*!40000 ALTER TABLE `roomsubpic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `so`
--

DROP TABLE IF EXISTS `so`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `so` (
  `soid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `socode` char(2) DEFAULT NULL,
  `daeid` char(2) DEFAULT NULL,
  PRIMARY KEY (`soid`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `so`
--

LOCK TABLES `so` WRITE;
/*!40000 ALTER TABLE `so` DISABLE KEYS */;
INSERT INTO `so` VALUES (24,'홍대/신촌','01','01'),(25,'건대/잠실/강동구','02','01'),(26,'사당','03','01'),(27,'신도림/구로/노량진/선유도','04','01'),(28,'연신내/은평구','05','01'),(29,'혜화/이태원','06','01'),(30,'강북구','07','01'),(31,'마곡/까치산','08','01'),(32,'인천','01','02'),(33,'부천','02','02'),(34,'수원/동탄','01','03'),(35,'분당','02','03'),(36,'하남/남양주/구리','03','03'),(37,'시흥/안양','04','03'),(38,'파주','05','03'),(39,'평택/오산','06','03'),(40,'광주/용인','07','03'),(41,'부산','00','04'),(42,'대구','01','05'),(43,'구미','02','05'),(44,'대전/충청','00','06'),(45,'광주','01','07'),(46,'전주','02','07');
/*!40000 ALTER TABLE `so` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeslot`
--

DROP TABLE IF EXISTS `timeslot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeslot` (
  `timeslotid` int(11) NOT NULL AUTO_INCREMENT,
  `available_date` date NOT NULL,
  `available_time` time NOT NULL,
  `roomid` int(11) DEFAULT NULL,
  PRIMARY KEY (`timeslotid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslot`
--

LOCK TABLES `timeslot` WRITE;
/*!40000 ALTER TABLE `timeslot` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeslot` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-17  5:33:56
