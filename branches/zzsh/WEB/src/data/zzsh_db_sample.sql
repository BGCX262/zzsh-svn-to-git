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
INSERT INTO `pc_agency` VALUES (1,'某党委',6,'','2011-11-27 00:00:00','2012-01-01 00:00:00',0,0,NULL,'111','111',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(2,'办公室党委',7,'01','2011-12-25 00:00:00','2012-01-01 00:00:00',0,0,NULL,NULL,NULL,0,0,' ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'beijing',1),(3,'秘书处党支部',10,'0101','2011-12-25 00:00:00','2012-01-01 00:00:00',0,0,NULL,NULL,NULL,6,44,'李广岐 ',NULL,'张宾','李华','朱杰','邢栋',NULL,'贾娜','beijing',2),(4,'政治处党支部',10,'0103','2011-12-25 00:00:00','2012-01-01 00:00:00',0,0,NULL,NULL,NULL,0,8,' ','赵伟','宋艳庆',NULL,'',NULL,NULL,NULL,'beijing',2),(5,'研究室党支部',10,'0105','2011-12-08 00:00:00','2007-11-13 00:00:00',0,0,NULL,NULL,NULL,1,23,'刘滨 ',NULL,'马波','孙威毅','张成格',NULL,'丁镭（保密委员）',NULL,'beijing',2),(6,'综合处党支部',10,'0107','2011-12-25 00:00:00','2012-01-01 00:00:00',0,0,NULL,NULL,NULL,4,20,'刘东 ',NULL,'高廷海','许巍','胡鹏',NULL,'李芳（保密委员）',NULL,'beijing',2),(7,'信访处党支部',10,'0109','2011-12-25 00:00:00','2012-01-01 00:00:00',0,0,NULL,NULL,NULL,2,35,'杨志刚 ',NULL,'张家祥','宋红','康健','陈军',NULL,NULL,'beijing',2),(8,'档案处党支部',10,'0111','2011-12-25 00:00:00','2012-01-01 00:00:00',0,0,NULL,NULL,NULL,6,37,'张兵 ','张延太','唐琼','马军','刘蔚','刘珠江',NULL,'葛婴','beijing',2),(9,'外事办公室党支部',10,'0113','2011-12-25 00:00:00','2012-01-01 00:00:00',0,0,NULL,NULL,NULL,0,7,'高红军 ',NULL,'寇波','臧德国',NULL,NULL,NULL,NULL,'beijing',2),(10,'新闻办党支部',10,'0115','2011-12-25 00:00:00','2012-01-01 00:00:00',0,0,NULL,NULL,NULL,3,48,'刘大伟 ',NULL,'杨亚玲','王文杰','胡蓉','赵峰',NULL,NULL,'beijing',2),(2216,'国际警务联络处党支部',10,'0116','2012-10-15 14:09:44','2012-01-01 00:00:00',0,0,NULL,'','',0,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'beijing',2);
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
INSERT INTO `pc_agency_mapping` VALUES (4400,1,1,NULL),(2,2,2,NULL),(3,3,3,NULL),(4,4,3,NULL),(5,5,4,NULL),(6,6,4,NULL),(7,7,5,NULL),(8,8,5,NULL),(9,9,6,NULL),(10,10,6,NULL),(11,11,7,NULL),(12,12,7,NULL),(13,13,8,NULL),(14,14,8,NULL),(15,15,9,NULL),(16,16,9,NULL),(17,17,10,NULL),(18,18,10,NULL),(4242,4246,2216,NULL),(4241,4245,2216,NULL);
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
INSERT INTO `pc_agency_stats` VALUES (1,3,'秘书处党支部',10,'0101',1325347200,0,2,1,0,0,0,1,0,0,0,6,44,1,0,1,1,1,1,0,0,1,'2012-04-05 04:54:56'),(2,4,'政治处党支部',10,'0103',1325347200,0,2,1,0,0,0,1,0,0,0,0,8,1,0,1,0,0,0,0,0,0,'2012-04-05 04:54:56'),(3,5,'研究室党支部',10,'0105',1194883200,0,2,1,0,0,0,1,1,0,0,1,23,1,0,1,1,1,0,0,0,1,'2012-04-05 04:54:56'),(4,6,'综合处党支部',10,'0107',1325347200,0,2,1,0,0,0,1,0,0,0,4,20,1,0,1,1,1,0,0,0,1,'2012-04-05 04:54:56'),(5,7,'信访处党支部',10,'0109',1325347200,0,2,1,0,0,0,1,0,0,0,2,35,1,0,1,1,1,1,0,0,0,'2012-04-05 04:54:56'),(6,8,'档案处党支部',10,'0111',1325347200,0,2,1,0,0,0,1,0,0,0,6,37,1,1,1,1,1,1,0,0,0,'2012-04-05 04:54:56'),(7,9,'外事办公室党支部',10,'0113',1325347200,0,2,1,0,0,0,1,0,0,0,0,7,1,0,1,1,0,0,0,0,0,'2012-04-05 04:54:56'),(8,10,'新闻办党支部',10,'0115',1325347200,0,2,1,0,0,0,1,0,0,0,3,48,1,0,1,1,1,1,0,0,0,'2012-04-05 04:54:56'),(1975,2,'办公室党委',7,'01',0,0,1,10,1,0,0,9,1,0,0,22,230,9,1,9,8,6,4,0,0,3,'2012-04-05 04:54:58'),(2183,2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,1,0,0,0,1,0,0,0,0,8,1,0,1,1,0,0,0,0,0,'2012-10-15 06:10:21');
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
INSERT INTO `pc_meeting` VALUES (80528,3,2013,1,0,8,'李广岐','学习市局党委贯彻落实中央和市委市政府关于改进工作作风密切联系群众有关精神的实施意见',7,0,5,0,NULL,'2013-01-04 16:00:00','',1),(80607,6,2013,1,0,8,'刘东','研究综合处贯彻落实党的十八大会议精神学习意见。',6,0,5,0,NULL,'2013-01-08 16:00:00','',1),(80660,7,2013,1,0,8,'杨志刚','研究2013年党建工作',6,0,5,0,NULL,'2013-01-08 16:00:00','',1),(80736,9,2013,1,0,8,'高红军','外事办公室党支部召开支委会结合中央八项规定研究部署近期工作',3,0,5,0,NULL,'2013-01-08 16:00:00','',1),(81577,6,2013,1,0,6,'刘东','召开“坚守道德底线，提升党性修养”专项教育整顿活动部署会',20,0,5,0,NULL,'2013-01-15 16:00:00','',0),(81673,4,2013,1,0,6,'王锦','坚守道德底线，提升党性修养',8,0,5,0,NULL,'2013-01-03 16:00:00','',0),(82589,3,2013,1,0,6,'李广岐','学习习近平总书记重要讲话精神及《人民日报》刊载文章《信仰的味道》',44,0,5,0,NULL,'2013-01-10 16:00:00','',0),(82930,2216,2013,1,0,8,'冯若非','办公室先进典型信息库人员推荐工作',8,0,5,0,NULL,'2013-01-09 16:00:00','',1),(83507,5,2013,1,0,8,'徐暖保','研究近期支部工作',5,0,3,0,NULL,'2013-01-16 16:00:00','',1),(84273,6,2013,1,0,8,'刘东','综合处党支部迅速学习贯彻市局党委扩大会和办公室第一党支部会议精神',6,0,3,0,NULL,'2013-01-24 16:00:00','',1),(84379,5,2013,1,0,6,'徐暖保','组织开展年度公务员考核工作',21,0,3,0,NULL,'2013-02-19 16:00:00','',0),(85132,6,2013,1,0,6,'刘东','综合处召开全体党员民警大会学习习总书记讲话精神和市局党委扩大会议精神',20,0,5,0,NULL,'2013-01-27 16:00:00','',0),(85136,9,2013,1,0,9,'高红军','外事办公室党支部组织开展读书学习党日活动',7,0,5,0,NULL,'2013-01-24 16:00:00','1月份党日活动',1),(85210,7,2013,1,0,7,'杨志刚','学习市局党委第一次扩大会并结合廉政教育谈个人体会',6,0,5,0,NULL,'2013-01-23 16:00:00','',0),(85434,4,2013,1,0,8,'王锦','学习市局2013年第一次党委扩大会议精神',9,0,5,0,NULL,'2013-01-23 16:00:00','',1),(85736,10,2013,1,0,8,'胡蓉','学习习近平总书记近期重要指示精神，研究如何继续深入学习贯彻市局第一次党委扩大会议精神',3,0,5,0,NULL,'2013-01-27 16:00:00','',1),(87134,6,2013,1,0,8,'刘东','学习市局和办公室有关通知精神，研究春节安保工作',6,0,5,0,NULL,'2013-02-07 16:00:00','',2),(87696,9,2013,1,0,8,'高红军','外事办公室党支部召开支委会研究部署春节前开展安全教育工作',7,0,3,0,NULL,'2013-02-05 16:00:00','',2),(87715,9,2013,1,0,9,'高红军','外事办公室党支部组织开展“五条禁令”要牢记的党日活动',7,0,3,0,NULL,'2013-02-06 16:00:00','党日活动',2),(87784,10,2013,1,0,8,'胡蓉','学习习近平总书记在京视察亲切看望慰问首都公安民警时的重要讲话精神',3,0,3,0,NULL,'2013-02-08 16:00:00','',2),(88387,6,2013,1,0,9,'刘东','学习市局有关会议精神，对节日期间纪律提要求',20,0,3,0,NULL,'2013-02-18 16:00:00','综合处召开节前纪律教育会',2),(88518,4,2013,1,0,8,'王锦','部署春节前安全教育工作',9,0,3,0,NULL,'2013-02-07 16:00:00','',2),(88856,7,2013,1,0,8,'杨志刚','研究近期工作和两会安保',10,0,3,0,NULL,'2013-02-16 16:00:00','',2),(88861,5,2013,1,0,8,'徐暖保','研究年度公务员考核等工作',5,0,3,0,NULL,'2013-02-18 16:00:00','',2),(88862,5,2013,1,0,6,'徐暖保','研究2013年工作要点、领导班子述职述德述廉等工作',23,0,3,0,NULL,'2013-02-03 16:00:00','',0),(88982,6,2013,1,0,5,'刘东','综合处党支部开展主题党课教育活动',20,0,3,0,NULL,'2013-02-20 16:00:00','',0),(89001,6,2013,1,0,7,'刘东','综合处召开以“学习贯彻党的十八大精神，进一步改进工作作风”为主题的民主生活会',6,0,3,0,NULL,'2013-02-20 16:00:00','',0),(89283,7,2013,1,0,6,'杨志刚','学习文件精神',34,0,3,0,NULL,'2013-01-31 16:00:00','',0),(89287,7,2013,1,0,6,'杨志刚','节前安全教育',34,0,3,0,NULL,'2013-02-07 16:00:00','',0),(90043,5,2013,1,0,5,'徐暖保','如何贯彻做强将、带精兵、打造过硬队伍要求，大力加强学习型队伍建设',23,0,3,0,NULL,'2013-02-21 16:00:00','',0);
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
INSERT INTO `pc_meeting_asence` VALUES (34093,80660,'无'),(34473,81577,'0'),(35962,85210,'无'),(37326,88856,'无'),(37473,89283,'无'),(37474,89287,'无');
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
INSERT INTO `pc_meeting_content` VALUES (235550,80528,1,0,'刘保齐','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         1月5日上午，办公室秘书处召开支委会，深入学习《中共北京市公安局委员会贯彻落实中央和北京市委市政府关于改进工作作风密切联系群众有关精神的实施意见》（以下称《实施意见》）。秘书处党支部全体成员参加了会议。会议由办公室副主任、秘书处党支部书记、处长李广岐主持。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         会上，与会人员全文学习了《实施意见》，并分别结合工作实际，就如何贯彻落实市局党委和办公室党委的工作部署，进一步改进工作作风，密切联系群众进行了深入讨论。大家一致认为，《实施意见》贴合我局工作实际，是贯彻中央精神，杜绝形式主义，厉行勤俭节约，发扬优良传统的有力武器，充分体现了市局党委求真务实的工作态度和密切联系群众的工作作风，对推进首都公安事业创新发展具有十分重要的意义。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        办公室副主任、秘书处党支部书记、处长李广岐就秘书处如何学习贯彻落实《实施意见》提出了具体要求：一是充分认识《实施意见》的重要意义。中央出台的《关于改进工作作风、密切联系群众八项规定》及其《实施细则》，是以习近平同志为总书记的新一届党中央站在战略和全局的高度做出的重大决策部署，充分体现了新一届中央领导结构强烈的使命感和责任感、强烈的忧患意识和清醒的政治意识。为贯彻落实中央规定和市委、市政府相关实施意见，市局党委结合我局实际，及时研究制定了《实施意见》。《实施意见》中的很多措施与秘书处工作息息相关，全体民警特别是各级领导干部要充分认识学习贯彻落实《实施意见》的重要意义，深刻领会精神内涵。 二是认真学习贯彻《实施意见》。在党支部集中组织学习的基础上，各党小组、各科室要组织全体民警认真学习《实施意见》。全体民警要深入理解并熟练掌握《实施意见》的具体要求。各科室要结合工作实际，进一步细化相关工作实施细则。工作中，要严格执行《实施意见》各项规定，不折不扣的完成市局党委的部署要求。同时，要及时掌握《实施意见》执行过程中出现的各种情况和问题，加强各种情况信息的收集整理。要严格按照市局党委的的部署要求，进一步改进工作作风、密切联系群众，切实提高办文、办会、办事和“三服务”工作水平。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  </FONT></P></TEXTFORMAT>','2013-01-08 07:38:12'),(235712,80607,1,0,'高廷海','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">1月8日下午，综合处处组织召开支委会，以深入学习、贯彻党的十八大精神与本职工作相结合，研究讨论综合处贯彻落实党的十八大会议精神学习意见。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">会上，支部委员分别结合实际工作谈了自己学习十八大精神的体会，随后按照综合处处队伍特点及工作实际，就建设中国特色社会主义道路、科学发展观和廉洁自律三项内容，认真研究了综合处贯彻落实十八大会议精神意见。决定采取集中学习、个人自学，分组讨论，主题党日等多种形式组织开展活动，并进一步明确了责任分工。综合处党支部书记刘东同志，对全处贯彻落实十八大文件精神工作提出三点要求：一是要高度重视。做好宣传发动工作，使民警充分认识学习贯彻党的十八大精神的重要意义，确保学习的主动性和积极性。二是要严格落实。各支部委员要进一步细化各项学习计划，抓好各党小组的学习工作。三是要强化实效。将十八大精神切实融入到实际工作中去，多干实事，全力做好全局各种文字材料撰写工作。</FONT></P></TEXTFORMAT>','2013-01-09 03:07:34'),(236217,80660,1,0,'罗瑛','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         <FONT SIZE=\"16\"> 1月9日上午，信访处召开支部委员会，研究2013年党建工作和讨论研提办公室党委及班子成员意见。会议由支部书记杨志刚同志主持。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        首先，传达了办公室党委关于开好两级班子民主生活会，贯彻十八大精神的意见，并向全体支委和党员征求意见。全体支委经充分讨论，发表个人意见，最后形成三条意见：一是希望多到基层一线了解工作，从领导层面予以支持。二是希望加大对干部和民警的岗位交流力度。三是希望在爱警方面，加大力度，特别是对信访一线采取有针对性的措施，比如开展心理咨询减压服务等。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        第二项议题是研究2013年支部工作计划，经充分讨论，形成意见。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        第三项议题是研究第一季度工作计划，经充分讨论，形成意见。</FONT></P></TEXTFORMAT>','2013-01-09 07:51:08'),(236380,80736,1,0,'臧德国','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">外事办公室党支部召开支委会</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">结合中央八项规定研究部署近期工作</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	1月8日，新年伊始第一个工作日上午，党支部书记高红军同志在104办公室，主持召开外事办2013年第一次支委会，结合中央八项规定，研究、部署近期工作并提出工作要求，外事办相关人员参加了会议。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	会上，与会人员首先学习了中央八项规定，大家边学边议，结合一月份将要开展的两项大的工作、具体实际情况，重点就2013年北京市公安局与部分驻华使馆警务联络官安全官新春联谊活动各项筹备工作进行了再明确、再落实；深入讨论并初步确定了“加强警务合作，共建平安首都”国际警务会议拟举办时间、参会范围及人数、邀会方式等相关事宜，同时对各项工作进行了具体分工部署。会议筹备工作紧紧围绕勤俭节约、务实高效的原则规划、设计、运作，突破以往的条条框框，新年伊始，充分展示我们的工作状态和面貌，支部要充分发挥引领、带头作用，务必打好新年开局之仗。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	最后，高红军副主任强调：一是要统筹推进，周密规划近期及全年各项外事工作；二是要认真细致，妥善落实各项活动组织事宜；三是要注重协调，加强与公安部、市政府相关部门以及局属相关单位的沟通、配合，科学形成工作合力。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	                                                                                                                                                                                                                      2013年1月8日</FONT></P></TEXTFORMAT>','2013-01-10 01:49:19'),(238778,81673,1,0,'李明','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">    2013年1月4日，政治处以“坚守道德底线，提升党性修养”为主题召开党员大会。会上，政治处主任王锦组织全体民警学习了“坚守道德底线，提升党性修养”专项教育整顿活动方案，结合市局警示教育内参片《“畸情”的代价---北京市公安局违反社会主义道德案件纪实》体会展开讨论。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">    大家一致表示，纪委下发的警示教育片中种种违法违纪现象触目惊心，以前的警示教育片大多是违反法纪法规、工作失误一类，这次以失守道德底线为主题的教育片对自己触动很大，我们都拥有满意的工作、和谐的家庭，应当珍惜现有的工作生活，汲取教训，在面对诱惑时一定要筑牢道德防线，杜绝违法违纪违反道德底线的情况发生。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">    王锦主任提出了工作要求：一是要深入贯彻落实十八大精神、提升党员领导干部和全体民警的党性修养和道德素质，充分认识开展此次教育整顿活动的重要意义。二是要以打造最廉洁警队为导向，做遵纪守法、遵守道德的楷模；三是要汲取教训，市局纪委下发的警示教育片中种种违法违纪现象触目惊心，令人警醒，进一步加强“8小时”外的监督管理，防止发生违法违纪的问题。<FONT KERNING=\"0\"></FONT></FONT></P></TEXTFORMAT>','2013-01-16 08:41:04'),(238543,81577,1,0,'高廷海','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">2013年1月11日，我处召开“坚守道德底线，提升党性修养”专项教育整顿活动部署会，处党支部书记刘东同志主持。会上，处领导组织全体民警学习了办公室下发的“坚守道德底线，提升党性修养”专项教育整顿活动方案，党支部书记刘东同志，结合市局警示教育内参片《“畸情”的代价---北京市公安局违反社会主义道德案件纪实》，对专项教育活动进行了部署并提出了工作要求：一是要正确认识，努力打造最廉洁警队。要从深入贯彻落实十八大精神、提升党员领导干部和全体民警党性修养和道德素质、实现“两最”警务战略目标的政治高度，充分认识开展此次教育整顿活动的重要意义，落实责任，抓好落实。二是要汲取教训，提升坚守道德的主动意识。市局纪委下发的警示教育片中种种违法违纪现象触目惊心，令人警醒，领导干部要充分认识到“家”和“单位”是民警的两个重要的“停靠站”，进一步加强对民警8小时外的监督管理，防止发生违法违纪的问题。今后，凡党员领导干部、民警的婚姻状况发生变化的，要作为一个重大事项，及时向组织报告；三是要创新思路，做活自选动作。要结合队伍现状和工作实际，以专项教育整顿活动作为“抓手”，用微型党课开路，不拘泥于形式，不走过场，务实推进活动的开展，以取得教育整顿的最佳效果。</FONT></P></TEXTFORMAT>','2013-01-16 03:22:59'),(238831,80528,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">好，进一步改进工作作风、密切联系群众，切实提高办文、办会、办事和“三服务”工作水平。</FONT></P></TEXTFORMAT>','2013-01-17 01:37:22'),(238832,80528,4,0,'办公室党委','1','2013-01-17 01:37:22'),(238839,80607,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">充分认识学习贯彻党的十八大精神的重要意义，进一步细化各项学习计划，切实融入到实际工作中去。</FONT></P></TEXTFORMAT>','2013-01-17 01:40:31'),(238840,80607,4,0,'办公室党委','1','2013-01-17 01:40:31'),(238852,80736,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">好，会议密切结合<FONT KERNING=\"1\">中央八项规定</FONT>，研究实际工作<FONT KERNING=\"1\">，科学形成工作合力。</FONT></FONT></P></TEXTFORMAT>','2013-01-17 01:43:08'),(238853,80736,4,0,'办公室党委','1','2013-01-17 01:43:08'),(238862,80660,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">会议召开及时，内容有针对性。</FONT></P></TEXTFORMAT>','2013-01-17 01:44:24'),(238863,80660,4,0,'办公室党委','1','2013-01-17 01:44:24'),(238876,81577,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">“坚守道德底线，提升党性修养”<FONT KERNING=\"0\">专项教育活动的开展，对</FONT>贯彻落实十八大精神、提升党员领导干部和全体民警党性修养和道德素质、打造最廉洁警队、实现“两最”警务战略目标有重要意义。</FONT></P></TEXTFORMAT>','2013-01-17 01:48:32'),(238877,81577,4,0,'办公室党委','1','2013-01-17 01:48:32'),(238904,81673,2,0,'政治处','支部反映填写有误','2013-01-24 01:56:09'),(240849,82589,1,0,'刘保齐','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        1月11日下午，办公室秘书处党支部召开全体党员大会，深入学习习近平总书记近期重要讲话精神及《人民日报》刊载文章《信仰的味道》。秘书处党支部全体党员参加了会议。会议由办公室副主任、秘书处党支部书记、处长李广岐主持。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        会上，全体党员认真学习了习近平总书记近期重要讲话精神及《人民日报》刊载文章《信仰的味道》，并就如何贯彻党的十八大和习近平总书记重要指示精神，落实市局党委和办公室党委的工作部署，进一步加强秘书处提高执法能力、增强人民群众安全感和满意度进行了深入讨论。大家一致认为贯彻落实党的十八大和习近平总书记重要讲话精神是新时期政法机关全力推进平安中国、法治中国、过硬队伍建设，深化司法体制机制改革， 坚持从严治警，反对执法不公、司法腐败，进一步提高执法能力，增强人民群众安全感和满意度，进一步提高政法工作亲和力和公信力。对推进首都公安事业创新发展具有十分重要的意义。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        办公室副主任、秘书处党支部书记、处长李广岐就进一步学习习近平总书记重要讲话精神提出了具体要求：一是强调学习贯彻党的十八大和习近平总书记重要讲话精神的重要意义。全国政法工作电视电话会议要求，当前和今后一个时期政法机关要深入学习贯彻党的十八大和习近平总书记重要指示精神，坚持以推动社会主义司法制度自我完善和发展为方向，以解决群众反映的突出执法司法问题为重点，进一步深化司法改革，努力建设公正高效权威的社会主义司法制度，不断提升执法司法公信力。市局党委和办公室党委按照全国政法工作会议精神及时开展学习贯彻活动，要求传达贯彻到每名民警，认真学习领会习近平总书记讲话精神的实质，全面贯彻落实。二是认真学习领会精神实质，进一步提高执法能力。中共中央政治局委员、中央政法委书记孟建柱在全国政法工作会议强调，要把促进全社会学法尊法守法用法作为重要目标，深化法制宣传教育，弘扬法治精神、塑造法治文化，努力形成尊重法律、崇尚法治的良好氛围。办公室秘书处工作虽不参加一线执法，但要注重对法律的学习和运用。严格依法履行职责、行使职权，肩负起社会主义法治国家建设者、实践者的重任。三是按照市局和办公室党委工作部署，深入开展“坚守道德底线，提升党性修养”专项教育整顿活动。为落实市局党委“深入开展道德领域突出问题专项教育和治理”工作部署，办公室集中开展“坚守道德底线，提升党性修养”专项教育整顿活动。秘书处全体党员民警要结合观看《“畸情”的代价》 警示教育片，牢固树立正确的世界观、人生观、权力观事业观。各党小组要组织讨论，认真剖析、整改队伍存在的突出问题，确保教育活动不搞花架子、避免形式主义，务实推进教育活动开展，确保实效。</FONT></P></TEXTFORMAT>','2013-01-21 02:19:08'),(242100,82930,1,0,'李险峰','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"宋体\" SIZE=\"20\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">2013年1月国际警务联络处</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"宋体\" SIZE=\"20\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">党支部支委会情况<FONT FACE=\"ArialBlack\" SIZE=\"12\"></FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      <FONT SIZE=\"16\">  <FONT FACE=\"宋体\">2013年1月10日，我处收到市局办公室《关于做好纳入办公室先进典型信息库人员推荐工作的通知》。国际警务联络处支部领导高度重视，立即召开了支委会，专门研究落实该项工作。在对《通知》进行深入领会后，支委会成员对照通知的标准对全处干警进行了考察测评，经民主推选，确定李险峰同志符合办公室党委要求，作为我处典型推荐上报，并在全处党员大会上予以通报。</FONT></FONT></FONT></P></TEXTFORMAT>','2013-01-22 02:11:47'),(243936,83507,1,0,'孙威毅','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    1月17日上午，研究室党支部召开支委会，对春节期间爱警工作、先进典型申报、慰问老干部、强化民警道德底线教育等工作进行了研究。要求支委成员充分发挥作用，认真做好近期支部工作。</FONT></P></TEXTFORMAT>','2013-01-23 08:28:18'),(245687,84273,1,0,'高廷海','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">1月24日上午，办公室第一党支部召开全体会议，学习习近平总书记就做好新形势下的政法工作作出重要指示、总书记在广东考察时的讲话精神及关于厉行勤俭节约反对铺张浪费重要批示等，办公室第一党支部书记王守江同志，就如何贯彻习总书记讲话精神和市局党委扩大会议精神进行了部署。会后，办公室综合处党小组迅速召开会议，就贯彻上述会议精神进行了专题讨论。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">会上，党小组成员结合学习习近平总书记近期的一系列讲话精神和市局党委扩大会议精神的体会进行了交流，大家纷纷表示，要认真学习和落实习总书记的讲话精神，深入领会其内容和精神实质，进一步加强自身思想建设，严守道德底线，切实转变工作作风。在谈到学习贯彻好市局党委扩大会议精神时，大家一致认为。市局党委扩大会议提出的“建设最安全城市、打造最廉洁警队”的目标，是贯彻十八大精神的体现，是和中央提出的建设“平安中国、法制中国”合拍的，我们要集中精力做好当前和今后一个时期的工作，紧紧围绕“两最”的工作目标，结合综合处工作实际，全力做好各项工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">最后，综合处党支部书记刘东同志就贯彻学习习总书记讲话精神和市局党委扩大会议精神强调指出：一是要坚定理想信念，保持奋发有为的精神状态。作为党员领导干部，要始终和党中央保持一致，自觉抵制不同声音，做忠实履行中国特色社会主义道路的捍卫者。二是切实转变工作作风。作为市局参谋中枢机构，在文字材料、统计分析工作中，创新工作思维，要切实转变作风，切记空话、套话，提高文件办理质量，规范文件程序。三是紧密围绕市局党委会“两最”工作目标，认真研究制定工作措施。四是要切实加强党风廉政建设，中央办公厅、市委办公厅和市政府办公厅就厉行勤俭节约反对铺张浪费提出了明确要求，做出了具体的规定，领导干部必须带头执行，中国的传统节日春节就要到了，领导干部要注意节日廉政，管住手、管住嘴。五是发扬勤俭节约的优良传统。在日常工作中，从点滴做起，从小事做起。</FONT></P></TEXTFORMAT>','2013-01-25 07:14:02'),(245919,84379,1,0,'孙威毅','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">     2月20日，研究室召开全体党员大会，组织开展年度公务员考核工作。会上，组织全体民警对年度公务员考核、非领导职务晋升等工作进行了评分。</FONT></P></TEXTFORMAT>','2013-01-25 09:15:41'),(247703,85132,1,0,'高廷海','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">1月25日上午，办公室综合处党支部召开大会，处领导组织全体党员民警学习习近平总书记就做好新形势下的政法工作作出重要指示、总书记在广东考察时的讲话精神及关于厉行勤俭节约反对铺张浪费重要批示和市局党委扩大会议精神。综合处党支部书记刘东同志就贯彻学习习总书记讲话精神和市局党委扩大会议精神强调指出：一是要坚定理想信念，保持奋发有为的精神状态。作为党员领导干部，要始终和党中央保持一致，自觉抵制不同声音，做忠实履行中国特色社会主义道路的捍卫者。二是切实转变工作作风。作为市局参谋中枢机构，在文字材料、统计分析工作中，创新工作思维，要切实转变作风，切记空话、套话，提高文件办理质量，规范文件程序。三是紧密围绕市局党委会“两最”工作目标，认真研究制定工作措施。四是要切实加强党风廉政建设，中央办公厅、市委办公厅和市政府办公厅就厉行勤俭节约反对铺张浪费提出了明确要求，做出了具体的规定，领导干部必须带头执行，中国的传统节日春节就要到了，领导干部要注意节日廉政，管住手、管住嘴。五是发扬勤俭节约的优良传统。在日常工作中，从点滴做起，从小事做起。</FONT></P></TEXTFORMAT>','2013-01-28 06:42:47'),(247707,85136,1,0,'臧德国','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">		</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"18\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">外事办公室党支部组织开展读书学习党日活动<FONT SIZE=\"16\"></FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	近期，刊发了习总书记一系列重要讲话和重要批示,为了使本室全体党员，能够很好的学习、领会中央领导的讲话和批示精神，1月25日下午，外事办公室党支部按照高红军书记的指示要求，组织本室全体党员以读书学习的形式学习中央领导重要讲话和批示精神。活动由高红军同志主持。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	会上，高红军书记首先提要求，习总书记一系列重要讲话和重要批示，主题鲜明地回答了我们党举什么旗、走什么路、保持什么样的精神状态、朝着什么样的目标继续前进的重大问题，我们要认真学习、认真讨论，深入领会批示的内容和精神实质，把学习和贯彻落实落到实处。其次，通读了习总书记就做好新形势下政法工作作出的重要批示、在广东考察时的讲话精神、在新进中央委员会的委员、候补委员学习贯彻党的十八大精神研讨班上的讲话精神、关于厉行勤俭节约反对铺张浪费重要批示等文件。随后，大家在认真学习的基础上，进行了座谈讨论，大家认为：党的十八大胜利召开以后，学习、宣传、贯彻十八大，是当前和今后一段时期最大的政治任务，我们要旗帜鲜明地高举旗帜，毫不动摇坚持和发展中国特色社会主义，坚持以科学发展观为指导，不断深化改革开放，锐意进取，实践创新，坚决抵制和反对与党中央不一致的声音，努力转变工作作风，勤于思考，少说多干，为党和人民多做有益的事，自觉抵制不正之风，反对铺张浪费，从自己做起，把牢思想防线，守住最低底线，自觉抵御不良侵袭，永葆纯洁。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	  </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">                                                                                                                                                                                                                                                                      <FONT SIZE=\"12\">  </FONT>        </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">                                                                                                                                                   2013年1月28日   </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	<FONT SIZE=\"12\"></FONT></FONT></P></TEXTFORMAT>','2013-01-28 06:44:41'),(247851,85210,1,0,'罗瑛','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        为深入贯彻落实市局2013年第一次党委扩大会议精神，按照办公室党委部署要求，信访处于1月24日上午组织召开了支部会议。办公室副主任王冬斌、信访处班子成员参加了会议。会议由信访处党支部书记、处长杨志刚主持。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        会上，支部成员均围绕如何立足本职岗位，深入学习贯彻党的十八大以及市局2013年第一次党委扩大会议精神，结合廉政教育谈了自己的体会，发表了自己的看法。杨志刚处长指出：要深入贯彻落实党的十八大精神，找准当前和今后一个时期首都公安信访工作的努力方向，创新制度，创新举措，为“建设最安全城市，打造最廉洁警队”贡献力量。一要统筹规划，集思广益，加快制定2013年全局信访工作要点，为全局信访工作指明方向；二要围绕信访工作法制化来开展工作，重点关注《刑事诉讼法》修改实施后信访问题的新变化，以及法治化趋势下信访部门的职能定位、管理体制、运作程序等，切实增强运用法治思维和法治方式做信访工作的能力；三要从涉法涉诉信访积案化解入手，紧密结合信访群众需求，创新举措和方法，下大力气化解信访积案；四是大力加强队伍建设。一方面要加强党风廉政建设，领导干部既要管好自己，又要带好队伍，要在处里设定“高压线”，碰触“高压线”者必定追究责任，促使处领导及民警都能遵纪守法；另一方面，要推树典型，进一步完善激励机制，提高队伍凝聚力与战斗力。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        最后，王冬斌副主任指出，要深入领会市局党委扩大会议精神，会后，要整理相关材料在全处传阅，确保每名同志都能深入领会、学习贯彻市局党委扩大会精神，结合廉政教育，努力做好自己的本职工作，更好地为市局党委服务、为人民群众服务。另外，年前要组织对困难民警及家属进行慰问，确保将市局党委和办公室党委的关怀和问候送到，使民警及家属感受到党组织的温暖，不断鼓足干劲，再创佳绩。<FONT SIZE=\"12\"></FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT>','2013-01-28 07:22:38'),(248430,85434,1,0,'李明','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        1月24日，办公室政治处召开会议，学习市局2013年第一次党委扩大会议精神，紧密围绕“建设最安全城市、打造最廉洁警队”的目标，结合工作实际，研究探讨今年工作思路，切实将思想认识统一到市局党委和办公室党委的决策部署上来，扎实做好2013年各项工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        与会人员全文学习了习近平总书记对政法工作的重要指示、习近平总书记在中纪委二次全会上的讲话精神，全国政法工作会议、全国公安厅局长会议、北京市政法工作会议精神，以及傅政华局长代表市局党委所做的工作报告。随后，同志们紧密围绕会议主题，结合实际工作，展开专题讨论。最后，王锦主任就如何深入学习贯彻市局党委扩大会议精神提出了要求：一是要把学习贯彻党的十八精神和习近平总书记近期重要讲话指示精神作为当前和今后一个时期的重要政治任务，切实把思想统一到中央、市委、公安部、市局党委各项部署要求上来。二是要认真贯彻主动实践“两最”工作目标，坚定信心，认真查找差距，始终保持清醒头脑，紧密结合工作实际，以可能达到的最高标准完成工作。三是继续大力加强党建队建工作。始终坚持“党建是核心、队建是根本”的政治理念，以首都公安“三大支柱”为统领，切实增强党员意识、危机意识、群众意识，充分发挥支部的战斗堡垒作用和党员的先锋模范作用，树立和维护好党的威信，做好各项群众工作，深入推进党风廉政和反腐败建设，遵纪守规，守住底线，确保不发生问题。 </FONT></P></TEXTFORMAT>','2013-01-29 01:26:26'),(249372,85736,1,0,'杨雅佳','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	1月28日，新闻办党支部召开2013年第一次支委会，一是学习习近平总书记近期重要指示精神，二是研究如何继续深入学习贯彻市局第一次党委扩大会议精神，围绕实现“建设最安全城市，打造最廉洁警队”目标，抓好支部的党建和队建工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	为进一步推进新闻办党建队建和公安工作的科学发展，党支部组织支部成员学习了习近平总书记近期重要指示精神。习近平同志指出：“政法机关在保障人民安居乐业、服务经济社会发展、维护国家安全和社会稳定中具有十分重要的作用。希望同志们全面贯彻落实党的十八大精神，坚持依法治国基本方略，以党和国家工作大局为重，以最广大人民利益为念，切实担负起中国特色社会主义事业的建设者、捍卫者的职责使命，要顺应人民群众对公共安全、司法公正、权益保障的新期待，全力推进平安中国、法治中国、过硬队伍建设，深化司法体制机制改革，坚持从严治警，坚决反对执法不公、司法腐败，进一步提高执法能力，进一步增强人民群众安全感满意度，进一步提高政法工作亲和力和公信力，努力让人民群众在每一个司法案件当中都能感受到公平正义，保证中国特色社会主义事业在和谐稳定的社会环境中顺利推进”。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	习近平同志在《国内动态清样》上的批示中指出：从文章反映的情况看，餐饮环节上浪费现象触目惊心。广大干部群众对餐饮浪费等各种浪费行为反映强烈。浪费之风必须狠刹车！要加大宣传引导力度，各级党政军机关、事业单位、各级领导干部，都要率先垂范，坚决杜绝公款浪费现象。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	学习后支部全体成员一致认为，总书记的重要批示，是当前和今后一个时期的政法工作，特别是首都公安工作的重要行动纲领，是我们筹划2013年全年工作的重要指南，要认真学习，着重从以下几个方面去体会把握：一是要始终牢记“依法治国”的基本方略；二是要“以党和国家的大局为重”，三是要“以最广大人民利益为念”，坚持人民利益高于一切，也就是要积极践行市局党委提出的“民意主导”理念；四是要“切实担负起中国特色社会主义事业的建设者、捍卫者的职责使命”。五是要从树立维护党和政府形象，首都公安机关和人民警察形象的高度，重视和做好厉行节约、反对浪费工作，对此五个要点，在工作中要始终牢记。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	结合新闻办2013年的各项工作，党支部工作重点要继续以加强党建工作为主要抓手，继续坚持“党建是核心，队建是根本”的政治理念，坚持“抓党建、带队建、促发展”的工作思路，这样才能真正为实现“平安中国”的建设，实现北京“两最”目标开好局、起好步。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	齐心协力、真抓实干，切实做好支部的党建工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    新闻办党支部要始终坚持把党建作为核心，队建作为根本。把抓好支部党建工作作为贯彻十八精神的实际行动。特别是面对当前新形势、新任务，新闻办党支部将以抓党建为核心目标，为我局“建设最安全城市，打造最廉洁警队”工作目标的实现做最大的贡献。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	二、充分发挥基层党组织的旗帜、先锋和战斗堡垒作用，为实现“两最”目标而奋斗。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    党的十八大报告提出“党的基层组织是团结带领群众贯彻党的理论和路线方针政策、落实党的任务的战斗堡垒”，同时明确要求“牢牢把握加强党的执政能力建设、先进性和纯洁性建设这条主线”，这为我们支部党建工作指明了方向。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	我们要以首都公安“三大支柱”特别是人民警察核心价值观做为对党员干部和民警思想教育的重要内容，进一步强化对队伍的教育管理。同时要努力提高自身的管理能力和管理水平，支部成员在各项工作中要率先垂范,同时还要加大对全体党员民警思想、工作和生活情况的摸排力度，及时掌握第一手的真实情况，及时消除问题苗头；同时支部尽最大力量为党员民警解决问题和困难，把爱警工作抓实抓好。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	三，多策并举，努力提升队伍的整体素质和能力。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	要通过学习教育，不断增强全体党员的政治意识和党性意识，以提高专业化、职业化、正规化水平为重点，继续巩固和发展首都公安新闻宣传二条主线、四个阵地，通过不断完善电视新闻值守、值班制度等工作制度，不断提升新闻办队伍的业务素质和工作能力，着力打造一支忠诚可靠、执法为民、务实进取、公正廉洁的高素质的首都人民警察队伍。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	把中央厉行勤俭节约，反对铺张浪费的要求落到实处。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    要教育党员民警从坚持党的执政为民理念、维护首都人民警察形象、弘扬中华民族优良传统的高度，深刻认识厉行勤俭节约，反对铺张浪费的重要意义。支部带头，从我做起，从现在做起，单位不用公款搞走访、送礼、宴请、旅游等活动，党员民警在食堂用餐按需取量，办公用品节约使用，严禁浪费。</FONT></P></TEXTFORMAT>','2013-01-29 09:32:29'),(259881,88982,1,0,'高廷海','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">为了深入贯彻“坚守道德底线，提升党性修养”专项教育整顿活动要求,进一步提高广大党员的思想道德水平，按照办公室党委工作要求，综合处党支部于2013年2月18日下午举办专题微型党课，对全体党员民警进行了党性修养教育。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">首先，刘东书记首先从道德规范的重要意义、人的社会角色要求等方面深入阐述了加强党员干部道德作风建设的重要性。随后，深入分析了导致党员干部腐败的背后原因，最后，要求全体党员干部、民警应当自觉地以提高自身品德修养为起点，树立正确的人生观、世界观、价值观，实现内在自我和外部环境的和谐统一，胜任自己的家庭角色、职业角色和社会角色，更好地履行党员责任和义务。要常存“慎独、慎思、慎微、慎初、慎终”的“五慎”之心，做到自重、自省、自警、自励，牢记宗旨，永葆本色。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">最后，刘东书记提出了四点要求：一是努力学习道德知识和科学文化知识，真正理解道德规范的深刻含义，并使之成为指导具体行为的准则。二是重视“内省”，经常对照道德标准在内心省察自己的言行，坚持正确的道德行为并促进习惯养成。三是立足当前，循序渐进，从点滴小事做起，勿以恶小而为之，日积月累，持之以恒。四是提高对“慎独”的认识，时刻按照党员标准和道德规范严格要求自己，筑牢道德防线，永葆共产党员的纯洁性和先进性，为党的发展和公安工作作出更大的贡献！</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">党支部全体党员民警纷纷表示：要带头自觉执行纪律规定，对照“生活正派、情趣健康，讲操守、重品行”的标准，坚持以德修身，自觉遵守职业道德、家庭美德、社会公德，始终保持共产党员的先进性和纯洁性。</FONT></P></TEXTFORMAT>','2013-02-21 02:01:25'),(255050,87134,1,0,'高廷海','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">为贯彻落实市局和办公室党委关于做好春节安全保卫工作的有关通知精神，办公室综合处党支部及时召开会议，认真组织学习有关通知精神，并就如何做好春节及节日爱警工作进行了研究。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">会议由综合处党支部书记刘东同志主持，各位支部委员就春节前分管工作进行了汇报，大家一致认为，我处作为全局文字材料起草部门，春节前各种会议较多，需要准备的文字材料很多，要对全处民警进行一次动员部署，发扬连续作战的作风，全力完成好领导交办的各项任务。同时，认真落实市局和办公室爱警工作要求，节前党支部要对一年来，默默工作，无私奉献的民警和家属进行慰问，鼓舞士气。</FONT></P></TEXTFORMAT>','2013-02-08 01:42:44'),(256497,87696,1,0,'臧德国','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">外事办公室党支部召开支委会</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">研究部署春节前开展安全教育工作</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	春节临近，为了进一步强化民警春节前教育工作，确保民警度过一个安全祥和的新年，2月6日下午，党支部召开支委会，研究部署组织开展对民警政治思想教育暨春节前教育会相关工作。会议由支部书记高红军同志主持。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	外事办公室主任高红军首先传达了傅政华书记《致局属各单位领导班子成员的一封信》的精神，总结了近一时期外事队伍建设情况，着重点评了近期内务安全、节前思想作风等方面的成绩与不足，并明确提出，领导班子成员要起到表率作用，加强廉洁自律，严守党风党纪，奉公守法，厉行节约，带领全体民警守住“廉关”，过好“年关”。随后，高红军主任就春节期间外事办公室内部安全工作提出了几点工作要求：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	一是要增强贯彻“五条禁令”的责任意识，重温“五条禁令”、《公安机关人民警察内务条令》和相关公安工作纪律规定的深刻含义，切实把各项纪律规定贯穿于日常工作中，切实增强安全意识和责任意识，防止发生违法违纪问题，做到牢记“五条禁令”，确保警钟长鸣。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	二是加强各项安全措施，特别是要做好办公室内部各种电器的安全检查，做到无人时电源切断、关灯锁门，消除各种安全隐患。同时，要加强保密安全检查工作，妥善保管各类涉密和内部文件，并对联入公安专网的计算机进行认真自查，坚决杜绝“一机两用”及违规外联问题的发生。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	三是严格车辆管理。车管干部要在节前对所有车辆进行全面检查，严格落实公务用车出车审批制度，严禁公车私用。民警在驾驶私家车辆时也要加强安全意识，杜绝各类违纪问题发生。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	四是严格值班和请销假制度。认真落实领导带班制度，值班人员要坚守岗位，严格履行职责任务，加强请示报告。凡节日期间离京外出民警，要严格履行请假报告手续。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	                         </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	                                                                                                                                                                                                       外事办公室</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	                                                                                                                                                                                                     2013年2月6日</FONT></P></TEXTFORMAT>','2013-02-17 07:10:29'),(256519,87715,1,0,'臧德国','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">外事办公室党支部组织开展</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">“五条禁令”要牢记的党日活动</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	2月6日下午，办公室召开了2013年第三次党委会，会上专门传达了公安部贯彻“五条禁令”电视电话会议精神和市局相关通知要求。2月7日下午，外事办公室党支部以座谈会的形式，组织开展“五条禁令”要牢记的党日活动。活动由党支部书记高红军同志主持。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	会上，办公室副主任、外事办公室主任高红军首先传达了办公室党委会精神和《公安部贯彻“五条禁令”电视电话精神》、《关于进一步加强公务车管理严禁公车私用的通知》、《关于认真做好春节期间内部交通安全工作的通知》等文件。接着，高红军主任提出了四点工作要求：一是严格贯彻“五条禁令”，消除麻痹大意、侥幸松懈等思想，坚决做到“开车不饮酒、饮酒不开车”。二是严格落实监督检查制度，节前统一签订《“五条禁令”责任书》，并向民警发放了《致民警家属的一封信》，切实做到营造监督氛围，加强领导检查，强化自我约束，杜绝违法违纪。三是严格按照内部交通规章制度和外事办公室内务规定使用公车，履行行车登记制度，规范公车管理，春节期间非公务不得使用公车。四是春节前对全室车辆进行彻底检查和卫生清洁，对“问题”车及时进行维护，其他车辆做好冬季保养，消除潜在隐患。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	随后，大家对照学习内容和高主任提出的工作要求，结合自身实际，畅谈自己感想和体会，纷纷表示，要严格遵守“五条禁令”，杜绝酒后驾驶公车或私车；严格遵守交通法规，安全驾驶，文明驾驶，杜绝违法行驶、特权行驶的现象发生；严格按照内部交通规章制度和外事办公室内务规定使用公车，履行行车登记制度，杜绝公车私用。会后，外事办全体党员民警签订了《“五条禁令”责任书》。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	                                                                                                                                                                                            外事办公室党支部</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">                                                                                                                                                                                                   2013年2月7日</FONT></P></TEXTFORMAT>','2013-02-17 08:45:52'),(256614,87784,1,0,'杨雅佳','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	2月9日上午，市局召开电视电话会议，全面传达学习习近平总书记在京视察亲切看望慰问首都公安民警时的重要讲话精神，对下一步学习贯彻工作进行了动员部署。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	市局电视电话会议结束后，新闻办党支部书记胡蓉立即召开支委会组织进行再学习、再讨论，并要求各支委采取多种途径第一时间将习总书记讲话精神传达到新闻办的每一名同志。针对正值假期，部分同志已离京的情况，支部通过打电话传达的方式将习近平总书记慰问首都公安民警时的重要讲话精神，以及节日期间带头不燃放烟花爆竹和其它纪律要求等内容逐一传达到每一位民警和文职人员，要求大家及时收看新闻报道，认真学习领会。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	一、高度重视，做好学习贯彻组织工作</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	为确保活动取得实效，针对此次学习贯彻活动，新闻办党支部确定了由各科科长为具体责任人负责督导检查工作，做到了民警人人学习、人人知晓，确保学习贯彻活动不留死角，切实把大家的思想和行动统一到总书记的重要讲话精神上来，把智慧和力量凝聚到总书记对首都公安工作提出的要求和希望上来。通过学习，广大民警纷纷表示：习总书记节前深入一线，看望慰问民警，充分体现了党中央对公安工作的重视，一定要深刻领会总书记的讲话精神，牢记重托、不辱使命，要进一步强化落实各项措施，立足本职、忠于职守，圆满完成两会和全年的首都公安新闻宣传工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	二、学以致用，强化节日期间新闻宣传工作</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	按照市局领导关于“牵动全局全力做好春节安保新闻宣传工作，突出反映一线民警工作状态”的工作要求，新闻办全体党员坚守岗位，忠诚履职，全面加强正面宣传报道，以实际行动落实习近平总书记重要讲话精神。除夕当天，新闻办逾一半以上同志分赴警航总队及一线执勤岗位全力开展“首都公安民警无私奉献确保人民群众度过安全祥和除夕”的宣传报道工作。2月10日、11日，新闻办影视中心由于晓宝、费洁、王晓燕、薛天骄、徐轩、徐小琳等同志组成工作专班，在新闻办主任胡蓉、副主任胡文滨的带领下，加紧制作反映“习近平总书记来京视察看望我局民警并发表重要讲话”以及市局党委迅速召开会议组织学习传达贯彻等重要内容的电视节目，节目经政华局长亲自审定后，于2月11日在《首都警务报道》上线播出。截至2月16日17时，全局共44619名民警收看了电视节目。2月15日，新闻办副主任王文杰和《首都公安报》全体同志放弃与家人团聚，提前返回单位，加班编印2013年第6期《首都公安报》，确保初七一上班便将习近平总书记对首都公安民警的亲切关怀和殷切嘱托通过《首都公安报》传达给全体同志。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    节日期间，新闻中心民警组织媒体记者随警作战，实时报道我局广大民警昼夜奋战一线守护一方平安的鲜活事例，共组织媒体刊发我局正面报道600余篇（条），网络转载3000余次，同比增长20%。同时，舆情引导科的民警及时收集编发每日舆情，微博平台跟进发布新闻资讯，以加强舆论引导，宣传队伍形象，展示工作状态，赢得群众支持，发挥了积极的作用。 </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	</FONT></P></TEXTFORMAT>','2013-02-18 01:48:32'),(258224,82589,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">好，<FONT KERNING=\"1\">进一步提高执法能力、增强人民群众安全感和满意度。</FONT></FONT></P></TEXTFORMAT>','2013-02-20 02:06:40'),(258225,82589,4,0,'办公室党委','1','2013-02-20 02:06:40'),(258015,88387,1,0,'高廷海','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">2013年2月7日下午，办公室综合处召开节前纪律教育会。会议由处长刘东同志主持，全体现职领导及民警参加了会议。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">会上，处领导传达了市局2013年党风廉政建设会议精神及市局和办公室关于节日期间车辆管理使用和消防安全等有关工作要求。 </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">办公室副主任、我处处长刘东同志结合我处工作实际提出了三点要求。一是要加强节前纪律教育。全体人员要严格落实离京审批、五条禁令等铁规铁纪，对市局有关会议精神要人人知晓，确保节日期间不发生问题。二是要注意用电、防火及交通安全。节日期间，特别是没有值班人员的房间要关闭电源，清除火灾隐患。同时，节日期间做到开车不饮酒，饮酒不开车。三是坚守工作岗位，严格落实紧急召回制度。节日期间在岗值班人员要恪尽职守，认真履职，休假人员要保持24小时通讯畅通，落实紧急召回制度。</FONT></P></TEXTFORMAT>','2013-02-19 09:38:32'),(258182,88518,1,0,'李明','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    为进一步强化民警春节前教育工作，确保民警度过一个安全祥和的新年，2月8日，政治处召开会议，对民警进行政治思想暨春节前安全教育。会议由政治处主任王锦同志主持。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	 王锦主任首先传达了公安部贯彻“五条禁令”电视电话会议精神和近期市局、办公室有关会议精神，并提出政治处全体人员在廉洁自律，遵纪守法，厉行节约各方面都要起到表率作用。一是要坚决遵守“五条禁令”，杜绝违法违纪问题的发生，做到警钟长鸣，不碰不触高压线；二是加强节日期间安全意识，防止发生各种安全隐患；三是严格值班和请销假制度。</FONT></P></TEXTFORMAT>','2013-02-20 01:55:12'),(259555,88862,1,0,'孙威毅','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2月4日下午，研究室召开全体党员大会。会上，研究室领导班子成员分别进行了述职述德述廉；研究了2013年研究室工作要点（初稿），全体民警分别对要点进行了研提意见；对“3+1”考评工作进行了部署。</FONT></P></TEXTFORMAT>','2013-02-20 10:12:00'),(258941,85736,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">好，会议内容丰富。望多策并举、真抓实干，切实做好支部的党建工作。</FONT></P></TEXTFORMAT>','2013-02-20 06:53:27'),(258942,85736,4,0,'办公室党委','1','2013-02-20 06:53:28'),(258951,82930,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">会议内容有针对性。</FONT></P></TEXTFORMAT>','2013-02-20 06:55:16'),(258952,82930,4,0,'办公室党委','1','2013-02-20 06:55:16'),(258957,85136,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">筑牢思想防线，坚守底线，抵御不良侵袭，永葆纯洁。</FONT></P></TEXTFORMAT>','2013-02-20 06:56:12'),(258958,85136,4,0,'办公室党委','1','2013-02-20 06:56:12'),(258975,85210,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">结合廉政教育，深入领会市局党委扩大会议精神，传达到全体党员民警，做好爱警工作。</FONT></P></TEXTFORMAT>','2013-02-20 06:59:10'),(258976,85210,4,0,'办公室党委','1','2013-02-20 06:59:11'),(258989,85132,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">坚定理想信念，继续加强党风廉政建设，切实转变工作作风，发扬勤俭节约的优良传统。</FONT></P></TEXTFORMAT>','2013-02-20 07:01:14'),(258990,85132,4,0,'办公室党委','1','2013-02-20 07:01:14'),(259073,85434,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">认真学习贯彻十八精神和习近平总书记近期重要讲话指示精神，紧密结合工作实际，以可能达到的最高标准完成工作。</FONT></P></TEXTFORMAT>','2013-02-20 07:20:10'),(259074,85434,4,0,'办公室党委','1','2013-02-20 07:20:10'),(259080,81673,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">要进一步加强“8小时”外的监督管理，防止发生违法违纪的问题。</FONT></P></TEXTFORMAT>','2013-02-20 07:21:43'),(259081,81673,4,0,'办公室党委','1','2013-02-20 07:21:44'),(259085,87134,3,0,'政治处','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">结合工作性质特点，切实做好爱警工作。</FONT></P></TEXTFORMAT>','2013-02-20 07:22:57'),(259086,87134,4,0,'办公室党委','1','2013-02-20 07:22:58'),(259541,88856,1,0,'罗瑛','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        2013年2月17日，信访处召开支部委员扩大会，研究节后近期工作和两会安保工作，主管领导冬斌主任参加会议。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        会上，首先通报了局党委研究确定的信访处搬迁新址决定，要求全处同志统一思想，提高认识，从大局角度出发考虑理解和执行这项决定，并且结合各项工作要求，在保障办公环境、休息环境的改建基础上，切实做好搬迁的筹备组各项工作。二是关于第五批市局竞聘事宜，鼓励符合条件的人员积极报名参加，做好支持配合工作。三是两会即将召开，各科都要加强对重点人员、敏感信息的掌控，以高度负责的政治意识，全力投入到安保工作中。</FONT></P></TEXTFORMAT>','2013-02-20 09:42:44'),(259550,88861,1,0,'孙威毅','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2月19日上午，研究室支部召开支委会和班子成员联席会议，研究年度公务员考核和非领导职务晋升等工作。会议经过初步研究，决定根据全体民警评议结合，综合日常工作表现，统筹考虑公务员考核等工作。</FONT></P></TEXTFORMAT>','2013-02-20 10:04:15'),(259942,89001,1,0,'高廷海','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">2月6日下午，召开了以“学习贯彻党的十八大精神，进一步改进工作作风，为民务实清廉”为主题的民主生活会。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">会上，党支部书记刘东同志，组织全体委员进一步学习了习总书记有关讲话精神，大家一致认为，党的十八大后新一届中央领导集体提出的改进工作作风，密切联系群众的八项规定，近期习近平总书记又发表了一系列讲话，特别是针对奢侈腐败等行为作出的关于厉行勤俭节约反对铺张浪费重要批示，体现了中央关心群众生活，注重改善民生的为民情怀。各位支委结合自身思想和工作实际，认真开展党性分析和对照检查，深入查找不足和差距，明确了整改提高措施。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">最后刘东书记就下一步工作提出要求，一是支委要带头认真学习，并且要与所分管民警一起学习；通过学习要始终牢记依法治国的基本方略，进一步提高政治理论水平。二是要将贯彻学习与工作实际紧密相结合，市局党委提出将总书记的重要批示作为我们筹划今年工作的一个指导性意见。因此，我们要深入研究，明确工作重点，要立足当前、着眼长远、统筹谋划、真抓实干，以更加奋发有为的精神状态和求真务实的工作作风，全面提高工作水平。三是坚持从严治警方针，严格落实党风廉政建设责任制，抓好班子、带好队伍，着力打造一支忠诚可靠、务实进取、公正廉洁的高素质队伍</FONT></P></TEXTFORMAT>','2013-02-21 02:14:03'),(260489,89283,1,0,'罗瑛','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        2013年2月1日，信访处召开全体党员大会，认真学习有关文件精神。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">       一是传达学习习近平总书记对政法工作的重要指示。二是传达学习全国政法工作会议的主要精神。三是传达学习全国公安厅局长会议主要精神。四是传达学习北京市政法工作会议主要精神。五是传达学习习近平同志关于厉行节约反对铺张浪费的重要批示。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        支部书记杨志刚同志传达市局2013年第一次党委扩大会议有关文件及傅政华局长的讲话精神，并就近期相关工作进行部署。</FONT></P></TEXTFORMAT>','2013-02-21 08:38:16'),(260496,89287,1,0,'罗瑛','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">2013年2月8日，信访处召开全体大会，组织部署相关工作进行节前安全教育。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">一、杨志刚处长进行节前安全教育。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">二、传达学习相关文件：一是李建华同志在市局2013年队伍建设暨党风廉政工作会议上的报告，马燕军同志的讲话。二是春节期间安全教育通知。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">三、杨处通报第五次竞争选拔工作相关工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">四、杨处就节日期间情况提出工作要求：一是注意节日期间各项纪律规定要严格遵守地。二是值班期间有上访的必须处理好。三是注意消防、用水用电等室内安全。四是出京要严格审批制度。五是五条禁令等高压线不得触碰。</FONT></P></TEXTFORMAT>','2013-02-21 08:43:06'),(262493,90043,1,0,'孙威毅','<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        2月22日下午，研究室召开全体党员大会，支部书记徐暖保就如何贯彻做强将、带精兵、打造过硬队伍要求，大力加强学习型队伍建设，给全体党员民警上了一堂党课。党课上，首先集中学习了习近平总书记、温家宝总理到我局视察慰问时的重要讲话精神，以及傅政华局长在市局第二次党委扩大会议上的重要讲话，从分析研究现状和存在问题入手，从解决学习的认识问题、深入基层开展调研、强化学习考核等方面作了讲解动员，要求全体党员民警强化学习意识，提高学习能力，为发挥研究室职能作用、做好三服务工作奠定基础。</FONT></P></TEXTFORMAT>','2013-02-24 00:38:18');
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
INSERT INTO `pc_member` VALUES (15,10,0,'刘大伟',1,1,'1972-06-26 15:56:42','1994-07-13 15:56:42','1994-06-13 15:56:42',8,'2011-12-09 15:56:42','山东省齐河县','北京市朝阳区幸福一村西里16号楼1106',1,NULL,1,NULL,NULL,'主任',1),(16,10,0,'杨亚玲',2,1,'1964-05-17 17:25:57','1986-08-03 18:25:57','1994-06-08 17:25:57',8,'2011-12-09 17:25:57','江苏省灌云县','北京市东城区龙潭北里六条5号楼1门13号',3,NULL,1,NULL,NULL,'副主任',2),(35,10,0,'王文杰',1,1,'1972-03-19 17:25:39','1994-07-25 17:25:39','1994-01-12 17:25:39',8,'2011-12-09 17:25:39','湖北黄岗','丰台区紫芳园1区7号楼804',4,NULL,1,NULL,NULL,'副主任',3),(37,10,0,'胡蓉',2,1,'1969-09-02 17:33:47','1984-01-01 17:33:47','1990-07-05 18:33:47',3,'2011-12-09 17:33:47','重庆河川市','北京市海淀区镶红旗1号院西区14号楼20号',5,NULL,1,NULL,NULL,'副主任',4),(38,10,0,'赵峰',1,2,'1975-05-29 17:37:27','1998-07-13 17:37:27','1998-06-16 17:37:27',8,'2011-12-09 17:37:27','北京市','北京市通州区富河园2号楼62号',6,NULL,1,NULL,NULL,'科长',5),(103,4,0,'赵伟',1,1,'1972-12-22 10:43:35','1994-01-01 10:43:35','2000-01-01 10:43:35',8,'2005-01-01 10:43:35','','北京市丰台区政法小区',3,NULL,1,NULL,NULL,'',2),(12103,4,0,'王锦',1,1,'1972-07-09 10:44:56','1994-01-01 10:44:56','1994-01-01 10:44:56',8,'2012-12-01 10:44:56','','',1,NULL,1,NULL,NULL,'',1),(296,6,0,'刘东',1,1,'1967-12-19 11:55:45','1987-12-01 11:55:45','1993-12-01 11:55:45',8,'2003-01-01 11:55:45','河北','',1,NULL,1,NULL,NULL,'办公室副主任、综合处处长',1),(347,6,0,'李芳',2,1,'1964-04-01 15:19:00','1986-07-01 16:19:00','1996-10-01 15:19:00',8,'2011-12-08 15:19:00','吉林','',8,NULL,1,NULL,NULL,'综合处副处长',2),(349,6,0,'胡鹏',1,6,'1970-12-01 15:21:28','1994-07-01 15:21:28','1996-12-01 15:21:28',8,'2011-12-08 15:21:28','贵州','',5,NULL,1,NULL,NULL,'综合处副处长',3),(350,6,0,'许巍',1,1,'1974-12-31 15:26:42','1994-07-01 15:26:42','1999-06-01 15:26:42',12,'2012-12-08 15:26:42','天津','',4,NULL,1,NULL,NULL,'综合处副处长',4),(352,6,0,'高廷海',1,1,'1959-03-19 15:26:20','1979-09-01 15:26:20','1992-12-01 15:26:20',12,'2011-12-08 15:26:20','北京','',3,NULL,1,NULL,NULL,'副调研员',5),(1135,5,0,'马波',2,1,'1963-02-01 11:16:22','1986-07-01 12:16:22','1989-11-01 11:16:22',3,'2011-12-08 11:16:22','','',3,NULL,1,NULL,NULL,'研究室副主任',0),(1138,5,0,'张成格',1,13,'1963-09-01 11:17:51','1982-07-01 11:17:51','2000-07-01 11:17:51',3,'2011-12-08 11:17:51','','',5,NULL,1,NULL,NULL,'研究室副主任',0),(1140,5,0,'孙威毅',1,1,'1979-07-01 11:19:01','2002-06-01 11:19:01','2001-03-01 11:19:01',3,'2011-12-08 11:19:01','','',4,NULL,1,NULL,NULL,'研究室科长',0),(1144,5,0,'丁镭',1,1,'1973-02-01 11:20:11','1992-07-01 11:20:11','1998-03-01 11:20:11',9,'2011-12-08 11:20:11','','',8,NULL,1,NULL,NULL,'研究室副科长',0),(1468,7,0,'杨志刚',1,1,'1964-01-13 10:03:53','1981-02-01 10:03:53','1985-11-01 10:03:53',8,'2011-12-16 10:03:53','','',1,NULL,1,NULL,NULL,'信访处处长',1),(1476,7,0,'张家祥',1,1,'1956-04-16 10:04:10','1973-09-01 10:04:10','1980-07-01 10:04:10',8,'2011-12-16 10:04:10','','',3,NULL,1,NULL,NULL,'信访处副处长',2),(1483,7,0,'宋红',2,1,'1966-05-29 10:06:25','1989-07-01 11:06:25','1986-05-01 10:06:25',8,'2011-12-16 10:06:25','','',4,NULL,1,NULL,NULL,'信访处副处长',3),(1492,7,0,'康健',1,1,'1964-08-25 10:10:15','1984-07-01 10:10:15','1985-11-01 10:10:15',5,'2011-12-16 10:10:15','','',5,NULL,1,NULL,NULL,'信访处副处长',4),(1500,7,0,'陈军',1,1,'1969-08-26 10:12:54','1990-07-01 11:12:54','1995-10-01 10:12:54',8,'2011-12-16 10:12:54','','',6,NULL,1,NULL,NULL,'信访处副处长',5),(2679,9,0,'高红军',1,1,'1962-11-30 16:38:29','1981-12-23 16:38:29','1986-12-12 16:38:29',8,'2011-11-21 16:38:29','北京市','北京市宣武区灵佑宫2号院2号楼3门302',1,NULL,1,NULL,NULL,'办公室外事办公室主任',1),(3063,9,0,'臧德国',1,1,'1962-06-25 17:03:55','1983-03-15 17:03:55','1991-11-11 17:03:55',8,'2011-11-21 17:03:55','山东省','北京市宣武区广外小红庙10-1-503',4,NULL,1,NULL,NULL,'办公室外事办公室科长',3),(4398,8,0,'张兵',1,1,'1962-04-20 16:12:04','1986-07-01 17:12:04','1992-10-01 16:12:04',5,'2011-12-01 16:12:04','江苏苏州','',1,NULL,1,NULL,NULL,'市局办公室档案处处长',1),(4399,8,0,'张延太',1,1,'1955-06-16 16:15:54','1976-03-01 16:15:54','1979-11-01 16:15:54',8,'2011-12-01 16:15:54','山东','',2,NULL,1,NULL,NULL,'市局办公室档案处政委',2),(4400,8,0,'刘蔚',1,1,'1957-07-24 16:15:27','1974-03-01 16:15:27','1989-07-01 17:15:27',8,'2011-12-01 16:15:27','','',5,NULL,1,NULL,NULL,'市局办公室档案处副处长',3),(4401,8,0,'唐琼',2,1,'1962-06-01 16:17:12','1980-11-21 16:17:12','1983-04-30 16:17:12',8,'2011-12-01 16:17:12','山东','',3,NULL,1,NULL,NULL,'市局办公室档案处副处长',4),(4402,8,0,'马军',1,1,'1961-12-09 16:18:21','1976-12-01 16:18:21','1990-07-19 17:18:21',8,'2011-12-01 16:18:21','','',4,NULL,1,NULL,NULL,'市局办公室档案处副处长',5),(4403,8,0,'葛婴',2,1,'1971-03-19 15:09:38','1995-07-15 15:09:38','1998-11-26 15:09:38',8,'2011-12-01 15:09:38','','',9,NULL,1,NULL,NULL,'市局办公室档案处科长',6),(4404,8,0,'刘珠江',1,1,'1976-03-06 16:21:04','1999-07-08 16:21:04','1997-01-02 16:21:04',8,'2011-12-01 16:21:04','河北','',6,NULL,1,NULL,NULL,'市局办公室档案处主任科员',7),(4535,3,0,'李广岐',1,1,'1963-04-17 16:26:42','1983-12-28 16:26:42','1987-08-25 17:26:42',5,'2010-06-10 16:26:42','北京市西城区','北京市西城区南半截胡同８号',1,NULL,1,NULL,NULL,'北京市公安局办公室副主任兼秘书处处长',0),(4543,3,0,'朱杰',1,1,'1965-03-20 16:25:10','1985-07-01 16:25:10','1996-06-24 16:25:10',8,'2006-10-17 16:25:10','北京市','北京丰台区洋桥71号院1号楼1102室',5,NULL,1,NULL,NULL,'北京市公安局办公室秘书处副处长',0),(4549,3,0,'邢栋',1,1,'1980-07-27 16:25:29','2003-09-24 16:25:29','2001-12-20 16:25:29',8,'2011-12-29 16:25:29','河北省衡水','北京东城区前门东大街9号',6,NULL,1,NULL,NULL,'北京市公安局办公室秘书处督办联络科科长',0),(4556,3,0,'李华',2,1,'1972-01-29 16:25:43','1995-07-21 16:25:43','1994-01-15 16:25:43',8,'2011-12-29 16:25:43','河北省保定唐县','北京海淀区厂洼街甲5号1-608',8,NULL,1,NULL,NULL,'北京市公安局办公室秘书处保密科科长',0),(4569,3,0,'张宾',1,1,'1978-07-20 17:56:51','1998-09-12 17:56:51','2002-09-18 17:56:51',8,'2011-12-29 17:56:51','安徽阜阳太和县','朝阳区华严里甲20号楼6-413',3,NULL,1,NULL,NULL,'北京市公安局办公室秘书处值班科科长 ',0),(4583,3,0,'贾娜',2,1,'1975-04-08 15:42:02','1997-07-10 15:42:02','2001-06-07 15:42:02',8,'2011-12-29 15:42:02','北京市','北京石景山区苹果园三区19栋907室',9,NULL,1,NULL,NULL,'北京市公安局办公室秘书处文电科科长',0),(4596,3,0,'高飞',1,1,'1980-04-09 16:26:17','2003-07-14 16:26:17','2005-06-13 16:26:17',8,'2011-12-29 16:26:17','北京市房山区','北京房山区良乡西路18号4-401',4,NULL,1,NULL,NULL,'北京市公安局办公室秘书处秘书科科长',0),(11929,9,0,'赵伟',1,11,'1975-09-01 17:03:44','1995-11-08 17:03:44','2001-06-15 17:03:44',5,'2012-11-16 17:03:44','','',3,NULL,1,NULL,NULL,'科长',2),(11619,5,0,'徐暖保',1,1,'1970-09-06 10:59:30','1990-07-01 11:59:30','1999-12-31 10:59:30',3,'2012-09-27 10:59:30','','',1,NULL,1,NULL,NULL,'主任',0),(11391,2216,0,'冯若非',1,1,'1957-10-16 14:45:18','1977-03-01 14:45:18','1986-12-01 14:45:18',8,'2012-01-01 14:45:18','北京','北京市海淀区',1,NULL,1,NULL,NULL,'处长',1),(11392,2216,0,'寇波',1,1,'1968-10-02 14:48:23','1989-08-01 15:48:23','1996-07-01 14:48:23',8,'2012-01-01 14:48:23','北京','北京市朝阳区',4,NULL,1,NULL,NULL,'副处长',2),(11393,2216,0,'王元君',2,1,'1974-02-03 14:48:17','1996-07-01 14:48:17','1994-06-01 14:48:17',3,'2012-01-01 14:48:17','山东','北京市东城区',3,NULL,1,NULL,NULL,'科长',3);
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
INSERT INTO `pc_remind` VALUES (1,3,'秘书处党支部',10,'0101',2,'办公室党委',2013,0,1,5,'beijing'),(2,3,'秘书处党支部',10,'0101',2,'办公室党委',2013,1,2,5,'beijing'),(5,3,'秘书处党支部',10,'0101',2,'办公室党委',2013,1,5,0,'beijing'),(6,3,'秘书处党支部',10,'0101',2,'办公室党委',2013,1,6,5,'beijing'),(7,3,'秘书处党支部',10,'0101',2,'办公室党委',2013,1,7,0,'beijing'),(8,3,'秘书处党支部',10,'0101',2,'办公室党委',2013,1,8,0,'beijing'),(9,4,'政治处党支部',10,'0103',2,'办公室党委',2013,0,1,3,'beijing'),(10,4,'政治处党支部',10,'0103',2,'办公室党委',2013,1,2,3,'beijing'),(13,4,'政治处党支部',10,'0103',2,'办公室党委',2013,1,5,0,'beijing'),(14,4,'政治处党支部',10,'0103',2,'办公室党委',2013,1,6,5,'beijing'),(15,4,'政治处党支部',10,'0103',2,'办公室党委',2013,1,7,0,'beijing'),(16,4,'政治处党支部',10,'0103',2,'办公室党委',2013,1,8,3,'beijing'),(17,5,'研究室党支部',10,'0105',2,'办公室党委',2013,0,1,3,'beijing'),(18,5,'研究室党支部',10,'0105',2,'办公室党委',2013,1,2,3,'beijing'),(21,5,'研究室党支部',10,'0105',2,'办公室党委',2013,1,5,3,'beijing'),(22,5,'研究室党支部',10,'0105',2,'办公室党委',2013,1,6,3,'beijing'),(23,5,'研究室党支部',10,'0105',2,'办公室党委',2013,1,7,0,'beijing'),(24,5,'研究室党支部',10,'0105',2,'办公室党委',2013,1,8,3,'beijing'),(25,6,'综合处党支部',10,'0107',2,'办公室党委',2013,0,1,3,'beijing'),(26,6,'综合处党支部',10,'0107',2,'办公室党委',2013,1,2,3,'beijing'),(29,6,'综合处党支部',10,'0107',2,'办公室党委',2013,1,5,3,'beijing'),(30,6,'综合处党支部',10,'0107',2,'办公室党委',2013,1,6,5,'beijing'),(31,6,'综合处党支部',10,'0107',2,'办公室党委',2013,1,7,3,'beijing'),(32,6,'综合处党支部',10,'0107',2,'办公室党委',2013,1,8,5,'beijing'),(33,7,'信访处党支部',10,'0109',2,'办公室党委',2013,0,1,3,'beijing'),(34,7,'信访处党支部',10,'0109',2,'办公室党委',2013,1,2,3,'beijing'),(37,7,'信访处党支部',10,'0109',2,'办公室党委',2013,1,5,0,'beijing'),(38,7,'信访处党支部',10,'0109',2,'办公室党委',2013,1,6,3,'beijing'),(39,7,'信访处党支部',10,'0109',2,'办公室党委',2013,1,7,5,'beijing'),(40,7,'信访处党支部',10,'0109',2,'办公室党委',2013,1,8,3,'beijing'),(41,8,'档案处党支部',10,'0111',2,'办公室党委',2013,0,1,3,'beijing'),(42,8,'档案处党支部',10,'0111',2,'办公室党委',2013,1,2,3,'beijing'),(45,8,'档案处党支部',10,'0111',2,'办公室党委',2013,1,5,0,'beijing'),(46,8,'档案处党支部',10,'0111',2,'办公室党委',2013,1,6,0,'beijing'),(47,8,'档案处党支部',10,'0111',2,'办公室党委',2013,1,7,0,'beijing'),(48,8,'档案处党支部',10,'0111',2,'办公室党委',2013,1,8,0,'beijing'),(49,9,'外事办公室党支部',10,'0113',2,'办公室党委',2013,0,1,3,'beijing'),(50,9,'外事办公室党支部',10,'0113',2,'办公室党委',2013,1,2,3,'beijing'),(53,9,'外事办公室党支部',10,'0113',2,'办公室党委',2013,1,5,0,'beijing'),(54,9,'外事办公室党支部',10,'0113',2,'办公室党委',2013,1,6,0,'beijing'),(55,9,'外事办公室党支部',10,'0113',2,'办公室党委',2013,1,7,0,'beijing'),(56,9,'外事办公室党支部',10,'0113',2,'办公室党委',2013,1,8,3,'beijing'),(57,10,'新闻办党支部',10,'0115',2,'办公室党委',2013,0,1,3,'beijing'),(58,10,'新闻办党支部',10,'0115',2,'办公室党委',2013,1,2,3,'beijing'),(61,10,'新闻办党支部',10,'0115',2,'办公室党委',2013,1,5,0,'beijing'),(62,10,'新闻办党支部',10,'0115',2,'办公室党委',2013,1,6,0,'beijing'),(63,10,'新闻办党支部',10,'0115',2,'办公室党委',2013,1,7,0,'beijing'),(64,10,'新闻办党支部',10,'0115',2,'办公室党委',2013,1,8,3,'beijing'),(15785,2216,'国际警务联络处党支部',10,'0116',2,'办公室党委',2013,0,1,3,'beijing'),(15786,2216,'国际警务联络处党支部',10,'0116',2,'办公室党委',2013,1,2,3,'beijing'),(15789,2216,'国际警务联络处党支部',10,'0116',2,'办公室党委',2013,1,5,0,'beijing'),(15790,2216,'国际警务联络处党支部',10,'0116',2,'办公室党委',2013,1,6,0,'beijing'),(15791,2216,'国际警务联络处党支部',10,'0116',2,'办公室党委',2013,1,7,0,'beijing'),(15792,2216,'国际警务联络处党支部',10,'0116',2,'办公室党委',2013,1,8,0,'beijing');
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
INSERT INTO `pc_remind_lock` VALUES (6911,3,'秘书处党支部',10,'0101',2,2013,1,2,8,9,'','beijing'),(6865,8,'档案处党支部',10,'0111',2,2013,1,1,8,9,'','beijing'),(6912,8,'档案处党支部',10,'0111',2,2013,1,2,8,9,'','beijing');
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
INSERT INTO `pc_remind_stat` VALUES (3,2,'办公室党委',7,'01',1,2013,0,1,3,8,'beijing'),(4,2,'办公室党委',7,'01',1,2013,0,1,5,1,'beijing'),(5,2,'办公室党委',7,'01',1,2013,1,2,3,8,'beijing'),(6,2,'办公室党委',7,'01',1,2013,1,2,5,1,'beijing'),(7,2,'办公室党委',7,'01',1,2013,1,5,0,7,'beijing'),(8,2,'办公室党委',7,'01',1,2013,1,5,3,2,'beijing'),(9,2,'办公室党委',7,'01',1,2013,1,6,0,4,'beijing'),(10,2,'办公室党委',7,'01',1,2013,1,6,3,2,'beijing'),(11,2,'办公室党委',7,'01',1,2013,1,6,5,3,'beijing'),(12,2,'办公室党委',7,'01',1,2013,1,7,0,7,'beijing'),(13,2,'办公室党委',7,'01',1,2013,1,7,3,1,'beijing'),(14,2,'办公室党委',7,'01',1,2013,1,7,5,1,'beijing'),(15,2,'办公室党委',7,'01',1,2013,1,8,0,3,'beijing'),(16,2,'办公室党委',7,'01',1,2013,1,8,3,5,'beijing'),(17,2,'办公室党委',7,'01',1,2013,1,8,5,1,'beijing');
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
INSERT INTO `pc_user` VALUES (1,'admin','admin1234','admin@admin.com','123456',1,'2013-09-03 14:23:45',NULL,'1',0,6),(2,'bgs','12345678','','',1,'2013-02-20 07:15:21',NULL,'2',0,7),(3,'bgsmsczb','12345678','','',1,'2013-03-10 08:05:21',NULL,'3',1,NULL),(4,'bgsmscdy','12345678','','',1,'2011-12-25 14:47:00',NULL,'3',0,NULL),(5,'bgszzczb','123456','','',1,'2013-02-20 07:14:22',NULL,'4',1,10),(6,'bgszzcdy','12345678','','',1,'2011-12-25 14:47:00',NULL,'4',0,NULL),(7,'bgsyjszb','87654321','','',1,'2013-02-24 00:32:21',NULL,'5',1,10),(8,'bgsyjsdy','12345678','','',1,'2011-12-25 14:47:00',NULL,'5',0,10),(9,'bgszhczb','85223223','','',1,'2013-02-21 02:10:39',NULL,'6',1,10),(10,'bgszhcdy','12345678','','',1,'2011-12-25 14:47:00',NULL,'6',0,NULL),(11,'bgsxfczb','85222802','','',1,'2013-02-21 08:46:34',NULL,'7',1,10),(12,'bgsxfcdy','12345678','','',1,'2012-10-11 02:32:46',NULL,'7',0,NULL),(13,'bgsdaczb','dac','','',1,'2013-02-25 02:36:03',NULL,'8',1,10),(14,'bgsdacdy','dacdy','','',1,'2012-09-21 04:20:07',NULL,'8',0,10),(15,'bgswsbzb','12345678','','',1,'2013-02-17 08:42:23',NULL,'9',1,NULL),(16,'bgswsbdy','12345678','','',1,'2011-12-25 14:47:00',NULL,'9',0,NULL),(17,'bgsxwbzb','12345678','','',1,'2013-02-18 01:46:34',NULL,'10',1,NULL),(18,'bgsxwbdy','12345678','','',1,'2011-12-25 14:47:00',NULL,'10',0,NULL),(4245,'bgsgjjwzb','12345678','','',1,'2013-02-27 01:56:53',NULL,'2216',0,10),(4246,'bgjgjjwdy','12345678','','',1,NULL,NULL,'2216',0,10);
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
INSERT INTO `pc_user_role` VALUES (14847,1,1),(14845,1,3),(14844,1,4),(14843,1,5),(14842,1,6),(12821,2,5),(12820,2,4),(12819,2,3),(6386,3,1),(6387,3,2),(6388,4,1),(13490,5,2),(13489,5,1),(6391,6,1),(6392,7,1),(6393,7,2),(6394,8,1),(6395,9,1),(6396,9,2),(6397,10,1),(6398,11,1),(6399,11,2),(6400,12,1),(6401,13,1),(6402,13,2),(6403,14,1),(6404,15,1),(6405,15,2),(6406,16,1),(6407,17,1),(6408,17,2),(6409,18,1),(12818,2,1),(14206,4245,1),(14207,4245,2),(14208,4246,1);
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
INSERT INTO `pc_workplan` VALUES (20674,2216,2,2013,1,3,0),(20901,3,1,2013,0,5,0),(20905,3,2,2013,1,5,0),(21661,2216,1,2013,0,3,0),(22547,10,1,2013,0,3,0),(22737,5,1,2013,0,3,0),(22738,5,2,2013,1,3,0),(22809,8,1,2013,0,3,0),(23202,9,1,2013,0,3,0),(23483,6,1,2013,0,3,0),(23491,6,2,2013,1,3,0),(23492,9,2,2013,1,3,0),(23611,10,2,2013,1,3,0),(24058,8,2,2013,1,3,0),(24158,4,1,2013,0,3,0),(24163,4,2,2013,1,3,0),(24601,7,1,2013,0,3,0),(24615,7,2,2013,1,3,0);
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
INSERT INTO `pc_workplan_content` VALUES (54338,20674,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">一、按照市局和办公室党委的部署安排，继续开展十八大精神学习活动，把握精神实质，找准工作结合点，抓好贯彻落实，全面推进工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">二、认真做好年终总结，及时固化经验。同时，做好党员民警评优和爱警慰问活动，发挥典型引领示范作用，对工作表现突出和家庭困难民警及时开展走访慰问，帮助民警及家属解决实际困难。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">三、积极做好“两节”期间思想政治工作，进一步强化纪律作风教育，不断增强队伍的安全意识和纪律意识，并组织全体民警深入开展内部安全大检查，重点对文件管理、车辆安全、防火防盗等问题督查，及时发现安全隐患，及时采取整改措施，确保节日期间内部安全。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">四、围绕“两会”安保中心工作，按照办公室的统一部署，充分发挥本单位职能，认真组织、周密安排，确保出色完成“两会”安保工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">五、按照建设“学习型党组织”的目标,加强党员教育培训，邀请外交部领导就“中国周边国家外交战略与形势”做专题讲座，切实提高民警对国际形势政策的理解把握能力，学会运用全球视野和世界眼光研究工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">六、将践行“三大支柱”与学习贯彻十八大精神结合起来，开展主题党日活动，以“树立民警形象，打造和谐警营”为主题组织民警实地摄影技能培训。</FONT></P></TEXTFORMAT>','2012-12-26 02:38:57','李险峰'),(54807,20901,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2013年，秘书处将根据市局党委和办公室党委部署要求，深入学习贯彻党的十八大会议精神，“抓党建、带队建、促发展”，以“三大支柱”为引领，进一步加强基层党组织建设，狠抓队伍管理。结合秘书处队伍和业务工作实际，特制定以下工作计划：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合秘书处党员队伍和业务工作实际，认真做好年度工作计划和每季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2.强化党组织活动。坚持以党建带队建促工作，认真落实好党支部组织生活制度，开展好主题党日活动，加强办公室第一党支部第二党小组组织活动，始终保持全体党员民警坚定的党性观念。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    3.深入学习贯彻党的十八大会议精神。组织全体党员深入学习、深刻领会、广泛宣传、全面贯彻党的十八大会议精神，组织实施好党的十八大会议精神学习宣传贯彻党的十八大会议精神各项工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    4.进一步加强基层党组织建设。结合十八大会议精神的学习贯彻，进一步加强基层党组织建设，提高基层党组织自我净化、自我完善、自我革新、自我提高的能力，始终保持党员队伍的先进性和纯洁性。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    5.加强日常政策理论学习。结合公安工作实际，及时组织学习党和国家的理论方针政策，及时学习中央和市委、市政府、公安部等上级单位的决策部署，及时学习市局党委和办公室党委的部署要求，始终保持全体党员民警在政策理论上的先进性。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    6.做好战时思想政治动员。围绕春节、五一、十一等重大节日以及六四等重要敏感日，特别是全国“两会”等重大活动安保工作，启动战时思想政治动员机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    7.加强党支部文化建设。以“忠诚、为民、公正、廉洁”人民警察核心价值观、“理性、平和、文明、规范”执法理念和“爱国、创新、包容、厚德”北京精神为引领，组织开展符合秘书处特点的警营文化建设和爱警系统工程，做好青年文明岗和优秀青年警队争创工作，激发队伍活力，保持队伍状态。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    8.认真开展党风廉政建设。围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，始终保持队伍风清气正。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    9.扎实做好保密工作。严格执行市委、市政府、公安部和市局有关保密规定，定期开展内部保密教育和保密检查，始终做到警钟长鸣，坚决防止发生失泄密问题。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    10.做好总结和表彰等各项工作。根据市局党委和办公室党委的部署要求，认真做好支部建设工作总结、宣传表彰等各项工作，始终保持队伍良好的精神面貌。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      </FONT></P></TEXTFORMAT>','2012-12-26 07:02:33','刘保齐'),(54811,20905,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  根据2013年度工作计划安排，制定第一季度主要工作计划如下：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  1.制定年度和季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  2.强化党组织活动，落实好三会一课制度，开展好相关主题党日活动，过好春节廉政关。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  3.根据上级的决策部署，加强日常政策理论学习。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  4.围绕元旦、春节和全国“两会”安保工作，做好战时思想政治动员。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  5.根据办公室党委的部署要求，做好其他各项思想政治工作。</FONT></P></TEXTFORMAT>','2012-12-26 07:05:42','刘保齐'),(56902,21661,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"20\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">国际警务联络处党支部2013年工作计划<FONT SIZE=\"12\"></FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         <FONT SIZE=\"16\">认真学习贯彻十八大精神，按照“党建是核心，队建是根本”的工作要求，牢固树立“警意主导政工”理念，以继承发扬建局65周年优良传统为主题，深入开展队伍思想发动，不断强化党支部建设，丰富爱警措施，狠抓各项纪律规定执行与落实，有效激发和调动民警的工作积极性、主动性，全面提升队伍向心力凝聚力战斗力。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">一、认真组织开展政治学习。学习贯彻党的十八大精神，学习社会主义核心价值体系和人民警察核心价值观；重点抓好全国“两会”精神的学习贯彻。通过集中学习、专题讨论、辅导讲座等多种形式，形成强大的学习宣传声势。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">二、积极做好春节、五一、十一等重大节假日思想政治工作。不断增强队伍的安全意识和纪律意识，并组织全体民警深入开展内部安全大检查，重点对文件管理、车辆安全、防火防盗等问题督查，及时发现安全隐患，及时采取整改措施，确保节日期间内部安全。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">三、坚决做好重大安保工作。以“两会”安保为重心，按照办公室的统一部署，充分发挥本单位职能，认真组织、周密安排，发挥党建工作的带动作用，确保出色完成各项重大活动的安保工作。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">四、全面落实党组织基本制度建设。认真落实“一岗双责”、“三会一课”等制度，做到党内组织生活经常化、规范化、制度化。主动向办公室党委汇报，积极参加市局和办公室党委举办的各项活动。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">五、深入开展党风廉政建设。以创建廉洁型集体为导向，不断强化示范教育、警示教育、岗位廉政教育，通过民主生活会、观看警示教育片、学习廉政教育规范等活动，引导党员民警特别是领导干部不断提高思想道德水平，增强廉洁从政意识；</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">六、狠抓队伍纪律作风建设，严格落实考勤、车辆等内部管理制度，强化工作执行力，广泛开展谈心活动，班子成员每月至少与每位民警进行一次谈心，了解掌握思想动态，确保不发生违法违纪问题。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">七、按照建设“学习型党组织”的目标,加强党员教育培训，邀请外交部、公安部等相关部门做专题讲座和业务培训，深入局内外相关单位、部门调研实践，切实提升民警对跨国执法合作的理解把握，提高协调办案的操作能力。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">八、广泛开展形式多样的组织生活，结合建局65周年、“五四青年节”、“七一党建”等开展多种主题党日活动，组织民警实地摄影技能培训等，利用积极向上的活动丰富党员民警生活。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">九、加强学习能力培养。根据工作性质和需求，购买、订阅时事类、外语类书刊杂志，营造良好的学习环境；组织开展读书日活动，坚持每日英语晨读，提高民警学习积极性。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">         <FONT SIZE=\"16\" KERNING=\"0\">十、加强落实爱警措施，开展走访慰问活动，积极协调解决民警实际困难；支持培养民警良好的兴趣爱好，组织相关讲座活动；落实民警休假制度，开展每日工间锻炼，提高民警身体素质；充分发挥各自优势，调动民警积极性，打造团结协作警队。</FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT>','2012-12-27 09:06:05','李险峰'),(59465,22547,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	在2013年度，新闻办党支部将按照市局党委“抓党建、带队建、促工作”的指导方针，继续下大力推动党建工作创新，不断加强党支部的思想建设、组织建设、作风建设、文化建设和党风廉政建设，努力开创党建工作的新局面，为完成建设最安全世界城市，打造最廉洁警队的总体目标，提供强有力的政治思想保障和组织保障。为此，2013年度新闻办党支部将着重做好以下几方面的工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	认真学习贯彻党的十八大精神，以“科学发展观”为指引，不断增强党员干部的政治素质。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	党支部要继续采取多种形式，组织和引导全体党员继续认真学习党的十八大精神，正确把握其中一系列的新思想、新观点、新诊断，力争把党的十八大精神学得更加深入、领会得更加透彻、贯彻得更加自觉，切实把党的十八大精神，作为今后全部工作的聚集点、着力点和落脚点。以“科学发展观”为今后公安新闻宣传工作的指引，不断增强建设最安全世界城市、打造最廉洁警队的主动性、紧迫性和自觉性。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">同时还要通过及时传达贯彻市局党委的各项指示精神和工作要求，积极开展党性教育活动，增强全体党员对党的事业坚定不移的信心，以及自觉履行义务的党员意识和全心全意为人民服务的宗旨意识，自觉积极践行“忠诚、为民、公正、廉洁”的人民警察核心价值观、“理性、平和、文明、规范”的执法理念和“爱国、创新、包容、厚德”的北京精神，使党员干部的政治素质在学习教育中不断稳步获得提升。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	认真做好党的基层组织建设工作，充分发挥党支部的战斗堡垒作用。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	党支部要依托市局“第一党支部”建设，从注重抓好支部各项工作的规范化、制度化建设着手，确保“三会一课”制度的有效落实，要结合实际，联系主题，经常性地认真开展批评与自我批评，及时纠正各种可能出现的问题苗头，切实把对党员干部的教育、管理、监督等各个环节抓紧抓好，在全体党员中树立起积极奋进、健康向上的良好风气。支部还要注重坚持民主集中制原则，不断深化党内的民主建设，进一步增强党组织的凝聚力和战斗力，充分发挥党支部的战斗堡垒作用，始终保持党的先进性和纯洁性。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	加强思想作风和工作作风建设，打造一支优秀的党员队伍。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	党支部要加强对党员的思想作风和工作作风教育，让全体党员继承和发扬党的优良传统作风，理论联系实际，密切联系群众，根据形势和任务及时调整思想观念，以适应新时期党委及群众工作对我们提出的新的要求；同时还要注重工作作风的改进和提高，要迅速形成执行上级党委指示坚定不移，注重政治大局意识敏锐闻警而动，贯彻落实各项工作任务迅捷高效，团队精神浓郁工作配合密切默契，严格队伍管理常抓不懈，落实考勤制度从严治警，为我局公安新闻宣传和公共关系建设发展工作打造出一支优秀的党员队伍。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	加强警察文化建设，为全体党员营造一个温馨的“党员之家”。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	党支部要依据自身特点，因地制宜，采取开展文化理论研究，组织本单位文艺、摄影摄像人才，成立兴趣小组，组织开展各类文化活动，加强文化载体建设等多种形式，充分调动党员参与文化建设的主动性和积极性，营造出在政治上和生活中关心人、尊重人，在学习上和工作中培养人、锻炼人的文化氛围，使党员成为警营文化建设的实践者和受益者，使党支部成为党员们喜爱留恋的“温馨党员之家”，使广大民警更加忠于和热爱公安事业，全力以赴完成各项中心工作，并能快乐工作、幸福生活，从而进一步增强整个队伍的凝聚力和战斗力。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	重视并加强党风廉政建设，持之以恒、防微杜渐，确保做到警钟长鸣。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	党支部要认真贯彻落实党风廉政建设责任制，仔细梳理本单位的廉政问题风险点，不断加强对全体党员干部的日常监督，要通过党员大会、专题党课、警示教育和思想摸排等多种形式，经常性地给党员干部和民警敲响思想上的警钟，及时有效地查找队伍中可能出现的细小问题苗头，并迅速采取有针对性的解决措施，把问题消除在萌芽状态。要不断提高全体党员干部在反腐倡廉上的自觉性和坚定性，在新闻办全体党员中努力营造出一种“人人思廉、人人倡廉、人人促廉”的良好氛围，确保党员干部队伍不出任何问题，让党委放心，让人民满意。</FONT></P></TEXTFORMAT>','2012-12-31 02:54:43','杨雅佳'),(60453,22737,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        根据市局党委和办公室党委关于加强党建工作的各项部署要求，紧紧围绕最安全世界城市、最廉洁警察队伍建设，坚持以“三大支柱”为引领，按照抓党建、带队建、促发展的思路，结合研究室队伍和业务工作实际，特制定以下工作计划：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合研究室党员队伍和业务工作实际，认真做好年度工作计划和每季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         2.强化党组织活动。按照完成规定动作、强化自选动作的原则，认真落实好党支部组织生活制度，发挥党小组作用，开展好主题党日活动和支部文化建设，增强党员民警的组织观念。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         3.强化政策理论学习。按照建设学习型党组织的要求，结合公安工作实际，组织全体党员民警深入学习贯彻党的十八大精神，认真学习公安部、市委、市政府和市局党委、办公室党委的决策精神，始终保持政治上的清醒、理论上的先进。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         4.强化战时思想政治动员。围绕重大安保工作和春节、五一、十一等重大节日以及六四等重要敏感日，及时启动战时思想政治动员机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        5.强化党风廉政建设。紧紧围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，始终保持队伍风清气正。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         6.扎实做好保密工作。严格执行市委、市政府、公安部和市局有关保密规定，定期开展内部保密教育和保密检查，坚决防止发生失泄密问题。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         7.做好总结和表彰等各项工作。根据市局党委和办公室党委的部署要求，认真做好支部建设工作总结、宣传表彰等各项工作，始终保持队伍良好的精神面貌。</FONT></P></TEXTFORMAT>','2012-12-31 08:55:37','孙威毅'),(60454,22738,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        根据年度工作计划安排，制定第一季度主要工作计划如下：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        1.制定年度和季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        2.强化党组织活动，落实好三会一课制度，开展好主题当日活动，加强支部文化建设，过好春节廉政关。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         3加强政策理论学习，组织全体党员民警深入学习贯彻十八大精神。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">         4.围绕春节和全国“两会”安保工作，做好战时思想政治动员和安保组织发动工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        5.根据办公室党委的部署要求，做好其他各项思想政治工作。</FONT></P></TEXTFORMAT>','2012-12-31 08:56:22','孙威毅'),(60720,22809,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        2013年，档案处党支部在办公室党委的领导下，以邓小平理论 、“三个代表”重要思想、科学发展观为指导，深入学习宣传贯彻党的十八大精神，紧紧围绕市局中心工作和办公室党委相关要求，坚持以党建带队建，不断加强支部建设，狠抓全处党员队伍的教育管理，促进全处各项工作全面发展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        <B>一、以十八大精神为重点，深入开展政治理论学习。</B>按照市局党委和办公室党委部署要求，切实抓好十八大精神的学习贯彻，确保全员学习好、贯彻好、落实好党的十八大精神。大力营造学习氛围，引导广大党员民警立足岗位自觉学习、主动宣传、深入贯彻党的十八大精神；组织党员研读原文，学好《党的十八大文件汇编》、《十八大党章修正案学习问答》、《十八大报告学习辅导百问》等学习资料，采取集中讲读与自学研读相结合方式，认认真真、原原本本地学习党的十八大工作报告和相关会议文件；依托“三会一课”等组织生活，通过召开党员大会、党小组会，开展主题党日活动等，进一步扎实深入学习，全面准确领会十八大精神，进一步强化“党建是核心，队建是根本”的政治理念，坚决以党的新思想、新观点、新论断指引推进党建工作，促进各项业务工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        <B>二、以贯彻落实市局党委部署要求为契机，不断完善党支部建设。</B>结合市局《关于进一步加强基层党组织建设的决定》、《关于贯彻落实市局党委进一步加强基层党组织建设决定的实施意见》等制度文件，及修订《基层党支部工作实施细则》等制度措施工作，切实加强党支部建设，全面提升党建工作科学化水平。在做好十八大安保战后“民主评议党员”工作的基础上，结合党员队伍实际，按照上级党委要求，建立健全处支部“党员每月口头报告，党小组进行党性分析，支委会每季度考评定等，党支部年度民主评议”的民主评议党员长效机制。并抓好贯彻落实和督导检查，全面加强支部建设。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        <B>三、以建局65年为主题，组织各项主题宣传教育活动。</B>按照市局为期一年的主题宣传系统活动的具体要求，积极开展支部宣传教育活动的落实。依托处主页、交流平台、史志刊物、博物馆等载体，组织参观、学习、讨论活动，充分宣传和了解我局65年取得的辉煌成就和创新发展，不断激发广大民警积极投身首都公安事业。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        <B>四、以强化纪律作风教育为抓手</B><FONT KERNING=\"1\"><B>，</B><FONT KERNING=\"0\"><B>加大队伍管理力度。</B>按照上级部署要求，继续开展多种形式的纪律作风教育整顿活动，不断强化党员队伍的大局意识、责任意识、奉献意识。继续狠抓各项规章制度的落实，确保队伍始终保持严明的纪律和良好的精神状态，并定期对各项业务工作进行督导，进一步提升全员执行力。</FONT></FONT></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        <B>五、以提升党员民警素质和状态为主线，进一步丰富党员文化建设。</B>完善处网页交流平台，使之真正成为民警交流思想、学习知识、展示才艺的平台。结合我处党员队伍实际，开展不同层级的交流活动。针对中青年民警特点，开展主题研讨会等交流活动，加强党员同志间的沟通对话，进一步缓解民警焦虑情绪；针对我处文职人员特点，进一步做好青年工作，开展多项文体活动，加强民警与文职间的沟通协作；针对女警特点，设立“女警小屋”，选购适宜女民警阅读的图书，屋内展示女警才艺作品，购置女警健身等相关设施，提升女警修养，促进身心健康，并在“三八”节精选女警工作、活动照片，配精致相框发给女警。通过一系列活动，加强全员间的沟通和交流，进一步增强队伍凝聚力和战斗力。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        <B>六、以服务工作需要和民警需求为中心，切实落实各项爱警措施。</B>结合科职轮岗和民警交流，开展广泛谈心，充分了解和倾听民警心声，切实关爱民警，着力解决民警实际困难。依托工会工作小组，不断开展兴趣小组活动及读书、参观、摄影、健步走等广大民警喜闻乐见的文体活动。加强对食堂、办公环境、宿舍、各健身室及相关设备设施的管理和维护，为档案处文化建设和各类活动的开展提供良好的硬件基础。</FONT></P></TEXTFORMAT>','2013-01-01 01:42:10','王冀阳'),(62352,23202,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">外事办公室2013年党支部工作计划</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2013年外事办公室党支部坚持以邓小平理论重要思想为指导，学习、宣传、贯彻党的十八大精神，以科学发展观为统揽，不断增强党支部的创造力、凝聚力和战斗力,全面加强党支部的思想、组织和作风建设，不断开拓创新,扎实工作,为首都公安外事的改革、发展、稳定提供坚强的政治思想和组织保证。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    一、坚持把队伍建设放在首要位置，进一步强化思想政治工作</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    把学习邓小平理论、“三个代表”重要思想与学习十八大精神结合起来，不断促进政治理论文化学习。按照武装头脑、指导实践、推动工作的要求，继续把学习贯彻活动新高潮向广度拓展、向浓度推进。通过教育培训、政治理论学习、交流讨论会和主题教育活动等形式，组织党员干部深入学习、深刻领会“三个代表”重要思想科学体系和十八大精神实质和内涵。坚持每月定期集中学习制度，加强对树立和落实科学观的理论学习，切实加强党员干部的政治建设，把经常性的学习教育作为培养干部战略思维能力，提高科学预见性和增强判断和决策能力的重要载体，切实从学习内容和学习方法上下功夫，进一步丰富学习内容，通过开展专题研讨会和专题讲座等形式，努力提高党员干部的学习成效。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    坚持理论联系实际，在实践中不断深化学习，在学习中不断加强实践，推进党建工作。在新时期加强党的建设，应认真做到在改进中加强，在加强中改进，把学习和实践结合起来，围绕市局中心工作工作和队伍建设整体发展要求，把加强党建工作与推进我局外事发展结合起来，切实解决外事工作中遇到的实际问题。按照市局党委和办公室党委的指示精神，完善和落实党委理论学习中心组和机关干部学习制度，保证全体民警集中学习的时间和质量，在内容安排上，把树立正确的政绩观作为重要内容，切实加强政绩观教育大力提倡服务、务实、清廉的党风政风，进一步推动一般党员干部的理论学习，组织观看有关党风廉政建设、优秀民警先进事迹等内容的教育片；邀请上级有关领导作政治理论学习和业务知识培训，组织上好党课。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    抓好组织生活规范化，积极推进组织建设。结合实际，合理安排，集中时间，组织召开民主生活会，抓好“三会一课”制度的落实，要坚持党支部每3个月召开一次党员大会，每月召开一次党支部委员会议，每月组织1至2次党日活动，每季度至少要上一次党课。要做到人员、内容、时间、记录四到位、四落实。坚持民主生活会制度正常化、制度化、规范化，通过召开民主生活会，开展批评与自我批评，认真查摆班子和个人在思想建设、工作作风等方面存在的问题，制订整改措施，认真加以整改，沟通思想、消除隔阂、促进团结。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    提高党支部的自主活动能力，不断丰富党支部活动形式、内容。集中全部精力做好学习、宣传、贯彻十八大工作，按照市局党委和办公室党委的的统一部署，开展十八大精神系列学习活动，定期组织学习讨论活动，树立正确的人生观、价值观和政绩观，不定期地与党员进行思想交流，及时了解掌握党员的思想情况，“七一”期间进行爱国主义教育，发扬廉洁自律，艰苦奋斗精神。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    严格执行廉政规定，带头做到廉洁自律，巩固和加强党风廉政建设。外事办公室班子成员、各级领导干部要按照与办公室党委签订《党风廉政建设责任书》的要求，率先垂范，加强自律，年底对《党风廉政建设责任书》执行情况进行考核；领导干部要严格执行《中国共产党党内监督条例（试行）》的规定，恪守“四大纪律，八项要求”，坚决执行廉洁自律和制止奢侈浪费等各项规定；定期根据实际情况，对《党风廉政建设责任书》、《中国共产党党内监督条例（试行）》的执行情况进行检查，对违纪违规的人员和不正之风进行严肃处理。 按照从严治党方针和市局党委、办公室党委要求，结合外事办公室实际情况，把干部监督贯穿于干部培养教育、考察考核、选拔任用、日常管理的各个环节，形成一个全方位、全过程、宽领域、多形式的干部监督体系，为首都外事工作进一步发展提供坚强的组织保证。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	    二、坚持把党建工作贯穿各项工作始终，切实提升党建工作水平</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	坚持“党建是核心、队建是根本”的政治理念，进一步强化基层党组织战斗堡垒作用。牢牢掌握党内思想发动和党建工作的主动权，坚持“靠前研究、提早部署、深入发动、环环相扣”的原则，始终确保全体民警思想上、认识上、行动上高度统一到市局党委决策部署上来，贯彻“抓党建、带队建、促发展”的工作思路。一是提升党建工作规范性。有效依托基层党组织网上系统建设，基层党组织工作逐步规范，党内组织生活有序开展，完成支委会、全体党员大会、民主生活会以及爱警党日活动等党建工作。二是创新学习型党支部新机制。根据市局党委提出的在监督和学习状态下学习的要求，开展外事工作业务培训机制，规范外事用语，把首都外事接待情况、公文写作、因公护照办理及护照管理、外事礼仪、参加使馆活动的要求等纳入培训课程，三是全面落实并细化爱警措施。把握工作节奏，科学部署警力，优化内部结构，盘活警力资源，使队伍张弛有度、劳逸结合，始终保持旺盛的斗志，帮助民警解决实际困难，努力解除民警的后顾之忧，增强爱警工作的实际效能，持续增强了队伍的凝聚力、战斗力。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	                                                                                                                                                                                                                                                                                                                                      2013年1月4日</FONT></P></TEXTFORMAT>','2013-01-04 08:07:46','臧德国'),(63768,23491,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">一是按照市局和办公室部署，组织全处党员领导干部和党员民警认真学习党的十八大精神，深刻领会其内涵，做到入脑入心。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">主要形式：观看十八大精神讲座视频，民警自学、交流等。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">二是结合春节各项工作开展，认真做好节日廉政关教育，组织领导干部和全体民警认真学习中央、市委市政府、公安部有关规定。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">主要形式：集中学习和自学相结合。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">三是组织党员民警观看电影《雷锋》，学习雷锋“为人民服务”的精神，把全心全意为人民服务作为公安工作的价值追求。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">主要形式：观看电影《雷锋》，组织开展学习、讨论活动。</FONT></P></TEXTFORMAT>','2013-01-05 07:58:21','高廷海'),(63769,23492,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"CENTER\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">外事办公室党支部一季度工作计划</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    按照市局和办公室党委工作部署和工作要求，结合外事办公室2013年党支部工作总体计划，密切联系工作实际，联系当前中心工作，积极开展理论学习、精心组织党日活动，制定周密工作安排，严格组织程序，认真抓好各项工作落实。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	一、每月至少召开一次支委会。支委会的内容，主要围绕学习、贯彻十八大这一中心工作，并结合办公室党委要求和工作安排，研究制定本支部学习内容和活动方案，加强支部组织领导，强化支部政治理论学习，不断加强支部委员自身的学习，不断提高支委的组织能力和领导能力，把支部工作提高到新的水平。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	二、每月至少组织一次党日活动。党日活动主要内容，紧密结合学习、宣传、贯彻十八大这一政治任务，贯彻到实际工作和队伍建设中，采取集中学习、座谈、讨论等形式，积极开展争先活动、党员建功活动，警示教育活动，理论研讨等主题实践活动。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	三、本季度至少召开一次党员大会。及时将市局及办公室党委有关学习、宣传、贯彻党的十八大精神，传达到全体党员，加强学习，深刻领会精神实质，认真贯彻落实市局和办公室党委各项工作部署。  </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    四、本季度至少召开一次民主生活会。民主生活会的内容，支部结合学习、贯彻十八大情况，组织开展民主生活会，谈体会、谈感想、谈经验、谈不足、谈发展，开展客观评议活动，努力提升我们的工作能力，努力提高我们的思想境界，努力确立我们的远大目标。  </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	本季度至少安排一次讲授党课。党课的内容，以深入学习党的十八大、贯彻党的十八大为主题，充分发挥支部引导作用，用党课的形式，讲解十八大，宣传十八大，结合实际工作贯彻十八大。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	                  </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	                                                                                                                                                                                                  外事办公室党支部</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	                                                                                                                                                                                                       2013年1月4日</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT>','2013-01-05 07:59:00','臧德国'),(63756,23483,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">2013年，是全面深入贯彻党的十八大精神的重要一年，也是我局按照科学发展观要求，继续依托创新型警务建设，全力“建设最安全世界城市，打造最廉洁警队”的关键之年。作为市局办公室的重要组成部分，文字、数据材料汇总起草部门，综合处将坚决贯彻落实市局党委、办公室党委的各项决策部署，以“两最”为目标，继续深入学习领会党的十八大精神，在学习中认知理论，在实践中探索创新，在工作中创先争优，在磨砺中锻造品格，切实将学习成果体现在党建、队建及日常工作中，进一步提高“三服务”能力，真正打造一支思想坚定、业务精通、作风过硬，让领导放心、与基层单位贴心的忠诚队伍，不辜负市局和办公室党委寄予的殷切厚望。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"><B>一是深入贯彻党的十八大精神，在学习中提高。</B>坚持在学习研究状态下工作，依托“三会一课”制度，启动综合处“学习年、党建年”工作，通过开展集中学习、座谈讨论和“走出去、请进来”等多种方式，深入学习领会党的十八大精神，坚持学以致用、用以促学，不断强化对国家“双百”发展目标、中国特色社会主义、科学发展观以及中国特色社会主义理论体系等观点、内涵的认识，准确把握党的十八大对公安工作提出的新要求，找准党的十八大精神与公安工作的结合点，坚定理想信念，坚守共产党人精神追求，把学习成果转化为谋划工作的思路、做好工作的动力，用科学的理论、创新的思维武装头脑，永葆忠诚本色，永葆队伍的先进性和纯洁性。在此基础上，紧紧围绕“党建是核心，队建是根本”的理念，将政治建警作为队伍建设主线，全面加强综合处党支部的思想、组织、作风、反腐倡廉和制度建设，进一步增强全处上下自我净化、自我完善、自我革新、自我提高能力，努力建设学习型、服务型、创新型队伍，提高履职能力，为更好的实现“三服务”奠定坚实基础。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"><B>二是认真总结固化经验成果，在继承中发展。</B>近年来，按照市局创新型警务建设部署，综合处从“三服务”大局出发，立足本职工作，面对“人手紧、任务重、要求高、时效强”等客观实际，主动思考、主动创新、转变思路，针对日常工作，组建了维稳、打击、治安、统计、内勤5个最小作战单元；针对掌握情况需要，建立了分组包点的全局联络员制度；针对重大安保工作，建立了“一日两会商”制度，处领导早晚召开现职领导会，通报当日情况，梳理工作，针对性部署；针对突发紧急任务，依托5个最小作战单元，建立了“小分工、大合作”的应急工作模式；针对领导交办任务，建立了“一把手盯办，主管处领导抓办，骨干力量主办”的“三办”模式；针对情况反映工作，建立了“常态账单化、专项即时化”情况反映模式；针对数据统计分析，与公安部和环首都七省区市公安机关建立了“绿色通道”和“直通车”，扩大对基层的数据共享范围，为基层打防工作提供依据。2013年，综合处将认真总结固化成功经验成果，紧密结合工作实际，在继承中逐步调整、完善、改进，进一步探索适应首都公安工作需要，服务领导决策、服务基层、服务中心工作的好方法、新形式，为更好地履职履责提供有力保障。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"><B>三是主动转变作风文风，在创新中进步。</B>把学习贯彻十八大精神引向深入，必须要有好的作风、好的文风来推动。近一阶段，中央、市里和市局党委先后就转变作风、文风作出了一系列重要部署。作为全局文字起草部门，综合处将迅速转变观念，将思想和行动统一到市局党委、办公室党委部署要求上来，在继续发挥原有机制、模式优势的基础上，主动适应形势发展、主动适应工作需要、主动调整工作模式，在转作风、改文风上发挥带头作用，在文字材料的鲜活性、指导性、借鉴性上再下功夫、再想办法，在转变作风文风上创新突破、锐意进取，真正实现与领导关注同步、与基层单位贴心、与实战需要对接，以实际行动不断将学习贯彻十八大精神引向深入。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">——在作风上，坚持贴近基层、走进一线。进一步抓好理论与联系的实际，坚持工作作风“向一线转变、向基层转变、向实战转变”，依托分组包点的全局联络员制度，加强与本系统、基层实战单位民警的联系沟通，采取“两个走进”的方式，面对面交流、面对面指导、面对面解决问题。其一是“走进本系统业务单位”，紧紧围绕文字材料起草工作，定期不定期走进各级办公室部门，加强文字材料起草工作交流，适时组织开展业务培训，及时掌握基层部门工作实际，及时掌握工作需求，及时解决工作中遇到的困惑和问题，拉近机关与基层间的距离，增强相互间业务交流、感情交流，共同提高文字材料撰写的能力和水平。其二是“走进基层实战一线”，作为机关单位，脱离基层、脱离一线、脱离实际工作是最容易出现的问题。为此，综合处将借此机会，从维稳、打击、治安管理、街面防控、社区管理等方面入手，分组定期走进基层一线，与民警一起座谈、一起学习、一道跟班作战，补好“基层”、“基础”课程，真正了解具体工作方法、发现工作部署与实际落实的差异点、挖掘基层实战工作的亮点，切实将基层实战所学、所看、所感体现在文字材料起草框架、内容上，体现在指导工作开展思路上，体现在文字材料的针对性、指导性、参考性上，更好地发挥以文辅政的作用。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">——在文风上，认真践行“短、实、新”，克服“长、空、假”。按照中央关于精简文件简报，改进文风的有关要求，努力在积极倡导、践行优良文风上下功夫。进一步突出文件思想性、针对性和可操作性，突出简报作为内部了解情况、学习交流的载体功能，重点反映重要动态、经验、问题和工作意见建议等内容。要以“减数量、提质量”为重点，紧密围绕中心任务、重点工作，精心组织，精益求精，及时反映警务动态、创新做法、典型经验等内容，切实提高文件简报的信息含量、参阅价值和指导借鉴作用，做到主题鲜明、结构严谨、重点突出、表述准确、意尽文止，原则上一般文件篇幅控制在3000字以内，简报篇幅控制在1500字以内，在此基础上，进一步提升市委、市政府、公安部等上级部门转发我局上报材料数量。此外，定期通报各单位报送简报采用情况，发挥优秀简报的引领示范作用，有效促进全局简报质量提高、文风转变。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"><B>四是将党风廉政与业务工作同部署，在实践中养成。</B>紧紧围绕“打造最廉洁警队”目标，继续狠抓党风廉政、纪律作风不放松，严格落实党风廉政建设责任制，将党风廉政与业务工作同部署、将党风廉政作为爱警工作的重要组成部分，采取“三定工作法”，即“定期学”，以党小组会、民主生活会为载体，定期组织全处党员民警围绕“廉政党课”系列教育、警示片等主题开展学习交流；“定期谈”，针对民警可能存在的思想波动，定期开展廉政谈话、提醒制度，对苗头性、倾向性问题早发现、早提醒、早纠正，时刻绷紧拒腐防变这根弦；“定期访”，定期深入民警家中，加强与民警家属的沟通联系，进一步延伸党风廉政责任制触角，及时发现、疏导、消除苗头，做到防患于未然。通过采取以上措施，努力做到“反腐倡廉常抓不懈，拒腐防变警钟长鸣”，进一步增强全体民警的政治意识、责任意识和党风廉政思想意识，时刻保持队伍的清风正气，永葆共产党人清正廉洁的政治本色。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT>','2013-01-05 07:51:09','高廷海'),(64374,23611,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">一、加强政治理论学习，提高党员的政治素质。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	1、组织全体党员民警继续认真学习胡锦涛总书记在党的十八大开幕式上所作报的告，通过深入领会报告中一系列新思想、新观点、新目标、新举措，进一步增强在党的带领下坚定不移沿着中国特色社会主义道路前进的决心和信心。同时认真贯彻市局党委扩大会精神，为“创建最安全的世界城市、打造最廉洁的警队”的奋斗目标做出新的更大的贡献。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">	2、组织全体党员民警继续认真学习了傅政华局长在市局基层党建工作会和第一党支部全体党员大会上的讲话精神，学习市局党委《关于进一步加强基层党组织建设的决定》及《实施意见》。牢固树立对党负责、为党分忧的政治意识和大局意识，以及打造廉洁警队、推动首都公安工作科学发展的责任意识和忧患意识。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">二、加强支部和党员的组织建设、思想建设和队伍建设。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    1、健全支部构成，及时补选新的支部成员（胡文滨），进一步规范支部日常工作，严格执行党内组织生活的各项要求，切实抓好“三会一课”制度的落实。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2、每季度至少召开一次党小组生活会，由各党小组组织党员进行思想工作汇报，深入了解并及时掌握党员的思想和工作情况。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    3、支部组织带领全体党员，积极践行“忠诚、为民、公正、廉洁”的人民警察核心价值观和“理性、平和、文明、规范”的执法理念，在各项公安工作中，充分发挥支部的战斗堡垒作用和党员干部的先锋模范作用。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">三、强化日常的教育监督机制，切实加强党风廉政建设。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    1、在一季度支部组织开展一次党风廉政教育，在党员干部中深入开展党风党纪教育，法制教育和警示教育，筑牢严守党纪国法的思想道德防线。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2、认真落实党风廉政建设责任制，严格执行各项相关规定，增强班子成员对各自职责内党风廉政工作的责任意识，严格执行责任追究制，确保党员干部在履职中廉洁奉公，确保单位风清源正。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">四、认真关注党员的工作和生活情况，继续做好爱警工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    1、关注党员在政治、业务学习上的进展和需求，积极鼓励并尽可能地提供方便和支持，为他们的成长进步创造有利条件。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2、及时了解党员及家庭在工作中和生活上遇到的问题和困难，及时开展有针对性的排忧解难工作，尽最大限度给党员以关心和支持，使爱警工作不断深入。</FONT></P></TEXTFORMAT>','2013-01-06 02:24:22','杨雅佳'),(66080,24058,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">1、总结2012年支部工作</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">2、研究2013年支部工作计划</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">3、学习贯彻市局2013年第一次党委扩大会议精神</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">4、按照市局党委和办公室党委要求，完成支部、党员评议等工作</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">5、完成“三会一课”规定动作</FONT></P></TEXTFORMAT>','2013-01-07 09:04:53','王冀阳'),(66308,24158,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2013年，政治处将根据市局党委和办公室党委关于加强党建工作的各项部署要求，深入学习贯彻党的十八大会议精神，紧紧围绕“建设最安全城市、打造最廉洁警队”目标，坚持以“三大支柱”为引领，按照“抓党建、带队建、促发展”的思路，结合工作实际，进一步加强基层党组织建设，狠抓队伍管理。特制定以下工作计划： </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合政治处党员队伍和业务工作实际，做好年度工作计划和每季度工作计划，确保本年度支部各项工作有序开展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    2. 按照建设学习型党组织的要求，加强日常政策理论和业务知识的学习。组织全体党员深入学习、深刻领会、广泛宣传、全面贯彻党的十八大会议精神，学习社会主义核心价值体系和全国“两会”精神，结合公安工作实际，及时组织学习中央和市委、市政府、公安部等上级单位的决策部署以及学习市局党委和办公室党委的部署要求，注重公安业务知识的学习积累，形成良好的学习氛围。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    3.严格落实党组织生活制度。坚持以党建带队建促发展，认真落实好“一岗双责”、“三会一课”等制度，开展好主题党日活动和支部文化建设，增强党员民警的组织观念。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    4. 以贯彻落实市局《关于进一步加强基层党组织建设的决定》、《关于贯彻落实市局党委进一步加强基层党组织建设决定的实施意见》等制度文件为契机，结合十八大会议精神的学习贯彻，进一步加强党支部建设，全面提升党建工作科学化水平，始终保持党员队伍的先进性和纯洁性。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    5.以建局65周年为主题，组织各项主题宣传教育活动。按照市局为期一年的主题宣传系统活动的具体要求，积极开展支部宣传教育活动的落实。采取组织参观、学习、讨论活动等多种方式，充分宣传和了解我局65年取得的辉煌成就和创新发展，不断激发全体民警积极投身首都公安事业。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    6.做好战时思想政治动员。围绕春节、五一、十一等重大节日以及六四等重要敏感日，特别是全国“两会”等重大活动安保工作，启动战时思想政治动员机制和政工民警驻在机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    7.认真开展党风廉政建设。围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，不断强化示范教育、警示教育、岗位廉政教育，切实筑牢思想防线，始终保持队伍风清气正。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">    8.切实落实各项爱警措施。结合工作需要和民警需求，采取座谈、走访、谈心等方式，充分了解和倾听民警心声，切实关爱民警，着力解决民警实际困难。</FONT></P></TEXTFORMAT>','2013-01-08 02:48:34','李明'),(66315,24163,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  根据2013年度工作计划安排，制定第一季度主要工作计划如下：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  1.总结2012年支部工作，制定2013年度和季度工作计划，确保本年度支部各项工作有序开展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  2.强化党组织活动，落实好三会一课制度，开展好相关主题党日活动，过好春节廉政关。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  3.按照市局和办公室党委的部署安排，继续开展十八大精神学习活动，抓好贯彻落实，全面推进工作。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  4.围绕“两节”、“两会”安保工作，做好战时思想政治动员。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">  5.按照市局党委和办公室党委要求，完成支部、党员评议等工作。</FONT></P></TEXTFORMAT>','2013-01-08 02:54:06','李明'),(67620,24601,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        工作总体思路是：以邓小平理论和&quot;三个代表&quot;重要思想为指导，深入学习贯彻党的十八大精神，牢固树立和全面落实科学发展观，围绕“打造最安全城市和最廉洁警队”的目标，全面加强党的思想建设、组织建设、作风建设和制度建设，增强服务意识，转变工作作风，提高工作效率，提升管理水平，为实现“两最”目标提供坚强的思想和组织保证。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        一、深入学习贯彻十八大精神，努力加强思想理论建设</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        继续抓好邓小平理论和“三个代表”重要思想的学习，深入贯彻党的十八大精神，认真抓好全国“两会”精神、科学发展观等学习活动，通过理论学习中心组读书会、专题报告会、学习交流会和知识竞赛等形式，把学习到的理论知识运用到实际工作中去，把党的执政能力建设体现在维护安全稳定上、做好信访工作上，落实在思想政治工作上，切实提高党员干部的思想政治素质和理论水平。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        二、全面加强党的基层组织建设，发挥党支部战斗堡垒作用，提高基层党组织的凝聚力</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （一）认真落实党风廉政建设责任制。进一步增强党员领导干部廉洁自律意识，组织党员认真学习贯彻并落实领导干部廉洁自律的各项规定，努力提高广大党员的党性修养。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （二）切实加强党支部班子建设。坚持以理论创新推动工作创新，大力加强支部班子思想理论建设。坚持和完善民主集中制，不断提高支部班子的凝聚力和战斗力。继续加强制度建设，更好地发挥制度在工作中的保障作用。进一步抓好党支部目标考核。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （三）不断创新支部工作方式。在丰富活动内容、改进活动方式、增强活动效果上下功夫，充分发挥党支部的战斗堡垒作用，保持支部争创先进的意识，以抓树典型引路，从领导干部、从党员民警做起，保持先进性党支部的奋斗目标。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        三、大力加强党员干部队伍建设，提高党员思想认识</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （一）加大党员干部教育力度，努力培养一支政治坚定、业务过硬、作风优良、学识丰富的高素质党员干部队伍，充分发挥党员干部队伍的先锋模范作用。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （二）把服务理念引入机关党建工作。紧密联系机关党员实际，坚持用科学发展观教育广大党员，以感情、信念、形象来凝聚党员、开展工作。逐步形成支部为党员服务，党员为群众服务的工作链条，发挥信访紧密联系群众的优势，使党建工作开展的有声有色。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        四、继续推进支部作风建设，不断提高队伍管理水平和工作效率</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （一）认真落实按照市局和办公室党委的要求，继续推进支部作风建设，使管理水平和工作效率再上新台阶。认真落实“三会一课”制度，确保每月召开支委会，每季度召开民主生活会等支部例会制度。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （二）进一步健全和完善已有的学习载体，形成浓厚的学习氛围，加强对党员民警的思想教育和业务知识培训，改进党员作风，树立窗口形象。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （三）加强队伍从严管理，坚持开展反腐倡廉教育，定期开展队伍摸排分析，防止发生违法违纪。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        五、结合信访实际工作，开展一系列党建队建活动</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （一）一季度开展以“解民忧、送温暖”为主题的活动，发挥党员先锋作用。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （二）二季度重点结合为民服务活动，开展专项群众工作，搞好争创“优秀服务群众标兵”活动。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （三）结合七一以及争优创先等系列活动，开展“为建设小康社会，在本职本职做贡献”活动。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">      （四）青年警队要发挥在党员队伍的先锋骨干和生力军作用，发扬不怕吃苦、勇于奉献的精神，并结合形势情况，开展一系列主题教育活动。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">                                                                                                                                  二〇一三年一月九日</FONT></P></TEXTFORMAT>','2013-01-09 07:44:37','罗瑛'),(67649,24615,1,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        第一季度主要结合两节和两会，支部开展各项活动：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        一是继续组织领导干部和党员民警认真学习领会十八大精神和总书记在全国政法工作会议上的讲话精神；。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        二是开展解民忧、送温暖活动，结合信访工作，按照市政府要求，对重点上访人员、确有经济困难、有帮扶需求的人员，在信访系统组织号召党员开展活动。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        三是按照市局、办公室党委打造“两最”的目标，加强对党员的反腐倡廉教育。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        四是针对两节和两会和工作要求，加强队伍摸排分析，严格队伍管理。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        五是两会期间，加强窗口单位作风建设，坚持树形象，带队伍，发扬党员先锋模范作用。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"16\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">        六是加强对车辆管理和有关交通管理会议精神的学习，确保车辆不发生问题。</FONT></P></TEXTFORMAT>','2013-01-09 07:59:49','罗瑛'),(71336,20901,3,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">秘书处能够根据市局党委和办公室党委部署要求，深入学习贯彻党的十八大会议精神，“抓党建、带队建、促发展”，以“三大支柱”为引领，结合秘书处队伍和业务工作实际，制定工作计划内容详实，重点突出，条理清楚，可操作性强。要注重在实操过程中逐步落实，避免流于形式，走过场。</FONT></P></TEXTFORMAT>','2013-01-16 08:59:33','政治处'),(71337,20901,4,NULL,'1','2013-01-16 08:59:33','办公室党委'),(71338,20905,3,NULL,'<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">好，要确保本季度支部各项工作有条不紊开展。</FONT></P></TEXTFORMAT>','2013-01-16 09:00:14','政治处'),(71339,20905,4,NULL,'1','2013-01-16 09:00:14','办公室党委');
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
INSERT INTO `pc_zzsh_stat` VALUES (3,'秘书处党支部',10,'0101',2012,0,2,2013,0,0,1,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(3,'秘书处党支部',10,'0101',2012,0,2,2013,0,0,4,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,0,2,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,0,3,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,0,5,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,0,6,1,1,0,0,1,'1.0000','0.0000','0.0000',44,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,0,7,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,1,8,1,1,0,0,1,'1.0000','0.0000','0.0000',7,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,1,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,2,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,2,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,3,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(3,'秘书处党支部',10,'0101',1325347200,0,2,2013,1,3,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(4,'政治处党支部',10,'0103',2012,0,2,2013,0,0,1,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(4,'政治处党支部',10,'0103',2012,0,2,2013,0,0,4,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,0,2,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,0,3,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,0,5,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,0,6,1,1,1,0,1,'1.0000','1.0000','0.0000',8,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,0,7,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,1,8,1,1,0,0,1,'1.0000','0.0000','0.0000',9,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,1,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,2,8,1,1,0,0,1,'1.0000','0.0000','0.0000',9,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,2,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,3,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(4,'政治处党支部',10,'0103',1325347200,0,2,2013,1,3,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(5,'研究室党支部',10,'0105',2007,0,2,2013,0,0,1,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(5,'研究室党支部',10,'0105',2007,0,2,2013,0,0,4,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,0,2,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,0,3,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,0,5,1,1,0,0,1,'1.0000','0.0000','0.0000',23,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,0,6,2,2,0,0,1,'1.0000','0.0000','0.0000',44,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,0,7,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,1,8,1,1,0,0,1,'1.0000','0.0000','0.0000',5,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,1,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,2,8,1,1,0,0,1,'1.0000','0.0000','0.0000',5,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,2,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,3,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(5,'研究室党支部',10,'0105',1194883200,0,2,2013,1,3,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(6,'综合处党支部',10,'0107',2012,0,2,2013,0,0,1,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(6,'综合处党支部',10,'0107',2012,0,2,2013,0,0,4,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,0,2,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,0,3,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,0,5,1,1,0,0,1,'1.0000','0.0000','0.0000',20,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,0,6,2,2,0,0,1,'1.0000','0.0000','0.0000',40,0,'1.0000',2,'1.0000',2,0,0,0,1,0,0,0,1),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,0,7,1,1,0,0,1,'1.0000','0.0000','0.0000',6,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,1,8,2,2,0,0,1,'1.0000','0.0000','0.0000',12,0,'1.0000',1,'0.5000',1,0,0,0,1,0,0,0,1),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,1,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,2,8,1,1,0,0,1,'1.0000','0.0000','0.0000',6,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,2,9,1,1,0,0,1,'1.0000','0.0000','0.0000',20,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,3,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(6,'综合处党支部',10,'0107',1325347200,0,2,2013,1,3,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(7,'信访处党支部',10,'0109',2012,0,2,2013,0,0,1,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(7,'信访处党支部',10,'0109',2012,0,2,2013,0,0,4,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,0,2,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,0,3,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,0,5,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,0,6,2,2,0,0,1,'1.0000','0.0000','0.0000',68,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,0,7,1,1,0,0,1,'1.0000','0.0000','0.0000',6,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,1,8,1,1,0,0,1,'1.0000','0.0000','0.0000',6,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,1,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,2,8,1,1,0,0,1,'1.0000','0.0000','0.0000',10,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,2,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,3,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(7,'信访处党支部',10,'0109',1325347200,0,2,2013,1,3,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',2012,0,2,2013,0,0,1,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(8,'档案处党支部',10,'0111',2012,0,2,2013,0,0,4,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,0,2,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,0,3,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,0,5,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,0,6,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,0,7,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,1,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,1,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,2,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,2,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,3,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(8,'档案处党支部',10,'0111',1325347200,0,2,2013,1,3,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(9,'外事办公室党支部',10,'0113',2012,0,2,2013,0,0,1,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(9,'外事办公室党支部',10,'0113',2012,0,2,2013,0,0,4,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,0,2,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,0,3,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,0,5,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,0,6,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,0,7,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,1,8,1,1,0,0,1,'1.0000','0.0000','0.0000',3,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,1,9,1,1,0,0,1,'1.0000','0.0000','0.0000',7,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,2,8,1,1,0,0,1,'1.0000','0.0000','0.0000',7,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,2,9,1,1,0,0,1,'1.0000','0.0000','0.0000',7,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,3,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(9,'外事办公室党支部',10,'0113',1325347200,0,2,2013,1,3,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(10,'新闻办党支部',10,'0115',2012,0,2,2013,0,0,1,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(10,'新闻办党支部',10,'0115',2012,0,2,2013,0,0,4,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,0,2,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,0,3,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,0,5,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,0,6,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,0,7,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,1,8,1,1,0,0,1,'1.0000','0.0000','0.0000',3,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,1,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,2,8,1,1,0,0,1,'1.0000','0.0000','0.0000',3,0,'1.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,2,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,3,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(10,'新闻办党支部',10,'0115',1325347200,0,2,2013,1,3,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',2012,0,2,2013,0,0,1,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(2216,'国际警务联络处党支部',10,'0116',2012,0,2,2013,0,0,4,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,0,2,1,1,0,0,1,'1.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,1),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,0,3,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,0,5,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,0,6,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,0,7,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,1,8,1,1,0,0,1,'1.0000','0.0000','0.0000',8,0,'1.0000',1,'1.0000',1,0,0,0,1,0,0,0,1),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,1,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,2,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,2,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,3,8,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0),(2216,'国际警务联络处党支部',10,'0116',1325347200,0,2,2013,1,3,9,0,0,0,0,0,'0.0000','0.0000','0.0000',0,0,'0.0000',0,'0.0000',0,0,0,0,0,0,0,0,0);
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

-- Dump completed on 2013-09-08 15:30:25
