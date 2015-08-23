package com.partycommittee.persistence.daoimpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.hibernate.ejb.HibernateEntityManager;
import org.springframework.stereotype.Repository;

import com.common.utils.DateUtils;
import com.partycommittee.persistence.dao.PcStatsDao;
import com.partycommittee.persistence.po.PcRemind;
import com.partycommittee.persistence.po.PcRemindConfig;
import com.partycommittee.persistence.po.PcStats;
import com.partycommittee.remote.vo.FilterVo;
import com.partycommittee.remote.vo.PcMeetingZBStatsVo;
import com.partycommittee.remote.vo.PcStatsVo;
import com.partycommittee.remote.vo.PcWorkPlanZBStatsVo;

@Repository("PcStatsDaoImpl")
public class PcStatsDaoImpl extends JpaDaoBase implements PcStatsDao {

	
	
//	public List<PcStatsVo> getStatsByIdForAdmin(Integer id, Integer year,
//			List<Integer> qs, Integer typeId) {
//		try {
//			// 跨季度
//			String ids = "";
//			for (Integer idItem : qs) {
//				if (ids.equals("")) {
//					ids = idItem + "";
//				} else {
//					ids += "," + idItem;
//				}
//			}
//
//			Integer avg = qs.size();
//
//			String where = " WHERE 1= 1";
//			where = where + " WHERE code_id= 10";
//			where = where + " AND year =" + year;
//			where = where + " AND quarter in (" + ids + ")";
//			where = where + " AND type_id = " + typeId;
//						
//			String sql = createSql(id, where);
////			System.out.print(sql);
//			List<PcStatsVo> list = getResult(sql);
//			return list;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return null;
//	}	
	
	public List<PcStatsVo> getStatsById(Integer id, Integer year,
			List<Integer> qs, Integer typeId) {
		try {
			// 跨季度
			String ids = "";
			for (Integer idItem : qs) {
				if (ids.equals("")) {
					ids = idItem + "";
				} else {
					ids += "," + idItem;
				}
			}

			Integer avg = qs.size();
			String where = " WHERE 1= 1";
			EntityManager em = super.getEntityManager();
			Query sql1 = em.createQuery("select code from PcAgency where id = " + id);
			List<String> rs = sql1.getResultList();
			String code = rs.get(0);
			where = where + " AND code like '" + code + "%'";
			where = where + " AND year =" + year;
			where = where + " AND quarter in (" + ids + ")";
			where = where + " AND type_id = " + typeId;
			String sql = createSql(id, where, year, typeId);
//			System.out.print(sql);
			List<PcStatsVo> list = getResult(sql);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}		
	
	public List<PcStatsVo> getZwhStatsById(Integer id, Integer year, Integer typeId,
			Integer startM, Integer endM) {
		try {

			Integer avg = endM - startM + 1;

			String where = " WHERE 1= 1";

			EntityManager em = super.getEntityManager();
			Query sql1 = em.createQuery("select code from PcAgency where id = " + id);
			List<String> rs = sql1.getResultList();
			String code = rs.get(0);
			where = where + " AND code like '" + code + "%'";			
			
			where = where + " AND year =" + year;
			where = where + " AND month >= " + startM + " AND month <=" + endM;
			where = where + " AND type_id = " + typeId;
			String sql = createSql(id, where, year, typeId);
//			System.out.print(sql);
			List<PcStatsVo> list = getResult(sql);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}		
	
	public List<PcStatsVo> getZwhStatsByIdForAdmin(Integer id, Integer year, Integer typeId,
			Integer startM, Integer endM) {
		try {

			Integer avg = endM - startM + 1;

			String where = " WHERE 1= 1";
			where = where + " AND code_id= 10";
			where = where + " AND year =" + year;
			where = where + " AND month >= " + startM + " AND month <=" + endM;
			where = where + " AND type_id = " + typeId;
			String sql = createSql(id, where, year, typeId);
//			System.out.print(sql);
			List<PcStatsVo> list = getResult(sql);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}			
	
	
	
	public String createSql(Integer id, String where, Integer year, Integer typeId) {
		String sql = "SELECT * FROM"
			+ " (SELECT T1.agency_id, T2.name, T2.code_id, T2.code,  0 as parent_id, " 
			+ year +" as year, "
			+ typeId +" as type_id, "
			+ " (CASE WHEN T1.total is NULL THEN 0 ELSE T1.total END) as total, "
			+ " (CASE WHEN T1.total_success is NULL THEN 0 ELSE T1.total_success END) as total_success, "
			+ " (CASE WHEN T1.total_return is NULL THEN 0 ELSE T1.total_return END) as total_return, "
			+ " (CASE WHEN T1.total_delay is NULL THEN 0 ELSE T1.total_delay END) as total_delay, "
			+ " (CASE WHEN T1.reported is NULL THEN 0 ELSE T1.reported END) as reported, "
			+ " (CASE WHEN T1.reported_rate is NULL THEN 0 ELSE T1.reported_rate END) as reported_rate, "
			+ " (CASE WHEN T1.return_rate is NULL THEN 0 ELSE T1.return_rate END) as return_rate, "
			+ " (CASE WHEN T1.delay_rate is NULL THEN 0 ELSE T1.delay_rate END) as delay_rate,   "
			+ " (CASE WHEN T1.attend is NULL THEN 0 ELSE T1.attend END) as attend,   "
			+ " (CASE WHEN T1.asence is NULL THEN 0 ELSE T1.asence END) as asence,   "
			+ " (CASE WHEN T1.attend_rate is NULL THEN 0 ELSE T1.attend_rate END) as attend_rate," 
			+ " (CASE WHEN T1.eva is NULL THEN 0 ELSE T1.eva END) as eva,   "
			+ " (CASE WHEN T1.eva_rate is NULL THEN 0 ELSE T1.eva_rate END) as eva_rate," 
			+ " (CASE WHEN T1.eva_1 is NULL THEN 0 ELSE T1.eva_1 END) as eva_1,"
			+ " (CASE WHEN T1.eva_2 is NULL THEN 0 ELSE T1.eva_2 END) as eva_2,"
			+ " (CASE WHEN T1.eva_3 is NULL THEN 0 ELSE T1.eva_3 END) as eva_3,"
			+ " (CASE WHEN T1.eva_4 is NULL THEN 0 ELSE T1.eva_4 END) as eva_4,"
			+ " (CASE WHEN T1.eva_1_rate is NULL THEN 0 ELSE T1.eva_1_rate END) as eva_1_rate," 
			+ " (CASE WHEN T1.eva_2_rate is NULL THEN 0 ELSE T1.eva_2_rate END) as eva_2_rate, "
			+ " (CASE WHEN T1.eva_3_rate is NULL THEN 0 ELSE T1.eva_3_rate END) as eva_3_rate, "
			+ " (CASE WHEN T1.eva_4_rate is NULL THEN 0 ELSE T1.eva_4_rate END) as eva_4_rate,  " 
			+ " (CASE WHEN T1.agency_goodjob is NULL THEN 0 ELSE T1.agency_goodjob END) as agency_goodjob  " 
			+ " FROM "
			+ " (SELECT "+ id +" as agency_id, YEAR, type_id," 
			+ " SUM(total) as total, "
			+ " SUM(total_success) as total_success," 
			+ " SUM(total_return) as total_return," 
			+ " SUM(total_delay) as total_delay," 
			+ " SUM(  reported ) as reported ," 
			+ " ROUND( COUNT(CASE WHEN reported_rate = 1 THEN agency_id END)/COUNT(*), 4) reported_rate,"
			+ " ROUND( COUNT(CASE WHEN return_rate = 1 THEN agency_id END)/COUNT(*), 4) return_rate,"
			+ " ROUND( COUNT(CASE WHEN delay_rate = 1 THEN agency_id END)/COUNT(*), 4) delay_rate,"
			+ " SUM(  attend ) as attend , "
			+ " SUM(  asence ) as asence , "
			+ " ROUND(SUM(attend_rate)/COUNT(CASE WHEN total > 0 THEN total END), 4) as attend_rate,"
			+ " SUM(eva) as eva,"
			+ " ROUND(SUM(eva)/SUM(total), 4) as eva_rate ," 
			+ " SUM(eva_1) as eva_1,"
			+ " SUM(eva_2) as eva_2,"
			+ " SUM(eva_3) as eva_3,"
			+ " SUM(eva_4) as eva_4,"
			+ " ROUND(SUM(eva_1)/SUM(eva), 4) as eva_1_rate," 
			+ " ROUND(SUM(eva_2)/SUM(eva), 4) as eva_2_rate, "
			+ " ROUND(SUM(eva_3)/SUM(eva), 4) as eva_3_rate, "
			+ " ROUND(SUM(eva_4)/SUM(eva), 4) as eva_4_rate, "
			+ " COUNT(CASE WHEN reported_rate = 1 THEN agency_id END) as agency_goodjob"
			+ " FROM  pc_zzsh_stat " + where
			+ " GROUP BY YEAR, type_id )  as T1"
			+ " LEFT JOIN pc_agency as T2 ON T1.agency_id = T2.id ) as T3";		
		
		
		return sql;
	}
	
	public List<PcStatsVo> getResult(String sql) throws SQLException {
		java.sql.Connection conn = null;
		try {

			 List<PcStatsVo> list = new ArrayList<PcStatsVo>();
			 EntityManager em = super.getEntityManager();
			 em.getTransaction().begin();

			 HibernateEntityManager hem = (HibernateEntityManager)em;
			 conn = hem.getSession().connection();
			 
			 java.sql.Statement statement = conn.createStatement();
			    ResultSet rows = statement.executeQuery(sql);  
			    while (rows.next()) {
//			    	System.out.println(rows.getString("name"));
			    	PcStatsVo pevo = new PcStatsVo();
			    	pevo.setAgencyId(rows.getInt("agency_id"));
			    	pevo.setCode(rows.getString("code"));
			    	pevo.setCodeId(rows.getInt("code_id"));
			    	pevo.setName(rows.getString("name"));
			    	pevo.setYear(rows.getInt("YEAR"));
			    	pevo.setTypeId(rows.getInt("type_id"));
			    	pevo.setTotal(rows.getInt("total"));
			    	pevo.setTotalSuccess(rows.getInt("total_success"));
			    	pevo.setTotalReturn(rows.getInt("total_return"));
			    	pevo.setTotalDelay(rows.getInt("total_delay"));
			    	pevo.setReported(rows.getInt("reported"));
			    	pevo.setReportedRate(rows.getDouble("reported_rate"));
			    	pevo.setReturnRate(rows.getDouble("return_rate"));
			    	pevo.setDelayRate(rows.getDouble("delay_rate"));
			    	pevo.setAttend(rows.getInt("attend"));
			    	pevo.setAsence(rows.getInt("asence"));
			    	pevo.setAttendRate(rows.getDouble("attend_rate"));
			    	pevo.setEva(rows.getInt("eva"));
			    	pevo.setEvaRate(rows.getDouble("eva_rate"));
			    	pevo.setEva1(rows.getInt("eva_1"));
			    	pevo.setEva2(rows.getInt("eva_2"));
			    	pevo.setEva3(rows.getInt("eva_3"));
			    	pevo.setEva4(rows.getInt("eva_4"));
			    	pevo.setEva1Rate(rows.getDouble("eva_1_rate"));
			    	pevo.setEva2Rate(rows.getDouble("eva_2_rate"));
			    	pevo.setEva3Rate(rows.getDouble("eva_3_rate"));
			    	pevo.setEva4Rate(rows.getDouble("eva_4_rate"));
			    	pevo.setAgencyGoodjob(rows.getInt("agency_goodjob"));
			    	
			    	list.add(pevo);
			    }
			    em.getTransaction().commit();
			 statement.close();
			 conn.close();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}		

	public List<PcStatsVo> getStatsByParentId(Integer id, Integer year,
			List<Integer> qs, Integer typeId) {

		try {
			// 跨季度
			String ids = "";
			for (Integer idItem : qs) {
				if (ids.equals("")) {
					ids = idItem + "";
				} else {
					ids += "," + idItem;
				}
			}

			Integer avg = qs.size();

			String where = " WHERE 1= 1";
			where = where + " AND parent_id=" + id;
			where = where + " AND year =" + year;
			where = where + " AND quarter in (" + ids + ")";
			where = where + " AND type_id = " + typeId;

			List<PcStatsVo> list = getResult(where);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PcStatsVo> getStatsByParentCode(Integer id, Integer year,
			List<Integer> qs, Integer typeId) {

		try {
			EntityManager em = super.getEntityManager();
			Query sql1 = em.createQuery("select code from PcAgency where id = "
					+ id);
			List<String> rs = sql1.getResultList();
			String code = rs.get(0);

			// 跨季度
			String ids = "";
			for (Integer idItem : qs) {
				if (ids.equals("")) {
					ids = idItem + "";
				} else {
					ids += "," + idItem;
				}
			}

			Integer avg = qs.size();

			String where = " WHERE 1= 1";
			where = where + " AND code like '" + code + "%'";
			where = where + " AND year =" + year;
			where = where + " AND quarter in (" + ids + ")";
			where = where + " AND type_id = " + typeId;

			List<PcStatsVo> list = getResult(where);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PcStatsVo> getZwhStatsById(Integer id, Integer year,
			Integer startM, Integer endM) {

		try {

			Integer avg = endM - startM + 1;

			String where = " WHERE 1= 1";
			where = where + " AND agency_id=" + id;
			where = where + " AND year =" + year;
			where = where + " AND month >= " + startM + " AND month <=" + endM;
			where = where + " AND type_id = 8";

			List<PcStatsVo> list = getResult(where);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<PcStatsVo> getZwhStatsByParentId(Integer id, Integer year,
			Integer startM, Integer endM) {

		try {

			Integer avg = endM - startM + 1;

			String where = " WHERE 1= 1";
			where = where + " AND parent_id=" + id;
			where = where + " AND year =" + year;
			where = where + " AND month >= " + startM + " AND month <=" + endM;
			where = where + " AND type_id = 8";

			List<PcStatsVo> list = getResult(where);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PcStatsVo> getZwhStatsByParentCode(Integer id, Integer year,
			Integer startM, Integer endM) {

		try {
			EntityManager em = super.getEntityManager();
			Query sql1 = em.createQuery("select code from PcAgency where id = "
					+ id);
			List<String> rs = sql1.getResultList();
			String code = rs.get(0);

			Integer avg = endM - startM + 1;

			String where = " WHERE 1= 1";
			where = where + " AND code like '" + code + "%'";
			where = where + " AND year =" + year;
			where = where + " AND month >= " + startM + " AND month <=" + endM;
			where = where + " AND type_id = 8";

			List<PcStatsVo> list = getResult(where);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	// 年度计划的统计
	public List<PcStatsVo> getYStatsById(Integer id, Integer year, Integer typeId, PcRemindConfig config) {
		try {
			
			Calendar cal = new GregorianCalendar(year, config.getEndMonth() - 1, config.getEndDay(),0,0,0);      
			cal.add(Calendar.YEAR, config.getEndYear());
			cal.add(Calendar.DATE, config.getDelayDay());
			Date date=cal.getTime();  
			SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd 00:00:00");				
			
			
			String where = " WHERE ";
			if (id == 1) {
				where = where + " code_id= 10";
			} else {
				EntityManager em = super.getEntityManager();
				Query sql1 = em.createQuery("select code from PcAgency where id = " + id);
				List<String> rs = sql1.getResultList();
				String code = rs.get(0);
				
				where = where + " code like '" + code + "%'";
			}
			where = where + " AND setup_datetime <= '" +df.format(date)+ "'";
			where = where + " AND year =" + year;
			where = where + " AND type_id = " + typeId;
			String sql = createSql(id, where, year, typeId);
//			System.out.println(sql);
			List<PcStatsVo> list = getResult(sql);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}		
	

	// 季度计划的统计
	public List<PcStatsVo> getQStatsById(Integer id, Integer year, List<Integer> qs, Integer typeId, PcRemindConfig config) {
		try {
			
			EntityManager em = super.getEntityManager();
			Query sql1 = em.createQuery("select code from PcAgency where id = " + id);
			List<String> rs = sql1.getResultList();
			String code = rs.get(0);
			
			
			
			String sql = "SELECT T1.agency_id, T2.name, T2.code_id, T2.code,  0 as parent_id, " 
			+ year +" as year, "
			+ typeId +" as type_id, "
			+ " (CASE WHEN T1.total is NULL THEN 0 ELSE T1.total END) as total, "
			+ " (CASE WHEN T1.total_success is NULL THEN 0 ELSE T1.total_success END) as total_success, "
			+ " (CASE WHEN T1.total_return is NULL THEN 0 ELSE T1.total_return END) as total_return, "
			+ " (CASE WHEN T1.total_delay is NULL THEN 0 ELSE T1.total_delay END) as total_delay, "
			+ " (CASE WHEN T1.reported is NULL THEN 0 ELSE T1.reported END) as reported, "
			+ " (CASE WHEN T1.reported_rate is NULL THEN 0 ELSE T1.reported_rate END) as reported_rate, "
			+ " (CASE WHEN T1.return_rate is NULL THEN 0 ELSE T1.return_rate END) as return_rate, "
			+ " (CASE WHEN T1.delay_rate is NULL THEN 0 ELSE T1.delay_rate END) as delay_rate,   "
			+ " (CASE WHEN T1.attend is NULL THEN 0 ELSE T1.attend END) as attend,   "
			+ " (CASE WHEN T1.asence is NULL THEN 0 ELSE T1.asence END) as asence,   "
			+ " (CASE WHEN T1.attend_rate is NULL THEN 0 ELSE T1.attend_rate END) as attend_rate," 
			+ " (CASE WHEN T1.eva is NULL THEN 0 ELSE T1.eva END) as eva,   "
			+ " (CASE WHEN T1.eva_rate is NULL THEN 0 ELSE T1.eva_rate END) as eva_rate," 
			+ " (CASE WHEN T1.eva_1 is NULL THEN 0 ELSE T1.eva_1 END) as eva_1,"
			+ " (CASE WHEN T1.eva_2 is NULL THEN 0 ELSE T1.eva_2 END) as eva_2,"
			+ " (CASE WHEN T1.eva_3 is NULL THEN 0 ELSE T1.eva_3 END) as eva_3,"
			+ " (CASE WHEN T1.eva_4 is NULL THEN 0 ELSE T1.eva_4 END) as eva_4,"
			+ " (CASE WHEN T1.eva_1_rate is NULL THEN 0 ELSE T1.eva_1_rate END) as eva_1_rate," 
			+ " (CASE WHEN T1.eva_2_rate is NULL THEN 0 ELSE T1.eva_2_rate END) as eva_2_rate, "
			+ " (CASE WHEN T1.eva_3_rate is NULL THEN 0 ELSE T1.eva_3_rate END) as eva_3_rate, "
			+ " (CASE WHEN T1.eva_4_rate is NULL THEN 0 ELSE T1.eva_4_rate END) as eva_4_rate,  " 
			+ " (CASE WHEN T1.agency_goodjob is NULL THEN 0 ELSE T1.agency_goodjob END) as agency_goodjob  " 
			+ " FROM"
			+ " ( "  							// as T1.begin
				+ " SELECT  "+ id +" as agency_id, year, type_id,"
				+ " SUM(total) as total, SUM(total_success) as total_success, SUM(total_return) as total_return," 
				+ " SUM(total_delay) as total_delay, SUM( reported ) as reported , "
				+ " ROUND( SUM(agency_goodjob)/SUM(zb_count), 4) reported_rate, "
				+ " ROUND( SUM(return_count)/SUM(zb_count), 4) return_rate, "
				+ " ROUND( SUM(delay_count)/SUM(zb_count), 4) delay_rate, "
				+ " SUM(  attend ) as attend ,  SUM(  asence ) as asence , " 
				+ " ROUND(SUM(attend_rate)/SUM(attend_count), 4) as attend_rate, " 
				+ " SUM(eva) as eva, ROUND(SUM(eva)/SUM(total), 4) as eva_rate , "
				+ " SUM(eva_1) as eva_1, SUM(eva_2) as eva_2, SUM(eva_3) as eva_3, SUM(eva_4) as eva_4," 
				+ " ROUND(SUM(eva_1)/SUM(eva), 4) as eva_1_rate,"
				+ " ROUND(SUM(eva_2)/SUM(eva), 4) as eva_2_rate,"
				+ " ROUND(SUM(eva_3)/SUM(eva), 4) as eva_3_rate,"
				+ " ROUND(SUM(eva_4)/SUM(eva), 4) as eva_4_rate,"  
				+ " SUM(agency_goodjob) as agency_goodjob" 
				+ " FROM ( ";    // as T begin
			int i = 1;
			for(Integer q : qs) {
				String d = DateUtils.formatDate(new Date()) + " 00:00:00";
				if (typeId > 2) {
					Date date = DateUtils.getLastDateOfSeasonByQuarter(year, q, config.getEndDay());
					d = DateUtils.formatDate(date) + " 00:00:00";
				} else {
					Date date = DateUtils.getFirstDateOfSeasonByQuarter(year, q, config.getEndDay());
					d = DateUtils.formatDate(date) + " 00:00:00";
				}
				
				String where = "  ";
				if (id == 1) {
					where = where + " WHERE code_id= 10";
				} else {
					where = where + " WHERE code like '" + code + "%'";
				}
				where = where + " AND setup_datetime <= '" +d+ "'";
				where = where + " AND year =" + year;
				where = where + " AND quarter =" + q;
				where = where + " AND type_id = " + typeId;
				
				String sql_quarter = " SELECT 	year, type_id," 
					+ " SUM(total) as total,"
					+ " SUM(total_success) as total_success," 
					+ " SUM(total_return) as total_return," 
					+ " SUM(total_delay) as total_delay," 
					+ " SUM(reported ) as reported ,"
					+ " SUM(  attend ) as attend ,  SUM(  asence ) as asence ,"  
					+ " SUM(attend_rate) as attend_rate,"
					+ " SUM(eva) as eva," 
					+ " SUM(eva_1) as eva_1, SUM(eva_2) as eva_2," 
					+ " SUM(eva_3) as eva_3, SUM(eva_4) as eva_4," 
					+ " COUNT(CASE WHEN reported_rate = 1 THEN agency_id END) as agency_goodjob,"
					+ " COUNT(CASE WHEN return_rate = 1 THEN agency_id END) as return_count," 
					+ " COUNT(CASE WHEN delay_rate = 1 THEN agency_id END) as delay_count," 
					+ " COUNT(CASE WHEN total > 0 THEN total END) as attend_count,"
					+ " COUNT(*) as zb_count"
					+ " FROM  pc_zzsh_stat " + where
					+ " GROUP BY YEAR, type_id ";				
				
					if (i == qs.size()) {
						sql = sql + sql_quarter ;
					} else {
						sql = sql + sql_quarter + " UNION ALL ";
					}
					i++;
			}
			
				sql = sql + "  ) as T " ;    // as T end
			sql = sql + " ) as T1 ";	 // as T1 end
			sql = sql + " LEFT JOIN pc_agency as T2 ON T1.agency_id = T2.id";
//			if (typeId == 2) {
//				System.out.println(sql);
//			}
			List<PcStatsVo> list = getResult(sql);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
	
	// 月份统计
	public List<PcStatsVo> getMStatsById(Integer id, Integer year, Integer startM, Integer endM, Integer typeId) {
		try {
			Integer avg = endM - startM + 1;
			
			EntityManager em = super.getEntityManager();
			Query sql1 = em.createQuery("select code from PcAgency where id = " + id);
			List<String> rs = sql1.getResultList();
			String code = rs.get(0);
			
			String sql = "SELECT T1.agency_id, T2.name, T2.code_id, T2.code,  0 as parent_id, " 
			+ year +" as year, "
			+ typeId +" as type_id, "
			+ " (CASE WHEN T1.total is NULL THEN 0 ELSE T1.total END) as total, "
			+ " (CASE WHEN T1.total_success is NULL THEN 0 ELSE T1.total_success END) as total_success, "
			+ " (CASE WHEN T1.total_return is NULL THEN 0 ELSE T1.total_return END) as total_return, "
			+ " (CASE WHEN T1.total_delay is NULL THEN 0 ELSE T1.total_delay END) as total_delay, "
			+ " (CASE WHEN T1.reported is NULL THEN 0 ELSE T1.reported END) as reported, "
			+ " (CASE WHEN T1.reported_rate is NULL THEN 0 ELSE T1.reported_rate END) as reported_rate, "
			+ " (CASE WHEN T1.return_rate is NULL THEN 0 ELSE T1.return_rate END) as return_rate, "
			+ " (CASE WHEN T1.delay_rate is NULL THEN 0 ELSE T1.delay_rate END) as delay_rate,   "
			+ " (CASE WHEN T1.attend is NULL THEN 0 ELSE T1.attend END) as attend,   "
			+ " (CASE WHEN T1.asence is NULL THEN 0 ELSE T1.asence END) as asence,   "
			+ " (CASE WHEN T1.attend_rate is NULL THEN 0 ELSE T1.attend_rate END) as attend_rate," 
			+ " (CASE WHEN T1.eva is NULL THEN 0 ELSE T1.eva END) as eva,   "
			+ " (CASE WHEN T1.eva_rate is NULL THEN 0 ELSE T1.eva_rate END) as eva_rate," 
			+ " (CASE WHEN T1.eva_1 is NULL THEN 0 ELSE T1.eva_1 END) as eva_1,"
			+ " (CASE WHEN T1.eva_2 is NULL THEN 0 ELSE T1.eva_2 END) as eva_2,"
			+ " (CASE WHEN T1.eva_3 is NULL THEN 0 ELSE T1.eva_3 END) as eva_3,"
			+ " (CASE WHEN T1.eva_4 is NULL THEN 0 ELSE T1.eva_4 END) as eva_4,"
			+ " (CASE WHEN T1.eva_1_rate is NULL THEN 0 ELSE T1.eva_1_rate END) as eva_1_rate," 
			+ " (CASE WHEN T1.eva_2_rate is NULL THEN 0 ELSE T1.eva_2_rate END) as eva_2_rate, "
			+ " (CASE WHEN T1.eva_3_rate is NULL THEN 0 ELSE T1.eva_3_rate END) as eva_3_rate, "
			+ " (CASE WHEN T1.eva_4_rate is NULL THEN 0 ELSE T1.eva_4_rate END) as eva_4_rate,  " 
			+ " (CASE WHEN T1.agency_goodjob is NULL THEN 0 ELSE T1.agency_goodjob END) as agency_goodjob  " 
				+ " FROM"
				+ " ( "  							// as T1.begin
					+ " SELECT  "+ id +" as agency_id, year, type_id,"
					+ " SUM(total) as total, SUM(total_success) as total_success, SUM(total_return) as total_return," 
					+ " SUM(total_delay) as total_delay, SUM( reported ) as reported , "
					+ " ROUND( SUM(agency_goodjob)/SUM(zb_count), 4) reported_rate, "
					+ " ROUND( SUM(return_count)/SUM(zb_count), 4) return_rate, "
					+ " ROUND( SUM(delay_count)/SUM(zb_count), 4) delay_rate, "
					+ " SUM(  attend ) as attend ,  SUM(  asence ) as asence , " 
					+ " ROUND(SUM(attend_rate)/SUM(attend_count), 4) as attend_rate, " 
					+ " SUM(eva) as eva, ROUND(SUM(eva)/SUM(total), 4) as eva_rate , "
					+ " SUM(eva_1) as eva_1, SUM(eva_2) as eva_2, SUM(eva_3) as eva_3, SUM(eva_4) as eva_4," 
					+ " ROUND(SUM(eva_1)/SUM(eva), 4) as eva_1_rate,"
					+ " ROUND(SUM(eva_2)/SUM(eva), 4) as eva_2_rate,"
					+ " ROUND(SUM(eva_3)/SUM(eva), 4) as eva_3_rate,"
					+ " ROUND(SUM(eva_4)/SUM(eva), 4) as eva_4_rate,"  
					+ " SUM(agency_goodjob) as agency_goodjob" 
					+ " FROM ( ";    // as T begin
			
			for(int i = startM; i <= endM; i++) {
				String d = DateUtils.formatDate(new Date()) + " 00:00:00";
				
				Date date = DateUtils.getLastDateOfMonthByMonth(year, i);
				d = DateUtils.formatDate(date) + " 00:00:00";
				
				
				String where = "  ";
				if (id == 1) {
					where = where + " WHERE code_id = 10";
				} else {
					where = where + " WHERE code like '" + code + "%'";
				}
				where = where + " AND setup_datetime <= '" +d+ "'";
				where = where + " AND year =" + year;
				where = where + " AND month =" + i;
				where = where + " AND type_id = " + typeId;
				
				String sql_quarter = " SELECT 	year, type_id," 
					+ " SUM(total) as total,"
					+ " SUM(total_success) as total_success," 
					+ " SUM(total_return) as total_return," 
					+ " SUM(total_delay) as total_delay," 
					+ " SUM(reported ) as reported ,"
					+ " SUM(  attend ) as attend ,  SUM(  asence ) as asence ,"  
					+ " SUM(attend_rate) as attend_rate,"
					+ " SUM(eva) as eva," 
					+ " SUM(eva_1) as eva_1, SUM(eva_2) as eva_2," 
					+ " SUM(eva_3) as eva_3, SUM(eva_4) as eva_4," 
					+ " COUNT(CASE WHEN reported_rate = 1 THEN agency_id END) as agency_goodjob,"
					+ " COUNT(CASE WHEN return_rate = 1 THEN agency_id END) as return_count," 
					+ " COUNT(CASE WHEN delay_rate = 1 THEN agency_id END) as delay_count," 
					+ " COUNT(CASE WHEN total > 0 THEN total END) as attend_count,"
					+ " COUNT(*) as zb_count"
					+ " FROM  pc_zzsh_stat " + where
					+ " GROUP BY YEAR, type_id ";				
				
					if (i == endM) {
						sql = sql + sql_quarter ;
					} else {
						sql = sql + sql_quarter + " UNION ALL ";
					}
			}
			
			sql = sql + "  ) as T " ;    // as T end
			sql = sql + " ) as T1 ";	 // as T1 end
			sql = sql + " LEFT JOIN pc_agency as T2 ON T1.agency_id = T2.id";
//			if (typeId == 8) {
//				System.out.println(sql);
//			}
			List<PcStatsVo> list = getResult(sql);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}		
	
	public List<PcMeetingZBStatsVo> getMeetingZBStatsById(Integer id, Integer year,
			List<Integer> qs, Integer endMonth) {

			// 跨季度
			String ids = "";
			for (Integer idItem : qs) {
				if (ids.equals("")) {
					ids = idItem + "";
				} else {
					ids += "," + idItem;
				}
			}

			Integer avg = qs.size();
			String where = " ";
//			EntityManager em = super.getEntityManager();
//			Query sql1 = em.createQuery("select code from PcAgency where id = " + id);
//			List<String> rs = sql1.getResultList();
//			String code = rs.get(0);
			
			if (endMonth.equals(12)) {
				endMonth = 1;
				year = year + 1;
			} else {
				endMonth = endMonth + 1;
			}
			
			String setup_datetime = year.toString() + "-" + endMonth + "01 00:00:00";
			where = where + " WHERE code_id = 10";
			where = where + " AND setup_datetime < '" + setup_datetime +"'";
			where = where + " AND year =" + year;
			where = where + " AND quarter in (" + ids + ")";


			String sql = "SELECT '某省公安厅' as p_name,T2.dw_name , T2.ej_or_dzz_name, T2.name, T2.setup_datetime,"
				+" T1.zwh_attend_rate," 
				+" T1.zwh_reported_rate,"  
				+" T1.zwh_total, " 
				+" T1.zwh_total_return,"  
				+" T1.zwh_total_delay, " 
				+" T1.zwh_eva_rate, " 
				+" T1.zwh_eva_1_rate," 	
				+" T1.zwh_eva_2_rate," 
				+" T1.zwh_eva_3_rate," 
				+" T1.zwh_eva_4_rate," 
				+" T1.dydh_attend_rate," 
				+" T1.dydh_reported_rate," 
				+" T1.dydh_total," 
				+" T1.dydh_total_return," 
				+" T1.dydh_total_delay," 
				+" T1.dydh_eva_rate," 
				+" T1.dydh_eva_1_rate," 
				+" T1.dydh_eva_2_rate," 
				+" T1.dydh_eva_3_rate," 
				+" T1.dydh_eva_4_rate," 
			
				+" T1.mzshh_attend_rate," 
				+" T1.mzshh_reported_rate," 
				+" T1.mzshh_total," 
				+" T1.mzshh_total_return," 
				+" T1.mzshh_total_delay," 
				+" T1.mzshh_eva_rate," 
				+" T1.mzshh_eva_1_rate," 
				+" T1.mzshh_eva_2_rate," 
				+" T1.mzshh_eva_3_rate," 
				+" T1.mzshh_eva_4_rate," 
			 
				+" T1.dk_attend_rate," 
				+" T1.dk_reported_rate," 
				+" T1.dk_total," 
				+" T1.dk_total_return," 
				+" T1.dk_total_delay," 
				+" T1.dk_eva_rate," 
				+" T1.dk_eva_1_rate," 
				+" T1.dk_eva_2_rate," 
				+" T1.dk_eva_3_rate," 
				+" T1.dk_eva_4_rate," 
				
				+" T1.qt_attend_rate," 
				+" T1.qt_total," 
				+" T1.qt_total_return," 
				+" T1.qt_total_delay," 
				+" T1.qt_eva_rate," 
				+" T1.qt_eva_1_rate," 
				+" T1.qt_eva_2_rate," 
				+" T1.qt_eva_3_rate," 
				+" T1.qt_eva_4_rate " 
				+" FROM" 
				+" 	(SELECT agency_id," 
				+" 	  ROUND(SUM( CASE WHEN type_id = 8 THEN attend_rate END)/COUNT(CASE WHEN type_id = 8 AND total > 0 THEN total END), 4) as zwh_attend_rate,"  
				+" 	  ROUND( COUNT(CASE WHEN type_id = 8 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 8 THEN agency_id END ), 4) zwh_reported_rate," 
				+" 	  SUM(CASE WHEN type_id = 8 THEN total END ) as zwh_total,  " 
				+"    SUM(CASE WHEN type_id = 8 THEN total_return END) as zwh_total_return,"  
				+"    SUM(CASE WHEN type_id = 8 THEN total_delay END) as zwh_total_delay, " 
				+" 	  ROUND(SUM(CASE WHEN type_id = 8 THEN eva END )/SUM( CASE WHEN type_id = 8 THEN total END ), 4) as zwh_eva_rate ,"  
				+"    ROUND(SUM(CASE WHEN type_id = 8 THEN eva_1 END )/SUM(CASE WHEN type_id = 8 THEN eva END ), 4) as zwh_eva_1_rate, " 
				+"    ROUND(SUM(CASE WHEN type_id = 8 THEN eva_2 END )/SUM(CASE WHEN type_id = 8 THEN eva END ), 4) as zwh_eva_2_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 8 THEN eva_3 END )/SUM(CASE WHEN type_id = 8 THEN eva END ), 4) as zwh_eva_3_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 8 THEN eva_4 END )/SUM(CASE WHEN type_id = 8 THEN eva END ), 4) as zwh_eva_4_rate,  " 
				
				+"    ROUND(SUM( CASE WHEN type_id = 5 THEN attend_rate END)/COUNT(CASE WHEN type_id = 5 AND total > 0 THEN total END), 4) as dk_attend_rate,"  
				+"    ROUND( COUNT(CASE WHEN type_id = 5 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 5 THEN agency_id END ), 4) dk_reported_rate," 
				+"    SUM(CASE WHEN type_id = 5 THEN total END ) as dk_total,  " 
				+"    SUM(CASE WHEN type_id = 5 THEN total_return END) as dk_total_return,"  
				+"    SUM(CASE WHEN type_id = 5 THEN total_delay END) as dk_total_delay, " 
				+"    ROUND(SUM(CASE WHEN type_id = 5 THEN eva END )/SUM( CASE WHEN type_id = 5 THEN total END ), 4) as dk_eva_rate ,"  
				+"    ROUND(SUM(CASE WHEN type_id = 5 THEN eva_1 END )/SUM(CASE WHEN type_id = 5 THEN eva END ), 4) as dk_eva_1_rate, " 
				+"    ROUND(SUM(CASE WHEN type_id = 5 THEN eva_2 END )/SUM(CASE WHEN type_id = 5 THEN eva END ), 4) as dk_eva_2_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 5 THEN eva_3 END )/SUM(CASE WHEN type_id = 5 THEN eva END ), 4) as dk_eva_3_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 5 THEN eva_4 END )/SUM(CASE WHEN type_id = 5 THEN eva END ), 4) as dk_eva_4_rate,  	" 
				
				+"    ROUND(SUM( CASE WHEN type_id = 6 THEN attend_rate END)/COUNT(CASE WHEN type_id = 6 AND total > 0 THEN total END), 4) as dydh_attend_rate,"  
				+"    ROUND( COUNT(CASE WHEN type_id = 6 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 6 THEN agency_id END ), 4) dydh_reported_rate," 
				+"    SUM(CASE WHEN type_id = 6 THEN total END ) as dydh_total,  " 
				+"    SUM(CASE WHEN type_id = 6 THEN total_return END) as dydh_total_return,"  
				+"    SUM(CASE WHEN type_id = 6 THEN total_delay END) as dydh_total_delay, " 
				+"    ROUND(SUM(CASE WHEN type_id = 6 THEN eva END )/SUM( CASE WHEN type_id = 6 THEN total END ), 4) as dydh_eva_rate ,"  
				+"    ROUND(SUM(CASE WHEN type_id = 6 THEN eva_1 END )/SUM(CASE WHEN type_id = 6 THEN eva END ), 4) as dydh_eva_1_rate, " 
				+"    ROUND(SUM(CASE WHEN type_id = 6 THEN eva_2 END )/SUM(CASE WHEN type_id = 6 THEN eva END ), 4) as dydh_eva_2_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 6 THEN eva_3 END )/SUM(CASE WHEN type_id = 6 THEN eva END ), 4) as dydh_eva_3_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 6 THEN eva_4 END )/SUM(CASE WHEN type_id = 6 THEN eva END ), 4) as dydh_eva_4_rate,  " 
				
				+" 	  ROUND(SUM( CASE WHEN type_id = 7 THEN attend_rate END)/COUNT(CASE WHEN type_id = 7 AND total > 0 THEN total END), 4) as mzshh_attend_rate,"  
				+"    ROUND( COUNT(CASE WHEN type_id = 7 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 7 THEN agency_id END ), 4) mzshh_reported_rate," 
				+"    SUM(CASE WHEN type_id = 7 THEN total END ) as mzshh_total,  " 
				+"    SUM(CASE WHEN type_id = 7 THEN total_return END) as mzshh_total_return,"  
				+"    SUM(CASE WHEN type_id = 7 THEN total_delay END) as mzshh_total_delay, " 
				+"    ROUND(SUM(CASE WHEN type_id = 7 THEN eva END )/SUM( CASE WHEN type_id = 7 THEN total END ), 4) as mzshh_eva_rate ,"  
				+"    ROUND(SUM(CASE WHEN type_id = 7 THEN eva_1 END )/SUM(CASE WHEN type_id = 7 THEN eva END ), 4) as mzshh_eva_1_rate, " 
				+"    ROUND(SUM(CASE WHEN type_id = 7 THEN eva_2 END )/SUM(CASE WHEN type_id = 7 THEN eva END ), 4) as mzshh_eva_2_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 7 THEN eva_3 END )/SUM(CASE WHEN type_id = 7 THEN eva END ), 4) as mzshh_eva_3_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 7 THEN eva_4 END )/SUM(CASE WHEN type_id = 7 THEN eva END ), 4) as mzshh_eva_4_rate,  " 
				
				+" 	  ROUND(SUM( CASE WHEN type_id = 9 THEN attend_rate END)/COUNT(CASE WHEN type_id = 9 AND total > 0 THEN total END), 4) as qt_attend_rate,"  
				+"    ROUND( COUNT(CASE WHEN type_id = 9 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 9 THEN agency_id END ), 4) qt_reported_rate," 
				+"    SUM(CASE WHEN type_id = 9 THEN total END ) as qt_total,  " 
				+"    SUM(CASE WHEN type_id = 9 THEN total_return END) as qt_total_return, " 
				+"    SUM(CASE WHEN type_id = 9 THEN total_delay END) as qt_total_delay, " 
				+"    ROUND(SUM(CASE WHEN type_id = 9 THEN eva END )/SUM( CASE WHEN type_id = 9 THEN total END ), 4) as qt_eva_rate ,"  
				+"    ROUND(SUM(CASE WHEN type_id = 9 THEN eva_1 END )/SUM(CASE WHEN type_id = 9 THEN eva END ), 4) as qt_eva_1_rate, " 
				+"    ROUND(SUM(CASE WHEN type_id = 9 THEN eva_2 END )/SUM(CASE WHEN type_id = 9 THEN eva END ), 4) as qt_eva_2_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 9 THEN eva_3 END )/SUM(CASE WHEN type_id = 9 THEN eva END ), 4) as qt_eva_3_rate,  " 
				+"    ROUND(SUM(CASE WHEN type_id = 9 THEN eva_4 END )/SUM(CASE WHEN type_id = 9 THEN eva END ), 4) as qt_eva_4_rate	" 					
				
				+"   FROM pc_zzsh_stat"
				+ 	 where
				+"   GROUP BY agency_id) as T1" 
				 +"   LEFT JOIN"
				 +" 	("
				 +"			select id, name, setup_datetime,"
				 +"			(CASE WHEN p_1_code_id = 8 OR p_1_code_id = 15 THEN p_1_name ELSE '' END) as ej_or_dzz_name,"
				 +"			(CASE WHEN p_1_code_id = 7 THEN p_1_name ELSE p_2_name END) as dw_name"
				 +"			FROM"
				 +"				(select" 
				 +"					c.id, c.name,  c.setup_datetime,"
				 +"					c1.name as p_1_name, c1.code_id as p_1_code_id,"
				 +"					c2.name as p_2_name, c2.code_id as p_2_code_id"
				 +"				from pc_agency c"
				 +"				left join pc_agency c1 on c.parent_id = c1.id"
				 +"				left join pc_agency c2 on c1.parent_id = c2.id"
				 +" 			where c.code_id = 10 and c.parent_id > 0) as a"	 
				 +" ) as T2 ON T1.agency_id = T2.id"
				 +"  order by agency_id ";
			
//				System.out.print(sql);

			
			
			java.sql.Connection conn = null;
			try {

				List<PcMeetingZBStatsVo> list = new ArrayList<PcMeetingZBStatsVo>();
				 EntityManager em = super.getEntityManager();
				 em.getTransaction().begin();

				 HibernateEntityManager hem = (HibernateEntityManager)em;
				 conn = hem.getSession().connection();
				 
				 java.sql.Statement statement = conn.createStatement();
				    ResultSet rows = statement.executeQuery(sql);  
				    while (rows.next()) {
//				    	System.out.println(rows.getString("name"));
				    	PcMeetingZBStatsVo pevo = new PcMeetingZBStatsVo();
				    	pevo.setP_name(rows.getString("p_name"));
				    	pevo.setDw_name(rows.getString("dw_name"));
				    	pevo.setEj_or_dzz_name(rows.getString("ej_or_dzz_name"));
				    	pevo.setName(rows.getString("name"));
				    	pevo.setSetup_datetime(rows.getString("setup_datetime"));
				    	
				    	pevo.setZwh_attend_rate(rows.getDouble("zwh_attend_rate"));
				    	pevo.setZwh_reported_rate(rows.getDouble("zwh_reported_rate"));
				    	pevo.setZwh_total(rows.getInt("zwh_total"));
				    	pevo.setZwh_total_return(rows.getInt("zwh_total_return"));
				    	pevo.setZwh_total_delay(rows.getInt("zwh_total_delay"));
				    	pevo.setZwh_eva_rate(rows.getDouble("zwh_eva_rate"));
				    	pevo.setZwh_eva_1_rate(rows.getDouble("zwh_eva_1_rate"));
				    	pevo.setZwh_eva_2_rate(rows.getDouble("zwh_eva_2_rate"));
				    	pevo.setZwh_eva_3_rate(rows.getDouble("zwh_eva_3_rate"));
				    	pevo.setZwh_eva_4_rate(rows.getDouble("zwh_eva_4_rate"));
				    	
				    	pevo.setDydh_attend_rate(rows.getDouble("dydh_attend_rate"));
				    	pevo.setDydh_reported_rate(rows.getDouble("dydh_reported_rate"));
				    	pevo.setDydh_total(rows.getInt("dydh_total"));
				    	pevo.setDydh_total_return(rows.getInt("dydh_total_return"));
				    	pevo.setDydh_total_delay(rows.getInt("dydh_total_delay"));
				    	pevo.setDydh_eva_rate(rows.getDouble("dydh_eva_rate"));
				    	pevo.setDydh_eva_1_rate(rows.getDouble("dydh_eva_1_rate"));
				    	pevo.setDydh_eva_2_rate(rows.getDouble("dydh_eva_2_rate"));
				    	pevo.setDydh_eva_3_rate(rows.getDouble("dydh_eva_3_rate"));
				    	pevo.setDydh_eva_4_rate(rows.getDouble("dydh_eva_4_rate"));	
				    	
				    	pevo.setMzshh_attend_rate(rows.getDouble("mzshh_attend_rate"));
				    	pevo.setMzshh_reported_rate(rows.getDouble("mzshh_reported_rate"));
				    	pevo.setMzshh_total(rows.getInt("mzshh_total"));
				    	pevo.setMzshh_total_return(rows.getInt("mzshh_total_return"));
				    	pevo.setMzshh_total_delay(rows.getInt("mzshh_total_delay"));
				    	pevo.setMzshh_eva_rate(rows.getDouble("mzshh_eva_rate"));
				    	pevo.setMzshh_eva_1_rate(rows.getDouble("mzshh_eva_1_rate"));
				    	pevo.setMzshh_eva_2_rate(rows.getDouble("mzshh_eva_2_rate"));
				    	pevo.setMzshh_eva_3_rate(rows.getDouble("mzshh_eva_3_rate"));
				    	pevo.setMzshh_eva_4_rate(rows.getDouble("mzshh_eva_4_rate"));					    	

				    	pevo.setDk_attend_rate(rows.getDouble("dk_attend_rate"));
				    	pevo.setDk_reported_rate(rows.getDouble("dk_reported_rate"));
				    	pevo.setDk_total(rows.getInt("dk_total"));
				    	pevo.setDk_total_return(rows.getInt("dk_total_return"));
				    	pevo.setDk_total_delay(rows.getInt("dk_total_delay"));
				    	pevo.setDk_eva_rate(rows.getDouble("dk_eva_rate"));
				    	pevo.setDk_eva_1_rate(rows.getDouble("dk_eva_1_rate"));
				    	pevo.setDk_eva_2_rate(rows.getDouble("dk_eva_2_rate"));
				    	pevo.setDk_eva_3_rate(rows.getDouble("dk_eva_3_rate"));
				    	pevo.setDk_eva_4_rate(rows.getDouble("dk_eva_4_rate"));
				    	
				    	pevo.setQt_attend_rate(rows.getDouble("qt_attend_rate"));
				    	pevo.setQt_total(rows.getInt("qt_total"));
				    	pevo.setQt_total_return(rows.getInt("qt_total_return"));
				    	pevo.setQt_total_delay(rows.getInt("qt_total_delay"));
				    	pevo.setQt_eva_rate(rows.getDouble("qt_eva_rate"));
				    	pevo.setQt_eva_1_rate(rows.getDouble("qt_eva_1_rate"));
				    	pevo.setQt_eva_2_rate(rows.getDouble("qt_eva_2_rate"));
				    	pevo.setQt_eva_3_rate(rows.getDouble("qt_eva_3_rate"));
				    	pevo.setQt_eva_4_rate(rows.getDouble("qt_eva_4_rate"));				    	
				    	
				    	
				    	list.add(pevo);
				    }
				    
				    em.getTransaction().commit();
				 statement.close();
				 conn.close();
				return list;
			} catch (Exception e) {
				e.printStackTrace();
			}			
		return null;
	}			
	
	
	public List<PcWorkPlanZBStatsVo> getWorkPlanZBStatsById(Integer id, Integer year,
			List<Integer> qs, Integer endMonth) {

			// 跨季度
			String ids = "";
			for (Integer idItem : qs) {
				if (ids.equals("")) {
					ids = idItem + "";
				} else {
					ids += "," + idItem;
				}
			}

			Integer avg = qs.size();
			String where = " ";
			
			if (endMonth.equals(12)) {
				endMonth = 1;
				year = year + 1;
			} else {
				endMonth = endMonth + 1;
			}
			
			String setup_datetime = year.toString() + "-" + endMonth + "01 00:00:00";
			where = where + " WHERE code_id = 10";
			where = where + " AND setup_datetime < '" + setup_datetime +"'";
			where = where + " AND year =" + year;
			where = where + " AND quarter in (" + ids + ")";

			String sql = "SELECT '某省公安厅' as p_name,T2.dw_name , T2.ej_or_dzz_name, T2.name, T2.setup_datetime,"
			 +" T1.yp_reported_rate,"
			 +" T1.yp_agency_goodjob," 
			 +" T1.yp_return_rate," 		
			 +" T1.yp_delay_rate," 		
			 +" T1.yp_eva_rate," 			
			 +" T1.yp_eva_1_rate," 		
			 +" T1.yp_eva_2_rate," 		
			 +" T1.yp_eva_3_rate," 		
			 +" T1.yp_eva_4_rate," 		
			 
			 +" T1.qp_reported_rate," 	
			 +" T1.qp_agency_goodjob," 
			 +" T1.qp_return_rate," 		
			 +" T1.qp_delay_rate," 		
			 +" T1.qp_eva_rate," 			
			 +" T1.qp_eva_1_rate," 		
			 +" T1.qp_eva_2_rate," 		
			 +" T1.qp_eva_3_rate," 		
			 +" T1.qp_eva_4_rate," 		
			 
			 +" T1.qs_reported_rate," 	
			 +" T1.qs_agency_goodjob," 
			 +" T1.qs_return_rate," 		
			 +" T1.qs_delay_rate,"
			 +" T1.qs_eva_rate," 			
			 +" T1.qs_eva_1_rate," 		
			 +" T1.qs_eva_2_rate," 		
			 +" T1.qs_eva_3_rate," 		
			 +" T1.qs_eva_4_rate," 					 		 

			 +" T1.ys_reported_rate," 	
			 +" T1.ys_agency_goodjob," 
			 +" T1.ys_return_rate," 		
			 +" T1.ys_delay_rate," 		
			 +" T1.ys_eva_rate,"			
			 +" T1.ys_eva_1_rate," 		
			 +" T1.ys_eva_2_rate," 		
			 +" T1.ys_eva_3_rate," 		
			 +" T1.ys_eva_4_rate" 		

			 +" FROM"		 
			 +"  (SELECT agency_id,"
			 +"	  ROUND( COUNT(CASE WHEN type_id = 1 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 1 THEN agency_id END ), 4) yp_reported_rate,"
			 +"   COUNT(CASE WHEN type_id = 1 AND reported_rate = 1 THEN agency_id END) as yp_agency_goodjob,"
			 +"	  ROUND( COUNT(CASE WHEN type_id = 1 AND return_rate = 1 THEN agency_id END)/COUNT( CASE WHEN type_id = 1 THEN agency_id END ), 4) as yp_return_rate," 
			 +"	  ROUND( COUNT(CASE WHEN type_id = 1 AND delay_rate = 1 THEN agency_id END)/COUNT( CASE WHEN type_id = 1 THEN agency_id END ), 4) as yp_delay_rate,"
			 +"	  ROUND(SUM(CASE WHEN type_id = 1 THEN eva END )/SUM( CASE WHEN type_id = 1 THEN total END ), 4) as yp_eva_rate , "
			 +"   ROUND(SUM(CASE WHEN type_id = 1 THEN eva_1 END )/SUM(CASE WHEN type_id = 1 THEN eva END ), 4) as yp_eva_1_rate, "
			 +"   ROUND(SUM(CASE WHEN type_id = 1 THEN eva_2 END )/SUM(CASE WHEN type_id = 1 THEN eva END ), 4) as yp_eva_2_rate, "
			 +"   ROUND(SUM(CASE WHEN type_id = 1 THEN eva_3 END )/SUM(CASE WHEN type_id = 1 THEN eva END ), 4) as yp_eva_3_rate, " 
			 +"   ROUND(SUM(CASE WHEN type_id = 1 THEN eva_4 END )/SUM(CASE WHEN type_id = 1 THEN eva END ), 4) as yp_eva_4_rate, " 			
			 +"	  ROUND( COUNT(CASE WHEN type_id = 2 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 2 THEN agency_id END ), 4) qp_reported_rate,"
			 +"   COUNT(CASE WHEN type_id = 2 AND reported_rate = 1 THEN agency_id END) as qp_agency_goodjob,"
			 +"	  ROUND( COUNT(CASE WHEN type_id = 2 AND return_rate = 1 THEN agency_id END)/COUNT( CASE WHEN type_id = 2 THEN agency_id END ), 4) as qp_return_rate," 
			 +"   ROUND( COUNT(CASE WHEN type_id = 2 AND delay_rate = 1 THEN agency_id END)/COUNT( CASE WHEN type_id = 2 THEN agency_id END ), 4) as qp_delay_rate,"
			 +"   ROUND(SUM(CASE WHEN type_id = 2 THEN eva END )/SUM( CASE WHEN type_id = 2 THEN total END ), 4) as qp_eva_rate , "
			 +"   ROUND(SUM(CASE WHEN type_id = 2 THEN eva_1 END )/SUM(CASE WHEN type_id = 2 THEN eva END ), 4) as qp_eva_1_rate, "
			 +"   ROUND(SUM(CASE WHEN type_id = 2 THEN eva_2 END )/SUM(CASE WHEN type_id = 2 THEN eva END ), 4) as qp_eva_2_rate, " 
			 +"   ROUND(SUM(CASE WHEN type_id = 2 THEN eva_3 END )/SUM(CASE WHEN type_id = 2 THEN eva END ), 4) as qp_eva_3_rate, " 
			 +"   ROUND(SUM(CASE WHEN type_id = 2 THEN eva_4 END )/SUM(CASE WHEN type_id = 2 THEN eva END ), 4) as qp_eva_4_rate, " 			
			 +"	  ROUND( COUNT(CASE WHEN type_id = 3 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 3 THEN agency_id END ), 4) qs_reported_rate,"
			 +"	  COUNT(CASE WHEN type_id = 3 AND reported_rate = 1 THEN agency_id END) as qs_agency_goodjob,"
			 +"   ROUND( COUNT(CASE WHEN type_id = 3 AND return_rate = 1 THEN agency_id END)/COUNT( CASE WHEN type_id = 3 THEN agency_id END ), 4) as qs_return_rate," 
			 +"   ROUND( COUNT(CASE WHEN type_id = 3 AND delay_rate = 1 THEN agency_id END)/COUNT( CASE WHEN type_id = 3 THEN agency_id END ), 4) as qs_delay_rate,"
			 +"   ROUND(SUM(CASE WHEN type_id = 3 THEN eva END )/SUM( CASE WHEN type_id = 3 THEN total END ), 4) as qs_eva_rate ," 
			 +"   ROUND(SUM(CASE WHEN type_id = 3 THEN eva_1 END )/SUM(CASE WHEN type_id = 3 THEN eva END ), 4) as qs_eva_1_rate," 
			 +"   ROUND(SUM(CASE WHEN type_id = 3 THEN eva_2 END )/SUM(CASE WHEN type_id = 3 THEN eva END ), 4) as qs_eva_2_rate,"  
			 +"   ROUND(SUM(CASE WHEN type_id = 3 THEN eva_3 END )/SUM(CASE WHEN type_id = 3 THEN eva END ), 4) as qs_eva_3_rate,"  
			 +"   ROUND(SUM(CASE WHEN type_id = 3 THEN eva_4 END )/SUM(CASE WHEN type_id = 3 THEN eva END ), 4) as qs_eva_4_rate," 			
			 +"	  ROUND( COUNT(CASE WHEN type_id = 4 AND reported_rate = 1  THEN agency_id END)/COUNT( CASE WHEN type_id = 4 THEN agency_id END ), 4) ys_reported_rate,"
			 +"   COUNT(CASE WHEN type_id = 4 AND reported_rate = 1 THEN agency_id END) as ys_agency_goodjob,"
			 +"   ROUND( COUNT(CASE WHEN type_id = 4 AND return_rate = 1 THEN agency_id END)/COUNT( CASE WHEN type_id = 4 THEN agency_id END ), 4) as ys_return_rate," 
			 +"   ROUND( COUNT(CASE WHEN type_id = 4 AND delay_rate = 1 THEN agency_id END)/COUNT( CASE WHEN type_id = 4 THEN agency_id END ), 4) as ys_delay_rate,"
			 +"   ROUND(SUM(CASE WHEN type_id = 4 THEN eva END )/SUM( CASE WHEN type_id = 4 THEN total END ), 4) as ys_eva_rate ," 
			 +"   ROUND(SUM(CASE WHEN type_id = 4 THEN eva_1 END )/SUM(CASE WHEN type_id = 4 THEN eva END ), 4) as ys_eva_1_rate," 
			 +"   ROUND(SUM(CASE WHEN type_id = 4 THEN eva_2 END )/SUM(CASE WHEN type_id = 4 THEN eva END ), 4) as ys_eva_2_rate,"  
			 +"   ROUND(SUM(CASE WHEN type_id = 4 THEN eva_3 END )/SUM(CASE WHEN type_id = 4 THEN eva END ), 4) as ys_eva_3_rate,"  
			 +"   ROUND(SUM(CASE WHEN type_id = 4 THEN eva_4 END )/SUM(CASE WHEN type_id = 4 THEN eva END ), 4) as ys_eva_4_rate"	
			 +"   FROM pc_zzsh_stat"
			 +    where
			 +" 	GROUP BY agency_id) as T1"
	 
			 +"   LEFT JOIN"
			 +" 	("
			 +"			select id, name, setup_datetime,"
			 +"			(CASE WHEN p_1_code_id = 8 OR p_1_code_id = 15 THEN p_1_name ELSE '' END) as ej_or_dzz_name,"
			 +"			(CASE WHEN p_1_code_id = 7 THEN p_1_name ELSE p_2_name END) as dw_name"
			 +"			FROM"
			 +"				(select" 
			 +"					c.id, c.name,  c.setup_datetime,"
			 +"					c1.name as p_1_name, c1.code_id as p_1_code_id,"
			 +"					c2.name as p_2_name, c2.code_id as p_2_code_id"
			 +"				from pc_agency c"
			 +"				left join pc_agency c1 on c.parent_id = c1.id"
			 +"				left join pc_agency c2 on c1.parent_id = c2.id"
			 +" 			where c.code_id = 10 and c.parent_id > 0) as a"	 
			 +" ) as T2 ON T1.agency_id = T2.id"
			 +"  order by agency_id ";
			
//				System.out.print(sql);

			
			
			java.sql.Connection conn = null;
			try {

				List<PcWorkPlanZBStatsVo> list = new ArrayList<PcWorkPlanZBStatsVo>();
				 EntityManager em = super.getEntityManager();
				 em.getTransaction().begin();

				 HibernateEntityManager hem = (HibernateEntityManager)em;
				 conn = hem.getSession().connection();
				 
				 java.sql.Statement statement = conn.createStatement();
				    ResultSet rows = statement.executeQuery(sql);  
				    while (rows.next()) {
//				    	System.out.println(rows.getString("name"));
				    	PcWorkPlanZBStatsVo pevo = new PcWorkPlanZBStatsVo();
				    	pevo.setP_name(rows.getString("p_name"));
				    	pevo.setDw_name(rows.getString("dw_name"));
				    	pevo.setEj_or_dzz_name(rows.getString("ej_or_dzz_name"));
				    	pevo.setName(rows.getString("name"));
				    	pevo.setSetup_datetime(rows.getString("setup_datetime"));
				    	
				    	//年度计划
				    	pevo.setYp_reported_rate(rows.getDouble("yp_reported_rate"));
				    	pevo.setYp_agency_goodjob(rows.getInt("yp_agency_goodjob"));
				    	pevo.setYp_return_rate(rows.getDouble("yp_return_rate"));
				    	pevo.setYp_delay_rate(rows.getDouble("yp_delay_rate"));
				    	pevo.setYp_eva_rate(rows.getDouble("yp_eva_rate"));
				    	pevo.setYp_eva_1_rate(rows.getDouble("yp_eva_1_rate"));
				    	pevo.setYp_eva_2_rate(rows.getDouble("yp_eva_2_rate"));
				    	pevo.setYp_eva_3_rate(rows.getDouble("yp_eva_3_rate"));
				    	pevo.setYp_eva_4_rate(rows.getDouble("yp_eva_4_rate"));
				    	//季度计划
				    	pevo.setQp_reported_rate(rows.getDouble("qp_reported_rate"));
				    	pevo.setQp_agency_goodjob(rows.getInt("qp_agency_goodjob"));
				    	pevo.setQp_return_rate(rows.getDouble("qp_return_rate"));
				    	pevo.setQp_delay_rate(rows.getDouble("qp_delay_rate"));
				    	pevo.setQp_eva_rate(rows.getDouble("qp_eva_rate"));
				    	pevo.setQp_eva_1_rate(rows.getDouble("qp_eva_1_rate"));
				    	pevo.setQp_eva_2_rate(rows.getDouble("qp_eva_2_rate"));
				    	pevo.setQp_eva_3_rate(rows.getDouble("qp_eva_3_rate"));
				    	pevo.setQp_eva_4_rate(rows.getDouble("qp_eva_4_rate"));
				    	//季度执行情况
				    	pevo.setQs_reported_rate(rows.getDouble("qs_reported_rate"));
				    	pevo.setQs_agency_goodjob(rows.getInt("qs_agency_goodjob"));
				    	pevo.setQs_return_rate(rows.getDouble("qs_return_rate"));
				    	pevo.setQs_delay_rate(rows.getDouble("qs_delay_rate"));
				    	pevo.setQs_eva_rate(rows.getDouble("qs_eva_rate"));
				    	pevo.setQs_eva_1_rate(rows.getDouble("qs_eva_1_rate"));
				    	pevo.setQs_eva_2_rate(rows.getDouble("qs_eva_2_rate"));
				    	pevo.setQs_eva_3_rate(rows.getDouble("qs_eva_3_rate"));
				    	pevo.setQs_eva_4_rate(rows.getDouble("qs_eva_4_rate"));	    	
				    	//年终总结
				    	pevo.setYs_reported_rate(rows.getDouble("ys_reported_rate"));
				    	pevo.setYs_agency_goodjob(rows.getInt("ys_agency_goodjob"));
				    	pevo.setYs_return_rate(rows.getDouble("ys_return_rate"));
				    	pevo.setYs_delay_rate(rows.getDouble("ys_delay_rate"));
				    	pevo.setYs_eva_rate(rows.getDouble("ys_eva_rate"));
				    	pevo.setYs_eva_1_rate(rows.getDouble("ys_eva_1_rate"));
				    	pevo.setYs_eva_2_rate(rows.getDouble("ys_eva_2_rate"));
				    	pevo.setYs_eva_3_rate(rows.getDouble("ys_eva_3_rate"));
				    	pevo.setYs_eva_4_rate(rows.getDouble("ys_eva_4_rate"));				    	
				    	
				    	list.add(pevo);
				    }
				    
				    em.getTransaction().commit();
				 statement.close();
				 conn.close();
				return list;
			} catch (Exception e) {
				e.printStackTrace();
			}			
		return null;
	}				
	

}
