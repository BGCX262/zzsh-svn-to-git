SELECT year, type_id,
				SUM(total) as total, SUM(total_success) as total_success, SUM(total_return) as total_return, 
				SUM(total_delay) as total_delay, SUM( reported ) as reported , 
				ROUND( SUM(agency_goodjob)/SUM(zb_count), 4) reported_rate, 
				ROUND( SUM(return_count)/SUM(zb_count), 4) return_rate, 
				ROUND( SUM(delay_count)/SUM(zb_count), 4) delay_rate, 
				SUM(  attend ) as attend ,  SUM(  asence ) as asence ,  
				ROUND(SUM(attend_rate)/SUM(attend_count), 4) as attend_rate, 
				SUM(eva) as eva, ROUND(SUM(eva)/SUM(total), 4) as eva_rate , 
				SUM(eva_1) as eva_1, SUM(eva_2) as eva_2, SUM(eva_3) as eva_3, SUM(eva_4) as eva_4, 
				ROUND(SUM(eva_1)/SUM(eva), 4) as eva_1_rate, 
				ROUND(SUM(eva_2)/SUM(eva), 4) as eva_2_rate,  
				ROUND(SUM(eva_3)/SUM(eva), 4) as eva_3_rate,  
				ROUND(SUM(eva_4)/SUM(eva), 4) as eva_4_rate,  
				SUM(agency_goodjob) as agency_goodjob 
				
  INTO OUTFILE 'E:/partycommittee_new/table1.csv'
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'				
FROM
(

	SELECT 	year, type_id, 
					SUM(total) as total,  
					SUM(total_success) as total_success, 
					SUM(total_return) as total_return, 
					SUM(total_delay) as total_delay, 
					SUM(reported ) as reported ,
					ROUND( COUNT(CASE WHEN return_rate = 1 THEN agency_id END)/COUNT(*), 4) return_rate, 
					ROUND( COUNT(CASE WHEN delay_rate = 1 THEN agency_id END)/COUNT(*), 4) delay_rate, 
					SUM(  attend ) as attend ,  SUM(  asence ) as asence ,  
					SUM(attend_rate) as attend_rate,
					SUM(eva) as eva, 
					SUM(eva_1) as eva_1, SUM(eva_2) as eva_2, 
					SUM(eva_3) as eva_3, SUM(eva_4) as eva_4, 
					COUNT(CASE WHEN reported_rate = 1 THEN agency_id END) as agency_goodjob,
					COUNT(CASE WHEN return_rate = 1 THEN agency_id END) as return_count, 
					COUNT(CASE WHEN delay_rate = 1 THEN agency_id END) as delay_count, 
					COUNT(CASE WHEN total > 0 THEN total END) as attend_count,
					COUNT(*) as zb_count
	FROM  pc_zzsh_stat
	WHERE  setup_datetime <= '2012-10-01 00:00:00'  AND year =2012 AND quarter = 3  AND type_id = 2 GROUP BY agencyid, year,type_id

 ) as T1
GROUP BY year, type_id