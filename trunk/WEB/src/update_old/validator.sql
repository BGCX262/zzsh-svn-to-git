SELECT  MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE()) QUARTER - INTERVAL 1 DAY

//获取季度第一天
SELECT  Date_ADD(MAKEDATE(2012, 1) + INTERVAL 2 QUARTER - INTERVAL    1 QUARTER , INTERVAL 10 DAY);

//获取季度最后一天
SELECT  Date_ADD(MAKEDATE(2012, 1) + INTERVAL 2 QUARTER - INTERVAL 1 DAY, INTERVAL -10 DAY);

SELECT MAKEDATE(2012, 1) + INTERVAL 2 QUARTER - INTERVAL 1 DAY


//验证锁定语句======================================================

//年度计划
SELECT * FROM `pc_agency` WHERE code_id = 10 and `parent_id` > 0 and id not in (select distinct agency_id from pc_workplan where year = 2012 and type_id = 1 and status_id > 2)



//季度计划
   
   //一季度
   SELECT * FROM `pc_agency` WHERE code_id = 10 and `parent_id` > 0 and id not in (select distinct agency_id from pc_workplan where year = 2012 and quarter = 1 and type_id = 2 and status_id > 2)
   
   SELECT * FROM `pc_remind_lock` WHERE year =2012 AND quarter =1 AND type_id =2 


   //二季度
   SELECT * FROM `pc_agency` WHERE code_id = 10 and `parent_id` > 0 and id not in (select distinct agency_id from pc_workplan where year = 2012 and quarter = 2 and type_id = 2 and status_id > 2)
   
   SELECT * FROM `pc_remind_lock` WHERE year =2012 AND quarter = 2 AND type_id =2 
   
//月份
   

   SELECT * FROM `pc_agency` WHERE code_id = 10 and `parent_id` > 0 and id not in (select distinct agency_id from pc_meeting where year = 2012 and quarter = 1 and month = 1 and type_id = 8 and status_id > 2)
   
   SELECT * FROM `pc_remind_lock` WHERE year =2012 AND quarter = 1 AND month = 1 AND type_id =8
   
   
   
   
   
 // 支委会 
   SELECT * FROM `pc_agency` WHERE name like '%大型工矿党总支%'

SELECT count(*) as stat_total, count(case when status_id = 5 then id end) as stat_eva FROM `pc_meeting` 
WHERE agency_id in (select id from pc_agency where code like '15%' and code_id = 10) 
and year = 2012 and month in (10,11,12) and type_id = 8 and status_id in (3,4,5)


SELECT * FROM pc_zzsh_stat WHERE code LIKE '17%' AND year =2012 AND MONTH =12 AND type_id =8 AND eva =0


select agency_id pc_meeting WHERE agency_id in (select id from pc_agency where code like '17%' and code_id = 10) 
and year = 2012 and month = 12 and type_id = 8 and status_id = 5

  // 党员大会
  
     SELECT * FROM `pc_agency` WHERE name like '%警卫局党委%'

SELECT count(*) as stat_total, count(case when status_id = 5 then id end) as stat_eva FROM `pc_meeting` 
WHERE agency_id in (select id from pc_agency where code like '15%' and code_id = 10) 
and year = 2012 and quarter = 4  and type_id = 5 and status_id in (3,4,5)






SELECT count(*) as stat_total, count(case when status_id = 5 then id end) as stat_eva FROM `pc_meeting` 
WHERE 
year = 2012 and month in (10,11,12) and type_id = 8 and status_id in (3,4,5)



SELECT T1.agency_id, T2.name, T2.code_id, T2.code,  0 as parent_id, 2012 as year, 8 as type_id,  (CASE WHEN T1.total is NULL THEN 0 ELSE T1.total END) as total,  (CASE WHEN T1.total_success is NULL THEN 0 ELSE T1.total_success END) as total_success,  (CASE WHEN T1.total_return is NULL THEN 0 ELSE T1.total_return END) as total_return,  (CASE WHEN T1.total_delay is NULL THEN 0 ELSE T1.total_delay END) as total_delay,  (CASE WHEN T1.reported is NULL THEN 0 ELSE T1.reported END) as reported,  (CASE WHEN T1.reported_rate is NULL THEN 0 ELSE T1.reported_rate END) as reported_rate,  (CASE WHEN T1.return_rate is NULL THEN 0 ELSE T1.return_rate END) as return_rate,  (CASE WHEN T1.delay_rate is NULL THEN 0 ELSE T1.delay_rate END) as delay_rate,    (CASE WHEN T1.attend is NULL THEN 0 ELSE T1.attend END) as attend,    (CASE WHEN T1.asence is NULL THEN 0 ELSE T1.asence END) as asence,    (CASE WHEN T1.attend_rate is NULL THEN 0 ELSE T1.attend_rate END) as attend_rate, (CASE WHEN T1.eva is NULL THEN 0 ELSE T1.eva END) as eva,    (CASE WHEN T1.eva_rate is NULL THEN 0 ELSE T1.eva_rate END) as eva_rate, (CASE WHEN T1.eva_1 is NULL THEN 0 ELSE T1.eva_1 END) as eva_1, (CASE WHEN T1.eva_2 is NULL THEN 0 ELSE T1.eva_2 END) as eva_2, (CASE WHEN T1.eva_3 is NULL THEN 0 ELSE T1.eva_3 END) as eva_3, (CASE WHEN T1.eva_4 is NULL THEN 0 ELSE T1.eva_4 END) as eva_4, (CASE WHEN T1.eva_1_rate is NULL THEN 0 ELSE T1.eva_1_rate END) as eva_1_rate, (CASE WHEN T1.eva_2_rate is NULL THEN 0 ELSE T1.eva_2_rate END) as eva_2_rate,  (CASE WHEN T1.eva_3_rate is NULL THEN 0 ELSE T1.eva_3_rate END) as eva_3_rate,  (CASE WHEN T1.eva_4_rate is NULL THEN 0 ELSE T1.eva_4_rate END) as eva_4_rate,   (CASE WHEN T1.agency_goodjob is NULL THEN 0 ELSE T1.agency_goodjob END) as agency_goodjob   FROM (  SELECT  288 as agency_id, 2012 as year, 8 as type_id, SUM(total) as total, SUM(total_success) as total_success, SUM(total_return) as total_return, SUM(total_delay) as total_delay, SUM( reported ) as reported ,  ROUND( SUM(agency_goodjob)/SUM(zb_count), 4) reported_rate,  ROUND( SUM(return_count)/SUM(zb_count), 4) return_rate,  ROUND( SUM(delay_count)/SUM(zb_count), 4) delay_rate,  SUM(  attend ) as attend ,  SUM(  asence ) as asence ,  ROUND(SUM(attend_rate)/SUM(attend_count), 4) as attend_rate,  SUM(eva) as eva, ROUND(SUM(eva)/SUM(total), 4) as eva_rate ,  SUM(eva_1) as eva_1, SUM(eva_2) as eva_2, SUM(eva_3) as eva_3, SUM(eva_4) as eva_4, ROUND(SUM(eva_1)/SUM(eva), 4) as eva_1_rate, ROUND(SUM(eva_2)/SUM(eva), 4) as eva_2_rate, ROUND(SUM(eva_3)/SUM(eva), 4) as eva_3_rate, ROUND(SUM(eva_4)/SUM(eva), 4) as eva_4_rate, SUM(agency_goodjob) as agency_goodjob FROM (  SELECT 	2012 as year, 8 as type_id, SUM(total) as total, SUM(total_success) as total_success, SUM(total_return) as total_return, SUM(total_delay) as total_delay, SUM(reported ) as reported , SUM(  attend ) as attend ,  SUM(  asence ) as asence , SUM(attend_rate) as attend_rate, SUM(eva) as eva, SUM(eva_1) as eva_1, SUM(eva_2) as eva_2, SUM(eva_3) as eva_3, SUM(eva_4) as eva_4, COUNT(CASE WHEN reported_rate = 1 THEN agency_id END) as agency_goodjob, COUNT(CASE WHEN return_rate = 1 THEN agency_id END) as return_count, COUNT(CASE WHEN delay_rate = 1 THEN agency_id END) as delay_count, COUNT(CASE WHEN total > 0 THEN total END) as attend_count, COUNT(*) as zb_count FROM  pc_zzsh_stat    WHERE code like '17%' AND setup_datetime <= '2012-12-31 00:00:00' AND year =2012 AND month =12 AND type_id = 8 GROUP BY YEAR, type_id   ) as T  ) as T1  LEFT JOIN pc_agency as T2 ON T1.agency_id = T2.id