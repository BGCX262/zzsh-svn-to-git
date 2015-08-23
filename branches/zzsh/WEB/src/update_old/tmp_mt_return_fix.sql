
delimiter //
DROP procedure IF EXISTS tmp_mt_return_fix//
CREATE PROCEDURE tmp_mt_return_fix()
begin
	DECLARE c_id int(11) unsigned;
	DECLARE c_meeting_id int(11) unsigned;
	DECLARE c_updatetime timestamp;
	DECLARE r_updatetime timestamp;
	DECLARE s tinyint(1) unsigned;
	DECLARE c_type_id tinyint(1) unsigned;
	DECLARE c_agency_id int(11) unsigned;
	DECLARE y smallint(4) unsigned;
	DECLARE q tinyint(1) unsigned;
	DECLARE m tinyint(1) unsigned;	
	DECLARE c_count int(11) unsigned;	
	
	DECLARE done int default 0;
	
	DECLARE rows int default 0;
	DECLARE row int default 0;

	DECLARE s_cursor CURSOR FOR SELECT id, meeting_id, updatetime  FROM pc_meeting_content WHERE meeting_id IN ( SELECT id FROM pc_meeting WHERE year = 2013 ) AND TYPE =2 ORDER BY meeting_id ASC;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	
	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;

	cursor_loop:loop
		FETCH s_cursor into c_id, c_meeting_id, c_updatetime;

		IF row >= rows then
			leave cursor_loop;
		end if;
		
		SET r_updatetime = NULL;
		SELECT updatetime INTO r_updatetime FROM pc_meeting_content where meeting_id = c_meeting_id AND type = 1;
		
		IF r_updatetime IS NULL THEN
		   SET r_updatetime = now();
		END IF;
		
		IF unix_timestamp(r_updatetime) < unix_timestamp(c_updatetime) THEN
		
			SELECT agency_id, type_id into c_agency_id, c_type_id FROM pc_meeting WHERE id = c_meeting_id;
		
			SET y = year(r_updatetime);
			SET q = quarter(r_updatetime);
			SET m = month(r_updatetime);
		
			IF  c_type_id in (5,6,7) THEN
				SET m = 0;
			END IF;
		
			SELECT COUNT(*) INTO c_count FROM pc_remind_lock WHERE agency_id = c_agency_id AND year = y AND quarter = q AND month = m AND type_id = c_type_id;
			IF c_count > 0 THEN
				SELECT c_count;
				SELECT c_updatetime, r_updatetime, y , q , m;
				SELECT c_agency_id, c_type_id, s;
				DELETE FROM pc_remind_lock WHERE agency_id = c_agency_id AND year = y AND quarter = q AND month = m AND type_id = c_type_id;
			END IF;
			
		END IF;		
		UPDATE pc_meeting_content SET updatetime = date_add(updatetime, interval -7 day) WHERE id = c_id;

		
	SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
end;
//
delimiter ;
