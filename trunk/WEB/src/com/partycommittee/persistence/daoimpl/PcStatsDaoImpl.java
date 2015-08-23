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
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcRemind;
import com.partycommittee.persistence.po.PcRemindConfig;
import com.partycommittee.persistence.po.PcStats;
import com.partycommittee.remote.vo.FilterVo;
import com.partycommittee.remote.vo.PcMeetingZBStatsVo;
import com.partycommittee.remote.vo.PcStatsVo;
import com.partycommittee.remote.vo.PcWorkPlanZBStatsVo;

@Repository("PcStatsDaoImpl")
public class PcStatsDaoImpl extends JpaDaoBase implements PcStatsDao {

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
			+ " (SELECT "+ id +" as agency_id, "+ year +" as year, "+ typeId +" as type_id," 
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
//			 System.out.println(sql);
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
			where = where + " AND setup_datetime <= UNIX_TIMESTAMP('" +df.format(date)+ "')";
			where = where + " AND invalid_datetime = 0";
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
			List<PcStatsVo> list = new ArrayList<PcStatsVo>();
			
			if (qs.size() == 0) {
				return list;
			}
			
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
				+ " SELECT  "+ id +" as agency_id, "+ year +" as year, "+ typeId +" as type_id,"
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
				where = where + " AND setup_datetime <= UNIX_TIMESTAMP('" +d+ "')";
				where = where + " AND invalid_datetime = 0";
				where = where + " AND year =" + year;
				where = where + " AND quarter =" + q;
				where = where + " AND type_id = " + typeId;
				
				String sql_quarter = " SELECT 	"+ year +" as year, "+ typeId +" as type_id," 
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
//					System.out.println(" i = " + i + "  qsize = " + qs.size());
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
			list = getResult(sql);
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
					+ " SELECT  "+ id +" as agency_id, "+ year +" as year, "+ typeId +" as type_id,"
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
				where = where + " AND setup_datetime <= UNIX_TIMESTAMP('" +d+ "')";
				where = where + " AND invalid_datetime = 0";
				where = where + " AND year =" + year;
				where = where + " AND month =" + i;
				where = where + " AND type_id = " + typeId;
				
				String sql_quarter = " SELECT 	"+ year +" as year, "+ typeId +" as type_id," 
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
//			if (id == 288) {
//				System.out.println(sql);
//			}
			List<PcStatsVo> list = getResult(sql);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}		
		
		
	
	public List<PcWorkPlanZBStatsVo> getWorkPlanZBStatsByYear(PcAgency agency, Integer year,
			Integer endMonth, Integer typeId) {

			String code = agency.getCode();
			String name = agency.getName();			

			Integer avg = 1;
			String where = " ";
			
			String d = DateUtils.formatDate(new Date()) + " 00:00:00";
			Date date = DateUtils.getLastDateOfMonthByMonth(year, endMonth);
			d = DateUtils.formatDate(date) + " 00:00:00";
			
			where = where + " WHERE code_id = 10";
			if (agency.getId() > 1) {
				where = where + " AND code like '" + code + "%'";
			}			
			where = where + " AND setup_datetime < UNIX_TIMESTAMP('" + d +"')";
			where = where + " AND invalid_datetime = 0";
			where = where + " AND year =" + year;
			where = where + " AND type_id = " + typeId;	

			List<PcWorkPlanZBStatsVo> list = new ArrayList<PcWorkPlanZBStatsVo>();
			list = getWorkPlanZBStatsResult(name, avg, where);
			return list;
	}			
	
	public List<PcWorkPlanZBStatsVo> getWorkPlanZBStatsByQuarter(PcAgency agency, Integer year,
			List<Integer> qs, Integer endMonth, Integer typeId) {
			
			// 跨季度
			String ids = "";
			if (qs.get(0) == 0) qs.remove(0);
			for (Integer idItem : qs) {
				if (ids.equals("")) {
					ids = idItem + "";
				} else {
					ids += "," + idItem;
				}
			}			

			String code = agency.getCode();
			String name = agency.getName();				
			
			Integer avg = qs.size();
			String where = " ";
			
			String d = DateUtils.formatDate(new Date()) + " 00:00:00";
			Date date = DateUtils.getLastDateOfMonthByMonth(year, endMonth);
			d = DateUtils.formatDate(date) + " 00:00:00";
			
			where = where + " WHERE code_id = 10";
			if (agency.getId() > 1) {
				where = where + " AND code like '" + code + "%'";
			}			
			where = where + " AND setup_datetime < UNIX_TIMESTAMP('" + d +"')";
			where = where + " AND invalid_datetime = 0";
			where = where + " AND year =" + year;
			where = where + " AND quarter in (" + ids + ")";
			where = where + " AND type_id = " + typeId;	

			List<PcWorkPlanZBStatsVo> list = new ArrayList<PcWorkPlanZBStatsVo>();
			list = getWorkPlanZBStatsResult(name, avg, where);
			return list;
	}				
	
	
	public List<PcWorkPlanZBStatsVo> getWorkPlanZBStatsResult(String name, Integer avg, String where) {

		String sql = "SELECT '"+name+"' as p_name,T2.dw_name , T2.ej_or_dzz_name, T2.name, T2.setup_datetime,"
				 +" T1.reported_rate,"
				 +" T1.agency_goodjob," 
				 +" T1.return_rate," 		
				 +" T1.delay_rate," 		
				 +" T1.eva_rate," 			
				 +" T1.eva_1_rate," 		
				 +" T1.eva_2_rate," 		
				 +" T1.eva_3_rate," 		
				 +" T1.eva_4_rate" 		

				 +" FROM"		 
				 +"  (SELECT agency_id,"
				 +"	  ROUND( SUM(reported_rate)/"+avg+", 4) as reported_rate,"
				 +"   COUNT(CASE WHEN reported_rate = 1 THEN agency_id END) as agency_goodjob,"
				 +"	  ROUND( COUNT(CASE WHEN return_rate = 1 THEN agency_id END)/SUM(total), 4) as return_rate," 
				 +"	  ROUND( COUNT(CASE WHEN delay_rate = 1 THEN agency_id END)/SUM(total), 4) as delay_rate,"
				 +"	  ROUND(SUM(eva)/SUM(total), 4) as eva_rate , "
				 +"   ROUND(SUM(eva_1)/SUM(eva), 4) as eva_1_rate, "
				 +"   ROUND(SUM(eva_2)/SUM(eva), 4) as eva_2_rate, "
				 +"   ROUND(SUM(eva_3)/SUM(eva), 4) as eva_3_rate, " 
				 +"   ROUND(SUM(eva_4)/SUM(eva), 4) as eva_4_rate " 			

				 +"   FROM pc_zzsh_stat"
				 +    where
				 +" 	GROUP BY agency_id) as T1"
				 +"   LEFT JOIN"
				 +" 	("
				 +"			select id, code, name, setup_datetime,"
				 +"			(CASE WHEN p_1_code_id = 8 OR p_1_code_id = 15 THEN p_1_name ELSE '' END) as ej_or_dzz_name,"
				 +"			(CASE WHEN p_1_code_id = 7 THEN p_1_name ELSE p_2_name END) as dw_name"
				 +"			FROM"
				 +"				(select" 
				 +"					c.id, c.code, c.name,  c.setup_datetime,"
				 +"					c1.name as p_1_name, c1.code_id as p_1_code_id,"
				 +"					c2.name as p_2_name, c2.code_id as p_2_code_id"
				 +"				from pc_agency c"
				 +"				left join pc_agency c1 on c.parent_id = c1.id"
				 +"				left join pc_agency c2 on c1.parent_id = c2.id"
				 +" 			where c.code_id = 10 and c.parent_id > 0) as a"	 
				 +" ) as T2 ON T1.agency_id = T2.id"
				 +"  order by T2.code asc ";
				
//					System.out.print(sql);

				
				
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
//					    	System.out.println(rows.getString("name"));
					    	PcWorkPlanZBStatsVo pevo = new PcWorkPlanZBStatsVo();
					    	pevo.setP_name(rows.getString("p_name"));
					    	pevo.setDw_name(rows.getString("dw_name"));
					    	pevo.setEj_or_dzz_name(rows.getString("ej_or_dzz_name"));
					    	pevo.setName(rows.getString("name"));
					    	pevo.setSetup_datetime(rows.getString("setup_datetime"));
					    	
					    	//年度计划
					    	pevo.setReported_rate(rows.getDouble("reported_rate"));
					    	pevo.setAgency_goodjob(rows.getInt("agency_goodjob"));
					    	pevo.setReturn_rate(rows.getDouble("return_rate"));
					    	pevo.setDelay_rate(rows.getDouble("delay_rate"));
					    	pevo.setEva_rate(rows.getDouble("eva_rate"));
					    	pevo.setEva_1_rate(rows.getDouble("eva_1_rate"));
					    	pevo.setEva_2_rate(rows.getDouble("eva_2_rate"));
					    	pevo.setEva_3_rate(rows.getDouble("eva_3_rate"));
					    	pevo.setEva_4_rate(rows.getDouble("eva_4_rate"));				    	
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
	
	
	public List<PcMeetingZBStatsVo> getMeetingZBStatsByMonth(PcAgency agency, Integer year,
		Integer startM, Integer endM, Integer typeId) {

		Integer avg = endM - startM + 1;
		
		if (avg <= 0) avg = 1;
		String where = " ";

		String code = agency.getCode();
		String name = agency.getName();
		
		String d = DateUtils.formatDate(new Date()) + " 00:00:00";
		Date date = DateUtils.getLastDateOfMonthByMonth(year, endM);
		d = DateUtils.formatDate(date) + " 00:00:00";
		
		where = where + " WHERE code_id = 10";
		if (agency.getId() > 1) {
			where = where + " AND code like '" + code + "%'";
		}
		where = where + " AND setup_datetime < UNIX_TIMESTAMP('" + d +"')";
		where = where + " AND invalid_datetime = 0";
		where = where + " AND year =" + year;
		where = where + " AND month >= " + startM + " AND month <=" + endM;
		where = where + " AND type_id = " + typeId;

		List<PcMeetingZBStatsVo> list = new ArrayList<PcMeetingZBStatsVo>();
		list = getMeetingZBStatsResult(name, avg, where);
		return list;
	}
	
	public List<PcMeetingZBStatsVo> getMeetingZBStatsByQuarter(PcAgency agency, Integer year,
		List<Integer> qs, Integer endM, Integer typeId) {

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
		
		if (avg <= 0) avg = 1;
		String where = " ";
		String code = agency.getCode();
		String name = agency.getName();
		
		String d = DateUtils.formatDate(new Date()) + " 00:00:00";
		Date date = DateUtils.getLastDateOfMonthByMonth(year, endM);
		d = DateUtils.formatDate(date) + " 00:00:00";
		
		where = where + " WHERE code_id = 10";
		if (agency.getId() > 1) {
			where = where + " AND code like '" + code + "%'";
		}
		where = where + " AND setup_datetime < UNIX_TIMESTAMP('" + d +"')";
		where = where + " AND invalid_datetime = 0";
		where = where + " AND year =" + year;
		where = where + " AND quarter in (" + ids + ")";
		where = where + " AND type_id = " + typeId;
		

		List<PcMeetingZBStatsVo> list = new ArrayList<PcMeetingZBStatsVo>();
		list = getMeetingZBStatsResult(name, avg, where);
		return list;
	}
	
	
	public List<PcMeetingZBStatsVo> getMeetingZBStatsResult(String name, Integer avg, String where) {

		String sql = "SELECT '"+name+"' as p_name,T2.dw_name , T2.ej_or_dzz_name, T2.name, T2.setup_datetime,"
				+" T1.attend_rate," 
				+" T1.reported_rate,"  
				+" T1.total, " 
				+" T1.total_return,"  
				+" T1.total_delay, " 
				+" T1.eva_rate, " 
				+" T1.eva_1_rate," 	
				+" T1.eva_2_rate," 
				+" T1.eva_3_rate," 
				+" T1.eva_4_rate" 
				+" FROM" 
				+" 	(SELECT agency_id," 
				+" 	  ROUND(SUM(attend)/(SUM(attend)+SUM(asence)), 4) as attend_rate,"  
				+" 	  ROUND( SUM(reported_rate)/"+avg+", 4) as  reported_rate," 
				+" 	  SUM(total) as total,  " 
				+"    SUM(total_return) as total_return,"  
				+"    SUM(total_delay) as total_delay, " 
				+" 	  ROUND(SUM(eva)/SUM(total), 4) as eva_rate ,"  
				+"    ROUND(SUM(eva_1)/SUM(total), 4) as eva_1_rate, " 
				+"    ROUND(SUM(eva_2)/SUM(total), 4) as eva_2_rate,  " 
				+"    ROUND(SUM(eva_3)/SUM(total), 4) as eva_3_rate,  " 
				+"    ROUND(SUM(eva_4)/SUM(total), 4) as eva_4_rate " 

				+"   FROM pc_zzsh_stat"
				+ 	 where
				+"   GROUP BY agency_id) as T1" 
				 +"   LEFT JOIN"
				 +" 	("
				 +"			select id, code, name, setup_datetime,"
				 +"			(CASE WHEN p_1_code_id = 8 OR p_1_code_id = 15 THEN p_1_name ELSE '' END) as ej_or_dzz_name,"
				 +"			(CASE WHEN p_1_code_id = 7 THEN p_1_name ELSE p_2_name END) as dw_name"
				 +"			FROM"
				 +"				(select" 
				 +"					c.id, c.code, c.name,  c.setup_datetime,"
				 +"					c1.name as p_1_name, c1.code_id as p_1_code_id,"
				 +"					c2.name as p_2_name, c2.code_id as p_2_code_id"
				 +"				from pc_agency c"
				 +"				left join pc_agency c1 on c.parent_id = c1.id"
				 +"				left join pc_agency c2 on c1.parent_id = c2.id"
				 +" 			where c.code_id = 10 and c.parent_id > 0) as a"	 
				 +" ) as T2 ON T1.agency_id = T2.id"
				 +"  order by T2.code asc ";		
		
//		System.out.print(sql);		
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
				    	
				    	pevo.setAttend_rate(rows.getDouble("attend_rate"));
				    	pevo.setReported_rate(rows.getDouble("reported_rate"));
				    	pevo.setTotal(rows.getInt("total"));
				    	pevo.setTotal_return(rows.getInt("total_return"));
				    	pevo.setTotal_delay(rows.getInt("total_delay"));
				    	pevo.setEva_rate(rows.getDouble("eva_rate"));
				    	pevo.setEva_1_rate(rows.getDouble("eva_1_rate"));
				    	pevo.setEva_2_rate(rows.getDouble("eva_2_rate"));
				    	pevo.setEva_3_rate(rows.getDouble("eva_3_rate"));
				    	pevo.setEva_4_rate(rows.getDouble("eva_4_rate"));

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
