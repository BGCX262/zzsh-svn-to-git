delimiter //
DROP TRIGGER IF EXISTS up_stats_tri//
CREATE TRIGGER up_stats_tri AFTER UPDATE ON pc_agency
FOR EACH ROW 
BEGIN

	IF (OLD.code != NEW.code OR
	   OLD.name != NEW.name OR 
	   OLD.invalid_datetime != NEW.invalid_datetime OR
	   OLD.create_datetime != NEW.create_datetime)  THEN
	 
		UPDATE pc_remind SET name = NEW.name, code = NEW.code, parent_id = NEW.parent_id WHERE agency_id = NEW.id;
		UPDATE pc_agency_stats SET name = NEW.name, code = NEW.code, parent_id = NEW.parent_id, setup_datetime = UNIX_TIMESTAMP(NEW.create_datetime), invalid_datetime = NEW.invalid_datetime WHERE agency_id = NEW.id;		 		 
		UPDATE pc_remind_lock SET name = NEW.name, code = NEW.code, parent_id = NEW.parent_id WHERE agency_id = NEW.id;
		UPDATE pc_zzsh_stat SET name = NEW.name, code = NEW.code, parent_id = NEW.parent_id, setup_datetime = UNIX_TIMESTAMP(NEW.create_datetime), invalid_datetime = NEW.invalid_datetime WHERE agency_id = NEW.id;
	END IF;

END
//
delimiter ;


delimiter //
DROP TRIGGER IF EXISTS del_stats_tri//
CREATE TRIGGER del_stats_tri AFTER DELETE ON pc_agency
FOR EACH ROW 
BEGIN

	DELETE FROM pc_remind WHERE agency_id = OLD.id;
	DELETE FROM pc_agency_stats WHERE agency_id = OLD.id;		 
	DELETE FROM pc_remind_lock WHERE agency_id = OLD.id;
	
END
//
delimiter ;


delimiter //
DROP TRIGGER IF EXISTS up_workpaln_tri//
CREATE TRIGGER up_workpaln_tri AFTER UPDATE ON pc_workplan
FOR EACH ROW 
BEGIN
	
	DECLARE up_txt varchar(255);
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
	
	IF (NEW.year < year(now()) AND NEW.status_id > OLD.status_id) THEN
		IF (OLD.status_id >= 3) THEN
			SELECT COUNT(CASE WHEN status_id = 5 THEN id END) into stat_eva FROM pc_workplan WHERE agency_id = NEW.agency_id AND type_id = NEW.type_id  AND year = NEW.year AND status_id >= 3;
			
			SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END),
				   COUNT(CASE WHEN b.content = 2 THEN a.id END),
				   COUNT(CASE WHEN b.content = 3 THEN a.id END),
				   COUNT(CASE WHEN b.content = 4 THEN a.id END)
				   into stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4 FROM pc_workplan as a left join pc_workplan_content as b on a.id = b.workplan_id WHERE a.agency_id = NEW.agency_id AND a.type_id = NEW.type_id AND a.year =NEW.year  AND a.status_id = 5 AND b.type = 4;
		
			IF (stat_eva > 0) THEN
				SET stat_eva = 1;
				SET stat_eva_rate = 1;
			ELSE 
				SET stat_eva = 0;
				SET stat_eva_rate = 0;
			END IF;
			
			IF stat_eva_rate is null THEN
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

			UPDATE pc_zzsh_stat SET eva = stat_eva, eva_rate = stat_eva_rate, eva_1 = stat_eva_1, eva_2 = stat_eva_2, eva_3 = stat_eva_3, eva_4 = stat_eva_4, 		eva_1_rate = stat_eva_1_rate, eva_2_rate = stat_eva_2_rate, eva_3_rate = stat_eva_3_rate, eva_4_rate = stat_eva_4_rate WHERE agency_id = NEW.agency_id AND year = NEW.year AND quarter = NEW.quarter AND month = 0 AND type_id = NEW.type_id ;

		END IF;
	END IF;
END
//
delimiter ;


delimiter //
DROP TRIGGER IF EXISTS up_meeting_tri//
CREATE TRIGGER up_meeting_tri AFTER UPDATE ON pc_meeting
FOR EACH ROW 
BEGIN
	
	DECLARE stat_total int(10) unsigned;
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
	
	SET  stat_total = 0;
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
	
	IF (NEW.year < year(now()) AND NEW.status_id > OLD.status_id) THEN
		IF (OLD.status_id >= 3) THEN
		
			IF (NEW.type_id IN (5,6,7)) THEN
				SELECT COUNT(*), COUNT(CASE WHEN status_id = 5 THEN id END) into stat_total, stat_eva FROM pc_meeting WHERE agency_id = NEW.agency_id AND year = NEW.year AND quarter = NEW.quarter AND month = NEW.month AND type_id = NEW.type_id AND status_id >= 3;
				
				SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END),
					   COUNT(CASE WHEN b.content = 2 THEN a.id END),
					   COUNT(CASE WHEN b.content = 3 THEN a.id END),
					   COUNT(CASE WHEN b.content = 4 THEN a.id END)
					   into stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = NEW.agency_id  AND a.year =NEW.year  AND quarter = NEW.quarter AND a.type_id = NEW.type_id  AND a.status_id = 5 AND b.type = 4;
				
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
				
				UPDATE pc_zzsh_stat 
				SET eva = stat_eva, eva_rate = stat_eva_rate, 
					eva_1 = stat_eva_1, eva_2 = stat_eva_2, eva_3 = stat_eva_3, eva_4 = stat_eva_4, 
					eva_1_rate = stat_eva_1_rate, eva_2_rate = stat_eva_2_rate, eva_3_rate = stat_eva_3_rate, eva_4_rate = stat_eva_4_rate
					WHERE agency_id = NEW.agency_id AND year = NEW.year AND quarter = NEW.quarter AND month = 0 AND type_id = NEW.type_id ;
					   
			END IF;

			IF (NEW.type_id IN (8,9)) THEN
				SELECT COUNT(*), COUNT(CASE WHEN status_id = 5 THEN id END) into stat_total, stat_eva FROM pc_meeting WHERE agency_id = NEW.agency_id AND year = NEW.year AND quarter = NEW.quarter AND month = NEW.month AND type_id = NEW.type_id AND status_id >= 3;
				
				SELECT COUNT(CASE WHEN b.content = 1 THEN a.id END),
					   COUNT(CASE WHEN b.content = 2 THEN a.id END),
					   COUNT(CASE WHEN b.content = 3 THEN a.id END),
					   COUNT(CASE WHEN b.content = 4 THEN a.id END)
					   into stat_eva_1, stat_eva_2, stat_eva_3, stat_eva_4 FROM pc_meeting as a left join pc_meeting_content as b on a.id = b.meeting_id WHERE a.agency_id = NEW.agency_id  AND a.year =NEW.year  AND quarter = NEW.quarter AND month = NEW.month AND a.type_id = NEW.type_id  AND a.status_id = 5 AND b.type = 4;
					   
					   
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

				UPDATE pc_zzsh_stat 
				SET eva = stat_eva, eva_rate = stat_eva_rate, 
					eva_1 = stat_eva_1, eva_2 = stat_eva_2, eva_3 = stat_eva_3, eva_4 = stat_eva_4, 
					eva_1_rate = stat_eva_1_rate, eva_2_rate = stat_eva_2_rate, eva_3_rate = stat_eva_3_rate, eva_4_rate = stat_eva_4_rate
					WHERE agency_id = NEW.agency_id AND year = NEW.year AND quarter = NEW.quarter AND month = NEW.month AND type_id = NEW.type_id ;
				   
			END IF;			
		
		END IF;
	END IF;
END
//
delimiter ;

