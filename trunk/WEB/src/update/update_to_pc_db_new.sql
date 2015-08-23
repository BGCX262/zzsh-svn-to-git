
ALTER TABLE `pc_agency` DROP `ext;
DROP TABLE `pc_agency_stat`;
DROP TABLE `pc_parent_stat`;
RENAME TABLE `pc_db_new`.`pc_duty_code` TO `pc_db_new`.`pc_code_duty` ;
RENAME TABLE `pc_db_new`.`pc_edu_code` TO `pc_db_new`.`pc_code_edu` ;
RENAME TABLE `pc_db_new`.`pc_nation_code` TO `pc_db_new`.`pc_code_nation` ;

CREATE TABLE IF NOT EXISTS `pc_meeting_evaluate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned NOT NULL COMMENT '会议ID',
  `member_id` int(10) unsigned DEFAULT 0 COMMENT '评议人id',
  `member_name` varchar(50) DEFAULT '' COMMENT '评议人',
  `val` tinyint(1) unsigned DEFAULT 1,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `createtime` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `meeting_id` (`meeting_id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8 COMMENT='组织生活会议评语表' AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `pc_meeting_rate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned NOT NULL COMMENT '会议ID',
  `member_id` int(10) unsigned DEFAULT 0 COMMENT '评价人',
  `member_name` varchar(50) DEFAULT '' COMMENT '评价人',,
  `val` tinyint(1) unsigned DEFAULT 1,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `createtime` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `meeting_id` (`meeting_id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8 COMMENT='组织生活会议评价表' AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `pc_meeting_rate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned NOT NULL COMMENT '会议ID',
  `member_id` int(10) unsigned DEFAULT 0 COMMENT '评价人',
  `member_name` varchar(50) DEFAULT '' COMMENT '评价人',,
  `val` tinyint(1) unsigned DEFAULT 1,
  `createtime` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `meeting_id` (`meeting_id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8 COMMENT='组织生活会议驳回表' AUTO_INCREMENT=1 ;