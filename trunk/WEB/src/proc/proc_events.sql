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
END 
//

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
        	CALL remind_lock(year(now()));
            CALL stat_zzsh(year(now()));          
        END IF;
        SELECT RELEASE_LOCK('event_stats_lock');
    END IF;
END 
//

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
END 
//
   
delimiter ;

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
END 
//
delimiter ;

SET GLOBAL event_scheduler = ON;
