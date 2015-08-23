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
	DECLARE c_setup_datetime datetime;
	DECLARE done int default 0;
	
	DECLARE y year(4);
	DECLARE q tinyint(1) unsigned;
	DECLARE m smallint(5) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i int;
	DECLARE s tinyint;
	DECLARE pre_s tinyint(1) unsigned;
	
	DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, create_datetime as setup_datetime, parent_id FROM  pc_agency WHERE code_id = 10 and invalid_datetime = 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
		
	truncate pc_remind;
	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;
	cursor_loop:loop
		FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_setup_datetime, c_parent_id;
		SELECT name into c_parent_name FROM pc_agency where id = c_parent_id;
		if row >= rows then
			leave cursor_loop;
		end if;		
		
		IF (c_parent_id IS NULL OR c_parent_id <= 0) THEN
			SET row = row + 1;
			ITERATE cursor_loop;
		END IF;
		
		set i = 1;
		type_while:while i < 9 do	
		
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
			
			IF (i = 1 OR i = 4) THEN
				IF year(c_setup_datetime) > y THEN
					set i=i+1;
					ITERATE type_while;				
				END IF;
			END IF;

			IF i in (1,2,3,4,5,6,7) THEN
				SET pre_s = 0;
				CALL set_remind_status(c_setup_datetime, y, q, m, i, pre_s);
				IF pre_s = 9 THEN
					SET i = i + 1;
					ITERATE type_while;							
				END IF;
			END IF;		
			
			IF i = 8 THEN
				IF year(c_setup_datetime) = y AND month(c_setup_datetime) > m THEN
					SET i = i + 1;
					ITERATE type_while;					
				END IF;
			
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
			
			INSERT INTO  pc_remind (agency_id, name, code_id, code, parent_id, parent_name, year, quarter, type_id, status) 
			VALUES (c_id, c_name, c_code_id,c_code, c_parent_id, c_parent_name,  y, q, i, s) 			
			ON DUPLICATE KEY UPDATE status = s, name =c_name, code = c_code, parent_name = c_parent_name;

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

	DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, parent_id FROM  pc_agency WHERE  invalid_datetime = 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

	
  truncate pc_remind_stat;
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