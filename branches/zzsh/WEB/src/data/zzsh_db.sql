-- MySQL dump 10.13  Distrib 5.1.33, for Win32 (ia32)
--
-- Host: localhost    Database: zzsh_db
-- ------------------------------------------------------
-- Server version	5.1.33-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `pc_agency`
--

DROP TABLE IF EXISTS `pc_agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_agency` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '党支部名称',
  `code_id` int(11) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `setup_datetime` datetime NOT NULL COMMENT '设选时间',
  `create_datetime` datetime NOT NULL,
  `invalid_datetime` int(11) unsigned NOT NULL DEFAULT '0',
  `number` smallint(5) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL COMMENT '组织负责人',
  `tel` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `comment` varchar(255) DEFAULT NULL,
  `p_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '党小组数',
  `zb_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支部人数',
  `zbsj` varchar(50) DEFAULT NULL COMMENT '支部书记',
  `zbfsj` varchar(50) DEFAULT NULL COMMENT '支部副书记',
  `zzwy` varchar(50) DEFAULT NULL COMMENT '组织委员',
  `xcwy` varchar(50) DEFAULT NULL COMMENT '宣传委员',
  `jjwy` varchar(50) DEFAULT NULL COMMENT '纪检委员',
  `qnwy` varchar(50) DEFAULT NULL COMMENT '青年委员',
  `ghwy` varchar(50) DEFAULT NULL COMMENT '工会委员',
  `fnwy` varchar(50) DEFAULT NULL COMMENT '妇女委员',
  `ext` varchar(255) DEFAULT NULL COMMENT 'saas扩展字段',
  `parent_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code_id` (`code_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2295 DEFAULT CHARSET=utf8 COMMENT='组织管理明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_agency`
--

LOCK TABLES `pc_agency` WRITE;
/*!40000 ALTER TABLE `pc_agency` DISABLE KEYS */;
INSERT INTO `pc_agency` VALUES (1,'某党委',6,'','2011-11-27 00:00:00','2012-01-01 00:00:00',0,0,NULL,'111','111',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `pc_agency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_agency_code`
--

DROP TABLE IF EXISTS `pc_agency_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_agency_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_agency_code`
--

LOCK TABLES `pc_agency_code` WRITE;
/*!40000 ALTER TABLE `pc_agency_code` DISABLE KEYS */;
INSERT INTO `pc_agency_code` VALUES (1,'4','政府工作部门党委（总支部，支部）'),(2,'421','地方政府工作部门党委'),(3,'422','地方政府工作部门党总支'),(4,'423','地方政府工作部门党支部'),(5,'430','地方政府工作部门第一党支部'),(6,'6','党的基层组织'),(7,'611','党委'),(8,'621','党总支部'),(9,'630','第一党支部'),(10,'631','党支部'),(11,'632','联合党支部'),(12,'7','未建立党组织'),(13,'711','党小组'),(14,'799','未建立党组织'),(15,'641','二级党委');
/*!40000 ALTER TABLE `pc_agency_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_agency_mapping`
--

DROP TABLE IF EXISTS `pc_agency_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_agency_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `agency_id` int(11) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4401 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_agency_mapping`
--

LOCK TABLES `pc_agency_mapping` WRITE;
/*!40000 ALTER TABLE `pc_agency_mapping` DISABLE KEYS */;
INSERT INTO `pc_agency_mapping` VALUES (4400,1,1,NULL);
/*!40000 ALTER TABLE `pc_agency_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_agency_relation`
--

DROP TABLE IF EXISTS `pc_agency_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_agency_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agency_id` (`agency_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2303 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_agency_relation`
--

LOCK TABLES `pc_agency_relation` WRITE;
/*!40000 ALTER TABLE `pc_agency_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_agency_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_agency_stat`
--

DROP TABLE IF EXISTS `pc_agency_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_agency_stat` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned NOT NULL COMMENT '党支部ID',
  `name` varchar(255) NOT NULL COMMENT '党支部名称',
  `code_id` int(11) NOT NULL DEFAULT '0' COMMENT '党支部类型',
  `code` varchar(10) NOT NULL,
  `parent_id` int(11) unsigned NOT NULL COMMENT '上级党支部ID',
  `year` year(4) NOT NULL COMMENT '年度',
  `quarter` tinyint(1) unsigned NOT NULL COMMENT '季度',
  `type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会议类型',
  `reported` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '规范执行情况',
  `delay` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '补开补报情况',
  `reported_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '规范执行率',
  `total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开会总次数',
  `eva` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已评价数',
  `eva_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '评价率',
  `attend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应出席人数',
  `asence` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '缺席人数',
  `attend_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '出席率',
  `p_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '党小组数',
  `zb_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支部人数',
  `zbsj_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支部书记数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `agency_id` (`agency_id`,`code_id`,`parent_id`,`year`,`quarter`,`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='党支部统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_agency_stat`
--

LOCK TABLES `pc_agency_stat` WRITE;
/*!40000 ALTER TABLE `pc_agency_stat` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_agency_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_agency_stats`
--

DROP TABLE IF EXISTS `pc_agency_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_agency_stats` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned NOT NULL COMMENT '党支部ID',
  `name` varchar(255) NOT NULL COMMENT '党支部名称',
  `code_id` int(11) NOT NULL DEFAULT '0' COMMENT '党支部类型',
  `code` varchar(10) NOT NULL,
  `setup_datetime` int(11) unsigned NOT NULL DEFAULT '0',
  `invalid_datetime` int(11) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(11) unsigned NOT NULL COMMENT '上级党支部ID',
  `zz_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组织总数',
  `jc_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '基层党委数',
  `ejdw_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '二级党委数量',
  `dzj_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '党总支数量',
  `dzb_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '党支部数',
  `more2year_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支部改选时间满两年的支部数',
  `less7_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '党员人数不足7人的党支部数量',
  `no_fsj_zbwy_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '只设支部书记未设支部副书记、支部委员的支部数量',
  `dxz_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '党小组数量',
  `dy_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '党员人数',
  `zbsj_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支部书记数',
  `zbfsj_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支部副书记数',
  `zzwy_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组织委员数',
  `xcwy_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '宣传委员数',
  `jjwy_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '纪检委员数',
  `qnwy_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '青年委员数',
  `ghwy_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '工会委员数',
  `fnwy_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '妇女委员数',
  `bmwy_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '保密委员数',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `agency_id` (`agency_id`,`code_id`,`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2262 DEFAULT CHARSET=utf8 COMMENT='党建办党支部基本情况统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_agency_stats`
--

LOCK TABLES `pc_agency_stats` WRITE;
/*!40000 ALTER TABLE `pc_agency_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_agency_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_backup`
--

DROP TABLE IF EXISTS `pc_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_backup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(30) NOT NULL,
  `backup_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_backup`
--

LOCK TABLES `pc_backup` WRITE;
/*!40000 ALTER TABLE `pc_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_bulletin`
--

DROP TABLE IF EXISTS `pc_bulletin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bulletin` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` mediumtext NOT NULL,
  `member` varchar(50) NOT NULL,
  `is_index` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pub_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expire_time` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_bulletin`
--

LOCK TABLES `pc_bulletin` WRITE;
/*!40000 ALTER TABLE `pc_bulletin` DISABLE KEYS */;
INSERT INTO `pc_bulletin` VALUES (2,'致全局广大党员的一封信','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">全局广大党员民警同志们：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      按照中央、市委和公安部党委关于提升党的建设科学化水平的要求，着眼于“首都稳、全国稳”的重大政治责任，为进一步创新党务公开工作载体途径，切实破解基层组织生活中存在的重点难点问题，充分发挥基层党组织在建设“忠诚、为民、公正、廉洁”首都公安队伍中的主渠道和根本性作用，市局设计开发了“北京市公安局基层党支部组织生活管理系统”。2012年1月1日，市委常委、市局党委书记、局长傅政华同志亲自点击开通了管理系统。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      基层党支部组织生活管理系统依托市局公安网，将全局在职党员党支部全部纳入管理范围，建立了“年度计划申报、年度总结报备，季度要点申报、季度总结报备”等报备审批管理模式，实现了对“支部党员大会、支委会、民主生活会、党课和党日活动”等组织生活的全面覆盖，并且任何一台联入公安网的计算机，都可以随时登录管理系统，填写或查阅支部组织生活落实情况。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      基层党支部组织生活管理系统具有“预警提示、政策发布、限时填报、定期关闭”等功能。通过定期发布预警提示和政策公告，督促指导基层党支部严格按照规定要求开展组织生活；通过设置限时填报和定期关闭功能，未按期开展组织生活的党支部将无法进行填写上报，重点解决基层党支部组织生活不规范、不严格等突出问题。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    基层党支部组织生活管理系统实行“一支部双用户”登录模式。为每个支部和支部党员分别发放了登录账号和密码，采取“支部登录填报、党员登录查询”管理方式，每名党员民警都可以任选一台联入公安网的计算机，查询所在支部组织生活开展情况，了解支部领导班子议事决策内容，切实保障广大党员民警的知情权、参与权、选择权、表达权和监督权。为进一步畅通渠道、扩大监督，广泛征求党员民警的意见建议，市局党建办专门设立了监督咨询电话，电话号码为85223064。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    党员民警同志们，你们是维护首都政治稳定和治安稳定的主体力量和根本依靠，你们是基层组织生活的参与主体与监督主体，希望你们能够切实树立主人翁的责任意识，充分发挥先锋模范作用，积极参加组织生活、主动思考献计献策、主动监督各项组织生活制度的执行，为全力推进基层党组织建设科学化水平贡献自己的力量，以实际行动确保党的十八大绝对安全！</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"> </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">                                     市局党建办</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">                             二○一二年一月八日</FONT></P></TEXTFORMAT>','',1,'2012-12-18 09:47:17','2013-01-17');
/*!40000 ALTER TABLE `pc_bulletin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_duty_code`
--

DROP TABLE IF EXISTS `pc_duty_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_duty_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_duty_code`
--

LOCK TABLES `pc_duty_code` WRITE;
/*!40000 ALTER TABLE `pc_duty_code` DISABLE KEYS */;
INSERT INTO `pc_duty_code` VALUES (1,'001A','书记'),(2,'001B','副书记'),(3,'030U','组织委员'),(4,'031U','宣传委员'),(5,'034U','纪检委员'),(6,'035U','青年委员'),(7,'036U','工会委员'),(8,'037U','保密委员'),(9,'038U','妇女委员'),(12,'401A','组长'),(13,'0000','其他');
/*!40000 ALTER TABLE `pc_duty_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_edu_code`
--

DROP TABLE IF EXISTS `pc_edu_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_edu_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_edu_code`
--

LOCK TABLES `pc_edu_code` WRITE;
/*!40000 ALTER TABLE `pc_edu_code` DISABLE KEYS */;
INSERT INTO `pc_edu_code` VALUES (1,'1','研究生教育'),(2,'11','博士研究生'),(3,'12','硕士研究生'),(4,'13','硕士生班'),(5,'1A','中央党校研究生'),(6,'1B','省（区，市）委党校研究生'),(7,'2','本专科教育'),(8,'21','大学'),(9,'22','大专'),(10,'23','大学普通版'),(11,'24','第二学士学位办'),(12,'2A','中央党校大学'),(13,'2B','省（区，市）委党校大学'),(14,'2C','中央党校大专'),(15,'2D','省（区，市）委党校大专'),(16,'4','中等职业学校教育'),(17,'41','中等专科'),(18,'44','职业高中'),(19,'47','技工学校'),(20,'6','普通高中教育'),(21,'61','普通高中'),(22,'7','初中教育'),(23,'71','初中'),(24,'8','小学教育'),(25,'81','小学'),(26,'9','其他');
/*!40000 ALTER TABLE `pc_edu_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_meeting`
--

DROP TABLE IF EXISTS `pc_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_meeting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` int(10) unsigned NOT NULL COMMENT '党支部ID',
  `year` year(4) DEFAULT NULL COMMENT '年度',
  `quarter` tinyint(1) DEFAULT NULL COMMENT '季度',
  `week` int(10) DEFAULT NULL,
  `type_id` int(10) DEFAULT NULL COMMENT '会议类型ID',
  `moderator` varchar(255) DEFAULT NULL COMMENT '授课人',
  `theme` varchar(255) DEFAULT NULL COMMENT '授课主题',
  `attend` int(10) DEFAULT NULL COMMENT '应到人数',
  `asence` int(10) DEFAULT NULL COMMENT '缺席人数',
  `status_id` int(10) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `meeting_datetime` timestamp NULL DEFAULT NULL,
  `meeting_name` varchar(200) DEFAULT NULL,
  `month` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agency_id` (`agency_id`,`year`,`quarter`,`type_id`),
  KEY `agency_id_2` (`agency_id`,`year`,`quarter`,`type_id`,`status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=91706 DEFAULT CHARSET=utf8 COMMENT='组织生活会';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_meeting`
--

LOCK TABLES `pc_meeting` WRITE;
/*!40000 ALTER TABLE `pc_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_meeting_asence`
--

DROP TABLE IF EXISTS `pc_meeting_asence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_meeting_asence` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned NOT NULL COMMENT '会议ID',
  `member_ids` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pb_meeting_id` (`meeting_id`)
) ENGINE=MyISAM AUTO_INCREMENT=38393 DEFAULT CHARSET=utf8 COMMENT='组织生活会缺席人数';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_meeting_asence`
--

LOCK TABLES `pc_meeting_asence` WRITE;
/*!40000 ALTER TABLE `pc_meeting_asence` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_meeting_asence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_meeting_content`
--

DROP TABLE IF EXISTS `pc_meeting_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_meeting_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned NOT NULL COMMENT '会议ID',
  `type` tinyint(1) unsigned NOT NULL COMMENT '类型:1=填报,2=审批,3=评价',
  `member_id` int(10) unsigned DEFAULT NULL COMMENT '填补人/审批人/评价人',
  `member_name` varchar(50) DEFAULT NULL,
  `content` longtext,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `meeting_id` (`meeting_id`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=268529 DEFAULT CHARSET=utf8 COMMENT='组织生活会议内容';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_meeting_content`
--

LOCK TABLES `pc_meeting_content` WRITE;
/*!40000 ALTER TABLE `pc_meeting_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_meeting_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_member`
--

DROP TABLE IF EXISTS `pc_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_member` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '党员ID',
  `agency_id` int(10) NOT NULL COMMENT '党支部ID',
  `post_id` int(10) NOT NULL COMMENT '党内职务ID',
  `name` varchar(255) NOT NULL COMMENT '姓名',
  `sex_id` smallint(5) NOT NULL COMMENT '性别ID',
  `nation_id` int(10) DEFAULT NULL COMMENT '民族',
  `birthday` datetime DEFAULT NULL COMMENT '出生年月',
  `workday` datetime DEFAULT NULL COMMENT '参加工作年月',
  `joinday` datetime DEFAULT NULL COMMENT '入党时间',
  `edu_id` int(10) DEFAULT NULL COMMENT '文化程度ID',
  `postday` datetime DEFAULT NULL COMMENT '任党内职务时间',
  `birthplace` varchar(255) DEFAULT NULL COMMENT '籍贯',
  `address` varchar(255) DEFAULT NULL COMMENT '家庭住址',
  `duty_id` int(10) NOT NULL COMMENT '行政职务ID',
  `ext` varchar(255) DEFAULT NULL COMMENT 'saas扩展字段',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可用: 1=可用 0=不可用',
  `updatetime` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `comment` text,
  `admin_duty` varchar(200) DEFAULT NULL,
  `sort` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agency_id` (`agency_id`,`post_id`),
  KEY `agency_id_2` (`agency_id`,`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12614 DEFAULT CHARSET=utf8 COMMENT='党支部基本情况表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_member`
--

LOCK TABLES `pc_member` WRITE;
/*!40000 ALTER TABLE `pc_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_nation_code`
--

DROP TABLE IF EXISTS `pc_nation_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_nation_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_nation_code`
--

LOCK TABLES `pc_nation_code` WRITE;
/*!40000 ALTER TABLE `pc_nation_code` DISABLE KEYS */;
INSERT INTO `pc_nation_code` VALUES (1,'1','汉族'),(2,'2','蒙古族'),(3,'3','回族'),(4,'4','藏族'),(5,'5','维吾尔族'),(6,'6','苗族'),(7,'7','彝族'),(8,'8','壮族'),(9,'9','布依族'),(10,'10','朝鲜族'),(11,'11','满族'),(12,'12','侗族'),(13,'13','瑶族'),(14,'14','白族'),(15,'15','土家族'),(16,'16','哈尼族'),(17,'17','哈萨克族'),(18,'18','傣族'),(19,'19','黎族'),(20,'20','傈僳族'),(21,'21','佤族'),(22,'22','畲族'),(23,'23','高山族'),(24,'24','拉祜族'),(25,'25','水族'),(26,'26','东乡族'),(27,'27','纳西族'),(28,'28','景颇族'),(29,'29','柯尔克孜族'),(30,'30','土族'),(31,'31','达斡尔族'),(32,'32','仫佬族'),(33,'33','羌族'),(34,'34','布朗族'),(35,'35','撒拉族'),(36,'36','毛南族'),(37,'37','仡佬族'),(38,'38','锡伯族'),(39,'39','阿昌族'),(40,'40','普米族'),(41,'41','塔吉克族'),(42,'42','怒族'),(43,'43','乌孜别克族'),(44,'44','俄罗斯族'),(45,'45','鄂温克族'),(46,'46','德昂族'),(47,'47','保安族'),(48,'48','裕固族'),(49,'49','京族'),(50,'50','塔塔尔族'),(51,'51','独龙族'),(52,'52','鄂伦春族'),(53,'53','赫哲族'),(54,'54','门巴族'),(55,'55','珞巴族'),(56,'56','基诺族'),(57,'57','其他'),(58,'58','外国血统中国籍人士');
/*!40000 ALTER TABLE `pc_nation_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_operation_type`
--

DROP TABLE IF EXISTS `pc_operation_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_operation_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_operation_type`
--

LOCK TABLES `pc_operation_type` WRITE;
/*!40000 ALTER TABLE `pc_operation_type` DISABLE KEYS */;
INSERT INTO `pc_operation_type` VALUES (1,'新增'),(2,'删除'),(3,'修改'),(4,'撤销'),(5,'合并'),(6,'划转'),(7,'提醒'),(8,'审批'),(9,'评价'),(10,'上报');
/*!40000 ALTER TABLE `pc_operation_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_parent_stat`
--

DROP TABLE IF EXISTS `pc_parent_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_parent_stat` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned NOT NULL COMMENT '党支部ID',
  `name` varchar(255) NOT NULL COMMENT '党支部名称',
  `code_id` int(11) NOT NULL DEFAULT '0' COMMENT '党支部类型',
  `code` varchar(20) NOT NULL,
  `parent_id` int(11) unsigned NOT NULL COMMENT '上级党支部ID',
  `year` year(4) NOT NULL COMMENT '年度',
  `quarter` tinyint(1) unsigned NOT NULL COMMENT '季度',
  `type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会议类型',
  `reported` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '规范执行情况',
  `delay` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '补开补报情况',
  `reported_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '规范执行率',
  `total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开会总次数',
  `eva` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已评价数',
  `eva_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '评价率',
  `attend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应出席人数',
  `asence` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '缺席人数',
  `attend_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '出席率',
  `p_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '党小组数',
  `zb_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支部人数',
  `zbsj_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支部书记数',
  `agency_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支部个数',
  `agency_goodjob` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `agency_id` (`agency_id`,`code_id`,`parent_id`,`year`,`quarter`,`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='党支部统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_parent_stat`
--

LOCK TABLES `pc_parent_stat` WRITE;
/*!40000 ALTER TABLE `pc_parent_stat` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_parent_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_remind`
--

DROP TABLE IF EXISTS `pc_remind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_remind` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned NOT NULL COMMENT '党支部ID',
  `name` varchar(255) NOT NULL COMMENT '党支部名称',
  `code_id` int(11) NOT NULL DEFAULT '0' COMMENT '党支部类型',
  `code` varchar(20) NOT NULL,
  `parent_id` int(11) unsigned NOT NULL COMMENT '上级党支部ID',
  `parent_name` varchar(255) NOT NULL,
  `year` year(4) NOT NULL COMMENT '年度',
  `quarter` tinyint(1) unsigned NOT NULL COMMENT '季度',
  `type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '年度计划状态',
  `status` smallint(5) unsigned NOT NULL,
  `ext` varchar(255) DEFAULT 'beijing' COMMENT 'saas扩展字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `agency_id` (`agency_id`,`code_id`,`parent_id`,`year`,`quarter`,`type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16033 DEFAULT CHARSET=utf8 COMMENT='党支部提醒统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_remind`
--

LOCK TABLES `pc_remind` WRITE;
/*!40000 ALTER TABLE `pc_remind` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_remind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_remind_config`
--

DROP TABLE IF EXISTS `pc_remind_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_remind_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT '0',
  `value` int(11) DEFAULT '0',
  `start_year` tinyint(1) NOT NULL DEFAULT '0',
  `start_quarter` tinyint(1) NOT NULL DEFAULT '0',
  `start_month` smallint(5) unsigned NOT NULL DEFAULT '0',
  `start_day` smallint(5) unsigned NOT NULL DEFAULT '0',
  `end_year` tinyint(1) NOT NULL DEFAULT '0',
  `end_quarter` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `end_month` smallint(5) unsigned NOT NULL DEFAULT '0',
  `end_day` smallint(5) unsigned NOT NULL DEFAULT '0',
  `delay_day` mediumint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_remind_config`
--

LOCK TABLES `pc_remind_config` WRITE;
/*!40000 ALTER TABLE `pc_remind_config` DISABLE KEYS */;
INSERT INTO `pc_remind_config` VALUES (1,1,7,-1,0,12,15,0,0,1,20,0),(2,4,7,0,0,12,15,1,0,1,20,0),(3,2,7,0,-1,0,10,0,0,0,10,0),(4,3,7,0,0,0,10,0,1,0,10,0),(5,5,90,0,0,0,0,0,0,0,0,0),(6,6,90,0,0,0,0,0,0,0,0,0),(7,7,90,0,0,0,0,0,0,0,0,0),(8,8,30,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `pc_remind_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_remind_lock`
--

DROP TABLE IF EXISTS `pc_remind_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_remind_lock` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned NOT NULL COMMENT '党支部ID',
  `name` varchar(255) NOT NULL COMMENT '党支部名称',
  `code_id` int(11) NOT NULL DEFAULT '0' COMMENT '党支部类型',
  `code` varchar(20) NOT NULL,
  `parent_id` int(11) unsigned NOT NULL COMMENT '上级党支部ID',
  `year` year(4) NOT NULL COMMENT '年度',
  `quarter` tinyint(1) unsigned NOT NULL COMMENT '季度',
  `month` smallint(5) unsigned NOT NULL DEFAULT '0',
  `type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '年度计划状态',
  `status` smallint(5) unsigned NOT NULL,
  `delay_date` varchar(20) NOT NULL,
  `ext` varchar(255) DEFAULT 'beijing' COMMENT 'saas扩展字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `agency_id` (`agency_id`,`code_id`,`parent_id`,`year`,`quarter`,`month`,`type_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=7104 DEFAULT CHARSET=utf8 COMMENT='党支部提醒统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_remind_lock`
--

LOCK TABLES `pc_remind_lock` WRITE;
/*!40000 ALTER TABLE `pc_remind_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_remind_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_remind_stat`
--

DROP TABLE IF EXISTS `pc_remind_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_remind_stat` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned NOT NULL COMMENT '党支部ID',
  `name` varchar(255) NOT NULL COMMENT '党支部名称',
  `code_id` int(11) DEFAULT NULL COMMENT '党支部类型',
  `code` varchar(20) NOT NULL,
  `parent_id` int(11) unsigned NOT NULL COMMENT '上级党支部ID',
  `year` year(4) NOT NULL COMMENT '年度',
  `quarter` tinyint(1) unsigned NOT NULL COMMENT '季度',
  `type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '年度计划状态',
  `status` smallint(5) unsigned NOT NULL,
  `c` int(10) unsigned NOT NULL COMMENT '季度执行计划状态',
  `ext` varchar(255) DEFAULT 'beijing' COMMENT 'saas扩展字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `agency_id` (`agency_id`,`code_id`,`parent_id`,`year`,`quarter`,`type_id`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=2213 DEFAULT CHARSET=utf8 COMMENT='党支部提醒统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_remind_stat`
--

LOCK TABLES `pc_remind_stat` WRITE;
/*!40000 ALTER TABLE `pc_remind_stat` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_remind_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_remind_type`
--

DROP TABLE IF EXISTS `pc_remind_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_remind_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_remind_type`
--

LOCK TABLES `pc_remind_type` WRITE;
/*!40000 ALTER TABLE `pc_remind_type` DISABLE KEYS */;
INSERT INTO `pc_remind_type` VALUES (1,'年度计划上报'),(2,'季度工作安排及执行情况'),(3,'党课'),(4,'支部党员大会'),(5,'支部委员会'),(6,'支部民主大会'),(7,'年终总结上报'),(8,'年终总结评价');
/*!40000 ALTER TABLE `pc_remind_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_roles`
--

DROP TABLE IF EXISTS `pc_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(20) NOT NULL COMMENT '权限',
  `name` varchar(20) NOT NULL COMMENT '说明',
  `enable` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否可用 1=可以 0=停用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_roles`
--

LOCK TABLES `pc_roles` WRITE;
/*!40000 ALTER TABLE `pc_roles` DISABLE KEYS */;
INSERT INTO `pc_roles` VALUES (1,'browse','浏览权',1),(2,'report','上报权',1),(3,'evaluate','评语权',1),(4,'rate','评价权',1),(5,'return','驳回权',1),(6,'delete','删除',1);
/*!40000 ALTER TABLE `pc_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_sex_code`
--

DROP TABLE IF EXISTS `pc_sex_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_sex_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_sex_code`
--

LOCK TABLES `pc_sex_code` WRITE;
/*!40000 ALTER TABLE `pc_sex_code` DISABLE KEYS */;
INSERT INTO `pc_sex_code` VALUES (1,'1','男性'),(2,'2','女性');
/*!40000 ALTER TABLE `pc_sex_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_status`
--

DROP TABLE IF EXISTS `pc_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_status` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '状态',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否可用:1=可用, 0=不可用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='业务流程状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_status`
--

LOCK TABLES `pc_status` WRITE;
/*!40000 ALTER TABLE `pc_status` DISABLE KEYS */;
INSERT INTO `pc_status` VALUES (1,'未上报',1),(2,'已上报',1),(3,'已审批',1),(4,'已评价',1),(5,'已作废',1);
/*!40000 ALTER TABLE `pc_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_sys_conf`
--

DROP TABLE IF EXISTS `pc_sys_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_sys_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config` int(11) NOT NULL COMMENT '配置参数',
  `type` int(11) NOT NULL COMMENT '配置类型',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_sys_conf`
--

LOCK TABLES `pc_sys_conf` WRITE;
/*!40000 ALTER TABLE `pc_sys_conf` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_sys_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_sys_log`
--

DROP TABLE IF EXISTS `pc_sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_sys_log` (
  `id` int(11) NOT NULL,
  `entity_type_id` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `operation_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_sys_log`
--

LOCK TABLES `pc_sys_log` WRITE;
/*!40000 ALTER TABLE `pc_sys_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_sys_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_user`
--

DROP TABLE IF EXISTS `pc_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `lastlogintime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment` varchar(200) DEFAULT NULL,
  `privilege` text,
  `enable_report` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可填报:1:填报 0:浏览',
  `agency_code_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4404 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_user`
--

LOCK TABLES `pc_user` WRITE;
/*!40000 ALTER TABLE `pc_user` DISABLE KEYS */;
INSERT INTO `pc_user` VALUES (1,'admin','admin1234','admin@admin.com','123456',1,'2013-09-03 14:23:45',NULL,'1',0,6);
/*!40000 ALTER TABLE `pc_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_user_role`
--

DROP TABLE IF EXISTS `pc_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_user_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14880 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_user_role`
--

LOCK TABLES `pc_user_role` WRITE;
/*!40000 ALTER TABLE `pc_user_role` DISABLE KEYS */;
INSERT INTO `pc_user_role` VALUES (14847,1,1),(14845,1,3),(14844,1,4),(14843,1,5),(14842,1,6);
/*!40000 ALTER TABLE `pc_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_workplan`
--

DROP TABLE IF EXISTS `pc_workplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_workplan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` int(10) unsigned NOT NULL COMMENT '党支部id',
  `type_id` int(10) unsigned NOT NULL COMMENT '会议类型ID',
  `year` year(4) NOT NULL COMMENT '年度',
  `quarter` tinyint(1) unsigned NOT NULL COMMENT '季度',
  `status_id` int(10) unsigned NOT NULL COMMENT '执行状态',
  `active` tinyint(1) NOT NULL COMMENT '是否可用:1=可用,0=不可用',
  PRIMARY KEY (`id`),
  KEY `agency_id` (`agency_id`,`type_id`,`year`,`quarter`),
  KEY `agency_id_2` (`agency_id`,`type_id`,`year`,`quarter`,`status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25795 DEFAULT CHARSET=utf8 COMMENT='工作计划表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_workplan`
--

LOCK TABLES `pc_workplan` WRITE;
/*!40000 ALTER TABLE `pc_workplan` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_workplan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_workplan_content`
--

DROP TABLE IF EXISTS `pc_workplan_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_workplan_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `workplan_id` int(10) unsigned NOT NULL COMMENT '工作计划id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '类型:1=填报,2=审批,3=评价',
  `member_id` int(10) unsigned DEFAULT NULL COMMENT '填补人/审批人/评价人',
  `content` longtext,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  `member_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workplan_id` (`workplan_id`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=74123 DEFAULT CHARSET=utf8 COMMENT='工作计划内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_workplan_content`
--

LOCK TABLES `pc_workplan_content` WRITE;
/*!40000 ALTER TABLE `pc_workplan_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_workplan_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_workplan_type`
--

DROP TABLE IF EXISTS `pc_workplan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_workplan_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '会议类型ID',
  `name` varchar(255) NOT NULL COMMENT '会议名称',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可用:1=可用 0=不可用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='组织生活会类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_workplan_type`
--

LOCK TABLES `pc_workplan_type` WRITE;
/*!40000 ALTER TABLE `pc_workplan_type` DISABLE KEYS */;
INSERT INTO `pc_workplan_type` VALUES (1,'年度计划',1),(2,'季度工作安排',1),(3,'季度执行情况',1),(4,'年终总结',1),(5,'党课',1),(6,'支部党员大会',1),(7,'支部民主生活会',1),(8,'支部委员会',1),(9,'其他会议',1),(10,'党小组会',1);
/*!40000 ALTER TABLE `pc_workplan_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_zzsh_stat`
--

DROP TABLE IF EXISTS `pc_zzsh_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_zzsh_stat` (
  `agency_id` int(11) unsigned NOT NULL COMMENT 'µ³Ö§²¿ID',
  `name` varchar(255) NOT NULL COMMENT 'µ³Ö§²¿Ãû³Æ',
  `code_id` int(11) NOT NULL DEFAULT '0' COMMENT 'µ³Ö§²¿ÀàÐÍ',
  `code` varchar(20) NOT NULL,
  `setup_datetime` int(11) unsigned NOT NULL DEFAULT '0',
  `invalid_datetime` int(11) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(11) unsigned NOT NULL COMMENT 'ÉÏ¼¶µ³Ö§²¿ID',
  `year` year(4) NOT NULL COMMENT 'Äê¶È',
  `quarter` tinyint(1) unsigned NOT NULL COMMENT '¼¾¶È',
  `month` smallint(5) unsigned NOT NULL COMMENT 'ÔÂ·Ý',
  `type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '»áÒéÀàÐÍ',
  `total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Êµ¼ÊÕÙ¿ªÊý',
  `total_success` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Ò»´Î³É¹¦ÉÏ±¨Êý',
  `total_return` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '²µ»ØÉÏ±¨Êý',
  `total_delay` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '²¹¿ª²¹±¨Çé¿ö',
  `reported` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '¹æ·¶Ö´ÐÐÇé¿ö',
  `reported_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '¹æ·¶Ö´ÐÐÂÊ',
  `return_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '²µ»ØºóÉÏ±¨ÂÊ',
  `delay_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT 'ÓâÆÚÉÏ±¨ÂÊ',
  `attend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Ó¦³öÏ¯ÈËÊý',
  `asence` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'È±Ï¯ÈËÊý',
  `attend_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '³öÏ¯ÂÊ',
  `eva` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ÒÑÆÀ¼ÛÊý',
  `eva_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT 'ÆÀ¼ÛÂÊ',
  `eva_1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ÆÀ¼Û´ÎÊý:ºÃ',
  `eva_2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ÆÀ¼Û´ÎÊý:½ÏºÃ',
  `eva_3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ÆÀ¼Û´ÎÊý:Ò»°ã',
  `eva_4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ÆÀ¼Û´ÎÊý:²î',
  `eva_1_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ÆÀ¼ÛÂÊ:ºÃ',
  `eva_2_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ÆÀ¼ÛÂÊ:½ÏºÃ',
  `eva_3_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ÆÀ¼ÛÂÊ:Ò»°ã',
  `eva_4_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ÆÀ¼ÛÂÊ:²î',
  `agency_goodjob` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `agency_id` (`agency_id`,`code_id`,`parent_id`,`year`,`quarter`,`month`,`type_id`),
  KEY `code` (`code`,`setup_datetime`,`invalid_datetime`,`year`,`month`,`type_id`),
  KEY `code_2` (`code`,`setup_datetime`,`invalid_datetime`,`year`,`type_id`),
  KEY `code_3` (`code`,`setup_datetime`,`invalid_datetime`,`year`,`quarter`,`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='×éÖ¯Éú»îÍ³¼Æ±í'
/*!50100 PARTITION BY RANGE (`year`)
(PARTITION p2011 VALUES LESS THAN (2012) ENGINE = InnoDB,
 PARTITION p2012 VALUES LESS THAN (2013) ENGINE = InnoDB,
 PARTITION p2013 VALUES LESS THAN (2014) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_zzsh_stat`
--

LOCK TABLES `pc_zzsh_stat` WRITE;
/*!40000 ALTER TABLE `pc_zzsh_stat` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc_zzsh_stat` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-03 14:31:31
