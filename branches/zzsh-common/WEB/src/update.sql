2012-11-27维护

SELECT * FROM `pc_agency` WHERE substring(code, 1, 2)  > 14 and code is not null order by code

DELETE FROM `pc_workplan_content` WHERE workplan_id in (SELECT id FROM `pc_workplan` WHERE agency_id in ( SELECT id FROM `pc_agency` WHERE substring(code, 1, 2)  > 14 and code is not null )) 


DELETE FROM `pc_workplan` WHERE agency_id in ( SELECT id FROM `pc_agency` WHERE substring(code, 1, 2)  > 14 and code is not null )


DELETE FROM `pc_meeting_content` WHERE meeting_id in (  SELECT id FROM `pc_meeting` WHERE agency_id in ( SELECT id FROM `pc_agency` WHERE substring(code, 1, 2)  > 14 and code is not null)  )

DELETE FROM `pc_meeting_asence` WHERE meeting_id in (  SELECT id FROM `pc_meeting` WHERE agency_id in ( SELECT id FROM `pc_agency` WHERE substring(code, 1, 2)  > 14 and code is not null)  )

DELETE FROM `pc_meeting` WHERE agency_id in ( SELECT id FROM `pc_agency` WHERE substring(code, 1, 2)  > 14 and code is not null)

DELETE FROM pc_member WHERE agency_id in ( SELECT id FROM `pc_agency` WHERE substring(code, 1, 2)  > 14 and code is not null)

DELETE FROM pc_user WHERE privilege in ( SELECT id FROM `pc_agency` WHERE substring(code, 1, 2)  > 14 and code is not null)

DELETE FROM pc_user_role where user_id not in (select id from pc_user)

DELETE FROM `pc_agency` WHERE substring(code, 1, 2)  > 14 and code is not null 


2012-11-04 之后

ALTER TABLE `pc_agency` ADD `create_datetime` DATETIME NOT NULL AFTER `setup_datetime` ;

UPDATE pc_agency SET create_datetime = '2012-01-01';

ALTER TABLE `pc_agency` ADD `parent_id` INT( 11 ) UNSIGNED NOT NULL ;
update `pc_agency` as a left join pc_agency_relation as b on a.id =b.agency_id set a.parent_id = b.parent_id;

ALTER TABLE `pc_agency` ADD INDEX ( `parent_id` ) ;

ALTER TABLE `pc_agency` ADD `invalid_datetime` INT( 11 ) UNSIGNED NOT NULL AFTER `create_datetime` 






2012-11-04 之前

statusId == 2 改为 statusId == 3

update `pc_workplan` set `status_id` = 4 where `status_id` = 3
update `pc_workplan` set `status_id` = 3 where `status_id` = 2
update `pc_meeting` set `status_id` = 4 where `status_id` = 3
update `pc_meeting` set `status_id` = 3 where `status_id` = 2

update `pc_workplan_content` set type = 3 where type = 2;
update `pc_meeting_content` set type = 3 where type = 2;

update pc_meeting set month = month(meeting_datetime);

update `pc_meeting` as t1,pc_meeting_content as t2 set t2.updatetime =t1.`meeting_datetime` where   t1.id = t2.meeting_id

ALTER TABLE  `pc_agency` ADD INDEX (  `code_id` ) ;

ALTER TABLE  `pc_agency_relation` ADD INDEX (  `agency_id` ) ;
ALTER TABLE  `pc_agency_relation` ADD INDEX (  `parent_id` ) ;

ALTER TABLE  `pc_workplan` ADD INDEX (  `agency_id` ,  `type_id` ,  `year` ,  `quarter` ,  `status_id` ) ;
ALTER TABLE  `pc_workplan_content` ADD INDEX (  `workplan_id` ,  `type` ) ;
ALTER TABLE  `pc_meeting` ADD INDEX (  `agency_id` ,  `year` ,  `quarter` ,  `type_id`,  `status_id` ) ;
ALTER TABLE  `pc_meeting_content` CHANGE  `updatetime`  `updatetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT  '时间'
ALTER TABLE  `pc_meeting_content` ADD INDEX (  `meeting_id` ,  `type` ) ;

ALTER TABLE  `pc_member` ADD INDEX (  `agency_id` ,  `post_id` ) ;

UPDATE  `partycommittee`.`pc_agency` SET  `code_id` =  '8' WHERE  `pc_agency`.`id` =244;

ALTER TABLE  `pc_agency` ADD  `exp_date` DATE NOT NULL DEFAULT  '0000-00-00'

ALTER TABLE  `pc_remind_config` ADD  `delay_day` MEDIUMINT( 10 ) UNSIGNED NOT NULL DEFAULT  '0'

update pc_meeting set month = month(meeting_datetime) where type_id = 9;

浏览权，上报权，评语权，评价权、驳回权

browse
report
evaluate
rate
return


设置my.ini
event_scheduler=ON
max_connections= 2048 
key_buffer_size=512M
sort_buffer_size=16M
table_cache=512
max_allowed_packet = 10M
wait_timeout=7200


JDK 环境变量:

JAVA_HOME  

CLASSPATH: .;%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar
PATH: %JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;

CREATE TABLE IF NOT EXISTS `pc_bulletin` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` mediumtext NOT NULL,
  `member` varchar(50) NOT NULL,
  `is_index` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `expire_time` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


--
-- 表的结构 `pc_agency_stat`
--

--
-- 表的结构 `pc_agency_stat`
--

DROP TABLE IF EXISTS `pc_agency_stat`;
CREATE TABLE IF NOT EXISTS `pc_agency_stat` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='党支部统计表' AUTO_INCREMENT=1 ;

--
-- 表的结构 `pc_parent_stat`
--

DROP TABLE IF EXISTS `pc_parent_stat`;
CREATE TABLE IF NOT EXISTS `pc_parent_stat` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='党支部统计表' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `pc_remind_lock`;
CREATE TABLE IF NOT EXISTS `pc_remind_lock` (
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
  UNIQUE KEY `agency_id` (`agency_id`,`code_id`,`parent_id`,`year`,`quarter`,`month`,`type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='党支部提醒统计表' AUTO_INCREMENT=1 ;


DROP TABLE IF EXISTS `pc_remind`;
CREATE TABLE IF NOT EXISTS `pc_remind` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='党支部提醒统计表' AUTO_INCREMENT=1 ;


DROP TABLE IF EXISTS `pc_remind_stat`;
CREATE TABLE IF NOT EXISTS `pc_remind_stat` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='党支部提醒统计表' AUTO_INCREMENT=1 ;

--
-- 表的结构 `pc_roles`
--

DROP TABLE IF EXISTS `pc_roles`;
CREATE TABLE IF NOT EXISTS `pc_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(20) NOT NULL COMMENT '权限',
  `name` varchar(20) NOT NULL COMMENT '说明',
  `enable` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否可用 1=可以 0=停用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `pc_roles`
--

INSERT INTO `pc_roles` (`id`, `role`, `name`, `enable`) VALUES
(1, 'browse', '浏览权', 1),
(2, 'report', '上报权', 1),
(3, 'evaluate', '评语权', 1),
(4, 'rate', '评价权', 1),
(5, 'return', '驳回权', 1),
(6, 'delete', '删除', 1);


CREATE TABLE IF NOT EXISTS `pc_agency_stats` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned NOT NULL COMMENT '党支部ID',
  `name` varchar(255) NOT NULL COMMENT '党支部名称',
  `code_id` int(11) NOT NULL DEFAULT '0' COMMENT '党支部类型',
  `code` varchar(10) NOT NULL,
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='党建办党支部基本情况统计表' AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `pc_zzsh_stat` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) unsigned NOT NULL COMMENT '党支部ID',
  `name` varchar(255) NOT NULL COMMENT '党支部名称',
  `code_id` int(11) NOT NULL DEFAULT '0' COMMENT '党支部类型',
  `code` varchar(20) NOT NULL,
  `parent_id` int(11) unsigned NOT NULL COMMENT '上级党支部ID',
  `year` year(4) NOT NULL COMMENT '年度',
  `quarter` tinyint(1) unsigned NOT NULL COMMENT '季度',
  `month` smallint(5) unsigned NOT NULL COMMENT '季度',
  `type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会议类型',
  `total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实际召开数',
  `total_success` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一次成功上报数',
  `total_return` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '驳回上报数',
  `total_delay` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '补开补报情况',  
  `reported` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '规范执行情况',
  `reported_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '规范执行率',
  `return_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '驳回后上报率',
  `delay_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '逾期上报率',
  `attend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应出席人数',
  `asence` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '缺席人数',
  `attend_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '出席率',
  `eva` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已评价数',
  `eva_rate` decimal(6,4) NOT NULL DEFAULT '0.0000' COMMENT '评价率',
  `eva_1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价次数:好',
  `eva_2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价次数:较好',
  `eva_3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价次数:一般',
  `eva_4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价次数:差',
  `eva_1_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价率:好',
  `eva_2_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价率:较好',
  `eva_3_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价率:一般',
  `eva_4_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价率:差',  
  `agency_goodjob` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `agency_id` (`agency_id`,`code_id`,`parent_id`,`year`,`quarter`, `month`,`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='组织生活统计表' AUTO_INCREMENT=1 ;



导出党员花名册

SELECT T2.p_name as '最上级党委',T2.parent_name as '上级党委', T2.name as '支部名称', T2.code as  '党支部代码',T1.name  as '姓名', T3.description as '性别', T4.description as '民族',
DATE_FORMAT( T1.birthday,  '%Y-%m-%d' )  as '出生日期', DATE_FORMAT( T1.workday,  '%Y-%m-%d' )  as '参加工作年月',  DATE_FORMAT( T1.joinday,  '%Y-%m-%d' ) as '入党时间',
T5.description as '文化程度', T6.description as '行政职务', DATE_FORMAT( T1.postday,  '%Y-%m-%d' ) as '任党内职务时间', T1.birthplace as '籍贯', T1.address as '现在家庭住址'
FROM pc_member as T1 LEFT JOIN 
(
select h.name as p_name, g.* from
(select f.parent_id as p_id, e.* from
(select d.name as parent_name, d.id as parent_id, c.name,c.id, c.code FROM
(select a.id, a.name, a.code, b.parent_id from pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id) as c 
LEFT JOIN  pc_agency as d on c.parent_id = d.id ) as e
LEFT JOIN  pc_agency_relation as f on e.parent_id = f.agency_id) as g
LEFT JOIN  pc_agency as h on g.p_id = h.id
) as T2 ON T1.agency_id = T2.id
LEFT JOIN  pc_sex_code as T3 ON T1.sex_id = T3.id
LEFT JOIN  pc_nation_code as T4 on T1.nation_id = T4.id
LEFT JOIN  pc_edu_code as T5 on T1.edu_id = T5.id
LEFT JOIN  pc_duty_code as T6 on T1.duty_id = T6.id
order by T2.p_id, T2.parent_id, T2.id asc




检查及更新code

delimiter //
DROP procedure IF EXISTS update_agency_code//
CREATE PROCEDURE update_agency_code()
begin
	DECLARE done int default 0;
	DECLARE c_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;	
	DECLARE c_parent_id int(11) unsigned;	
	
	DECLARE u_code VARCHAR(20);
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	
  DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id,b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a.code is null;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

  open s_cursor; 
  SELECT FOUND_ROWS() into rows;
  SELECT rows;
  SET row = 0;
	cursor_loop:loop
			FETCH s_cursor into c_id, c_name, c_code_id, c_parent_id;
				SELECT c_name, c_parent_id;
				
			IF row >= rows then
				leave cursor_loop;
			end if;
				SET u_code = null;
			
				SELECT code into c_code FROM pc_agency where id = c_parent_id;
				SELECT c_code;
				SELECT max(code) into u_code from pc_agency where code like CONCAT (c_code, '%') and length(code) = length(c_code) + 2 ;
				
				IF u_code is null then
					SET u_code = CONCAT(c_code, '01');
				ELSE 
					SET u_code = LPAD(u_code + 2, length(c_code) + 2, 0);
			  END IF;
			  
			  SELECT u_code;
			  update pc_agency set code = u_code where id = c_id;
			SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
	
	
end;
//
delimiter ;



检查code

delimiter //
DROP procedure IF EXISTS check_agency_code//
CREATE PROCEDURE check_agency_code()
begin
	DECLARE done int default 0;
	DECLARE c_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;	
	DECLARE c_parent_id int(11) unsigned;	
	
	DECLARE c_parent_code VARCHAR(20);
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	
  DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code, a.code_id,b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id where a.code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

  open s_cursor; 
  SELECT FOUND_ROWS() into rows;
  SELECT rows;
  SET row = 0;
	cursor_loop:loop
			FETCH s_cursor into c_id, c_name, c_code, c_code_id, c_parent_id;
--			SELECT c_id,c_name;
				
			IF row >= rows then
				leave cursor_loop;
			end if;
			  if c_parent_id is not null then
						select code into c_parent_code from pc_agency where id = c_parent_id;
--						SELECT CONCAT(substring(c_code, 1, length(c_parent_code)), '----', c_parent_code);
--						SELECT c_parent_code;
						if substring(c_code, 1, length(c_parent_code)) <> c_parent_code THEN
							SELECT c_code, c_id, c_name, c_parent_code;
							SELECT CONCAT(substring(c_code, 1, length(c_parent_code)), '----', c_parent_code);
						END IF;
				END IF;
			SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
	
	
end;
//
delimiter ;



插入用户权限:


delimiter //
DROP procedure IF EXISTS update_user_role//
CREATE PROCEDURE update_user_role()
begin
	DECLARE done int default 0;
	DECLARE userId int(11) unsigned;
	DECLARE agencyId int(11) unsigned;
	DECLARE c_report tinyint(2) unsigned;
	DECLARE c_code_id int(11) unsigned;	
	DECLARE c_code VARCHAR(20);
	
	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	
  DECLARE s_cursor CURSOR FOR SELECT id, privilege, enable_report from pc_user order by id asc;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

  open s_cursor; 
  SELECT FOUND_ROWS() into rows;
  SELECT rows;
  SET row = 0;
	cursor_loop:loop
			FETCH s_cursor into userId, agencyId, c_report;
				
				
			IF row >= rows then
				leave cursor_loop;
			end if;
				
				
				SELECT code, code_id into c_code, c_code_id FROM pc_agency where id = agencyId;
				
				SELECT userId, agencyId,c_report, c_code_id;
				
				INSERT INTO pc_user_role VALUES (0, userId, 1);
				
				IF (c_code_id = 10 AND c_report = 1) THEN
						INSERT INTO pc_user_role VALUES (0, userId, 2);
				END IF;
				
				IF c_code_id = 6 THEN
					INSERT INTO pc_user_role VALUES (0, userId, 1);
					INSERT INTO pc_user_role VALUES (0, userId, 3);
					INSERT INTO pc_user_role VALUES (0, userId, 4);
					INSERT INTO pc_user_role VALUES (0, userId, 5);
					INSERT INTO pc_user_role VALUES (0, userId, 6);
				END IF;				
				
				IF c_code_id = 7 THEN
						INSERT INTO pc_user_role VALUES (0, userId, 3);
						INSERT INTO pc_user_role VALUES (0, userId, 4);					
				END IF;
								
				IF (c_code_id = 8 OR c_code_id = 15) THEN
						INSERT INTO pc_user_role VALUES (0, userId, 3);				
				END IF;
			SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
	
	
end;
//
delimiter ;


去掉重复的计划:



delimiter //
DROP procedure IF EXISTS remove_dup_workplan//
CREATE PROCEDURE remove_dup_workplan()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_type_id int(11) unsigned;
	DECLARE c_y VARCHAR(255);
	DECLARE c_q VARCHAR(20);
	DECLARE c_workplan_id int(11) unsigned;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;


	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
		
	DECLARE s_cursor CURSOR FOR select agency_id, type_id,year, quarter FROM (SELECT agency_id, type_id,year, quarter,count(*) as c FROM pc_workplan group by agency_id, type_id,year, quarter) as T where c > 1;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	  open s_cursor; 
	  SELECT FOUND_ROWS() into rows;
	  SET row = 0;
		cursor_loop:loop
		
				SET c_workplan_id = 0;
		
				FETCH s_cursor into c_id, c_type_id, c_y, c_q;
--				SELECT c_id, c_type_id, c_y, c_q;

				IF row >= rows then
					leave cursor_loop;
				end if;
				
				SELECT min(id) into c_workplan_id FROM  pc_workplan WHERE agency_id =c_id AND type_id = c_type_id AND YEAR = c_y AND quarter = c_q AND status_id >= 3;
				IF c_workplan_id is NULL THEN
					SELECT min(id) into c_workplan_id FROM  pc_workplan WHERE agency_id =c_id AND type_id = c_type_id AND YEAR = c_y AND quarter = c_q;
				END IF;
				
				SELECT c_workplan_id;
				
				IF c_workplan_id is not NULL THEN
					DELETE FROM pc_workplan_content WHERE workplan_id in ( SELECT id FROM  pc_workplan WHERE agency_id =c_id AND type_id = c_type_id AND YEAR = c_y AND quarter = c_q and id <> c_workplan_id  );
					DELETE FROM pc_workplan WHERE agency_id =c_id AND type_id = c_type_id AND YEAR = c_y AND quarter = c_q and id <> c_workplan_id;
				END IF;
				
				

				SET row = row + 1;
		end loop cursor_loop;
		close s_cursor;
		
		
		DELETE FROM pc_workplan_content WHERE workplan_id in ( SELECT id FROM  pc_workplan WHERE YEAR = 0000 );
		DELETE FROM pc_workplan  WHERE YEAR = 0000;
		
end;
//
delimiter ;



CREATE TABLE  `partycommittee`.`pc_license` (
`id` MEDIUMINT( 5 ) NOT NULL AUTO_INCREMENT ,
`attr` VARCHAR( 20 ) NOT NULL ,
`value` VARCHAR( 255 ) NOT NULL ,
PRIMARY KEY (  `id` )
) ENGINE = MYISAM;


INSERT INTO `pc_license` (`id`, `attr`, `value`) VALUES
(1, 'maxUser', '29A69E71B145E458');




INSERT INTO `pc_duty_code` (`id`, `code`, `description`) VALUES
(1, '001A', '书记'),
(2, '001B', '副书记'),
(3, '030U', '组织委员'),
(4, '031U', '宣传委员'),
(5, '034U', '纪检委员'),
(6, '035U', '青年委员'),
(7, '036U', '工会委员'),
(8, '037U', '保密委员'),
(10, '038U', '妇女委员'),
(14, '401A', '组长'),
(15, '0000', '其他');