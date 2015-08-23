SELECT T2.p_name as '最上级党委',T2.parent_name as '上级党委', T2.name as '支部名称', T2.setup_datetime as '设选时间',
				T1.zwh_attend_rate 		as '支委会-出席率', 
				T1.zwh_reported_rate 	as '支委会-规范执行率', 
				T1.zwh_total 					as '支委会-开会总次数',  
				T1.zwh_total_return 	as '支委会-驳回后上报', 
				T1.zwh_total_delay 		as '支委会-逾期授权后上报', 
				T1.zwh_eva_rate 			as '支委会-上级评价率', 
				T1.zwh_eva_1_rate			as '支委会-上级评价率-好', 
				T1.zwh_eva_2_rate			as '支委会-上级评价率-较好', 
				T1.zwh_eva_3_rate			as '支委会-上级评价率-一般',  
				T1.zwh_eva_4_rate			as '支委会-上级评价率-差', 

				T1.dydh_attend_rate 		as '党员大会-出席率', 
				T1.dydh_reported_rate 	as '党员大会-规范执行率', 
				T1.dydh_total 					as '党员大会-开会总次数',  
				T1.dydh_total_return 		as '党员大会-驳回后上报', 
				T1.dydh_total_delay 		as '党员大会-逾期授权后上报', 
				T1.dydh_eva_rate 				as '党员大会-上级评价率', 
				T1.dydh_eva_1_rate			as '党员大会-上级评价率-好', 
				T1.dydh_eva_2_rate			as '党员大会-上级评价率-较好', 
				T1.dydh_eva_3_rate			as '党员大会-上级评价率-一般',  
				T1.dydh_eva_4_rate			as '党员大会-上级评价率-差', 
			 
				T1.mzshh_attend_rate 		as '民主生活会-出席率', 
				T1.mzshh_reported_rate 	as '民主生活会-规范执行率', 
				T1.mzshh_total 					as '民主生活会-开会总次数',  
				T1.mzshh_total_return 	as '民主生活会-驳回后上报', 
				T1.mzshh_total_delay 		as '民主生活会-逾期授权后上报', 
				T1.mzshh_eva_rate 			as '民主生活会-上级评价率', 
				T1.mzshh_eva_1_rate			as '民主生活会-上级评价率-好', 
				T1.mzshh_eva_2_rate			as '民主生活会-上级评价率-较好', 
				T1.mzshh_eva_3_rate			as '民主生活会-上级评价率-一般',  
				T1.mzshh_eva_4_rate			as '民主生活会-上级评价率-差',			 
			 
				T1.dk_attend_rate 		as '党课-出席率', 
				T1.dk_reported_rate 	as '党课-规范执行率', 
				T1.dk_total 					as '党课-开会总次数',  
				T1.dk_total_return 		as '党课-驳回后上报', 
				T1.dk_total_delay 		as '党课-逾期授权后上报', 
				T1.dk_eva_rate 				as '党课-上级评价率', 
				T1.dk_eva_1_rate			as '党课-上级评价率-好', 
				T1.dk_eva_2_rate			as '党课-上级评价率-较好', 
				T1.dk_eva_3_rate			as '党课-上级评价率-一般',  
				T1.dk_eva_4_rate			as '党课-上级评价率-差', 
				
				T1.qt_attend_rate 		as '其他-出席率', 
				T1.qt_total 					as '其他-开会总次数',  
				T1.qt_total_return 		as '其他-驳回后上报', 
				T1.qt_total_delay 		as '其他-逾期授权后上报', 
				T1.qt_eva_rate 				as '其他-上级评价率', 
				T1.qt_eva_1_rate			as '其他-上级评价率-好', 
				T1.qt_eva_2_rate			as '其他-上级评价率-较好', 
				T1.qt_eva_3_rate			as '其他-上级评价率-一般',  
				T1.qt_eva_4_rate			as '其他-上级评价率-差'										 

  INTO OUTFILE 'E:/partycommittee_new/table_meeting.csv'
  FIELDS TERMINATED BY ',' 
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'		 
			 FROM		   
   
   
					(SELECT agency_id,
				 	  ROUND(SUM( CASE WHEN type_id = 8 THEN attend_rate END)/COUNT(CASE WHEN type_id = 8 AND total > 0 THEN total END), 4) as zwh_attend_rate, 
				 	  ROUND( COUNT(CASE WHEN type_id = 8 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 8 THEN agency_id END ), 4) zwh_reported_rate,
				 	  SUM(CASE WHEN type_id = 8 THEN total END ) as zwh_total,  
				 	  SUM(CASE WHEN type_id = 8 THEN total_return END) as zwh_total_return, 
						SUM(CASE WHEN type_id = 8 THEN total_delay END) as zwh_total_delay, 
				 	  ROUND(SUM(CASE WHEN type_id = 8 THEN eva END )/SUM( CASE WHEN type_id = 8 THEN total END ), 4) as zwh_eva_rate , 
				 	  ROUND(SUM(CASE WHEN type_id = 8 THEN eva_1 END )/SUM(CASE WHEN type_id = 8 THEN eva END ), 4) as zwh_eva_1_rate, 
						ROUND(SUM(CASE WHEN type_id = 8 THEN eva_2 END )/SUM(CASE WHEN type_id = 8 THEN eva END ), 4) as zwh_eva_2_rate,  
						ROUND(SUM(CASE WHEN type_id = 8 THEN eva_3 END )/SUM(CASE WHEN type_id = 8 THEN eva END ), 4) as zwh_eva_3_rate,  
						ROUND(SUM(CASE WHEN type_id = 8 THEN eva_4 END )/SUM(CASE WHEN type_id = 8 THEN eva END ), 4) as zwh_eva_4_rate,  
						
				 	  ROUND(SUM( CASE WHEN type_id = 5 THEN attend_rate END)/COUNT(CASE WHEN type_id = 5 AND total > 0 THEN total END), 4) as dk_attend_rate, 
				 	  ROUND( COUNT(CASE WHEN type_id = 5 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 5 THEN agency_id END ), 4) dk_reported_rate,
				 	  SUM(CASE WHEN type_id = 5 THEN total END ) as dk_total,  
				 	  SUM(CASE WHEN type_id = 5 THEN total_return END) as dk_total_return, 
						SUM(CASE WHEN type_id = 5 THEN total_delay END) as dk_total_delay, 
				 	  ROUND(SUM(CASE WHEN type_id = 5 THEN eva END )/SUM( CASE WHEN type_id = 5 THEN total END ), 4) as dk_eva_rate , 
				 	  ROUND(SUM(CASE WHEN type_id = 5 THEN eva_1 END )/SUM(CASE WHEN type_id = 5 THEN eva END ), 4) as dk_eva_1_rate, 
						ROUND(SUM(CASE WHEN type_id = 5 THEN eva_2 END )/SUM(CASE WHEN type_id = 5 THEN eva END ), 4) as dk_eva_2_rate,  
						ROUND(SUM(CASE WHEN type_id = 5 THEN eva_3 END )/SUM(CASE WHEN type_id = 5 THEN eva END ), 4) as dk_eva_3_rate,  
						ROUND(SUM(CASE WHEN type_id = 5 THEN eva_4 END )/SUM(CASE WHEN type_id = 5 THEN eva END ), 4) as dk_eva_4_rate,  	
				
				 	  ROUND(SUM( CASE WHEN type_id = 6 THEN attend_rate END)/COUNT(CASE WHEN type_id = 6 AND total > 0 THEN total END), 4) as dydh_attend_rate, 
				 	  ROUND( COUNT(CASE WHEN type_id = 6 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 6 THEN agency_id END ), 4) dydh_reported_rate,
				 	  SUM(CASE WHEN type_id = 6 THEN total END ) as dydh_total,  
				 	  SUM(CASE WHEN type_id = 6 THEN total_return END) as dydh_total_return, 
						SUM(CASE WHEN type_id = 6 THEN total_delay END) as dydh_total_delay, 
				 	  ROUND(SUM(CASE WHEN type_id = 6 THEN eva END )/SUM( CASE WHEN type_id = 6 THEN total END ), 4) as dydh_eva_rate , 
				 	  ROUND(SUM(CASE WHEN type_id = 6 THEN eva_1 END )/SUM(CASE WHEN type_id = 6 THEN eva END ), 4) as dydh_eva_1_rate, 
						ROUND(SUM(CASE WHEN type_id = 6 THEN eva_2 END )/SUM(CASE WHEN type_id = 6 THEN eva END ), 4) as dydh_eva_2_rate,  
						ROUND(SUM(CASE WHEN type_id = 6 THEN eva_3 END )/SUM(CASE WHEN type_id = 6 THEN eva END ), 4) as dydh_eva_3_rate,  
						ROUND(SUM(CASE WHEN type_id = 6 THEN eva_4 END )/SUM(CASE WHEN type_id = 6 THEN eva END ), 4) as dydh_eva_4_rate,  
						
				 	  ROUND(SUM( CASE WHEN type_id = 7 THEN attend_rate END)/COUNT(CASE WHEN type_id = 7 AND total > 0 THEN total END), 4) as mzshh_attend_rate, 
				 	  ROUND( COUNT(CASE WHEN type_id = 7 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 7 THEN agency_id END ), 4) mzshh_reported_rate,
				 	  SUM(CASE WHEN type_id = 7 THEN total END ) as mzshh_total,  
				 	  SUM(CASE WHEN type_id = 7 THEN total_return END) as mzshh_total_return, 
						SUM(CASE WHEN type_id = 7 THEN total_delay END) as mzshh_total_delay, 
				 	  ROUND(SUM(CASE WHEN type_id = 7 THEN eva END )/SUM( CASE WHEN type_id = 7 THEN total END ), 4) as mzshh_eva_rate , 
				 	  ROUND(SUM(CASE WHEN type_id = 7 THEN eva_1 END )/SUM(CASE WHEN type_id = 7 THEN eva END ), 4) as mzshh_eva_1_rate, 
						ROUND(SUM(CASE WHEN type_id = 7 THEN eva_2 END )/SUM(CASE WHEN type_id = 7 THEN eva END ), 4) as mzshh_eva_2_rate,  
						ROUND(SUM(CASE WHEN type_id = 7 THEN eva_3 END )/SUM(CASE WHEN type_id = 7 THEN eva END ), 4) as mzshh_eva_3_rate,  
						ROUND(SUM(CASE WHEN type_id = 7 THEN eva_4 END )/SUM(CASE WHEN type_id = 7 THEN eva END ), 4) as mzshh_eva_4_rate,  
						
				 	  ROUND(SUM( CASE WHEN type_id = 9 THEN attend_rate END)/COUNT(CASE WHEN type_id = 9 AND total > 0 THEN total END), 4) as qt_attend_rate, 
				 	  ROUND( COUNT(CASE WHEN type_id = 9 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 9 THEN agency_id END ), 4) qt_reported_rate,
				 	  SUM(CASE WHEN type_id = 9 THEN total END ) as qt_total,  
				 	  SUM(CASE WHEN type_id = 9 THEN total_return END) as qt_total_return, 
						SUM(CASE WHEN type_id = 9 THEN total_delay END) as qt_total_delay, 
				 	  ROUND(SUM(CASE WHEN type_id = 9 THEN eva END )/SUM( CASE WHEN type_id = 9 THEN total END ), 4) as qt_eva_rate , 
				 	  ROUND(SUM(CASE WHEN type_id = 9 THEN eva_1 END )/SUM(CASE WHEN type_id = 9 THEN eva END ), 4) as qt_eva_1_rate, 
						ROUND(SUM(CASE WHEN type_id = 9 THEN eva_2 END )/SUM(CASE WHEN type_id = 9 THEN eva END ), 4) as qt_eva_2_rate,  
						ROUND(SUM(CASE WHEN type_id = 9 THEN eva_3 END )/SUM(CASE WHEN type_id = 9 THEN eva END ), 4) as qt_eva_3_rate,  
						ROUND(SUM(CASE WHEN type_id = 9 THEN eva_4 END )/SUM(CASE WHEN type_id = 9 THEN eva END ), 4) as qt_eva_4_rate						
				
				 FROM pc_zzsh_stat
				 WHERE code_id = 10 and setup_datetime < '2012-10-01 00:00:00' and  year = 2012 and quarter = 3  GROUP BY agency_id) as T1
LEFT JOIN
	 (
	 
		select h.name as p_name, g.* from
			(select f.parent_id as p_id, e.* from
				(select d.name as parent_name, d.id as parent_id, c.name,c.id, c.code, c.setup_datetime  FROM
					(select a.id, a.name, a.code, a.setup_datetime, b.parent_id from pc_agency as a left join pc_agency_relation as b on a.id = b.agency_id) as c 
						LEFT JOIN  pc_agency as d on c.parent_id = d.id ) as e
					LEFT JOIN  pc_agency_relation as f on e.parent_id = f.agency_id) as g
				LEFT JOIN  pc_agency as h on g.p_id = h.id

   ) as T2 ON T1.agency_id = T2.id
   where T2.parent_id is not null order by agency_id 