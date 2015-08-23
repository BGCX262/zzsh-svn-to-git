package com.partycommittee.persistence.daoimpl;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcAgencyDao;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcAgencyRelation;

@Repository("PcAgencyDaoImpl")
public class PcAgencyDaoImpl extends JpaDaoBase implements PcAgencyDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgency> getAgencyList() {
		return super.getJpaTemplate().find("from PcAgency");
	}

	@SuppressWarnings("unchecked")
	@Override
	public PcAgency getAgencyById(int agencyId) {
		try {
			List<PcAgency> list = super.getJpaTemplate().find("from PcAgency where id = " + agencyId);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	public PcAgency getAgencyByCode(String code) {
		try {
			List<PcAgency> list = super.getJpaTemplate().find("from PcAgency where code = '" + code + "'");
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}	
	
//	public List<PcAgency> getChildrenByParentId(int parentId) {
//		try {
//			return super.getJpaTemplate().find("from PcAgency where parentId = " + parentId + " AND invalid_datetime = 0");
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		}
//		return null;
//	}	
	
	@Override
	public void createAgency(PcAgency agency) {
		try {
			agency.setId(null);
			agency.setMemberId(null);
			agency.setSetupDatetime(new Date());
			super.persist(agency);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void updateAgency(PcAgency agency) {
		try {
			if (agency.getMemberId() != null && agency.getMemberId() == 0) {
				agency.setMemberId(null);
			}
			super.merge(agency);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void deleteAgency(PcAgency agency) {
		try {
			super.removeFromKey(PcAgency.class, agency.getId());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgency> getAgencyListByIds(String privilege) {
		try {
			return super.find("from PcAgency where id in (" + privilege + ")");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<PcAgency> getChildrenAgencyByCode(String code) {
		try {
			Integer childCodeLen = code.length() + 2;
			return  super.find("from PcAgency where code like '" + code + "%' and length(code) = " + childCodeLen + " AND invalid_datetime = 0");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}	
	
	public List<PcAgency> getHistoryChildrenAgencyByCode(String code) {
		try {
			Integer childCodeLen = code.length() + 2;
			return  super.find("from PcAgency where code like '" + code + "%' and length(code) = " + childCodeLen + " and code in (SELECT substring( code, 1, "+childCodeLen+" )  FROM PcAgency WHERE invalid_datetime >0)");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}		
	
	public List<PcAgency> getHistoryChildrenAgencyByCodeAll(String code) {
		try {
			return  super.find("from PcAgency where code like '" + code + "%' AND invalid_datetime >0)");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}		
	
	
	public List<PcAgency> getChildrenAgencyByCodeOnly(String code) {
		try {
			Integer childCodeLen = code.length() + 2;
			return  super.find("from PcAgency where code like '" + code + "%' and length(code) = " + childCodeLen + " AND code_id <> 10 AND invalid_datetime = 0");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}	
	
	public List<PcAgency> getChildrenAgencyByCodeAll(String code) {
		try {
			return  super.find("from PcAgency where code like '" + code + "%' AND invalid_datetime = 0");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}		
	
	
	public List<PcAgency> getChildrenLeafAgencyByCode(String code) {
		try {
			return  super.find("from PcAgency where code like '" + code + "%' AND code_id = 10 AND invalid_datetime = 0 Order By code asc");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}		
		
	
	@SuppressWarnings("unchecked")
	@Override
	public String getMaxCodeByParentId(int parent_id) {
		try {
			
			List<PcAgency> list = super.getJpaTemplate().find("from PcAgency where id = " + parent_id);
			PcAgency  parentVo;
			if (list != null && list.size() > 0) {
				parentVo = list.get(0);
				String parent_code = parentVo.getCode();
				String sql = "";
				if (parent_id == 1) {
					sql = "SELECT (CASE WHEN max(code) IS NULL THEN  '01' ELSE LPAD(max(code) + 1, 2, 0) END) as maxcode from PcAgency where length(code) = 2 ";
				} else {
					sql = "SELECT (CASE WHEN max(code) IS NULL THEN  CONCAT('"+ parent_code + "','01') ELSE LPAD(max(code) + 1, length('"+ parent_code + "') + 2, 0) END) as maxcode from PcAgency where code like CONCAT ('"+ parent_code + "', '%') and length(code) = length('"+ parent_code + "') + 2 ";
				}
				
				EntityManager em = super.getEntityManager();
				Query q = em.createQuery(sql);
				List<String> rs = q.getResultList();
				if (rs!= null && rs.size() > 0) {
					return rs.get(0);
				}
			}			

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}	
	

}
