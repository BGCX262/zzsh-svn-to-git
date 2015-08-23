delimiter //
DROP procedure IF EXISTS stat_remind//
CREATE PROCEDURE stat_remind()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_parent_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;
	DECLARE m smallint(5) unsigned;

  DECLARE rows int default 0;
  DECLARE row int default 0;
  DECLARE i int;
  DECLARE s tinyint;
	DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id, a.code, b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a. code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
			
		open s_cursor; 
	  SELECT FOUND_ROWS() into rows;
	  SET row = 0;
		cursor_loop:loop
				FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_parent_id;
				SELECT name into c_parent_name FROM pc_agency where id = c_parent_id;
				if row >= rows then
					leave cursor_loop;
				end if;		
				set i = 1;
				while i < 9 do	
				
					SET s = 0;
					SET y = year(now());
					SET q = quarter(now());		
					SET m = month(now());		
					IF (i = 1 OR i = 4) THEN
					   SET q = 0;
					END IF;
					
					IF i = 3 THEN
						 IF q = 1 THEN
						 	SET y = y -1;
						 	SET q = 4;
						 ELSE 
						 	SET q = q -1 ;
						 END IF;
					END IF;
					
					IF i = 4 THEN
						 SET y = y -1;
					END IF;
					IF i <= 4 THEN
			   				SELECT max(status_id) into s FROM pc_workplan WHERE agency_id = c_id AND year = y AND quarter = q AND type_id = i;
			   				IF  (s IS NULL OR s < 3) THEN
				   				SET s = 0;
								END IF;
								
					ELSE
							 IF i <> 8 THEN
							 	 SET m = 0;
							 END IF;
							 SELECT max(status_id) into s FROM pc_meeting WHERE agency_id = c_id AND year = y AND quarter = q and month = m AND type_id = i;
							 IF  (s IS NULL OR s < 3) THEN
				   				SET s = 0;
								END IF;
					END IF;	
					IF c_parent_id is not null THEN
						INSERT INTO  pc_remind (agency_id, name, code_id, code, parent_id, parent_name, year, quarter, type_id, status) 
						VALUES (c_id, c_name, c_code_id,c_code, c_parent_id, c_parent_name,  y, q, i, s) 			
						ON DUPLICATE KEY UPDATE status = s, name =c_name, code = c_code, parent_name = c_parent_name;
				  END IF;
			  
			  set i=i+1;
				end while;  
			  
				SET row = row + 1;
		end loop cursor_loop;
		close s_cursor;
		
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS stat_remind_stat//
CREATE PROCEDURE stat_remind_stat()
begin
	
	DECLARE done int default 0;
	DECLARE c_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;	
	DECLARE c_parent_id int(11) unsigned;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	
	DECLARE zb_num int(11) unsigned;

  DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id, a.code, b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a.code_id in (7,8,15);  
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

	

  open s_cursor; 
  SELECT FOUND_ROWS() into rows;
  SET row = 0;
	cursor_loop:loop
			FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_parent_id;
--			SELECT c_id;
			IF row >= rows then
				leave cursor_loop;
			end if;
			
			INSERT INTO pc_remind_stat (agency_id ,name ,code_id , code,parent_id ,year ,quarter ,type_id ,status ,c)
			SELECT * FROM
			(SELECT c_id as agency_id, c_name as name, c_code_id as code_id, c_code as code, c_parent_id as parent_id, year, quarter, type_id, status, SUM(c) as c FROM
			(select year ,quarter, type_id, status, count(*) as c FROM pc_remind 
			WHERE code like CONCAT(c_code, '%') GROUP BY code_id, parent_id, year ,quarter, type_id, status) as T1
			GROUP BY year ,quarter, type_id, status) AS T2
			ON DUPLICATE KEY UPDATE c = T2.c, name = T2.name, code = T2.code, code_id = T2.code_id;

			SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
							
											
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS check_remind_lock//
CREATE PROCEDURE check_remind_lock()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_parent_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_updatetime datetime;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q int(10) unsigned;
	DECLARE m int(10) unsigned;

  DECLARE rows int default 0;
  DECLARE row int default 0;
  DECLARE i int;
  DECLARE s tinyint(1) unsigned;
	DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id, a.code, b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a. code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
			
		open s_cursor; 
	  SELECT FOUND_ROWS() into rows;
	  SET row = 0;
		cursor_loop:loop
				FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_parent_id;
				SELECT name into c_parent_name FROM pc_agency where id = c_parent_id;
				if row >= rows then
					leave cursor_loop;
				end if;		
				set i = 1;
				while i < 9 do	
				
					SET s = 0;
					SET y = year(now());
					SET q = quarter(now());		
					SET m = 0;
					
					IF i = 1 THEN
						SET q = 0;
					END IF;
					
					IF (i = 3 OR i = 5 OR i = 6 OR i = 7) THEN
						SET q = q - 1;
						IF q = 0 THEN
							SET y = y -1;
						 	SET q = 4;					
						END IF;
					END IF;
					
					IF i = 4 THEN
						SET y = y - 1;
						SET q = 0;
					END IF;					
					
					IF i = 8 THEN
						SET m = month(now()) - 1;
						SET q = QUARTER(DATE_SUB(now(),interval 1 month));
						IF m = 0 THEN
							SET y = y - 1;
							SET m = 12;
							SET q = 4;
						END IF;
					END IF;
					
--					SELECT i, y, q, m;					
					
					
					IF i <= 4 THEN
			   			SELECT max(status_id) into s FROM pc_workplan WHERE agency_id = c_id AND year = y AND quarter = q AND type_id = i;
					ELSE
							SELECT max(status_id) into s FROM pc_meeting WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i;
					END IF;	
					
   				IF  s IS NULL THEN
	   				SET s = 0;
					END IF;								

					IF (c_parent_id is not null AND y >= 2012) THEN
							IF s < 2 THEN
								CALL set_remind_status(i, s);
							END IF;
							IF s = 2 THEN
								IF i<=4 THEN
									SELECT CONCAT(Date_Format(updatetime, '%Y-%m-%d'), ' 23:59:59') into c_updatetime FROM pc_workplan_content WHERE workplan_id in ( SELECT max(id) FROM pc_workplan WHERE agency_id = c_id AND year = y AND quarter = q AND type_id = i AND status_id = 2) AND type = 2;
								ELSE
									SELECT CONCAT(Date_Format(updatetime, '%Y-%m-%d'), ' 23:59:59') into c_updatetime FROM pc_meeting_content WHERE meeting_id in ( SELECT max(id) FROM pc_meeting WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i AND status_id = 2) AND type = 2;
								END IF;
								IF unix_timestamp(now()) > unix_timestamp(c_updatetime) THEN
									SET s = 9;
								END IF;
							END IF;
							

							if s = 9 THEN
									INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) 
									VALUES (c_id, c_name, c_code_id, c_code, c_parent_id, y , q, m, i, s)	ON DUPLICATE KEY UPDATE agency_id = c_id, name = c_name;
							END IF;		
							
															
				  END IF;
			  set i=i+1;
				end while;  
			  
				SET row = row + 1;
		end loop cursor_loop;
		close s_cursor;
		

		UPDATE pc_remind_lock set status = 9 WHERE status = 8 and delay_date < date_format(now(), '%Y-%m-%d');
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS set_remind_status//
CREATE PROCEDURE set_remind_status(t_id int, OUT status tinyint(1))
begin
	DECLARE y year(4);
	DECLARE e_y tinyint(1);
	DECLARE e_q tinyint(1) unsigned;
	DECLARE e_m smallint(5) unsigned;
	DECLARE e_d smallint(5) unsigned;
	DECLARE e_t varchar(20);
	DECLARE e_delay_day MEDIUMINT( 10 ) UNSIGNED;
	SET y = year(now());
	SELECT end_year, end_quarter, end_month, end_day, delay_day into e_y, e_q, e_m, e_d, e_delay_day FROM pc_remind_config WHERE type_id = t_id;

	
	IF (t_id  = 1 OR t_id = 4)  THEN 
		SET e_t = CONCAT(y, '-', e_m, '-', e_d, ' 23:59:59');
	END IF;
	
	IF (t_id = 2 OR t_id = 3)  THEN 
		SET e_t = concat(date_format(LAST_DAY(MAKEDATE(EXTRACT(YEAR FROM CURDATE()),1) + interval QUARTER(CURDATE())*3-3 month),'%Y-%m-'), e_d, ' 23:59:59');
  END IF;
  
	IF t_id > 4 AND t_id < 8 THEN
		SET e_t = CONCAT(LAST_DAY(MAKEDATE(EXTRACT(YEAR FROM CURDATE()),1) + interval QUARTER(CURDATE())*3-4 month), ' 23:59:59');
	END IF;
	
	IF t_id = 8 THEN
		SET e_t = CONCAT(LAST_DAY(now() - interval 1 month), ' 23:59:59');
	END IF;
	
	SET e_t = ADDDATE(e_t, e_delay_day);
	IF unix_timestamp(now()) > unix_timestamp(e_t) THEN
		SET status = 9;
	ELSE 
		SET status = 0;
	END IF;
	
end;
//
delimiter ;

delimiter //
DROP procedure IF EXISTS proc_agency_stats//
CREATE PROCEDURE proc_agency_stats()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_code VARCHAR(20);
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	
  DECLARE stat_zz_num int(10) unsigned;
  DECLARE stat_jc_num int(10) unsigned;	
  DECLARE stat_ejdw_num int(10) unsigned;
  DECLARE stat_dzj_num int(10) unsigned;
  DECLARE stat_dzb_num int(10) unsigned;
  DECLARE stat_more2year_num int(10) unsigned;
  DECLARE stat_less7_num int(10) unsigned;
  DECLARE stat_no_fsj_zbwy_num int(10) unsigned;
  DECLARE stat_dxz_num int(10) unsigned;
  DECLARE stat_dy_num int(10) unsigned;
  DECLARE stat_zbsj_num int(10) unsigned;
  DECLARE stat_zbfsj_num int(10) unsigned;
  DECLARE stat_zzwy_num int(10) unsigned;
  DECLARE stat_xcwy_num int(10) unsigned;
  DECLARE stat_jjwy_num int(10) unsigned;
  DECLARE stat_qnwy_num int(10) unsigned;
  DECLARE stat_ghwy_num int(10) unsigned;
  DECLARE stat_fnwy_num int(10) unsigned;
  DECLARE stat_bmwy_num int(10) unsigned;

	
	DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id, a.code, b.parent_id, a.setup_datetime,  a.p_count, a.zb_num FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a.code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  
  open s_cursor; 
  SELECT FOUND_ROWS() into rows;
  SET row = 0;
	cursor_loop:loop
			FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_parent_id, c_setup_datetime, stat_dxz_num, stat_dy_num;

		  SET stat_zz_num = 1;
		  SET stat_jc_num = 0;
		  SET stat_ejdw_num = 0;
		  SET stat_dzj_num = 0;
		  SET stat_dzb_num = 0;
		  SET stat_more2year_num = 0;
		  SET stat_less7_num = 0;
		  SET stat_no_fsj_zbwy_num = 0;
		  SET stat_zbsj_num = 0;
		  SET stat_zbfsj_num = 0;
		  SET stat_zzwy_num = 0;
		  SET stat_xcwy_num = 0;
		  SET stat_jjwy_num = 0;
		  SET stat_qnwy_num = 0;
		  SET stat_ghwy_num = 0;
		  SET stat_fnwy_num = 0;
		  SET stat_bmwy_num = 0;
			
			IF row >= rows then
				leave cursor_loop;
			end if;
			
			
			
--			党支部数量			
				SET stat_dzb_num = 1;
				
--      截止统计时间支部改选时间满两年的支部数				
				IF unix_timestamp(now()) > unix_timestamp(DATE_ADD(c_setup_datetime,INTERVAL 2 YEAR)) THEN
					SET stat_more2year_num = 1;
			  END IF;
			  
--			党员人数不足7人的党支部数量			  
--				SELECT COUNT(*) INTO stat_less7_num FROM pc_member where agency_id = c_id;
				IF stat_dy_num IS null THEN
					SET stat_dy_num = 0;
				END IF; 
			
				IF stat_dy_num < 7 THEN
					SET stat_less7_num = 1;
				ELSE 
					SET stat_less7_num = 0;
				END IF;


				
				SELECT COUNT(*) INTO stat_zbsj_num FROM pc_member where agency_id = c_id AND duty_id = 1;
				SELECT COUNT(*) INTO stat_zbfsj_num FROM pc_member where agency_id = c_id AND duty_id = 2;
				SELECT COUNT(*) INTO stat_zzwy_num FROM pc_member where agency_id = c_id AND duty_id = 3;
				SELECT COUNT(*) INTO stat_xcwy_num FROM pc_member where agency_id = c_id AND duty_id = 4;
				SELECT COUNT(*) INTO stat_jjwy_num FROM pc_member where agency_id = c_id AND duty_id = 5;
				SELECT COUNT(*) INTO stat_qnwy_num FROM pc_member where agency_id = c_id AND duty_id = 6;
				SELECT COUNT(*) INTO stat_fnwy_num FROM pc_member where agency_id = c_id AND duty_id = 10;
				SELECT COUNT(*) INTO stat_ghwy_num FROM pc_member where agency_id = c_id AND duty_id = 11;
				SELECT COUNT(*) INTO stat_bmwy_num FROM pc_member where agency_id = c_id AND duty_id = 8;
				
				
				
--			只设支部书记未设支部副书记、支部委员的支部数量
				SELECT COUNT(*) INTO stat_no_fsj_zbwy_num FROM pc_member where agency_id = c_id;
				IF (stat_no_fsj_zbwy_num = 1 AND stat_zbsj_num >= 1) THEN
					SET stat_no_fsj_zbwy_num = 1;
				ELSE
					SET stat_no_fsj_zbwy_num = 0;
				END IF;
				
			IF c_parent_id is not null THEN
				INSERT INTO pc_agency_stats (agency_id, name, code_id, code, parent_id, zz_num, jc_num, ejdw_num, dzj_num, dzb_num, more2year_num, less7_num, no_fsj_zbwy_num, dxz_num, dy_num, zbsj_num, zbfsj_num, zzwy_num, xcwy_num, jjwy_num, qnwy_num, ghwy_num, fnwy_num, bmwy_num) VALUES
				(c_id, c_name, c_code_id, c_code, c_parent_id, stat_zz_num, stat_jc_num, stat_ejdw_num, stat_dzj_num, stat_dzb_num, stat_more2year_num, stat_less7_num, stat_no_fsj_zbwy_num, stat_dxz_num, stat_dy_num, stat_zbsj_num, stat_zbfsj_num, stat_zzwy_num, stat_xcwy_num, stat_jjwy_num, stat_qnwy_num, stat_ghwy_num, stat_fnwy_num, stat_bmwy_num)
				ON DUPLICATE KEY UPDATE 
				name = c_name, 
				code_id = c_code_id, 
				code = c_code, 
				parent_id = c_parent_id, 
				zz_num = stat_zz_num,
				jc_num = stat_jc_num,
				ejdw_num = stat_ejdw_num, 
				dzj_num = stat_dzj_num, 
				dzb_num = stat_dzb_num, 
				more2year_num = stat_more2year_num, 
				less7_num = stat_less7_num, 
				no_fsj_zbwy_num = stat_no_fsj_zbwy_num, 
				dxz_num = stat_dxz_num, 
				dy_num = stat_dy_num, 
				zbsj_num = stat_zbsj_num, 
				zbfsj_num = stat_zbfsj_num, 
				zzwy_num = stat_zzwy_num, 
				xcwy_num = stat_xcwy_num, 
				jjwy_num = stat_jjwy_num, 
				qnwy_num = stat_qnwy_num, 
				ghwy_num = stat_ghwy_num, 
				fnwy_num = stat_fnwy_num, 
				bmwy_num = stat_bmwy_num;
			END IF;
			SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
end;
//
delimiter ;

delimiter //
DROP procedure IF EXISTS proc_parent_stats//
CREATE PROCEDURE proc_parent_stats()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_code VARCHAR(20);
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	
	
	DECLARE stat_zz_num int(10) unsigned;
  DECLARE stat_jc_num int(10) unsigned;		
  	
  DECLARE stat_ejdw_num int(10) unsigned;
  DECLARE stat_dzj_num int(10) unsigned;		
  
		
	DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id, a.code, b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a.code_id in (7,8,15);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  
  open s_cursor; 
  SELECT FOUND_ROWS() into rows;
  SET row = 0;
	cursor_loop:loop
			FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_parent_id;
			
		  SET stat_zz_num = 0;
		  SET stat_jc_num = 0;
		  SET stat_ejdw_num = 0;
		  SET stat_dzj_num = 0;

			IF row >= rows then
				leave cursor_loop;
			end if;
			IF c_code_id = 7 THEN
				SELECT COUNT(*) INTO stat_ejdw_num  FROM pc_agency WHERE code like CONCAT (c_code, '%') and code_id = 15;
				SELECT COUNT(*) INTO stat_dzj_num FROM pc_agency WHERE code like CONCAT (c_code, '%') and code_id = 8;
				SET stat_jc_num = 1;
			END IF;
			
			IF c_parent_id is not null THEN
				INSERT INTO pc_agency_stats (agency_id, name, code_id, code, parent_id, zz_num, jc_num, ejdw_num, dzj_num, dzb_num, more2year_num, less7_num, no_fsj_zbwy_num, dxz_num, dy_num, zbsj_num, zbfsj_num, zzwy_num, xcwy_num, jjwy_num, qnwy_num, ghwy_num, fnwy_num, bmwy_num)
				SELECT * FROM
				(SELECT  c_id as agency_id, c_name as name, c_code_id as code_id, c_code as  code, c_parent_id as  parent_id,
				(stat_jc_num + stat_ejdw_num + stat_dzj_num + SUM(dzb_num) ) as zz_num,
				stat_jc_num as jc_num,
				stat_ejdw_num as ejdw_num,
				stat_dzj_num as dzj_num,
				SUM(dzb_num) as dzb_num,
				SUM(more2year_num) as more2year_num,
				SUM(less7_num) as less7_num,
				SUM(no_fsj_zbwy_num) as no_fsj_zbwy_num,
				SUM(dxz_num) as dxz_num,
				SUM(dy_num) as dy_num,
				SUM(zbsj_num) as zbsj_num,
				SUM(zbfsj_num) as zbfsj_num,
				SUM(zzwy_num) as zzwy_num,
				SUM(xcwy_num) as xcwy_num,
				SUM(jjwy_num) as jjwy_num,
				SUM(qnwy_num) as qnwy_num,
				SUM(ghwy_num) as ghwy_num,
				SUM(fnwy_num) as fnwy_num,
				SUM(bmwy_num) as bmwy_num
				FROM pc_agency_stats 
				WHERE code like CONCAT (c_code, '%') and code_id = 10 ) AS T1
				ON DUPLICATE KEY UPDATE 
				name = c_name, 
				code_id = c_code_id, 
				code = c_code, 
				parent_id = c_parent_id, 
				zz_num = (CASE WHEN T1.zz_num is null THEN 0 ELSE T1.zz_NUM END),
				jc_num = (CASE WHEN T1.jc_num is null THEN 0 ELSE T1.jc_num END),
				ejdw_num =  (CASE WHEN T1.ejdw_num is null THEN 0 ELSE T1.ejdw_num END),
				dzj_num =  (CASE WHEN T1.dzj_num is null THEN 0 ELSE T1.dzj_num END),
				dzb_num = (CASE WHEN T1.dzb_num is null THEN 0 ELSE T1.dzb_num END), 
				more2year_num = (CASE WHEN T1.more2year_num is null THEN 0 ELSE T1.more2year_num END),
				less7_num = (CASE WHEN T1.less7_num is null THEN 0 ELSE T1.less7_num END),
				no_fsj_zbwy_num = (CASE WHEN T1.no_fsj_zbwy_num is null THEN 0 ELSE T1.no_fsj_zbwy_num END),
				dxz_num = (CASE WHEN T1.dxz_num is null THEN 0 ELSE T1.dxz_num END),
				dy_num = (CASE WHEN T1.dy_num is null THEN 0 ELSE T1.dy_num END),
				zbsj_num = (CASE WHEN T1.zbsj_num is null THEN 0 ELSE T1.zbsj_num END),
				zbfsj_num = (CASE WHEN T1.zbfsj_num is null THEN 0 ELSE T1.zbfsj_num END),
				zzwy_num = (CASE WHEN T1.zzwy_num is null THEN 0 ELSE T1.zzwy_num END),
				xcwy_num = (CASE WHEN T1.xcwy_num is null THEN 0 ELSE T1.xcwy_num END),
				jjwy_num = (CASE WHEN T1.jjwy_num is null THEN 0 ELSE T1.jjwy_num END),
				qnwy_num = (CASE WHEN T1.qnwy_num is null THEN 0 ELSE T1.qnwy_num END),
				ghwy_num = (CASE WHEN T1.ghwy_num is null THEN 0 ELSE T1.ghwy_num END),
				fnwy_num = (CASE WHEN T1.fnwy_num is null THEN 0 ELSE T1.fnwy_num END),
				bmwy_num = (CASE WHEN T1.bmwy_num is null THEN 0 ELSE T1.bmwy_num END);
			END IF;
			SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
	
	SELECT COUNT(CASE WHEN code_id = 7 THEN a.id END) INTO stat_jc_num FROM pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id where b.parent_id = 1;
	
	INSERT INTO pc_agency_stats (agency_id, name, code_id, code, parent_id, zz_num, jc_num, ejdw_num, dzj_num, dzb_num, more2year_num, less7_num, no_fsj_zbwy_num, dxz_num, dy_num, zbsj_num, zbfsj_num, zzwy_num, xcwy_num, jjwy_num, qnwy_num, ghwy_num, fnwy_num, bmwy_num)
	SELECT * FROM
	(SELECT  T1.parent_id as agency_id, T2.name, T2.code_id, T2.code, 0 as  parent_id,
	( stat_jc_num + SUM(ejdw_num) + SUM(dzj_num) + SUM(dzb_num) ) as zz_num,
	stat_jc_num as jc_num,
	SUM(ejdw_num) as ejdw_num,
	SUM(dzj_num) as dzj_num,
	SUM(dzb_num) as dzb_num,
	SUM(more2year_num) as more2year_num,
	SUM(less7_num) as less7_num,
	SUM(no_fsj_zbwy_num) as no_fsj_zbwy_num,
	SUM(dxz_num) as dxz_num,
	SUM(dy_num) as dy_num,
	SUM(zbsj_num) as zbsj_num,
	SUM(zbfsj_num) as zbfsj_num,
	SUM(zzwy_num) as zzwy_num,
	SUM(xcwy_num) as xcwy_num, 
	SUM(jjwy_num) as jjwy_num,
	SUM(qnwy_num) as qnwy_num,
	SUM(ghwy_num) as ghwy_num,
	SUM(fnwy_num) as fnwy_num,
	SUM(bmwy_num) as bmwy_num
	FROM pc_agency_stats as T1
	LEFT JOIN pc_agency as T2 on T1.parent_id = T2.id
	WHERE parent_id = 1 ) as T3
	ON DUPLICATE KEY UPDATE 
	name = T3.name,
	zz_num = (CASE WHEN T3.zz_num is null THEN 0 ELSE T3.zz_NUM END),
	jc_num = (CASE WHEN stat_jc_num is null THEN 0 ELSE stat_jc_num END),
	ejdw_num = (CASE WHEN T3.ejdw_num is null THEN 0 ELSE T3.ejdw_num END),
	dzj_num = (CASE WHEN T3.dzj_num is null THEN 0 ELSE T3.dzj_num END),
	dzb_num = (CASE WHEN T3.dzb_num is null THEN 0 ELSE T3.dzb_num END),
	more2year_num = (CASE WHEN T3.more2year_num is null THEN 0 ELSE T3.more2year_num END),
	less7_num = (CASE WHEN T3.less7_num is null THEN 0 ELSE T3.less7_num END),
	no_fsj_zbwy_num = (CASE WHEN T3.no_fsj_zbwy_num is null THEN 0 ELSE T3.no_fsj_zbwy_num END),
	dxz_num = (CASE WHEN T3.dxz_num is null THEN 0 ELSE T3.dxz_num END),
	dy_num = (CASE WHEN T3.dy_num is null THEN 0 ELSE T3.dy_num END),
	zbsj_num = (CASE WHEN T3.zbsj_num is null THEN 0 ELSE T3.zbsj_num END),
	zbfsj_num = (CASE WHEN T3.zbfsj_num is null THEN 0 ELSE T3.zbfsj_num END),
	zzwy_num = (CASE WHEN T3.zzwy_num is null THEN 0 ELSE T3.zzwy_num END),
	xcwy_num = (CASE WHEN T3.xcwy_num is null THEN 0 ELSE T3.xcwy_num END),
	jjwy_num = (CASE WHEN T3.jjwy_num is null THEN 0 ELSE T3.jjwy_num END),
	qnwy_num = (CASE WHEN T3.qnwy_num is null THEN 0 ELSE T3.qnwy_num END),
	ghwy_num = (CASE WHEN T3.ghwy_num is null THEN 0 ELSE T3.ghwy_num END),
	fnwy_num = (CASE WHEN T3.fnwy_num is null THEN 0 ELSE T3.fnwy_num END),
	bmwy_num = (CASE WHEN T3.bmwy_num is null THEN 0 ELSE T3.bmwy_num END);
	
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS stat_zzsh_year//
CREATE PROCEDURE stat_zzsh_year()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;
	DECLARE m smallint(5) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	
	DECLARE stat_reported int(10) unsigned;
	DECLARE stat_reported_rate DECIMAL(6,4) unsigned;	
	
	DECLARE stat_total int(10) unsigned;
	DECLARE stat_total_success int(10) unsigned;
	DECLARE stat_total_return int(10) unsigned;
	DECLARE stat_total_delay int(10) unsigned;
	DECLARE stat_return_rate DECIMAL(6,4) unsigned;
	DECLARE stat_delay_rate DECIMAL(6,4) unsigned;
	
	
	DECLARE stat_attend int(10) unsigned;
	DECLARE stat_asence int(10) unsigned;
	DECLARE stat_attend_rate DECIMAL(6,4) unsigned;

	DECLARE stat_eva int(10) unsigned;
	DECLARE stat_eva_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_1 int(10) unsigned;
	DECLARE stat_eva_2 int(10) unsigned;
	DECLARE stat_eva_3 int(10) unsigned;
	DECLARE stat_eva_4 int(10) unsigned;
	
	DECLARE stat_eva_1_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_2_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_3_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_4_rate DECIMAL(6,4) unsigned;

	DECLARE stat_agency_goodjob int(10) unsigned;

	
	DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id, a.code, setup_datetime, b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a. code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	  open s_cursor; 
	  SELECT FOUND_ROWS() into rows;
	  SET row = 0;
		cursor_loop:loop
				FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id;
--				SELECT c_id, c_name;

				IF row >= rows then
					leave cursor_loop;
				end if;
				SET i = 1;
				IF c_parent_id is not null THEN
					while i < 5 do	
					
						SET  stat_reported = 0;
						SET  stat_reported_rate = 0;
						
						SET  stat_total = 0;
						SET  stat_total_success = 0;
						SET  stat_total_return = 0;
						SET  stat_total_delay = 0;
						SET  stat_return_rate = 0;
						SET  stat_delay_rate = 0;

						SET  stat_attend = 0;
						SET  stat_asence = 0;
						SET  stat_attend_rate  = 0;
					
						SET  stat_eva = 0;
						SET  stat_eva_rate  = 0;
						SET  stat_eva_1 = 0;
						SET  stat_eva_2 = 0;
						SET  stat_eva_3 = 0;
						SET  stat_eva_4 = 0;
						SET  stat_eva_1_rate = 0;
						SET  stat_eva_2_rate = 0;
						SET  stat_eva_3_rate = 0;
						SET  stat_eva_4_rate = 0;								
					  SET  stat_agency_goodjob = 0;
						SET y = year(now());
						SET q = 0;
						SET m = month(now());
						
						
-- 				年度计划	q = 1 AND i = 1	
--			  年终总结	q = 4 AND i = 4					
--				季度计划和季度执行情况					

						IF (i = 1 OR i = 4) THEN
												SELECT COUNT(*) into stat_total FROM pc_workplan WHERE agency_id = c_id AND type_id = i AND year =y AND quarter = q AND status_id >= 3;
												SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock WHERE agency_id = c_id  AND year =y AND quarter = q AND type_id = i AND status = 8;
												SELECT COUNT(*) into stat_total_return FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id >= 3 AND b.type = 2;

												SELECT COUNT(*) into stat_eva FROM pc_workplan WHERE agency_id = c_id AND type_id = i AND year = y AND quarter = q AND status_id = 5;
												SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END) into stat_eva_1 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
												SELECT COUNT(CASE WHEN b.content = 2 THEN a.id END) into stat_eva_2 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
												SELECT COUNT(CASE WHEN b.content = 3 THEN a.id END) into stat_eva_3 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
												SELECT COUNT(CASE WHEN b.content = 4 THEN a.id END) into stat_eva_4 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;

																					
												IF (stat_total > 0) THEN
													SELECT 1 - stat_total_delay, ROUND( (1 - stat_total_delay)/1 , 4) into stat_reported, stat_reported_rate;
													SET stat_total_success = stat_total - stat_total_delay;
													
													IF stat_total_return > 0 THEN
														SET stat_return_rate = 1;
													END IF;
													
													IF stat_total_delay > 0 THEN
														SET stat_delay_rate = 1;
														SET stat_reported_rate = 0;
													END IF;
												END IF;
												
												IF (stat_eva > 0) THEN
													SET stat_eva = 1;
													SET stat_eva_rate = 1;
												ELSE 
													SET stat_eva = 0;
													SET stat_eva_rate = 0;
												END IF;
												
												IF stat_eva_1 > 0 THEN 
													SET stat_eva_1_rate = 1;
												END IF;
												
												IF stat_eva_2 > 0 THEN 
													SET stat_eva_2_rate = 1;
												END IF;
												
												IF stat_eva_3 > 0 THEN 
													SET stat_eva_3_rate = 1;
												END IF;
												
												IF stat_eva_4 > 0 THEN 
													SET stat_eva_4_rate = 1;
												END IF;																																				
												
												IF  stat_reported_rate = 1 THEN
														SET stat_agency_goodjob = 1;
												END IF;
												
												SET m = 0;


												IF stat_reported_rate is null THEN
													SET stat_reported_rate = 0;
												END IF;	
												
												IF stat_eva_rate is null THEN
													SET stat_eva_rate = 0;
												END IF;		
												
												IF stat_attend_rate is null THEN
													SET stat_attend_rate = 0;
												END IF;	
																		
												INSERT INTO pc_zzsh_stat (agency_id, name, code_id, code, setup_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES
												(c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id, y, q, m, i, stat_total, stat_total_success, stat_total_return, stat_total_delay, stat_reported, stat_reported_rate, stat_return_rate, stat_delay_rate, stat_attend, stat_asence, stat_attend_rate, stat_eva, stat_eva_rate, stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4, stat_eva_1_rate, stat_eva_2_rate, stat_eva_3_rate, stat_eva_4_rate, stat_agency_goodjob)
												ON DUPLICATE KEY UPDATE 
												name = c_name, code_id = c_code_id, code = c_code, parent_id = c_parent_id,
												total = stat_total, total_success = stat_total_success,  total_return = stat_total_return,  total_delay = stat_total_delay,  
												reported = stat_reported, reported_rate = stat_reported_rate,
												return_rate = stat_return_rate, delay_rate = stat_delay_rate,
												attend = stat_attend, asence = stat_asence, attend_rate = stat_attend_rate ,
												eva = stat_eva, eva_rate = stat_eva_rate,  eva_1 = stat_eva_1, eva_2 = stat_eva_2, eva_3 = stat_eva_3, eva_4 = stat_eva_4,
												eva_1_rate = stat_eva_1_rate, eva_2_rate = stat_eva_2_rate, eva_3_rate = stat_eva_3_rate, eva_4_rate = stat_eva_4_rate,
												agency_goodjob = stat_agency_goodjob;
						END IF;
						set i=i+1;
					end while;

				END IF;
				SET row = row + 1;
		end loop cursor_loop;
		close s_cursor;
		
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS stat_zzsh_quarter//
CREATE PROCEDURE stat_zzsh_quarter()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;
	DECLARE m smallint(5) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	DECLARE j int;
	
	DECLARE stat_reported int(10) unsigned;
	DECLARE stat_reported_rate DECIMAL(6,4) unsigned;	
	
	DECLARE stat_total int(10) unsigned;
	DECLARE stat_total_success int(10) unsigned;
	DECLARE stat_total_return int(10) unsigned;
	DECLARE stat_total_delay int(10) unsigned;
	DECLARE stat_return_rate DECIMAL(6,4) unsigned;
	DECLARE stat_delay_rate DECIMAL(6,4) unsigned;
	
	
	DECLARE stat_attend int(10) unsigned;
	DECLARE stat_asence int(10) unsigned;
	DECLARE stat_attend_rate DECIMAL(6,4) unsigned;

	DECLARE stat_eva int(10) unsigned;
	DECLARE stat_eva_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_1 int(10) unsigned;
	DECLARE stat_eva_2 int(10) unsigned;
	DECLARE stat_eva_3 int(10) unsigned;
	DECLARE stat_eva_4 int(10) unsigned;
	
	DECLARE stat_eva_1_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_2_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_3_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_4_rate DECIMAL(6,4) unsigned;

	DECLARE stat_agency_goodjob int(10) unsigned;

	
	DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id, a.code, a.setup_datetime, b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a. code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	  open s_cursor; 
	  SELECT FOUND_ROWS() into rows;
	  SET row = 0;
		cursor_loop:loop
				FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id;
--				SELECT c_id, c_name;

				IF row >= rows then
					leave cursor_loop;
				end if;
				SET i = 1;
				IF c_parent_id is not null THEN
					while i < 9 do	
						SET y = year(now());
						SET q = quarter(now());
						SET m = 0;
					
					
						SET j = 1;
						WHILE j <= q DO
										SET  stat_reported = 0;
										SET  stat_reported_rate = 0;
										
										SET  stat_total = 0;
										SET  stat_total_success = 0;
										SET  stat_total_return = 0;
										SET  stat_total_delay = 0;
										SET  stat_return_rate = 0;
										SET  stat_delay_rate = 0;
				
										SET  stat_attend = 0;
										SET  stat_asence = 0;
										SET  stat_attend_rate  = 0;
									
										SET  stat_eva = 0;
										SET  stat_eva_rate  = 0;
										SET  stat_eva_1 = 0;
										SET  stat_eva_2 = 0;
										SET  stat_eva_3 = 0;
										SET  stat_eva_4 = 0;
										SET  stat_eva_1_rate = 0;
										SET  stat_eva_2_rate = 0;
										SET  stat_eva_3_rate = 0;
										SET  stat_eva_4_rate = 0;								
									  SET  stat_agency_goodjob = 0;
				
										
										
				-- 				年度计划	q = 1 AND i = 1	
				--			  年终总结	q = 4 AND i = 4					
				--				季度计划和季度执行情况					
				
										IF (i = 2 OR i = 3) THEN
																SELECT COUNT(*) into stat_total FROM pc_workplan WHERE agency_id = c_id AND type_id = i AND year =y AND quarter = j AND status_id >= 3;
																SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock WHERE agency_id = c_id  AND year =y AND quarter = j AND type_id = i AND status = 8;
																SELECT COUNT(*) into stat_total_return FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id >= 3 AND b.type = 2;
				
																SELECT COUNT(*) into stat_eva FROM pc_workplan WHERE agency_id = c_id AND type_id = i AND year = y AND quarter = j AND status_id = 5;
																SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END) into stat_eva_1 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id = 5 AND b.type = 4;
																SELECT COUNT(CASE WHEN b.content = 2 THEN a.id END) into stat_eva_2 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id = 5 AND b.type = 4;
																SELECT COUNT(CASE WHEN b.content = 3 THEN a.id END) into stat_eva_3 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id = 5 AND b.type = 4;
																SELECT COUNT(CASE WHEN b.content = 4 THEN a.id END) into stat_eva_4 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id = 5 AND b.type = 4;
				
																									
																IF (stat_total > 0) THEN
																	SELECT 1 - stat_total_delay, ROUND( (1 - stat_total_delay)/1 , 4) into stat_reported, stat_reported_rate;
																	SET stat_total_success = stat_total - stat_total_delay;
																	
																	IF stat_total_return > 0 THEN
																		SET stat_return_rate = 1;
																	END IF;
																	
																	IF stat_total_delay > 0 THEN
																		SET stat_delay_rate = 1;
																		SET stat_reported_rate = 0;
																	END IF;
																END IF;
																
																IF (stat_eva > 0) THEN
																	SET stat_eva = 1;
																	SET stat_eva_rate = 1;
																ELSE 
																	SET stat_eva = 0;
																	SET stat_eva_rate = 0;
																END IF;
																
																IF stat_eva_1 > 0 THEN 
																	SET stat_eva_1_rate = 1;
																END IF;
																
																IF stat_eva_2 > 0 THEN 
																	SET stat_eva_2_rate = 1;
																END IF;
																
																IF stat_eva_3 > 0 THEN 
																	SET stat_eva_3_rate = 1;
																END IF;
																
																IF stat_eva_4 > 0 THEN 
																	SET stat_eva_4_rate = 1;
																END IF;																																				
																
																IF  stat_reported_rate = 1 THEN
																		SET stat_agency_goodjob = 1;
																END IF;
																
																IF stat_reported_rate is null THEN
																	SET stat_reported_rate = 0;
																END IF;	
																
																IF stat_eva_rate is null THEN
																	SET stat_eva_rate = 0;
																END IF;		
																
																IF stat_attend_rate is null THEN
																	SET stat_attend_rate = 0;
																END IF;	
																
																INSERT INTO pc_zzsh_stat (agency_id, name, code_id, code, setup_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES
																(c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id, y, j, m, i, stat_total, stat_total_success, stat_total_return, stat_total_delay, stat_reported, stat_reported_rate, stat_return_rate, stat_delay_rate, stat_attend, stat_asence, stat_attend_rate, stat_eva, stat_eva_rate, stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4, stat_eva_1_rate, stat_eva_2_rate, stat_eva_3_rate, stat_eva_4_rate, stat_agency_goodjob)
																ON DUPLICATE KEY UPDATE 
																name = c_name, code_id = c_code_id, code = c_code, parent_id = c_parent_id,
																total = stat_total, total_success = stat_total_success,  total_return = stat_total_return,  total_delay = stat_total_delay,  
																reported = stat_reported, reported_rate = stat_reported_rate,
																return_rate = stat_return_rate, delay_rate = stat_delay_rate,
																attend = stat_attend, asence = stat_asence, attend_rate = stat_attend_rate ,
																eva = stat_eva, eva_rate = stat_eva_rate,  eva_1 = stat_eva_1, eva_2 = stat_eva_2, eva_3 = stat_eva_3, eva_4 = stat_eva_4,
																eva_1_rate = stat_eva_1_rate, eva_2_rate = stat_eva_2_rate, eva_3_rate = stat_eva_3_rate, eva_4_rate = stat_eva_4_rate,
																agency_goodjob = stat_agency_goodjob;	

										END IF;
										
										IF (i = 5 OR i = 6 OR i =7)  THEN
												SELECT COUNT(*), sum(attend), sum(asence) into stat_total, stat_attend, stat_asence FROM pc_meeting WHERE agency_id = c_id AND type_id = i AND year =y AND quarter = j AND status_id >= 3;
												SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock WHERE agency_id = c_id  AND year =y AND quarter = j AND type_id = i AND status = 8;
												SELECT COUNT(*) into stat_total_return FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id >= 3 AND b.type = 2;

												SELECT COUNT(*) into stat_eva FROM pc_meeting WHERE agency_id = c_id AND type_id = i AND year = y AND quarter = j AND status_id = 5;
												SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END) into stat_eva_1 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id = 5 AND b.type = 4;
												SELECT COUNT(CASE WHEN b.content = 2 THEN a.id END) into stat_eva_2 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id = 5 AND b.type = 4;
												SELECT COUNT(CASE WHEN b.content = 3 THEN a.id END) into stat_eva_3 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id = 5 AND b.type = 4;
												SELECT COUNT(CASE WHEN b.content = 4 THEN a.id END) into stat_eva_4 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = j AND a.status_id = 5 AND b.type = 4;

												
												IF (stat_total > 0) THEN
													SELECT 1 - stat_total_delay, ROUND( (1 - stat_total_delay)/1 , 4) into stat_reported, stat_reported_rate;
													SET stat_total_success = stat_total - stat_total_delay;
													
													IF stat_total_return > 0 THEN
														SET stat_return_rate = 1;
													END IF;
													
													IF stat_total_delay > 0 THEN
														SET stat_delay_rate = 1;
														SET stat_reported_rate = 0;
													END IF;
												END IF;
												
												IF stat_eva is null THEN
													SET stat_eva = 0;
												END IF;												
												
												IF stat_eva_1 is null THEN
													SET stat_eva_1 = 0;
												END IF;	
												
												IF stat_eva_2 is null THEN
													SET stat_eva_2 = 0;
												END IF;			
												
												IF stat_eva_3 is null THEN
													SET stat_eva_3 = 0;
												END IF;			

												IF stat_eva_4 is null THEN
													SET stat_eva_4 = 0;
												END IF;																																												
												
												
												SET stat_eva_rate = ROUND(stat_eva/stat_total, 4);
												SET stat_eva_1_rate = ROUND(stat_eva_1/stat_eva, 4);
												SET stat_eva_2_rate = ROUND(stat_eva_2/stat_eva, 4);
												SET stat_eva_3_rate = ROUND(stat_eva_3/stat_eva, 4);
												SET stat_eva_4_rate = ROUND(stat_eva_4/stat_eva, 4);					
												
												
			
												IF stat_eva_1_rate is null THEN
													SET stat_eva_1_rate = 0;
												END IF;	
												
												IF stat_eva_2_rate is null THEN
													SET stat_eva_2_rate = 0;
												END IF;			
												
												IF stat_eva_3_rate is null THEN
													SET stat_eva_3_rate = 0;
												END IF;			

												IF stat_eva_4_rate is null THEN
													SET stat_eva_4_rate = 0;
												END IF;												
												
												
												IF stat_attend is null THEN
													SET stat_attend = 0;
												END IF;
												
												IF stat_asence is null THEN
													SET stat_asence = 0;
												END IF;			
												
												IF stat_attend >= stat_asence THEN
													SELECT ROUND(  (stat_attend - stat_asence)/ stat_attend , 4) into stat_attend_rate;
												ELSEIF stat_attend = 0 THEN
													SET stat_attend_rate = 0;
												END IF;												
												
												IF  stat_reported_rate = 1 THEN
														SET stat_agency_goodjob = 1;
												END IF;
														
												IF stat_reported_rate is null THEN
													SET stat_reported_rate = 0;
												END IF;	
												
												IF stat_eva_rate is null THEN
													SET stat_eva_rate = 0;
												END IF;		
												
												IF stat_attend_rate is null THEN
													SET stat_attend_rate = 0;
												END IF;	
												
												INSERT INTO pc_zzsh_stat (agency_id, name, code_id, code, setup_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES
												(c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id, y, j, m, i, stat_total, stat_total_success, stat_total_return, stat_total_delay, stat_reported, stat_reported_rate, stat_return_rate, stat_delay_rate, stat_attend, stat_asence, stat_attend_rate, stat_eva, stat_eva_rate, stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4, stat_eva_1_rate, stat_eva_2_rate, stat_eva_3_rate, stat_eva_4_rate, stat_agency_goodjob)
												ON DUPLICATE KEY UPDATE 
												name = c_name, code_id = c_code_id, code = c_code, parent_id = c_parent_id,
												total = stat_total, total_success = stat_total_success,  total_return = stat_total_return,  total_delay = stat_total_delay,  
												reported = stat_reported, reported_rate = stat_reported_rate,
												return_rate = stat_return_rate, delay_rate = stat_delay_rate,
												attend = stat_attend, asence = stat_asence, attend_rate = stat_attend_rate ,
												eva = stat_eva, eva_rate = stat_eva_rate,  eva_1 = stat_eva_1, eva_2 = stat_eva_2, eva_3 = stat_eva_3, eva_4 = stat_eva_4,
												eva_1_rate = stat_eva_1_rate, eva_2_rate = stat_eva_2_rate, eva_3_rate = stat_eva_3_rate, eva_4_rate = stat_eva_4_rate,
												agency_goodjob = stat_agency_goodjob;															
						
										END IF;										
										
									
										
										
								
								SET j = j + 1;		
								end while;
						set i=i+1;
					end while;

				END IF;
				SET row = row + 1;
		end loop cursor_loop;
		close s_cursor;
		
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS stat_zzsh_month//
CREATE PROCEDURE stat_zzsh_month()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;
	DECLARE m smallint(5) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	DECLARE j int;
	
	DECLARE stat_reported int(10) unsigned;
	DECLARE stat_reported_rate DECIMAL(6,4) unsigned;	
	
	DECLARE stat_total int(10) unsigned;
	DECLARE stat_total_success int(10) unsigned;
	DECLARE stat_total_return int(10) unsigned;
	DECLARE stat_total_delay int(10) unsigned;
	DECLARE stat_return_rate DECIMAL(6,4) unsigned;
	DECLARE stat_delay_rate DECIMAL(6,4) unsigned;
	
	
	DECLARE stat_attend int(10) unsigned;
	DECLARE stat_asence int(10) unsigned;
	DECLARE stat_attend_rate DECIMAL(6,4) unsigned;

	DECLARE stat_eva int(10) unsigned;
	DECLARE stat_eva_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_1 int(10) unsigned;
	DECLARE stat_eva_2 int(10) unsigned;
	DECLARE stat_eva_3 int(10) unsigned;
	DECLARE stat_eva_4 int(10) unsigned;
	
	DECLARE stat_eva_1_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_2_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_3_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_4_rate DECIMAL(6,4) unsigned;

	DECLARE stat_agency_goodjob int(10) unsigned;

	
	DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id, a.code, a.setup_datetime, b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a. code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	  open s_cursor; 
	  SELECT FOUND_ROWS() into rows;
	  SET row = 0;
		cursor_loop:loop
				FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id;
--				SELECT c_id, c_name;

				IF row >= rows then
					leave cursor_loop;
				end if;
				SET i = 8;
				IF c_parent_id is not null THEN
					while i <= 9 do	
						SET y = year(now());
						SET q = quarter(now());
						SET m = month(now());
					
					  IF (i = 8 OR i = 9) THEN
							SET j = 1;
							WHILE j <= m DO
											SET  stat_reported = 0;
											SET  stat_reported_rate = 0;
											
											SET  stat_total = 0;
											SET  stat_total_success = 0;
											SET  stat_total_return = 0;
											SET  stat_total_delay = 0;
											SET  stat_return_rate = 0;
											SET  stat_delay_rate = 0;
					
											SET  stat_attend = 0;
											SET  stat_asence = 0;
											SET  stat_attend_rate  = 0;
										
											SET  stat_eva = 0;
											SET  stat_eva_rate  = 0;
											SET  stat_eva_1 = 0;
											SET  stat_eva_2 = 0;
											SET  stat_eva_3 = 0;
											SET  stat_eva_4 = 0;
											SET  stat_eva_1_rate = 0;
											SET  stat_eva_2_rate = 0;
											SET  stat_eva_3_rate = 0;
											SET  stat_eva_4_rate = 0;								
										  SET  stat_agency_goodjob = 0;
					
											
											
											
													IF j < 4 THEN
														SET q = 1;
													END IF;
													
													IF (j > 3 AND j < 7) THEN
														SET q = 2;
													END IF;
													
													IF (j > 6 AND j < 10) THEN
														SET q = 3;
													END IF;
													
													IF (j > 9) THEN
														SET q = 4;
													END IF;									
													
											
													SELECT COUNT(*), sum(attend), sum(asence) into stat_total, stat_attend, stat_asence FROM pc_meeting WHERE agency_id = c_id AND type_id = i AND year =y AND quarter = q AND month = j AND status_id >= 3;
													SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock WHERE agency_id = c_id  AND year =y AND quarter = q AND month = j AND type_id = i AND status = 8;
													SELECT COUNT(*) into stat_total_return FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND month = j AND a.status_id >= 3 AND b.type = 2;
	
													SELECT COUNT(*) into stat_eva FROM pc_meeting WHERE agency_id = c_id AND type_id = i AND year = y AND quarter = q AND month = j AND status_id = 5;
													SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END) into stat_eva_1 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND month = j AND a.status_id = 5 AND b.type = 4;
													SELECT COUNT(CASE WHEN b.content = 2 THEN a.id END) into stat_eva_2 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND month = j AND a.status_id = 5 AND b.type = 4;
													SELECT COUNT(CASE WHEN b.content = 3 THEN a.id END) into stat_eva_3 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND month = j AND a.status_id = 5 AND b.type = 4;
													SELECT COUNT(CASE WHEN b.content = 4 THEN a.id END) into stat_eva_4 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND month = j AND a.status_id = 5 AND b.type = 4;
					
													
													IF (stat_total > 0) THEN
														SELECT 1 - stat_total_delay, ROUND( (1 - stat_total_delay)/1 , 4) into stat_reported, stat_reported_rate;
														SET stat_total_success = stat_total - stat_total_delay;
														
														IF stat_total_return > 0 THEN
															SET stat_return_rate = 1;
														END IF;
														
														IF stat_total_delay > 0 THEN
															SET stat_delay_rate = 1;
															SET stat_reported_rate = 0;
														END IF;
													END IF;
													
																	
													IF stat_eva is null THEN
														SET stat_eva = 0;
													END IF;												
													
													IF stat_eva_1 is null THEN
														SET stat_eva_1 = 0;
													END IF;	
													
													IF stat_eva_2 is null THEN
														SET stat_eva_2 = 0;
													END IF;			
													
													IF stat_eva_3 is null THEN
														SET stat_eva_3 = 0;
													END IF;			
	
													IF stat_eva_4 is null THEN
														SET stat_eva_4 = 0;
													END IF;														
																	
													SET stat_eva_rate = ROUND(stat_eva/stat_total, 4);
													SET stat_eva_1_rate = ROUND(stat_eva_1/stat_eva, 4);
													SET stat_eva_2_rate = ROUND(stat_eva_2/stat_eva, 4);
													SET stat_eva_3_rate = ROUND(stat_eva_3/stat_eva, 4);
													SET stat_eva_4_rate = ROUND(stat_eva_4/stat_eva, 4);					
													
													IF stat_eva_1_rate is null THEN
														SET stat_eva_1_rate = 0;
													END IF;	
													
													IF stat_eva_2_rate is null THEN
														SET stat_eva_2_rate = 0;
													END IF;			
													
													IF stat_eva_3_rate is null THEN
														SET stat_eva_3_rate = 0;
													END IF;			
	
													IF stat_eva_4_rate is null THEN
														SET stat_eva_4_rate = 0;
													END IF;													
													
													
													IF stat_attend is null THEN
														SET stat_attend = 0;
													END IF;
													
													IF stat_asence is null THEN
														SET stat_asence = 0;
													END IF;			
													
													IF stat_attend >= stat_asence THEN
														SELECT ROUND(  (stat_attend - stat_asence)/ stat_attend , 4) into stat_attend_rate;
													ELSEIF stat_attend = 0 THEN
														SET stat_attend_rate = 0;
													END IF;		
													
													IF  stat_reported_rate = 1 THEN
															SET stat_agency_goodjob = 1;
													END IF;
																
																
													IF stat_reported_rate is null THEN
														SET stat_reported_rate = 0;
													END IF;	
													
													IF stat_eva_rate is null THEN
														SET stat_eva_rate = 0;
													END IF;		
													
													IF stat_attend_rate is null THEN
														SET stat_attend_rate = 0;
													END IF;										
																		
													INSERT INTO pc_zzsh_stat (agency_id, name, code_id, code, setup_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES
													(c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id, y, q, j, i, stat_total, stat_total_success, stat_total_return, stat_total_delay, stat_reported, stat_reported_rate, stat_return_rate, stat_delay_rate, stat_attend, stat_asence, stat_attend_rate, stat_eva, stat_eva_rate, stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4, stat_eva_1_rate, stat_eva_2_rate, stat_eva_3_rate, stat_eva_4_rate, stat_agency_goodjob)
													ON DUPLICATE KEY UPDATE 
													name = c_name, code_id = c_code_id, code = c_code, parent_id = c_parent_id,
													total = stat_total, total_success = stat_total_success,  total_return = stat_total_return,  total_delay = stat_total_delay,  
													reported = stat_reported, reported_rate = stat_reported_rate,
													return_rate = stat_return_rate, delay_rate = stat_delay_rate,
													attend = stat_attend, asence = stat_asence, attend_rate = stat_attend_rate ,
													eva = stat_eva, eva_rate = stat_eva_rate,  eva_1 = stat_eva_1, eva_2 = stat_eva_2, eva_3 = stat_eva_3, eva_4 = stat_eva_4,
													eva_1_rate = stat_eva_1_rate, eva_2_rate = stat_eva_2_rate, eva_3_rate = stat_eva_3_rate, eva_4_rate = stat_eva_4_rate,
													agency_goodjob = stat_agency_goodjob;										
	
									
									SET j = j + 1;		
									end while;
							END IF;
						set i=i+1;
					end while;

				END IF;
				SET row = row + 1;
		end loop cursor_loop;
		close s_cursor;
		
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS stat_zzsh_new_year//
CREATE PROCEDURE stat_zzsh_new_year()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;
	DECLARE m smallint(5) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	DECLARE j int;
	
	DECLARE stat_reported int(10) unsigned;
	DECLARE stat_reported_rate DECIMAL(6,4) unsigned;	
	
	DECLARE stat_total int(10) unsigned;
	DECLARE stat_total_success int(10) unsigned;
	DECLARE stat_total_return int(10) unsigned;
	DECLARE stat_total_delay int(10) unsigned;
	DECLARE stat_return_rate DECIMAL(6,4) unsigned;
	DECLARE stat_delay_rate DECIMAL(6,4) unsigned;
	
	
	DECLARE stat_attend int(10) unsigned;
	DECLARE stat_asence int(10) unsigned;
	DECLARE stat_attend_rate DECIMAL(6,4) unsigned;

	DECLARE stat_eva int(10) unsigned;
	DECLARE stat_eva_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_1 int(10) unsigned;
	DECLARE stat_eva_2 int(10) unsigned;
	DECLARE stat_eva_3 int(10) unsigned;
	DECLARE stat_eva_4 int(10) unsigned;
	
	DECLARE stat_eva_1_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_2_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_3_rate DECIMAL(6,4) unsigned;
	DECLARE stat_eva_4_rate DECIMAL(6,4) unsigned;

	DECLARE stat_agency_goodjob int(10) unsigned;

	
	DECLARE s_cursor CURSOR FOR SELECT a.id, a.name, a.code_id, a.code, a.setup_datetime, b.parent_id FROM  pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id WHERE a. code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
--  处理跨年和跨季度的情况 开始
	  open s_cursor; 
	  SELECT FOUND_ROWS() into rows;
	  SET row = 0;
		cursor_loop:loop
				FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id;


				
				IF row >= rows then
					leave cursor_loop;
				end if;
				SET i = 1;
				IF c_parent_id is not null THEN
					while i <= 9 do	
					
						SET  stat_reported = 0;
						SET  stat_reported_rate = 0;
						
						SET  stat_total = 0;
						SET  stat_total_success = 0;
						SET  stat_total_return = 0;
						SET  stat_total_delay = 0;
						SET  stat_return_rate = 0;
						SET  stat_delay_rate = 0;

						SET  stat_attend = 0;
						SET  stat_asence = 0;
						SET  stat_attend_rate  = 0;
					
						SET  stat_eva = 0;
						SET  stat_eva_rate  = 0;
						SET  stat_eva_1 = 0;
						SET  stat_eva_2 = 0;
						SET  stat_eva_3 = 0;
						SET  stat_eva_4 = 0;
						SET  stat_eva_1_rate = 0;
						SET  stat_eva_2_rate = 0;
						SET  stat_eva_3_rate = 0;
						SET  stat_eva_4_rate = 0;								
					  SET stat_agency_goodjob = 0;
					
						SET y = year(now());
						SET q = quarter(now());		
						SET m = month(now());
						
--			  年终总结	q = 4 AND i = 4					
--				季度计划和季度执行情况					
						IF i = 3 THEN
										IF q = 1 THEN
									 		SET y = y -1;
											SET q = 4;
										ELSE 
											SET q = q - 1;
										END IF;
							
							
										SELECT COUNT(*) into stat_total FROM pc_workplan WHERE agency_id = c_id AND type_id = i AND year =y AND quarter = q AND status_id >= 3;
										SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock WHERE agency_id = c_id  AND year =y AND quarter = q AND type_id = i AND status = 8;
										SELECT COUNT(*) into stat_total_return FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id >= 3 AND b.type = 2;
										SELECT COUNT(*) into stat_eva FROM pc_workplan WHERE agency_id = c_id AND type_id = i AND year = y AND quarter = q AND status_id = 5;
										SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END) into stat_eva_1 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
										SELECT COUNT(CASE WHEN b.content = 2 THEN a.id END) into stat_eva_2 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
										SELECT COUNT(CASE WHEN b.content = 3 THEN a.id END) into stat_eva_3 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
										SELECT COUNT(CASE WHEN b.content = 4 THEN a.id END) into stat_eva_4 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
				
												IF (stat_total > 0) THEN
													SELECT 1 - stat_total_delay, ROUND( (1 - stat_total_delay)/1 , 4) into stat_reported, stat_reported_rate;
													SET stat_total_success = stat_total - stat_total_delay;
													
													IF stat_total_return > 0 THEN
														SET stat_return_rate = 1;
													END IF;
													
													IF stat_total_delay > 0 THEN
														SET stat_delay_rate = 1;
														SET stat_reported_rate = 0;
													END IF;
												END IF;
												
												IF (stat_eva > 0) THEN
													SET stat_eva = 1;
													SET stat_eva_rate = 1;
												ELSE 
													SET stat_eva = 0;
													SET stat_eva_rate = 0;
												END IF;
												
												IF stat_eva_1 > 0 THEN 
													SET stat_eva_1_rate = 1;
												END IF;
												
												IF stat_eva_2 > 0 THEN 
													SET stat_eva_2_rate = 1;
												END IF;
												
												IF stat_eva_3 > 0 THEN 
													SET stat_eva_3_rate = 1;
												END IF;
												
												IF stat_eva_4 > 0 THEN 
													SET stat_eva_4_rate = 1;
												END IF;				
												
												IF stat_attend is null THEN
													SET stat_attend = 0;
												END IF;
												
												IF stat_asence is null THEN
													SET stat_asence = 0;
												END IF;			
										
												SET m = 0;
												
												IF stat_reported_rate is null THEN
													SET stat_reported_rate = 0;
												END IF;	
										
												IF  stat_reported_rate = 1 THEN
														SET stat_agency_goodjob = 1;
												END IF;
										
									INSERT INTO pc_zzsh_stat (agency_id, name, code_id, code, setup_datetime,  parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES
									(c_id, c_name, c_code_id, c_code,  c_setup_datetime,  c_parent_id, y, q, m, i, stat_total, stat_total_success, stat_total_return, stat_total_delay, stat_reported, stat_reported_rate, stat_return_rate, stat_delay_rate, stat_attend, stat_asence, stat_attend_rate, stat_eva, stat_eva_rate, stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4, stat_eva_1_rate, stat_eva_2_rate, stat_eva_3_rate, stat_eva_4_rate, stat_agency_goodjob)
									ON DUPLICATE KEY UPDATE 
									name = c_name, code_id = c_code_id, code = c_code, parent_id = c_parent_id,
									total = stat_total, total_success = stat_total_success,  total_return = stat_total_return,  total_delay = stat_total_delay,  
									reported = stat_reported, reported_rate = stat_reported_rate, 
									return_rate = stat_return_rate, delay_rate = stat_delay_rate,
									attend = stat_attend, asence = stat_asence, attend_rate = stat_attend_rate ,
									eva = stat_eva, eva_rate = stat_eva_rate,  eva_1 = stat_eva_1, eva_2 = stat_eva_2, eva_3 = stat_eva_3, eva_4 = stat_eva_4,
									eva_1_rate = stat_eva_1_rate, eva_2_rate = stat_eva_2_rate, eva_3_rate = stat_eva_3_rate, eva_4_rate = stat_eva_4_rate,
									agency_goodjob = stat_agency_goodjob;				
	
						END IF;
						
						
						IF (q = 1 AND i = 4) THEN
										
										SET y = y -1;
										SET q = 4;
									
										SELECT COUNT(*) into stat_total FROM pc_workplan WHERE agency_id = c_id AND type_id = i AND year =y AND quarter = q AND status_id >= 3;
										SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock WHERE agency_id = c_id  AND year =y AND quarter = q AND type_id = i AND status = 8;
										SELECT COUNT(*) into stat_total_return FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id >= 3 AND b.type = 2;
										SELECT COUNT(*) into stat_eva FROM pc_workplan WHERE agency_id = c_id AND type_id = i AND year = y AND quarter = q AND status_id = 5;
										SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END) into stat_eva_1 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
										SELECT COUNT(CASE WHEN b.content = 2 THEN a.id END) into stat_eva_2 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
										SELECT COUNT(CASE WHEN b.content = 3 THEN a.id END) into stat_eva_3 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
										SELECT COUNT(CASE WHEN b.content = 4 THEN a.id END) into stat_eva_4 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
				
												IF (stat_total > 0) THEN
													SELECT 1 - stat_total_delay, ROUND( (1 - stat_total_delay)/1 , 4) into stat_reported, stat_reported_rate;
													SET stat_total_success = stat_total - stat_total_delay;
													
													IF stat_total_return > 0 THEN
														SET stat_return_rate = 1;
													END IF;
													
													IF stat_total_delay > 0 THEN
														SET stat_delay_rate = 1;
														SET stat_reported_rate = 0;
													END IF;
												END IF;
												
												IF (stat_eva > 0) THEN
													SET stat_eva = 1;
													SET stat_eva_rate = 1;
												ELSE 
													SET stat_eva = 0;
													SET stat_eva_rate = 0;
												END IF;
												
												IF stat_eva_1 > 0 THEN 
													SET stat_eva_1_rate = 1;
												END IF;
												
												IF stat_eva_2 > 0 THEN 
													SET stat_eva_2_rate = 1;
												END IF;
												
												IF stat_eva_3 > 0 THEN 
													SET stat_eva_3_rate = 1;
												END IF;
												
												IF stat_eva_4 > 0 THEN 
													SET stat_eva_4_rate = 1;
												END IF;				
												
												IF stat_attend is null THEN
													SET stat_attend = 0;
												END IF;
												
												IF stat_asence is null THEN
													SET stat_asence = 0;
												END IF;			
										
												SET m = 0;
												
												IF stat_reported_rate is null THEN
													SET stat_reported_rate = 0;
												END IF;	
												
												IF  stat_reported_rate = 1 THEN
														SET stat_agency_goodjob = 1;
												END IF;												
								
										
									INSERT INTO pc_zzsh_stat (agency_id, name, code_id, code,  setup_datetime,  parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES
									(c_id, c_name, c_code_id, c_code,  c_setup_datetime,  c_parent_id, y, q, m, i, stat_total, stat_total_success, stat_total_return, stat_total_delay, stat_reported, stat_reported_rate, stat_return_rate, stat_delay_rate, stat_attend, stat_asence, stat_attend_rate, stat_eva, stat_eva_rate, stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4, stat_eva_1_rate, stat_eva_2_rate, stat_eva_3_rate, stat_eva_4_rate, stat_agency_goodjob )
									ON DUPLICATE KEY UPDATE 
									name = c_name, code_id = c_code_id, code = c_code, parent_id = c_parent_id,
									total = stat_total, total_success = stat_total_success,  total_return = stat_total_return,  total_delay = stat_total_delay,  
									reported = stat_reported, reported_rate = stat_reported_rate, 
									return_rate = stat_return_rate, delay_rate = stat_delay_rate,
									attend = stat_attend, asence = stat_asence, attend_rate = stat_attend_rate ,
									eva = stat_eva, eva_rate = stat_eva_rate,  eva_1 = stat_eva_1, eva_2 = stat_eva_2, eva_3 = stat_eva_3, eva_4 = stat_eva_4,
									eva_1_rate = stat_eva_1_rate, eva_2_rate = stat_eva_2_rate, eva_3_rate = stat_eva_3_rate, eva_4_rate = stat_eva_4_rate,
									agency_goodjob = stat_agency_goodjob;			

						END IF;	
						
						set i=i+1;
					end while;

				END IF;
				SET row = row + 1;
		end loop cursor_loop;
		close s_cursor;		
		
--  处理跨年和跨季度的情况 结束		
end;
//
delimiter ;


delimiter //
DROP PROCEDURE IF EXISTS `stats_remind_process`//
CREATE PROCEDURE `stats_remind_process`()
BEGIN
    SELECT IS_FREE_LOCK('event_stats_remind_lock') INTO @event_stats_remind_lock_isfree;
    IF (@event_stats_remind_lock_isfree = 1) THEN
        SELECT GET_LOCK('event_stats_remind_lock', 10) INTO @event_stats_remind_lock_isfree;
        IF (@event_stats_remind_lock_isfree = 1) THEN
            CALL stat_remind();
            CALL stat_remind_stat();            
        END IF;
        SELECT RELEASE_LOCK('event_stats_remind_lock');
    END IF;
END //
delimiter ;


delimiter //
DROP PROCEDURE IF EXISTS `stats_process`//
CREATE PROCEDURE `stats_process`()
BEGIN
    SELECT IS_FREE_LOCK('event_stats_lock') INTO @event_stats_lock_isfree;
    SELECT @event_stats_lock_isfree;
    IF (@event_stats_lock_isfree = 1) THEN
        SELECT GET_LOCK('event_stats_lock', 10) INTO @event_stats_lock_isfree;
        IF (@event_stats_lock_isfree = 1) THEN
        		CALL proc_agency_stats();
        		CALL proc_parent_stats();
        		CALL check_remind_lock();
            CALL stat_zzsh_year();
            CALL stat_zzsh_quarter();
            CALL stat_zzsh_month();
            CALL stat_zzsh_new_year();
--            CALL stat_zzsh_stat();            
        END IF;
        SELECT RELEASE_LOCK('event_stats_lock');
    END IF;
END //
delimiter ;



SET GLOBAL event_scheduler = ON;

delimiter //
SET GLOBAL event_scheduler = OFF //
DROP EVENT IF EXISTS `event_stats`//
CREATE EVENT IF NOT EXISTS `event_stats`
ON SCHEDULE EVERY 10 MINUTE
ON COMPLETION PRESERVE
DO
   BEGIN
       call stats_process;
   END //
delimiter ;

SET GLOBAL event_scheduler = ON;


SET GLOBAL event_scheduler = ON;

delimiter //
SET GLOBAL event_scheduler = OFF //
DROP EVENT IF EXISTS `event_stats_remind`//
CREATE EVENT IF NOT EXISTS `event_stats_remind`
ON SCHEDULE EVERY 2 MINUTE
ON COMPLETION PRESERVE
DO
   BEGIN
       call stats_remind_process;
   END //
delimiter ;

SET GLOBAL event_scheduler = ON;



delimiter //
DROP TRIGGER IF EXISTS `up_stats_tri`//
CREATE TRIGGER up_stats_tri AFTER UPDATE ON pc_agency
FOR EACH ROW 
BEGIN
	  DECLARE c_parent_id int(11) unsigned;
		IF OLD.code != NEW.code THEN
		 SELECT parent_id INTO c_parent_id FROM pc_agency_relation where agency_id = NEW.id;
		 
		 UPDATE pc_remind SET name = NEW.name, code = NEW.code, parent_id = c_parent_id WHERE agency_id = NEW.id;
		 CALL stat_remind_stat();
		 
		 UPDATE pc_agency_stats SET name = NEW.name, code = NEW.code, parent_id = c_parent_id WHERE agency_id = NEW.id;		 
		 CALL proc_parent_stats();
		 
		 UPDATE pc_zzsh_stat SET name = NEW.name, code = NEW.code, parent_id = c_parent_id WHERE agency_id = NEW.id;		 
		 
		 UPDATE pc_remind_lock SET name = NEW.name, code = NEW.code, parent_id = c_parent_id WHERE agency_id = NEW.id;
		ELSEIF OLD.name != NEW.name THEN
		 UPDATE pc_remind SET name = NEW.name WHERE agency_id = NEW.id;
		 UPDATE pc_remind_stat SET name = NEW.name WHERE agency_id = NEW.id;
		 UPDATE pc_remind_lock SET name = NEW.name WHERE agency_id = NEW.id;
		 UPDATE pc_agency_stats SET name = NEW.name WHERE agency_id = NEW.id;		 
		 UPDATE pc_zzsh_stat SET name = NEW.name WHERE agency_id = NEW.id;		 
		
		END IF;
     
END//
delimiter ;


delimiter //
DROP TRIGGER IF EXISTS `del_stats_tri`//
CREATE TRIGGER del_stats_tri AFTER DELETE ON pc_agency
FOR EACH ROW 
BEGIN
		DELETE FROM pc_remind WHERE agency_id = OLD.id;
		CALL stat_remind_stat();
		 
		DELETE FROM pc_agency_stats WHERE agency_id = OLD.id;		 
		CALL proc_parent_stats();   
		 
		DELETE FROM pc_zzsh_stat WHERE agency_id = OLD.id;	    
		
		DELETE FROM pc_remind_lock WHERE agency_id = OLD.id;
END//
delimiter ;
