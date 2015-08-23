delimiter //
DROP procedure IF EXISTS remind_lock//
CREATE PROCEDURE remind_lock(y smallint(4))
begin

	IF y is null THEN
		SET y = year(now());
	END IF;
	call remind_lock_year(y);
	call remind_lock_quarter(y);
	call remind_lock_month(y);
	
	-- UPDATE pc_remind_lock set status = 9 WHERE status = 8 and delay_date < date_format(now(), '%Y-%m-%d');
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS remind_lock_year//
CREATE PROCEDURE remind_lock_year(c_y smallint(4))
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_parent_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id smallint(4) unsigned;
	DECLARE c_updatetime datetime;
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE y smallint(4) unsigned;
	DECLARE q tinyint(1) unsigned;
	DECLARE m tinyint(1) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i tinyint(1) unsigned;
	DECLARE s tinyint(1) unsigned;
	DECLARE pre_s tinyint(1) unsigned;
	DECLARE lock_date varchar(20);

	DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, create_datetime as setup_datetime, parent_id FROM  pc_agency WHERE code_id = 10 and invalid_datetime = 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	IF c_y is null THEN
		SET c_y = year(now());
	END IF;	
	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;
	SET @sql_txt = '';
	cursor_loop:loop
		FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id;
		-- SELECT c_id, c_name, c_setup_datetime;

		IF row >= rows then
			leave cursor_loop;
		end if;
		
		IF (c_parent_id IS NULL OR c_parent_id <= 0) THEN
			SET row = row + 1;
			ITERATE cursor_loop;
		END IF;
			
		SET i = 1;
			
		while i < 5 do	
			
			SET s = 0;
			SET q = 0;		
			SET m = 0;
			SET y = c_y;
			IF i = 4 THEN
				SET y = y - 1;
			END IF;
			-- SELECT c_setup_datetime, year(c_setup_datetime), month(c_setup_datetime) , day(c_setup_datetime) , y;
			IF year(c_setup_datetime) > y THEN
				SET row = row + 1;
				ITERATE cursor_loop;				
		    END IF;
			
			IF (i = 1) THEN
				SET pre_s = 0;
				
				CALL set_remind_status(c_setup_datetime, y, q, m, i, pre_s);
				IF pre_s = 9 THEN
					SET row = row + 1;
					ITERATE cursor_loop;					
				END IF;
			END IF;
	
			IF (i = 1 OR i = 4) THEN
				SELECT max(status_id) into s FROM pc_workplan WHERE agency_id = c_id AND year = y AND quarter = q AND type_id = i;
				
				IF  s IS NULL THEN
					SET s = 0;
				END IF;
				
				IF y >= 2012 THEN
					
					IF s <= 2 THEN
						UPDATE pc_remind_lock set status = 9 WHERE agency_id = c_id AND year = y AND quarter = q AND type_id = i AND status = 8 and delay_date < date_format(now(), '%Y-%m-%d');
					END IF;						
					
					IF s < 2 THEN
						CALL set_remind_status(now(), y, q, m, i, s);
					END IF;
					IF s = 2 THEN
						SELECT CONCAT(Date_Format(updatetime, '%Y-%m-%d'), ' 23:59:59') into c_updatetime FROM pc_workplan_content WHERE workplan_id in ( SELECT max(id) FROM pc_workplan WHERE agency_id = c_id AND year = y AND quarter = q AND type_id = i AND status_id = 2) AND type = 2;
						-- CALL set_remind_status(date_add(c_updatetime, interval 7 day), y, q, m, i, s);
						SET lock_date = now();
						CALL get_lock_date(y, q, m, i, lock_date);
						
						IF (unix_timestamp(date_add(c_updatetime, interval 7 day)) > unix_timestamp(lock_date)) THEN
							IF unix_timestamp(now()) > unix_timestamp(date_add(c_updatetime, interval 7 day) ) THEN
								SET s = 9;
							END IF;
						END IF;
						
					END IF;

					if s = 9 THEN
							
							-- INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) 
							-- VALUES (c_id, c_name, c_code_id, c_code, c_parent_id, y , q, m, i, s)	ON DUPLICATE KEY UPDATE agency_id = c_id, name = c_name;
							
							IF (@sql_txt is NULL) THEN
								SET @sql_txt = '';
							END IF;				
							
							IF (@sql_txt != '') THEN
								SET @sql_txt = CONCAT(@sql_txt, ", ");
							END IF;					
						
							SET @sql_txt = CONCAT( @sql_txt, "(",
							c_id, 				", '", 
							c_name, 			"', ", 
							c_code_id, 			", '", 
							c_code, 			"', ", 
							c_parent_id, 		", ", 
							y, 					", ",
							q, 					", ",
							m, 					", ",
							i, 					", ",
							s,
							")");

							IF (row > 0 AND MOD(row, 200) = 0 ) THEN
								IF (@sql_txt != '') THEN
									SET @sql_txt = CONCAT("INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) VALUES ", @sql_txt);
									SET @sql_txt = CONCAT(@sql_txt, " ON DUPLICATE KEY UPDATE agency_id = values(agency_id), name = values(name)");
									-- SELECT @sql_txt;
									PREPARE STMT FROM @sql_txt;   
									EXECUTE STMT;  	
									DEALLOCATE PREPARE STMT;
									SET @sql_txt = null;
								END IF;
							END IF;							
							
							
					END IF;						
				END IF;
				
				
			END IF;
			set i=i+1;
		end while;


	SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
		
	IF (@sql_txt != '') THEN
		SET @sql_txt = CONCAT("INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) VALUES ", @sql_txt);
		SET @sql_txt = CONCAT(@sql_txt, " ON DUPLICATE KEY UPDATE agency_id = values(agency_id), name = values(name)");
		-- SELECT @sql_txt;
		PREPARE STMT FROM @sql_txt;   
		EXECUTE STMT;  	
		DEALLOCATE PREPARE STMT;
		SET @sql_txt = null;
	END IF;		
end;
//
delimiter ;

delimiter //
DROP procedure IF EXISTS remind_lock_quarter//
CREATE PROCEDURE remind_lock_quarter(c_y smallint(4))
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_parent_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id smallint(4) unsigned;
	DECLARE c_updatetime datetime;
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE y smallint(4) unsigned;
	DECLARE q tinyint(1) unsigned;
	DECLARE q_range tinyint(1) unsigned;
	
	DECLARE m tinyint(1) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i tinyint(1) unsigned;
	DECLARE j tinyint(1) unsigned;
	DECLARE s tinyint(1) unsigned;
	DECLARE pre_s tinyint(1) unsigned;
	DECLARE lock_date varchar(20);

	DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, create_datetime as setup_datetime, parent_id FROM  pc_agency WHERE code_id = 10 and invalid_datetime = 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	IF c_y is null THEN
		SET c_y = year(now());
	END IF;	
	
	SET q_range = quarter(now());
	IF c_y < year(now()) THEN
	   SET q_range = 4;
	END IF; 
	
	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;
	SET @sql_quarter_txt = '';
	cursor_loop:loop
		FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id;

		IF row >= rows then
			leave cursor_loop;
		end if;
		
		IF (c_parent_id IS NULL OR c_parent_id <= 0) THEN
			SET row = row + 1;
			ITERATE cursor_loop;
		END IF;		
		
		SET i = 1;
		
		type_while:while i < 9 do	
			
			IF i in (1,4,8) THEN
				set i=i+1;
				ITERATE type_while;
			END IF;

			SET s = 0;
			SET m = 0;
			
								
			SET j = 1;
			quarter_while:WHILE j <= q_range DO
				SET y = c_y;
				SET q = j;
				
				IF i in (3,5,6,7) THEN
					SET q = q - 1;
					IF q = 0 THEN
						SET y = y -1;
						SET q = 4;	
					END IF;
				END IF;			
				
				-- SELECT c_setup_datetime, year(c_setup_datetime), month(c_setup_datetime) , day(c_setup_datetime) , y;
				IF year(c_setup_datetime) > y THEN
					SET j = j + 1;
					ITERATE quarter_while;				
				END IF;

				IF i in (2,3,5,6,7) THEN
					SET pre_s = 0;
					CALL set_remind_status(c_setup_datetime, y, q, m, i, pre_s);
					IF pre_s = 9 THEN
						SET j = j + 1;
						ITERATE quarter_while;							
					END IF;
				END IF;
				
				
				IF y >= 2012 THEN
					
					IF i in (2,3) THEN
						SELECT max(status_id) into s FROM pc_workplan WHERE agency_id = c_id AND year = y AND quarter = q AND type_id = i;
					END IF;
					IF i in (5,6,7) THEN
						SELECT max(status_id) into s FROM pc_meeting WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i;
					END IF;
					
					IF  s IS NULL THEN
						SET s = 0;
					END IF;

					IF s <= 2 THEN
						UPDATE pc_remind_lock set status = 9 WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i AND status = 8 and delay_date < date_format(now(), '%Y-%m-%d');
					END IF;							
					
					IF s < 2 THEN
						CALL set_remind_status(now(), y, q, m, i, s);
					END IF;
					IF s = 2 THEN
					
						IF i<=4 THEN
							SELECT CONCAT(Date_Format(updatetime, '%Y-%m-%d'), ' 23:59:59') into c_updatetime FROM pc_workplan_content WHERE workplan_id in ( SELECT max(id) FROM pc_workplan WHERE agency_id = c_id AND year = y AND quarter = q AND type_id = i AND status_id = 2) AND type = 2;
						ELSE
							SELECT CONCAT(Date_Format(updatetime, '%Y-%m-%d'), ' 23:59:59') into c_updatetime FROM pc_meeting_content WHERE meeting_id in ( SELECT max(id) FROM pc_meeting WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i AND status_id = 2) AND type = 2;
						END IF;							
						
						SET lock_date = now();
						CALL get_lock_date(y, q, m, i, lock_date);
						
						IF (unix_timestamp(date_add(c_updatetime, interval 7 day)) > unix_timestamp(lock_date)) THEN
							IF unix_timestamp(now()) > unix_timestamp(date_add(c_updatetime, interval 7 day) ) THEN
								SET s = 9;
							END IF;
						END IF;
						
					END IF;
					
					
					if s = 9 THEN
							-- INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) 
							-- VALUES (c_id, c_name, c_code_id, c_code, c_parent_id, y , q, m, i, s)	ON DUPLICATE KEY UPDATE agency_id = c_id, name = c_name;
							
							IF (@sql_quarter_txt is NULL) THEN
								SET @sql_quarter_txt = '';
							END IF;				
							
							IF (@sql_quarter_txt != '') THEN
								SET @sql_quarter_txt = CONCAT(@sql_quarter_txt, ", ");
							END IF;					
						
							SET @sql_quarter_txt = CONCAT( @sql_quarter_txt, "(",
							c_id, 				", '", 
							c_name, 			"', ", 
							c_code_id, 			", '", 
							c_code, 			"', ", 
							c_parent_id, 		", ", 
							y, 					", ",
							q, 					", ",
							m, 					", ",
							i, 					", ",
							s,
							")");

							IF (row > 0 AND MOD(row, 200) = 0 ) THEN
								IF (@sql_quarter_txt != '') THEN
									SET @sql_quarter_txt = CONCAT("INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) VALUES ", @sql_quarter_txt);
									SET @sql_quarter_txt = CONCAT(@sql_quarter_txt, " ON DUPLICATE KEY UPDATE agency_id = values(agency_id), name = values(name)");
									-- SELECT @sql_txt;
									PREPARE STMT FROM @sql_quarter_txt;   
									EXECUTE STMT;  	
									DEALLOCATE PREPARE STMT;
									SET @sql_quarter_txt = null;
								END IF;
							END IF;							
							
					END IF;						
				END IF;
				
				SET j = j + 1;		
			end while;

			set i=i+1;
		end while;

		SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
		
	IF (@sql_quarter_txt != '') THEN
		SET @sql_quarter_txt = CONCAT("INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) VALUES ", @sql_quarter_txt);
		SET @sql_quarter_txt = CONCAT(@sql_quarter_txt, " ON DUPLICATE KEY UPDATE agency_id = values(agency_id), name = values(name)");
		-- SELECT @sql_txt;
		PREPARE STMT FROM @sql_quarter_txt;   
		EXECUTE STMT;  	
		DEALLOCATE PREPARE STMT;
		SET @sql_quarter_txt = null;
	END IF;		
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS remind_lock_month//
CREATE PROCEDURE remind_lock_month(c_y smallint(4))
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255);
	DECLARE c_parent_name VARCHAR(255);
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id smallint(4) unsigned;
	DECLARE c_updatetime datetime;
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE y smallint(4) unsigned;
	DECLARE q tinyint(1) unsigned;
	DECLARE m_range tinyint(1) unsigned;
	
	DECLARE m tinyint(1) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i tinyint(1) unsigned;
	DECLARE j tinyint(1) unsigned;
	DECLARE s tinyint(1) unsigned;
	DECLARE lock_date varchar(20);

	DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, create_datetime as setup_datetime, parent_id FROM  pc_agency WHERE  code_id = 10 and invalid_datetime = 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	IF c_y is null THEN
		SET c_y = year(now());
	END IF;	
	
	SET m_range = month(now())+1;
	IF c_y < year(now()) THEN
	   SET m_range = 13;
	END IF; 
	
	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;
	SET @sql_month_txt = '';
	cursor_loop:loop
		FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id;

		IF row >= rows then
			leave cursor_loop;
		end if;
		
		IF (c_parent_id IS NULL OR c_parent_id <= 0) THEN
			SET row = row + 1;
			ITERATE cursor_loop;
		END IF;	
		
		SET i = 8;
		SET s = 0;			
		SET j = 1;
				
		month_while:WHILE j <= m_range DO
			SET y = c_y;
			
			SET m = j - 1;
			SET q = QUARTER(CONCAT(y,'-',LPAD(m,2,'00'),'-',01));
			IF m = 0 THEN
				SET y = y - 1;
				SET m = 12;
				SET q = 4;
			END IF;
			
			-- SELECT year(c_setup_datetime) , y;
			IF year(c_setup_datetime) > y THEN
				SET j = j + 1;	
				ITERATE month_while;				
			END IF;
			
			
			-- SELECT month(c_setup_datetime), q;
			IF year(c_setup_datetime) = y AND month(c_setup_datetime) > m THEN
				SET j = j + 1;	
				ITERATE month_while;					
			END IF;

			IF y >= 2012 THEN
				
				SELECT max(status_id) into s FROM pc_meeting WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i;
				
				IF  s IS NULL THEN
					SET s = 0;
				END IF;
				
				IF s <= 2 THEN
					UPDATE pc_remind_lock set status = 9 WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i AND status = 8 and delay_date < date_format(now(), '%Y-%m-%d');
				END IF;				
				
				IF s < 2 THEN
					CALL set_remind_status(now(), y, q, m, i, s);
				END IF;
				
				IF s = 2 THEN
					SELECT CONCAT(Date_Format(updatetime, '%Y-%m-%d'), ' 23:59:59') into c_updatetime FROM pc_meeting_content WHERE meeting_id in ( SELECT max(id) FROM pc_meeting WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i AND status_id = 2) AND type = 2;
					-- IF unix_timestamp(now()) > unix_timestamp(date_add(c_updatetime, interval 7 day) ) THEN
					-- 	SET s = 9;
					-- END IF;
					SET lock_date = now();
					CALL get_lock_date(y, q, m, i, lock_date);
					
					IF (unix_timestamp(date_add(c_updatetime, interval 7 day)) > unix_timestamp(lock_date)) THEN
						IF unix_timestamp(now()) > unix_timestamp(date_add(c_updatetime, interval 7 day) ) THEN
							SET s = 9;
						END IF;
					END IF;					
				END IF;
				
				

				
				if s = 9 THEN
					-- INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) 
					-- VALUES (c_id, c_name, c_code_id, c_code, c_parent_id, y , q, m, i, s)	ON DUPLICATE KEY UPDATE agency_id = c_id, name = c_name;
					
					
					IF (@sql_month_txt is NULL) THEN
						SET @sql_month_txt = '';
					END IF;				
					
					IF (@sql_month_txt != '') THEN
						SET @sql_month_txt = CONCAT(@sql_month_txt, ", ");
					END IF;					
				
					SET @sql_month_txt = CONCAT( @sql_month_txt, "(",
					c_id, 				", '", 
					c_name, 			"', ", 
					c_code_id, 			", '", 
					c_code, 			"', ", 
					c_parent_id, 		", ", 
					y, 					", ",
					q, 					", ",
					m, 					", ",
					i, 					", ",
					s,
					")");

					IF (row > 0 AND MOD(row, 200) = 0 ) THEN
						
						IF (@sql_month_txt != '') THEN
							SET @sql_month_txt = CONCAT("INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) VALUES ", @sql_month_txt);
							SET @sql_month_txt = CONCAT(@sql_month_txt, " ON DUPLICATE KEY UPDATE agency_id = values(agency_id), name = values(name)");
							-- SELECT @sql_month_txt;
							PREPARE STMT FROM @sql_month_txt;   
							EXECUTE STMT;  	
							DEALLOCATE PREPARE STMT;
							SET @sql_month_txt = null;
						END IF;
					END IF;							
				END IF;						
			END IF;
			
			SET j = j + 1;		
		end while;

		SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;


	IF (@sql_month_txt != '') THEN
		SET @sql_month_txt = CONCAT("INSERT INTO  pc_remind_lock (agency_id, name, code_id, code, parent_id, year, quarter, month, type_id, status) VALUES ", @sql_month_txt);
		SET @sql_month_txt = CONCAT(@sql_month_txt, " ON DUPLICATE KEY UPDATE agency_id = values(agency_id), name = values(name)");
		-- SELECT @sql_month_txt;
		PREPARE STMT FROM @sql_month_txt;   
		EXECUTE STMT;  	
		DEALLOCATE PREPARE STMT;
		SET @sql_month_txt = null;
	END IF;
		
		
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS set_remind_status//
CREATE PROCEDURE set_remind_status(ptime varchar(20), y smallint(4), q tinyint(1), m tinyint(1), t_id int, OUT status tinyint(1))
begin

	DECLARE e_y smallint(1);
	DECLARE e_q tinyint(1) unsigned;
	DECLARE e_m smallint(5) unsigned;
	DECLARE e_d smallint(5) unsigned;
	DECLARE e_t varchar(20);
	DECLARE e_delay_day MEDIUMINT( 10 ) UNSIGNED;
	
	IF ptime is null THEN
		SET ptime = NOW();
	END IF;
	
	IF y is null THEN
		SET y = year(now());
	END IF;
	
	if q is null THEN
		SET q = quarter(now());
	END IF;
	
	if m is null THEN
		SET m = month(now());
	END IF;
	
	SELECT end_year, end_quarter, end_month, end_day, delay_day into e_y, e_q, e_m, e_d, e_delay_day FROM pc_remind_config WHERE type_id = t_id;

	
	IF (t_id  = 1)  THEN 
		SET e_t = CONCAT(y, '-', e_m, '-', e_d, ' 23:59:59');
	END IF;
	
	IF (t_id = 4)  THEN 
		SET e_t = CONCAT(y + 1, '-', e_m, '-', e_d, ' 23:59:59');
	END IF;	
	
	IF t_id = 2  THEN 
		SET e_t = concat(Date_ADD(MAKEDATE(y, 1) + INTERVAL q + e_q QUARTER - INTERVAL 1 QUARTER , INTERVAL e_d DAY), ' 23:59:59');
	END IF;
	
	IF t_id = 3  THEN 
		SET e_t = concat(Date_ADD(MAKEDATE(y, 1) + INTERVAL q + e_q QUARTER - INTERVAL 1 QUARTER , INTERVAL e_d DAY), ' 23:59:59');
	END IF;	
  
	IF t_id > 4 AND t_id < 8 THEN
		SET e_t = CONCAT( MAKEDATE(y, 1) + INTERVAL q QUARTER - INTERVAL 1 DAY, ' 23:59:59');
	END IF;
	
	IF t_id = 8 THEN
		SET e_t = CONCAT(LAST_DAY( CONCAT(y,'-',LPAD(m,2,'00'),'-',01) ), ' 23:59:59');
	END IF;
	
	SET e_t = ADDDATE(e_t, e_delay_day);

	IF unix_timestamp(ptime) > unix_timestamp(e_t) THEN
		SET status = 9;
	ELSE 
		SET status = 0;
	END IF;

end;
//


delimiter //
DROP procedure IF EXISTS get_lock_date//
CREATE PROCEDURE get_lock_date(y smallint(4), q tinyint(1), m tinyint(1), t_id int, OUT lock_date varchar(20))
begin

	DECLARE e_y smallint(1);
	DECLARE e_q tinyint(1) unsigned;
	DECLARE e_m smallint(5) unsigned;
	DECLARE e_d smallint(5) unsigned;
	DECLARE e_t varchar(20);
	DECLARE e_delay_day MEDIUMINT( 10 ) UNSIGNED;
	
	IF y is null THEN
		SET y = year(now());
	END IF;
	
	if q is null THEN
		SET q = quarter(now());
	END IF;
	
	if m is null THEN
		SET m = month(now());
	END IF;
	
	SELECT end_year, end_quarter, end_month, end_day, delay_day into e_y, e_q, e_m, e_d, e_delay_day FROM pc_remind_config WHERE type_id = t_id;

	
	IF (t_id  = 1)  THEN 
		SET e_t = CONCAT(y, '-', e_m, '-', e_d, ' 23:59:59');
	END IF;
	
	IF (t_id = 4)  THEN 
		SET e_t = CONCAT(y + 1, '-', e_m, '-', e_d, ' 23:59:59');
	END IF;	
	
	IF t_id = 2  THEN 
		SET e_t = concat(Date_ADD(MAKEDATE(y, 1) + INTERVAL q + e_q QUARTER - INTERVAL 1 QUARTER , INTERVAL e_d DAY), ' 23:59:59');
	END IF;
	
	IF t_id = 3  THEN 
		SET e_t = concat(Date_ADD(MAKEDATE(y, 1) + INTERVAL q + e_q QUARTER - INTERVAL 1 QUARTER , INTERVAL e_d DAY), ' 23:59:59');
	END IF;	
  
	IF t_id > 4 AND t_id < 8 THEN
		SET e_t = CONCAT( MAKEDATE(y, 1) + INTERVAL q QUARTER - INTERVAL 1 DAY, ' 23:59:59');
	END IF;
	
	IF t_id = 8 THEN
		SET e_t = CONCAT(LAST_DAY( CONCAT(y,'-',LPAD(m,2,'00'),'-',01) ), ' 23:59:59');
	END IF;
	
	SET e_t = ADDDATE(e_t, e_delay_day);
	
	SET lock_date = e_t;

end;
//

delimiter ;

