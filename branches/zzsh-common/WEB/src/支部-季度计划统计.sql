SELECT T2.p_name as '最上级党委',T2.parent_name as '上级党委', T2.name as '支部名称', T2.setup_datetime as '设选时间',		 
			 T1.qp_reported_rate 			as '季度计划-规范报送率',
			 T1.qp_agency_goodjob 		as '季度计划-规范报送支部数',
			 T1.qp_return_rate 				as '季度计划-驳回后上报率',
			 T1.qp_delay_rate 				as '季度计划-逾期授权后上报率',
			 T1.qp_eva_rate 					as '季度计划-上级评价率',
			 T1.qp_eva_1_rate 				as '季度计划-上级评价率-好',
			 T1.qp_eva_2_rate 				as '季度计划-上级评价率-较好',
			 T1.qp_eva_3_rate 				as '季度计划-上级评价率-一般',
			 T1.qp_eva_4_rate 				as '季度计划-上级评价率-差'
	FROM
 (SELECT agency_id,
				 	  ROUND( COUNT(CASE WHEN  reported_rate = 1  THEN agency_id END)/COUNT(*), 4) qp_reported_rate,
				 	  (CASE WHEN  reported_rate = 1 THEN 1 ELSE 0 END) as qp_agency_goodjob,
				 	  ROUND( COUNT(CASE WHEN  return_rate = 1 THEN agency_id END)/COUNT(*), 4) as qp_return_rate, 
				 	  ROUND( COUNT(CASE WHEN  delay_rate = 1 THEN agency_id END)/COUNT(*), 4) as qp_delay_rate,
				 	  ROUND(SUM(eva)/SUM(total), 4) as qp_eva_rate , 
				 	  ROUND(SUM(eva_1)/SUM(eva), 4) as qp_eva_1_rate, 
						ROUND(SUM(eva_2)/SUM(eva), 4) as qp_eva_2_rate,  
						ROUND(SUM(eva_3)/SUM(eva), 4) as qp_eva_3_rate,  
						ROUND(SUM(eva_4)/SUM(eva), 4) as qp_eva_4_rate
	FROM  pc_zzsh_stat
	WHERE  code_id = 10 and setup_datetime <= '2012-07-10 00:00:00' and  year = 2012 and quarter = 3  and type_id = 2 GROUP BY agency_id ) as T1
	
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
						
						