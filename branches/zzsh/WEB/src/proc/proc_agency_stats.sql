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
	DECLARE v_setup_datetime int(11) unsigned;
	DECLARE c_invalid_datetime int(11) unsigned;
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

	DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, parent_id, create_datetime, invalid_datetime, p_count, zb_num FROM  pc_agency WHERE code_id = 10;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  
	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;
	cursor_loop:loop
		FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_parent_id, c_setup_datetime, c_invalid_datetime, stat_dxz_num, stat_dy_num;

		IF row >= rows then
			leave cursor_loop;
		end if;
			
		IF (c_parent_id IS NULL OR c_parent_id <= 0) THEN
			SET row = row + 1;
			ITERATE cursor_loop;
		END IF;			
		
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

--		党支部数量			
		SET stat_dzb_num = 1;
		
--      截止统计时间支部改选时间满两年的支部数				
		IF unix_timestamp(now()) > unix_timestamp(DATE_ADD(c_setup_datetime,INTERVAL 2 YEAR)) THEN
			SET stat_more2year_num = 1;
		END IF;
			  
--		党员人数不足7人的党支部数量			  
--		SELECT COUNT(*) INTO stat_less7_num FROM pc_member where agency_id = c_id;
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
					
--		只设支部书记未设支部副书记、支部委员的支部数量
		SELECT COUNT(*) INTO stat_no_fsj_zbwy_num FROM pc_member where agency_id = c_id;
		IF (stat_no_fsj_zbwy_num = 1 AND stat_zbsj_num >= 1) THEN
			SET stat_no_fsj_zbwy_num = 1;
		ELSE
			SET stat_no_fsj_zbwy_num = 0;
		END IF;
				
		SET v_setup_datetime = UNIX_TIMESTAMP(c_setup_datetime);
		INSERT INTO pc_agency_stats (agency_id, name, code_id, code, setup_datetime, invalid_datetime, parent_id, zz_num, jc_num, ejdw_num, dzj_num, dzb_num, more2year_num, less7_num, no_fsj_zbwy_num, dxz_num, dy_num, zbsj_num, zbfsj_num, zzwy_num, xcwy_num, jjwy_num, qnwy_num, ghwy_num, fnwy_num, bmwy_num) VALUES
		(c_id, c_name, c_code_id, c_code, v_setup_datetime, c_invalid_datetime, c_parent_id, stat_zz_num, stat_jc_num, stat_ejdw_num, stat_dzj_num, stat_dzb_num, stat_more2year_num, stat_less7_num, stat_no_fsj_zbwy_num, stat_dxz_num, stat_dy_num, stat_zbsj_num, stat_zbfsj_num, stat_zzwy_num, stat_xcwy_num, stat_jjwy_num, stat_qnwy_num, stat_ghwy_num, stat_fnwy_num, stat_bmwy_num)
		ON DUPLICATE KEY UPDATE 
			name = c_name, 
			code_id = c_code_id, 
			code = c_code, 
			setup_datetime = v_setup_datetime,
			invalid_datetime = c_invalid_datetime,
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
  
    DECLARE s_cursor CURSOR FOR SELECT id, name, code_id, code, parent_id FROM  pc_agency WHERE code_id in (7,8,15);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  
	open s_cursor; 
	SELECT FOUND_ROWS() into rows;
	SET row = 0;
	cursor_loop:loop
		FETCH s_cursor into c_id, c_name, c_code_id, c_code, c_parent_id;

		IF row >= rows then
			leave cursor_loop;
		end if;		
		
		IF (c_parent_id IS NULL OR c_parent_id <= 0) THEN
			SET row = row + 1;
			ITERATE cursor_loop;
		END IF;		
		
		SET stat_zz_num = 0;
		SET stat_jc_num = 0;
		SET stat_ejdw_num = 0;
		SET stat_dzj_num = 0;
		
		
		IF c_code_id = 7 THEN
			SELECT COUNT(*) INTO stat_ejdw_num  FROM pc_agency WHERE code like CONCAT (c_code, '%') and code_id = 15;
			SELECT COUNT(*) INTO stat_dzj_num FROM pc_agency WHERE code like CONCAT (c_code, '%') and code_id = 8;
			SET stat_jc_num = 1;
		END IF;
			
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

			SET row = row + 1;
	end loop cursor_loop;
	close s_cursor;
	
	SELECT COUNT(CASE WHEN code_id = 7 THEN id END) INTO stat_jc_num FROM pc_agency WHERE parent_id = 1;
	
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
	WHERE T1.parent_id = 1 ) as T3
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
