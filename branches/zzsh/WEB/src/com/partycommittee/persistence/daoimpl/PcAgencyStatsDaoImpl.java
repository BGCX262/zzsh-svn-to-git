package com.partycommittee.persistence.daoimpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.hibernate.ejb.HibernateEntityManager;
import org.springframework.stereotype.Repository;

import com.common.utils.DateUtils;
import com.partycommittee.persistence.dao.PcAgencyStatsDao;
import com.partycommittee.persistence.po.PcAgencyStats;
import com.partycommittee.remote.vo.PcStatsVo;

@Repository("PcAgencyStatsDaoImpl")
public class PcAgencyStatsDaoImpl extends JpaDaoBase implements PcAgencyStatsDao {
	

	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgencyStats> getAgencyStatsByParentCode(Integer id, Integer year, Integer endM) {
		try {
			if (id == null) {
				return null;
			}
			EntityManager em = super.getEntityManager();
			
			String d = DateUtils.formatDate(new Date()) + " 00:00:00";
			Date date = DateUtils.getFirstDateOfMonthByMonth(year, endM);
			d = DateUtils.formatDate(date) + " 00:00:00";			
//			System.out.println(d);
			// 获取直属党支部
			String query_sql;
			Query sql = em.createQuery("select code from PcAgency where id = " + id);
			List<String> rs = sql.getResultList();
			String code = rs.get(0);	
			
			Integer code_len = code.length();
			query_sql = "from PcAgencyStats where code = '"+code+"' or (code like '"+code+"%' and length(code) = "+ (code.length() + 2) +") AND (invalid_datetime <= UNIX_TIMESTAMP('" + d + "')) Order by agency_id ASC ";
//			System.out.println(query_sql);
			Query query=em.createQuery(query_sql);
			List<PcAgencyStats> list =  query.getResultList();
	
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgencyStats> getAgencyStatsById(Integer id, Integer year, Integer endM) {
		try {
			if (id == null) {
				return null;
			}
			EntityManager em = super.getEntityManager();

			String d = DateUtils.formatDate(new Date()) + " 00:00:00";
			Date date = DateUtils.getFirstDateOfMonthByMonth(year, endM);
			d = DateUtils.formatDate(date) + " 00:00:00";			
//			System.out.println(d);			
			
			Query query=em.createQuery("from PcAgencyStats where agencyId = "+id+" Order by agency_id ASC ");
			List<PcAgencyStats> list =  query.getResultList();
	
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
	@Override
	public List<PcAgencyStats> getAgencyStatsByParentId(Integer id, Integer year, Integer endM) {
		try {
			if (id == null) {
				return null;
			}
			EntityManager em = super.getEntityManager();

			String d = DateUtils.formatDate(new Date()) + " 00:00:00";
			Date date = DateUtils.getFirstDateOfMonthByMonth(year, endM);
			d = DateUtils.formatDate(date) + " 00:00:00";			
//			System.out.println(d);			
//			System.out.println("from PcAgencyStats where parent_id = "+id+" AND (invalid_datetime <= UNIX_TIMESTAMP('" + d + "')) Order by agency_id ASC ");
			Query query=em.createQuery("from PcAgencyStats where parent_id = "+id+" AND (invalid_datetime <= UNIX_TIMESTAMP('" + d + "')) Order by agency_id ASC ");
			
			List<PcAgencyStats> list =  query.getResultList();
	
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgencyStats> getAgencyStatsByAdmin(Integer id, Integer year, Integer endM) {
		try {
			if (id == null) {
				return null;
			}
			
			Calendar cal = Calendar.getInstance();

			if (year.equals(null) || year == 0) {
				year = cal.get(Calendar.YEAR);
			}
			
			if (endM == 0) {
				endM = cal.get(Calendar.MONTH )+1;		
			}			
			
			String d = DateUtils.formatDate(new Date()) + " 00:00:00";
			Date date = DateUtils.getFirstDateOfMonthByMonth(year, endM);
			d = DateUtils.formatDate(date) + " 23:59:59";			

			String where = " WHERE (invalid_datetime = 0 Or invalid_datetime >= UNIX_TIMESTAMP('" + d + "'))";


			String sql = "SELECT "
					 + " (T2.jc_num + T2.ejdw_num + T2.dzj_num + T2.dzb_num) as zz_num, T2.* FROM"
					 + " (SELECT "
					 	 + "  (CASE WHEN jc_num is null THEN 0 ELSE jc_num END) as jc_num,"
						 + "  (CASE WHEN ejdw_num is null THEN 0 ELSE ejdw_num END) as ejdw_num,"
						 + "  (CASE WHEN dzj_num is null THEN 0 ELSE dzj_num END) as dzj_num,"
						 + "  (CASE WHEN dzb_num is null THEN 0 ELSE dzb_num END) as dzb_num,"
						 + "  (CASE WHEN more2year_num is null THEN 0 ELSE more2year_num END) as more2year_num,"
						 + "  (CASE WHEN less7_num is null THEN 0 ELSE less7_num END) as less7_num,"
						 + "  (CASE WHEN no_fsj_zbwy_num is null THEN 0 ELSE no_fsj_zbwy_num END) as no_fsj_zbwy_num,"
						 + "  (CASE WHEN dxz_num is null THEN 0 ELSE dxz_num END) as dxz_num,"
						 + "  (CASE WHEN dy_num is null THEN 0 ELSE dy_num END) as dy_num,"
						 + "  (CASE WHEN zbsj_num is null THEN 0 ELSE zbsj_num END) as zbsj_num,"
						 + "  (CASE WHEN zbfsj_num is null THEN 0 ELSE zbfsj_num END) as zbfsj_num,"
						 + "  (CASE WHEN zzwy_num is null THEN 0 ELSE zzwy_num END) as zzwy_num,"
						 + "  (CASE WHEN xcwy_num is null THEN 0 ELSE xcwy_num END) as xcwy_num,"
						 + "  (CASE WHEN jjwy_num is null THEN 0 ELSE jjwy_num END) as jjwy_num,"
						 + "  (CASE WHEN qnwy_num is null THEN 0 ELSE qnwy_num END) as qnwy_num,"
						 + "  (CASE WHEN ghwy_num is null THEN 0 ELSE ghwy_num END) as ghwy_num,"
						 + "  (CASE WHEN fnwy_num is null THEN 0 ELSE fnwy_num END) as fnwy_num,"
						 + "  (CASE WHEN bmwy_num is null THEN 0 ELSE bmwy_num END) as bmwy_num"
					+ " FROM "					 			
					 	 + " (SELECT COUNT(CASE WHEN code_id = 7 THEN id END ) as jc_num ,"
						 + " COUNT(CASE WHEN code_id = 15 THEN id END ) as ejdw_num ,"
						 + " COUNT(CASE WHEN code_id = 8 THEN id END ) as dzj_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN dzb_num END ) as dzb_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN more2year_num END ) as more2year_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN less7_num END ) as less7_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN no_fsj_zbwy_num END ) as no_fsj_zbwy_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN dxz_num END ) as dxz_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN dy_num END ) as dy_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN zbsj_num END ) as zbsj_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN zbfsj_num END ) as zbfsj_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN zzwy_num END ) as zzwy_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN xcwy_num END ) as xcwy_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN jjwy_num END ) as jjwy_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN qnwy_num END ) as qnwy_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN ghwy_num END ) as ghwy_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN fnwy_num END ) as fnwy_num,"
						 + " SUM(CASE WHEN code_id = 10 THEN bmwy_num END ) as bmwy_num"
						 + " FROM pc_agency_stats "
						 + where
						 + ") as T1 "
						 + ") as T2";
//			 System.out.println(sql);
			 List<PcAgencyStats> list = getResult(sql);
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}		
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgencyStats> getAgencyStatsByCode(String code, Integer code_id, Integer year, Integer endM) {
		try {
			if (code == null) {
				return null;
			}
			
			Calendar cal = Calendar.getInstance();

			if (year.equals(null) || year == 0) {
				year = cal.get(Calendar.YEAR);
			}
			
			if (endM == 0) {
				endM = cal.get(Calendar.MONTH )+1;		
			}
			
//			System.out.println("year = " + year );
//			System.out.println("endM = " + endM);
			
			String d = DateUtils.formatDate(new Date()) + " 00:00:00";
			Date date = DateUtils.getLastDateOfMonthByMonth(year, endM);
			d = DateUtils.formatDate(date) + " 23:59:59";			

			// 获取直属党支部

			String where = "";
			where = where + " WHERE code like '" + code + "%'";			
			where = where + " AND (invalid_datetime = 0 Or invalid_datetime >= UNIX_TIMESTAMP('" + d + "'))";
			Integer jc_num = 0;
			if (code_id == 7) {
				jc_num = 1;
			}
			
			String sql = "SELECT "
						 + " ("+ jc_num +" + T2.ejdw_num + T2.dzj_num + T2.dzb_num) as zz_num, T2.* FROM"
						 + " (SELECT jc_num,"
							 + "  (CASE WHEN ejdw_num is null THEN 0 ELSE ejdw_num END) as ejdw_num,"
							 + "  (CASE WHEN dzj_num is null THEN 0 ELSE dzj_num END) as dzj_num,"
							 + "  (CASE WHEN dzb_num is null THEN 0 ELSE dzb_num END) as dzb_num,"
							 + "  (CASE WHEN more2year_num is null THEN 0 ELSE more2year_num END) as more2year_num,"
							 + "  (CASE WHEN less7_num is null THEN 0 ELSE less7_num END) as less7_num,"
							 + "  (CASE WHEN no_fsj_zbwy_num is null THEN 0 ELSE no_fsj_zbwy_num END) as no_fsj_zbwy_num,"
							 + "  (CASE WHEN dxz_num is null THEN 0 ELSE dxz_num END) as dxz_num,"
							 + "  (CASE WHEN dy_num is null THEN 0 ELSE dy_num END) as dy_num,"
							 + "  (CASE WHEN zbsj_num is null THEN 0 ELSE zbsj_num END) as zbsj_num,"
							 + "  (CASE WHEN zbfsj_num is null THEN 0 ELSE zbfsj_num END) as zbfsj_num,"
							 + "  (CASE WHEN zzwy_num is null THEN 0 ELSE zzwy_num END) as zzwy_num,"
							 + "  (CASE WHEN xcwy_num is null THEN 0 ELSE xcwy_num END) as xcwy_num,"
							 + "  (CASE WHEN jjwy_num is null THEN 0 ELSE jjwy_num END) as jjwy_num,"
							 + "  (CASE WHEN qnwy_num is null THEN 0 ELSE qnwy_num END) as qnwy_num,"
							 + "  (CASE WHEN ghwy_num is null THEN 0 ELSE ghwy_num END) as ghwy_num,"
							 + "  (CASE WHEN fnwy_num is null THEN 0 ELSE fnwy_num END) as fnwy_num,"
							 + "  (CASE WHEN bmwy_num is null THEN 0 ELSE bmwy_num END) as bmwy_num"
						 + " FROM "					 
							 + " (SELECT  " + jc_num + " as jc_num,"
							 + " COUNT(CASE WHEN code_id = 15 THEN id END ) as ejdw_num ,"
							 + " COUNT(CASE WHEN code_id = 8 THEN id END ) as dzj_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN dzb_num END ) as dzb_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN more2year_num END ) as more2year_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN less7_num END ) as less7_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN no_fsj_zbwy_num END ) as no_fsj_zbwy_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN dxz_num END ) as dxz_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN dy_num END ) as dy_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN zbsj_num END ) as zbsj_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN zbfsj_num END ) as zbfsj_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN zzwy_num END ) as zzwy_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN xcwy_num END ) as xcwy_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN jjwy_num END ) as jjwy_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN qnwy_num END ) as qnwy_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN ghwy_num END ) as ghwy_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN fnwy_num END ) as fnwy_num,"
							 + " SUM(CASE WHEN code_id = 10 THEN bmwy_num END ) as bmwy_num"
							 + " FROM pc_agency_stats "
							 + where   
						 + ") as T1 "
						 + ") as T2";
//			 System.out.println(sql);
			 List<PcAgencyStats> list = getResult(sql);
			
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
	
	public List<PcAgencyStats> getResult(String sql) throws SQLException {
		java.sql.Connection conn = null;
		try {

			 List<PcAgencyStats> list = new ArrayList<PcAgencyStats>();
			 EntityManager em = super.getEntityManager();
			 em.getTransaction().begin();

			 HibernateEntityManager hem = (HibernateEntityManager)em;
			 conn = hem.getSession().connection();
			 
			 java.sql.Statement statement = conn.createStatement();
//			 System.out.println(sql);
			    ResultSet rows = statement.executeQuery(sql);  
			    while (rows.next()) {
//			    	System.out.println(rows.getString("name"));
			    	PcAgencyStats pevo = new PcAgencyStats();
//			    	pevo.setAgencyId(rows.getInt("agency_id"));
//			    	pevo.setCode(rows.getString("code"));
//			    	pevo.setCodeId(rows.getInt("code_id"));
//			    	pevo.setName(rows.getString("name"));
//			    	pevo.setParentId(rows.getInt("parent_id"));
			    	pevo.setZzNum(rows.getInt("zz_num"));
			    	pevo.setJcNum(rows.getInt("jc_num"));
			    	pevo.setEjdwNum(rows.getInt("ejdw_num"));
			    	pevo.setDzjNum(rows.getInt("dzj_num"));
			    	pevo.setDzbNum(rows.getInt("dzb_num"));
			    	pevo.setMore2yearNum(rows.getInt("more2year_num"));
			    	pevo.setLess7Num(rows.getInt("less7_num"));
			    	pevo.setNoFsjZbwyNum(rows.getInt("no_fsj_zbwy_num"));
			    	pevo.setDxzNum(rows.getInt("dxz_num"));
			    	pevo.setDyNum(rows.getInt("dy_num"));
			    	pevo.setZbsjNum(rows.getInt("zbsj_num"));
			    	pevo.setZbfsjNum(rows.getInt("zbfsj_num"));
			    	pevo.setZzwyNum(rows.getInt("zzwy_num"));
			    	pevo.setXcwyNum(rows.getInt("xcwy_num"));
			    	pevo.setJjwyNum(rows.getInt("jjwy_num"));
			    	pevo.setQnwyNum(rows.getInt("qnwy_num"));
			    	pevo.setGhwyNum(rows.getInt("ghwy_num"));
			    	pevo.setFnwyNum(rows.getInt("fnwy_num"));
			    	pevo.setBmwyNum(rows.getInt("bmwy_num"));
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
