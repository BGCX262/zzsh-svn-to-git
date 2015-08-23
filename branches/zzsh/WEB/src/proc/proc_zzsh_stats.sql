delimiter //
DROP procedure IF EXISTS stat_zzsh//
CREATE PROCEDURE stat_zzsh(y smallint(4))
begin
	SET character set utf8;
	IF y is null THEN
		SET y = year(now());
	END IF;
	
	call create_stats_p(y);
	call create_stats_p(y - 1);
	call stat_zzsh_year(y);
	call stat_zzsh_quarter(y);
	call stat_zzsh_month(y);
end;
//
delimiter ;

delimiter //
DROP procedure IF EXISTS stat_zzsh_year//
CREATE PROCEDURE stat_zzsh_year(c_y smallint(4))
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255) CHARACTER SET utf8;
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_setup_datetime datetime;
	DECLARE c_invalid_datetime int(11) unsigned;
	DECLARE v_setup_datetime int(11) unsigned;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	
	DECLARE stat_reported int(10) unsigned;
	DECLARE stat_reported_rate DECIMAL(6,4) unsigned;	
	
	DECLARE stat_total int(10) unsigned;
	DECLARE stat_total_success int(10) unsigned;
	DECLARE stat_total_return int(10) unsigned;
	DECLARE stat_total_delay int(10) ;
	DECLARE stat_return_rate DECIMAL(6,4) unsigned;
	DECLARE stat_delay_rate DECIMAL(6,4) unsigned;

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
	
	
	DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, create_datetime, invalid_datetime, parent_id FROM  pc_agency WHERE code_id = 10;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	IF c_y is null THEN
		SET c_y = year(now());
	END IF;		
	
	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;
	SET @sql_txt = '';
	cursor_loop:loop
		FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_invalid_datetime, c_parent_id;
		IF row >= rows then
			leave cursor_loop;
		end if;
		
		IF (c_parent_id IS NULL OR c_parent_id <= 0) THEN
			SET row = row + 1;
			ITERATE cursor_loop;
		END IF;

		SET i = 1;
		loop_while:while i in (1,4) do	
			SET  stat_reported = 0;
			SET  stat_reported_rate = 0;
			
			SET  stat_total = 0;
			SET  stat_total_success = 0;
			SET  stat_total_return = 0;
			SET  stat_total_delay = 0;
			SET  stat_return_rate = 0;
			SET  stat_delay_rate = 0;

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
			SET y = c_y;
			
			IF i = 4 THEN
				SET y = y - 1;
			END IF;
			
			IF (y < 2012) THEN
				set i=i+1;
				ITERATE loop_while;
			END IF;
			
			
		
-- 			年度计划	q = 1 AND i = 1	
--			年终总结	q = 4 AND i = 4					
			
			IF (i = 1 OR i = 4) THEN
				SELECT COUNT(*) , COUNT(CASE WHEN status_id = 5 THEN id END) into stat_total, stat_eva FROM pc_workplan WHERE agency_id = c_id AND type_id = i  AND year =y   AND status_id >=3;
				SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock WHERE agency_id = c_id  AND year =y  AND type_id = i AND status = 8;
				SELECT COUNT(*) into stat_total_return FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.status_id in (3,4,5) AND b.type = 2;				
				
				SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END),
					   COUNT(CASE WHEN b.content = 2 THEN a.id END),
					   COUNT(CASE WHEN b.content = 3 THEN a.id END),
					   COUNT(CASE WHEN b.content = 4 THEN a.id END)
					   into stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y  AND a.status_id = 5 AND b.type = 4;
				
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
				
				IF stat_reported_rate is null THEN
					SET stat_reported_rate = 0;
				END IF;		

				IF  stat_reported_rate = 1 THEN
						SET stat_agency_goodjob = 1;
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

				IF stat_eva_rate is null THEN
					SET stat_eva_rate = 0;
				END IF;		
								
				SET v_setup_datetime = UNIX_TIMESTAMP(c_setup_datetime);

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
				v_setup_datetime, 	", ",
				c_invalid_datetime, ", ",
				c_parent_id, 		", ", 
				y, 					", ",
				"0, ",
				"0,",
				i, 					", ",
				stat_total, 		", ",
				stat_total_success, ", ",
				stat_total_return, 	", ",
				stat_total_delay, 	", ",
				stat_reported, 		", ",
				stat_reported_rate, ", ",
				stat_return_rate, 	", ",
				stat_delay_rate, 	", ",
				"0, ",
				"0, ",
				"0, ",
				stat_eva, 			", ",
				stat_eva_rate, 		", ",
				stat_eva_1, 		", ",
				stat_eva_2, 		", ",
				stat_eva_3, 		", ",
				stat_eva_4, 		", ",
				stat_eva_1_rate, 	", ",
				stat_eva_2_rate, 	", ",
				stat_eva_3_rate, 	", ",
				stat_eva_4_rate, 	", ",
				stat_agency_goodjob,
				")");

				IF (row > 0 AND MOD(row, 200) = 0 ) THEN
					IF (@sql_txt != '') THEN
						SET @sql_txt = CONCAT("INSERT INTO pc_zzsh_stat (agency_id, name, code_id, code, setup_datetime, invalid_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES ", @sql_txt);
						SET @sql_txt = CONCAT(@sql_txt, " ON DUPLICATE KEY UPDATE total = values(total), total_success = values(total_success), total_return = values(total_return), total_delay = values(total_delay), reported = values(reported), reported_rate = values(reported_rate), return_rate = values(return_rate), delay_rate = values(delay_rate), attend = values(attend), asence = values(asence), attend_rate = values(attend_rate), eva = values(eva), eva_rate = values(eva_rate), eva_1 = values(eva_1), eva_2 = values(eva_2), eva_3 = values(eva_3), eva_4 = values(eva_4), eva_1_rate = values(eva_1_rate), eva_2_rate = values(eva_2_rate), eva_3_rate = values(eva_3_rate), eva_4_rate = values(eva_4_rate), agency_goodjob = values(agency_goodjob)");
						-- SELECT @sql_txt;
						PREPARE STMT FROM @sql_txt;   
						EXECUTE STMT;  	
						DEALLOCATE PREPARE STMT;
						SET @sql_txt = null;
					END IF;
				END IF;
				
			END IF;
			set i=i+1;
			IF i = 2 THEN
			 SET i = 4;
			END IF;
		end while;

		SET row = row + 1;
		end loop cursor_loop;
		close s_cursor;
		
		IF (@sql_txt != '') THEN
			SET @sql_txt = CONCAT("INSERT INTO pc_zzsh_stat  (agency_id, name, code_id, code, setup_datetime, invalid_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES ", @sql_txt);
			SET @sql_txt = CONCAT(@sql_txt, " ON DUPLICATE KEY UPDATE total = values(total), total_success = values(total_success), total_return = values(total_return), total_delay = values(total_delay), reported = values(reported), reported_rate = values(reported_rate), return_rate = values(return_rate), delay_rate = values(delay_rate), attend = values(attend), asence = values(asence), attend_rate = values(attend_rate), eva = values(eva), eva_rate = values(eva_rate), eva_1 = values(eva_1), eva_2 = values(eva_2), eva_3 = values(eva_3), eva_4 = values(eva_4), eva_1_rate = values(eva_1_rate), eva_2_rate = values(eva_2_rate), eva_3_rate = values(eva_3_rate), eva_4_rate = values(eva_4_rate), agency_goodjob = values(agency_goodjob)");
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
DROP procedure IF EXISTS stat_zzsh_quarter//
CREATE PROCEDURE stat_zzsh_quarter(c_y smallint(4))
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255) CHARACTER SET utf8;
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_setup_datetime datetime;
	DECLARE c_invalid_datetime int(11) unsigned;
	DECLARE v_setup_datetime int(11) unsigned;	
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;
	DECLARE q_range tinyint(1) unsigned;
	
	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	DECLARE j int;
	
	DECLARE stat_reported int(11) unsigned;
	DECLARE stat_reported_rate DECIMAL(6,4) unsigned;	
	
	DECLARE stat_total int(10) unsigned;
	DECLARE stat_total_success int(10) unsigned;
	DECLARE stat_total_return int(10) unsigned;
	DECLARE stat_total_delay int(10) ;
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
	
	DECLARE v int(10) unsigned;
	
	DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, create_datetime, invalid_datetime, parent_id FROM  pc_agency WHERE code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	IF c_y is null THEN
		SET c_y = year(now());
	END IF;		
	
	SET q_range = quarter(now()) + 1;
	IF c_y < year(now()) THEN
	   SET q_range = 5;
	END IF; 	
	
	SET @sql_quarter_txt = '';

	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;

	SET v = 0;

	cursor_loop:loop
		FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_invalid_datetime, c_parent_id;

		IF row >= rows then
			leave cursor_loop;
		END if;
		
		IF (c_parent_id IS NULL OR c_parent_id <= 0) THEN
			SET row = row + 1;
			ITERATE cursor_loop;
		END IF;	

		SET i = 2;

		while i in (2,3,5,6,7) do	

			SET j = 1;
			loop_q:WHILE j <= q_range DO
				
				SET y = c_y;
				SET q = j - 1;
				
				IF q = 0 THEN
					SET y = y -1;
					SET q = 4;	
									
				END IF;
				
				IF (y < 2012) THEN
					SET j = j + 1;
					ITERATE loop_q;
				END IF;
				
				SET v = v + 1;
				
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
--			    年终总结	q = 4 AND i = 4					
--				季度计划和季度执行情况					
				
				IF i in (2,3) THEN
					SELECT COUNT(*), COUNT(CASE WHEN status_id = 5 THEN id END) into stat_total, stat_eva FROM pc_workplan  WHERE agency_id = c_id AND type_id = i AND year =y AND quarter = q AND status_id in (3,4,5);
					SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock  WHERE agency_id = c_id  AND year =y AND quarter = q AND type_id = i AND status = 8;
					SELECT COUNT(*) into stat_total_return FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.status_id in (3,4,5) AND b.type = 2;
					SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END), 
						   COUNT(CASE WHEN b.content = 2 THEN a.id END),
						   COUNT(CASE WHEN b.content = 3 THEN a.id END),
						   COUNT(CASE WHEN b.content = 4 THEN a.id END)
						   into stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
					
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
					
					IF stat_reported_rate is null THEN
						SET stat_reported_rate = 0;
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
																
					IF stat_eva is null OR stat_eva = 0 THEN
						SET stat_eva = 0;
					END IF;						
																																																								
					SET stat_eva_rate = ROUND(stat_eva/stat_total, 4);
					SET stat_eva_1_rate = ROUND(stat_eva_1/stat_eva, 4);
					SET stat_eva_2_rate = ROUND(stat_eva_2/stat_eva, 4);
					SET stat_eva_3_rate = ROUND(stat_eva_3/stat_eva, 4);
					SET stat_eva_4_rate = ROUND(stat_eva_4/stat_eva, 4);					

					IF stat_eva_rate is null THEN
						SET stat_eva_rate = 0;
					END IF;							
					
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
					
				END IF;
				
				IF i in (5,6,7)  THEN
					SELECT COUNT(*), sum(attend), sum(asence), COUNT(CASE WHEN status_id = 5 THEN id END) into stat_total, stat_attend, stat_asence, stat_eva FROM pc_meeting  WHERE agency_id = c_id AND year =y AND quarter = q AND type_id = i AND status_id in (3,4,5);
					SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock WHERE agency_id = c_id  AND year =y AND quarter = q AND type_id = i AND status = 8;
					SELECT COUNT(*) into stat_total_return FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id in (3,4,5) AND b.type = 2;
					
					SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END), 
						   COUNT(CASE WHEN b.content = 2 THEN a.id END),
						   COUNT(CASE WHEN b.content = 3 THEN a.id END),
						   COUNT(CASE WHEN b.content = 4 THEN a.id END)
						   into stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.type_id = i AND a.year =y AND a.quarter = q AND a.status_id = 5 AND b.type = 4;
					
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
						SELECT ROUND(  stat_attend/(stat_attend + stat_asence), 4) into stat_attend_rate;
					ELSEIF stat_attend = 0 THEN
						SET stat_attend_rate = 0;
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
					
					IF  stat_reported_rate = 1 THEN
							SET stat_agency_goodjob = 1;
					END IF;					
				END IF;				
				
				SET v_setup_datetime = UNIX_TIMESTAMP(c_setup_datetime);				

				
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
				v_setup_datetime, 	", ",
				c_invalid_datetime, ", ",
				c_parent_id, 		", ", 
				y, 					", ",
				q,					", ",
				"0, ",
				i, 					", ",
				stat_total, 		", ",
				stat_total_success, ", ",
				stat_total_return, 	", ",
				stat_total_delay, 	", ",
				stat_reported, 		", ",
				stat_reported_rate, ", ",
				stat_return_rate, 	", ",
				stat_delay_rate, 	", ",
				stat_attend, 		", ",
				stat_asence, 		", ",
				stat_attend_rate, 	", ",
				stat_eva, 			", ",
				stat_eva_rate, 		", ",
				stat_eva_1, 		", ",
				stat_eva_2, 		", ",
				stat_eva_3, 		", ",
				stat_eva_4, 		", ",
				stat_eva_1_rate, 	", ",
				stat_eva_2_rate, 	", ",
				stat_eva_3_rate, 	", ",
				stat_eva_4_rate, 	", ",
				stat_agency_goodjob,
				")");

				IF (row > 0 AND mod(row, 200) = 0) THEN
					IF (@sql_quarter_txt != '') THEN
						SET @sql_quarter_txt = CONCAT("INSERT INTO pc_zzsh_stat  (agency_id, name, code_id, code, setup_datetime, invalid_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES ", @sql_quarter_txt);
						SET @sql_quarter_txt = CONCAT(@sql_quarter_txt, " ON DUPLICATE KEY UPDATE total = values(total), total_success = values(total_success), total_return = values(total_return), total_delay = values(total_delay), reported = values(reported), reported_rate = values(reported_rate), return_rate = values(return_rate), delay_rate = values(delay_rate), attend = values(attend), asence = values(asence), attend_rate = values(attend_rate), eva = values(eva), eva_rate = values(eva_rate), eva_1 = values(eva_1), eva_2 = values(eva_2), eva_3 = values(eva_3), eva_4 = values(eva_4), eva_1_rate = values(eva_1_rate), eva_2_rate = values(eva_2_rate), eva_3_rate = values(eva_3_rate), eva_4_rate = values(eva_4_rate), agency_goodjob = values(agency_goodjob)");
						-- SELECT @sql_quarter_txt;
						PREPARE STMT FROM @sql_quarter_txt;   
						EXECUTE STMT;  	
						DEALLOCATE PREPARE STMT;
						
						
						SET @sql_quarter_txt = null;
					END IF;

				END IF;				

				
			SET j = j + 1;		
			end while;
		set i=i+1;
		IF i = 4 THEN
			SET i = 5;
		END IF;
		end while;


		SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
	
	IF (@sql_quarter_txt != '') THEN
		SET @sql_quarter_txt = CONCAT("INSERT INTO pc_zzsh_stat  (agency_id, name, code_id, code, setup_datetime, invalid_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES ", @sql_quarter_txt);
		SET @sql_quarter_txt = CONCAT(@sql_quarter_txt, " ON DUPLICATE KEY UPDATE total = values(total), total_success = values(total_success), total_return = values(total_return), total_delay = values(total_delay), reported = values(reported), reported_rate = values(reported_rate), return_rate = values(return_rate), delay_rate = values(delay_rate), attend = values(attend), asence = values(asence), attend_rate = values(attend_rate), eva = values(eva), eva_rate = values(eva_rate), eva_1 = values(eva_1), eva_2 = values(eva_2), eva_3 = values(eva_3), eva_4 = values(eva_4), eva_1_rate = values(eva_1_rate), eva_2_rate = values(eva_2_rate), eva_3_rate = values(eva_3_rate), eva_4_rate = values(eva_4_rate), agency_goodjob = values(agency_goodjob)");
		-- SELECT @sql_quarter_txt;
		PREPARE STMT FROM @sql_quarter_txt;   
		EXECUTE STMT;  	
		DEALLOCATE PREPARE STMT;
		
		
		SET @sql_quarter_txt = null;
	END IF;

	SELECT v;
end;
//
delimiter ;


delimiter //
DROP procedure IF EXISTS stat_zzsh_month//
CREATE PROCEDURE stat_zzsh_month(c_y smallint(4))
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_parent_id int(11) unsigned;
	DECLARE c_name VARCHAR(255) CHARACTER SET utf8;
	DECLARE c_code VARCHAR(20);
	DECLARE c_code_id int(11) unsigned;
	DECLARE c_setup_datetime datetime;
	DECLARE v_setup_datetime int(11) unsigned;
	DECLARE c_invalid_datetime int(11) unsigned;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;

	DECLARE m smallint(5) unsigned;
	DECLARE m_range smallint(5) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	DECLARE j int;
	
	DECLARE stat_reported int(10) unsigned;
	DECLARE stat_reported_rate DECIMAL(6,4) unsigned;	
	
	DECLARE stat_total int(10) unsigned;
	DECLARE stat_total_success int(10) unsigned;
	DECLARE stat_total_return int(10) unsigned;
	DECLARE stat_total_delay int(10) ;
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
	
	DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, create_datetime, invalid_datetime, parent_id FROM  pc_agency WHERE code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	IF c_y is null THEN
		SET c_y = year(now());
	END IF;	
	
	SET m_range = month(now())+1;
	IF c_y < year(now()) THEN
	   SET m_range = 13;
	END IF; 
	
	SET @sql_month_txt = '';

	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;

	cursor_loop:loop
		FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_invalid_datetime, c_parent_id;

		IF row >= rows then
			leave cursor_loop;
		end if;
		
		IF (c_parent_id IS NULL OR c_parent_id <= 0) THEN
			SET row = row + 1;
			ITERATE cursor_loop;
		END IF;		
	
		SET i = 8;

		while i in (8,9) do	
						
			SET j = 1;
			loop_m:WHILE j <= m_range DO
				SET y = c_y;
				SET m = j - 1;
				SET q = QUARTER(CONCAT(y,'-',LPAD(m,2,'00'),'-',01));
				IF m = 0 THEN
					SET y = y - 1;
					SET m = 12;
					SET q = 4;				
				END IF;		

				IF (y < 2012) THEN
					SET j = j + 1;
					ITERATE loop_m;
				END IF;		

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

				SELECT COUNT(*), sum(attend), sum(asence), COUNT(CASE WHEN status_id = 5 THEN id END) into stat_total, stat_attend, stat_asence, stat_eva FROM pc_meeting  WHERE agency_id = c_id AND year =y AND quarter = q AND month = m AND type_id = i  AND status_id in (3,4,5);
				SELECT COUNT(*) into stat_total_delay FROM pc_remind_lock WHERE agency_id = c_id  AND year =y AND quarter = q AND month = m AND type_id = i AND status = 8;
				SELECT COUNT(*) into stat_total_return FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.year =y AND a.quarter = q AND month = m AND a.type_id = i AND a.status_id in (3,4,5) AND b.type = 2;

				SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END), 
					   COUNT(CASE WHEN b.content = 2 THEN a.id END), 
					   COUNT(CASE WHEN b.content = 3 THEN a.id END), 
					   COUNT(CASE WHEN b.content = 4 THEN a.id END)
					   into stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4  FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = c_id AND a.year =y AND a.quarter = q AND month = m AND a.type_id = i  AND a.status_id = 5 AND b.type = 4;
				-- SELECT CONCAT("year = ", y, " quarter =", q, " m =", m, " stat_eva = ", stat_eva);
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
				
				IF stat_reported_rate is null THEN
					SET stat_reported_rate = 0;
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
				
				IF stat_eva_rate is null THEN
					SET stat_eva_rate = 0;
				END IF;						
				
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
					SELECT ROUND(  stat_attend/(stat_attend + stat_asence), 4) into stat_attend_rate;
				ELSEIF stat_attend = 0 THEN
					SET stat_attend_rate = 0;
				END IF;		

				IF stat_attend_rate is null THEN
					SET stat_attend_rate = 0;
				END IF;										
				
				IF  stat_reported_rate = 1 THEN
						SET stat_agency_goodjob = 1;
				END IF;				
				
				SET v_setup_datetime = UNIX_TIMESTAMP(c_setup_datetime);
				
				IF @sql_month_txt IS NULL THEN
					SET @sql_month_txt = '';
				END IF;		

				IF @sql_month_txt !='' THEN
					SET @sql_month_txt = CONCAT(@sql_month_txt, ', ');
				END IF;	
				
				SET @sql_month_txt = CONCAT( @sql_month_txt, "(",
				c_id, 				", '", 
				c_name, 			"', ", 
				c_code_id, 			", '", 
				c_code, 			"', ", 
				v_setup_datetime, 	", ",
				c_invalid_datetime, ", ",
				c_parent_id, 		", ", 
				y, 					", ",
				q,					", ",
				m,					", ",
				i, 					", ",
				stat_total, 		", ",
				stat_total_success, ", ",
				stat_total_return, 	", ",
				stat_total_delay, 	", ",
				stat_reported, 		", ",
				stat_reported_rate, ", ",
				stat_return_rate, 	", ",
				stat_delay_rate, 	", ",
				stat_attend, 		", ",
				stat_asence, 		", ",
				stat_attend_rate, 	", ",
				stat_eva, 			", ",
				stat_eva_rate, 		", ",
				stat_eva_1, 		", ",
				stat_eva_2, 		", ",
				stat_eva_3, 		", ",
				stat_eva_4, 		", ",
				stat_eva_1_rate, 	", ",
				stat_eva_2_rate, 	", ",
				stat_eva_3_rate, 	", ",
				stat_eva_4_rate, 	", ",
				stat_agency_goodjob,
				")");
				
				IF (row > 0 AND mod(row, 200) = 0) THEN
					IF (@sql_month_txt != '') THEN
							SET @sql_month_txt = CONCAT("INSERT INTO pc_zzsh_stat  (agency_id, name, code_id, code, setup_datetime, invalid_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES ", @sql_month_txt);
							SET @sql_month_txt = CONCAT(@sql_month_txt, " ON DUPLICATE KEY UPDATE total = values(total), total_success = values(total_success), total_return = values(total_return), total_delay = values(total_delay), reported = values(reported), reported_rate = values(reported_rate), return_rate = values(return_rate), delay_rate = values(delay_rate), attend = values(attend), asence = values(asence), attend_rate = values(attend_rate), eva = values(eva), eva_rate = values(eva_rate), eva_1 = values(eva_1), eva_2 = values(eva_2), eva_3 = values(eva_3), eva_4 = values(eva_4), eva_1_rate = values(eva_1_rate), eva_2_rate = values(eva_2_rate), eva_3_rate = values(eva_3_rate), eva_4_rate = values(eva_4_rate), agency_goodjob = values(agency_goodjob)");

							-- SELECT @sql_month_txt;
							PREPARE STMT FROM @sql_month_txt;   
							EXECUTE STMT;  	
							DEALLOCATE PREPARE STMT;
							SET @sql_month_txt = null;
						END IF;
									
				END IF;
			
			SET j = j + 1;		
			end while;

			set i=i+1;
		end while;

		SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
	
	IF (@sql_month_txt != '') THEN
		SET @sql_month_txt = CONCAT("INSERT INTO pc_zzsh_stat  (agency_id, name, code_id, code, setup_datetime, invalid_datetime, parent_id, year, quarter, month, type_id, total, total_success, total_return, total_delay, reported, reported_rate, return_rate, delay_rate,  attend, asence, attend_rate, eva, eva_rate, eva_1, eva_2, eva_3, eva_4, eva_1_rate, eva_2_rate, eva_3_rate, eva_4_rate, agency_goodjob) VALUES ", @sql_month_txt);
		SET @sql_month_txt = CONCAT(@sql_month_txt, " ON DUPLICATE KEY UPDATE total = values(total), total_success = values(total_success), total_return = values(total_return), total_delay = values(total_delay), reported = values(reported), reported_rate = values(reported_rate), return_rate = values(return_rate), delay_rate = values(delay_rate), attend = values(attend), asence = values(asence), attend_rate = values(attend_rate), eva = values(eva), eva_rate = values(eva_rate), eva_1 = values(eva_1), eva_2 = values(eva_2), eva_3 = values(eva_3), eva_4 = values(eva_4), eva_1_rate = values(eva_1_rate), eva_2_rate = values(eva_2_rate), eva_3_rate = values(eva_3_rate), eva_4_rate = values(eva_4_rate), agency_goodjob = values(agency_goodjob)");

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
DROP procedure IF EXISTS create_stats_p//
CREATE PROCEDURE create_stats_p(y smallint(4))
begin
	
	DECLARE p_name varchar(20);
	DECLARE c tinyint(1);
	IF y is null THEN
		SET y = year(now());
	END IF;
	
	SET p_name = CONCAT('p', y);
	SELECT COUNT(*) INTO c FROM information_schema.PARTITIONS WHERE table_name LIKE '%pc_zzsh_stat%' AND PARTITION_NAME = p_name;
	IF c = 0 THEN
		SET @p_sql = CONCAT("ALTER TABLE pc_zzsh_stat ADD PARTITION (PARTITION ", p_name, " VALUES LESS THAN (",y + 1,"))");
		PREPARE STMT FROM @p_sql;   
		EXECUTE STMT;  	
		DEALLOCATE PREPARE STMT;		
	END IF;
end;
//
delimiter ;
