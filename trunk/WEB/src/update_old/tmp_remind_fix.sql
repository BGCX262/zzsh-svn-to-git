
delimiter //
DROP procedure IF EXISTS tmp_remind_fix//
CREATE PROCEDURE tmp_remind_fix(c_y smallint(4))
begin
	DECLARE c_id int(11) unsigned;
	DECLARE done int default 0;
	
	DECLARE y smallint(4) unsigned;
	DECLARE q tinyint(1) unsigned;
	DECLARE m tinyint(1) unsigned;

	DECLARE rows int default 0;
	DECLARE row int default 0;
	DECLARE i tinyint(1) unsigned;
	DECLARE s tinyint(1) unsigned;
	DECLARE c_s tinyint(1) unsigned;

	DECLARE s_cursor CURSOR FOR SELECT agency_id, year,quarter,month,type_id, status FROM  pc_remind_lock WHERE year = 2013;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	IF c_y is null THEN
		SET c_y = year(now());
	END IF;	
	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;
	SET @sql_txt = '';
	cursor_loop:loop
		FETCH s_cursor into c_id, y, q, m, i, s;
		select c_id, y, q, m, i, s;
		IF row >= rows then
			leave cursor_loop;
		end if;

		if s = 9 THEN
			if i <=4 THEN
				SELECT max(status_id) into c_s FROM pc_workplan WHERE agency_id = c_id AND year = y AND quarter = q AND type_id = i;
			ELSE 
				SELECT max(status_id) into c_s FROM pc_meeting WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i;
			END IF;
			IF  c_s IS NULL THEN
				SET c_s = 0;
			END IF;
			SELECT c_id,c_s;
			IF c_s > 0 THEN
				UPDATE pc_remind_lock set status = 8 WHERE agency_id = c_id AND year = y AND quarter = q AND month = m AND type_id = i AND status = 9;
			END IF;	
		END IF;

	SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
		
	
end;
//
delimiter ;
