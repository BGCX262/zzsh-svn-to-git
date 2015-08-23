SELECT T2.p_name as '���ϼ���ί',T2.parent_name as '�ϼ���ί', T2.name as '֧������', T2.setup_datetime as '��ѡʱ��',
				T1.zwh_attend_rate 		as '֧ί��-��ϯ��', 
				T1.zwh_reported_rate 	as '֧ί��-�淶ִ����', 
				T1.zwh_total 					as '֧ί��-�����ܴ���',  
				T1.zwh_total_return 	as '֧ί��-���غ��ϱ�', 
				T1.zwh_total_delay 		as '֧ί��-������Ȩ���ϱ�', 
				T1.zwh_eva_rate 			as '֧ί��-�ϼ�������', 
				T1.zwh_eva_1_rate			as '֧ί��-�ϼ�������-��', 
				T1.zwh_eva_2_rate			as '֧ί��-�ϼ�������-�Ϻ�', 
				T1.zwh_eva_3_rate			as '֧ί��-�ϼ�������-һ��',  
				T1.zwh_eva_4_rate			as '֧ί��-�ϼ�������-��', 

				T1.dydh_attend_rate 		as '��Ա���-��ϯ��', 
				T1.dydh_reported_rate 	as '��Ա���-�淶ִ����', 
				T1.dydh_total 					as '��Ա���-�����ܴ���',  
				T1.dydh_total_return 		as '��Ա���-���غ��ϱ�', 
				T1.dydh_total_delay 		as '��Ա���-������Ȩ���ϱ�', 
				T1.dydh_eva_rate 				as '��Ա���-�ϼ�������', 
				T1.dydh_eva_1_rate			as '��Ա���-�ϼ�������-��', 
				T1.dydh_eva_2_rate			as '��Ա���-�ϼ�������-�Ϻ�', 
				T1.dydh_eva_3_rate			as '��Ա���-�ϼ�������-һ��',  
				T1.dydh_eva_4_rate			as '��Ա���-�ϼ�������-��', 
			 
				T1.mzshh_attend_rate 		as '���������-��ϯ��', 
				T1.mzshh_reported_rate 	as '���������-�淶ִ����', 
				T1.mzshh_total 					as '���������-�����ܴ���',  
				T1.mzshh_total_return 	as '���������-���غ��ϱ�', 
				T1.mzshh_total_delay 		as '���������-������Ȩ���ϱ�', 
				T1.mzshh_eva_rate 			as '���������-�ϼ�������', 
				T1.mzshh_eva_1_rate			as '���������-�ϼ�������-��', 
				T1.mzshh_eva_2_rate			as '���������-�ϼ�������-�Ϻ�', 
				T1.mzshh_eva_3_rate			as '���������-�ϼ�������-һ��',  
				T1.mzshh_eva_4_rate			as '���������-�ϼ�������-��',			 
			 
				T1.dk_attend_rate 		as '����-��ϯ��', 
				T1.dk_reported_rate 	as '����-�淶ִ����', 
				T1.dk_total 					as '����-�����ܴ���',  
				T1.dk_total_return 		as '����-���غ��ϱ�', 
				T1.dk_total_delay 		as '����-������Ȩ���ϱ�', 
				T1.dk_eva_rate 				as '����-�ϼ�������', 
				T1.dk_eva_1_rate			as '����-�ϼ�������-��', 
				T1.dk_eva_2_rate			as '����-�ϼ�������-�Ϻ�', 
				T1.dk_eva_3_rate			as '����-�ϼ�������-һ��',  
				T1.dk_eva_4_rate			as '����-�ϼ�������-��', 
				
				T1.qt_attend_rate 		as '����-��ϯ��', 
				T1.qt_total 					as '����-�����ܴ���',  
				T1.qt_total_return 		as '����-���غ��ϱ�', 
				T1.qt_total_delay 		as '����-������Ȩ���ϱ�', 
				T1.qt_eva_rate 				as '����-�ϼ�������', 
				T1.qt_eva_1_rate			as '����-�ϼ�������-��', 
				T1.qt_eva_2_rate			as '����-�ϼ�������-�Ϻ�', 
				T1.qt_eva_3_rate			as '����-�ϼ�������-һ��',  
				T1.qt_eva_4_rate			as '����-�ϼ�������-��'										 

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