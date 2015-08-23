SELECT T2.p_name as '���ϼ���ί',T2.parent_name as '�ϼ���ί', T2.name as '֧������', T2.setup_datetime as '��ѡʱ��',		 
			 T1.qp_reported_rate 			as '���ȼƻ�-�淶������',
			 T1.qp_agency_goodjob 		as '���ȼƻ�-�淶����֧����',
			 T1.qp_return_rate 				as '���ȼƻ�-���غ��ϱ���',
			 T1.qp_delay_rate 				as '���ȼƻ�-������Ȩ���ϱ���',
			 T1.qp_eva_rate 					as '���ȼƻ�-�ϼ�������',
			 T1.qp_eva_1_rate 				as '���ȼƻ�-�ϼ�������-��',
			 T1.qp_eva_2_rate 				as '���ȼƻ�-�ϼ�������-�Ϻ�',
			 T1.qp_eva_3_rate 				as '���ȼƻ�-�ϼ�������-һ��',
			 T1.qp_eva_4_rate 				as '���ȼƻ�-�ϼ�������-��'
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
						
						