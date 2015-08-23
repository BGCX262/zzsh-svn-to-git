package com.partycommittee.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.persistence.daoimpl.PcMeetingDaoImpl;
import com.partycommittee.persistence.daoimpl.PcRemindDaoImpl;
import com.partycommittee.persistence.daoimpl.PcRemindStatDaoImpl;
import com.partycommittee.persistence.daoimpl.PcWorkPlanDaoImpl;
import com.partycommittee.remote.vo.PcMeetingVo;
import com.partycommittee.remote.vo.PcRemindStatVo;
import com.partycommittee.remote.vo.PcRemindVo;
import com.partycommittee.remote.vo.PcWorkPlanVo;
import com.partycommittee.persistence.po.PcMeeting;
import com.partycommittee.persistence.po.PcRemind;
import com.partycommittee.persistence.po.PcRemindStat;
import com.partycommittee.persistence.po.PcWorkPlan;


@Transactional
@Service("PcRemindService")
public class PcRemindService {

	@Resource(name="PcRemindDaoImpl")
	private PcRemindDaoImpl PcRemindDaoImpl;
	public void setPcRemindDaoImpl(PcRemindDaoImpl PcRemindDaoImpl) {
		this.PcRemindDaoImpl = PcRemindDaoImpl;
	}
	
	@Resource(name="PcRemindStatDaoImpl")
	private PcRemindStatDaoImpl PcRemindStatDaoImpl;
	public void setPcRemindStatDaoImpl(PcRemindStatDaoImpl PcRemindDaoStatImpl) {
		this.PcRemindStatDaoImpl = PcRemindStatDaoImpl;
	}
	
	@Resource(name="PcWorkPlanDaoImpl")
	private PcWorkPlanDaoImpl pcWorkPlanDaoImpl;
	public void setPcWorkPlanDaoImpl(PcWorkPlanDaoImpl pcWorkPlanDaoImpl) {
		this.pcWorkPlanDaoImpl = pcWorkPlanDaoImpl;
	}
	
	@Resource(name="PcMeetingDaoImpl")
	private PcMeetingDaoImpl pcMeetingDaoImpl;
	public void setPcMeetingDaoImpl(PcMeetingDaoImpl pcMeetingDaoImpl) {
		this.pcMeetingDaoImpl = pcMeetingDaoImpl;
	}	
	
	public List<PcRemindStatVo> getListRemindStatById(Integer id, Integer year, Integer q) {
		List<PcRemindStatVo> list = new ArrayList<PcRemindStatVo>();
		
		//年度计划
		List<PcRemindStat> y = PcRemindStatDaoImpl.getListWorkPlanById(id, year, 0, 1);
		for (PcRemindStat item : y) {
			list.add(PcRemindStatVo.fromPcRemind(item));
		}
		
		List<PcRemindStat> last_q;
		if (q == 1) {
			Integer last_year = year - 1;
			
			// 去年第四季度执行情况
			last_q = PcRemindStatDaoImpl.getListWorkPlanById(id, last_year, 4, 3);
			for (PcRemindStat item : last_q) {
				list.add(PcRemindStatVo.fromPcRemind(item));
			}
			
			// 去年年终工作总结
			List<PcRemindStat> last_year_end = PcRemindStatDaoImpl.getListWorkPlanById(id, last_year, 0, 4);
			for (PcRemindStat item : last_year_end) {
				list.add(PcRemindStatVo.fromPcRemind(item));
			}			
		} else {
			// 上季度执行情况
			Integer last_qu = q - 1;
			last_q = PcRemindStatDaoImpl.getListWorkPlanById(id, year, last_qu, 3);
			for (PcRemindStat item : last_q) {
				list.add(PcRemindStatVo.fromPcRemind(item));
			}
		}
		
		// 本季度工作安排
		List<PcRemindStat> q_plan = PcRemindStatDaoImpl.getListWorkPlanById(id, year, q, 2);
		for (PcRemindStat item : q_plan) {
			list.add(PcRemindStatVo.fromPcRemind(item));
		}			
		
		List<PcRemindStat> meeting;
		for(int i=5; i<=9; i++) {
		// 党课
			meeting = null;
			meeting = PcRemindStatDaoImpl.getListWorkPlanById(id, year, q, i);
	
			for (PcRemindStat item : meeting) {
				list.add(PcRemindStatVo.fromPcRemind(item));
			}
		}
		return list;
	}
	
	public List<PcRemindVo> getListRemindNoCommitByParentId(Integer id, Integer year, Integer q, Integer tid) {
		List<PcRemindVo> list = new ArrayList<PcRemindVo>();
		List<PcRemind> items = PcRemindDaoImpl.getListNoCommitByParentId(id, year, q, tid);
		for (PcRemind item : items) {
			list.add(PcRemindVo.fromPcRemind(item));
		}
		return list;
	}
	
	public List<PcRemindVo> getListRemindCommitByParentId(Integer id, Integer year, Integer q, Integer tid, Integer sid) {
		List<PcRemindVo> list = new ArrayList<PcRemindVo>();
		List<PcRemind> items = PcRemindDaoImpl.getListByParentId(id, year, q, tid, sid);
		for (PcRemind item : items) {
			list.add(PcRemindVo.fromPcRemind(item));
		}
		return list;
	}	
	
	public List<PcRemindVo> getListRemindByParentId(Integer id, Integer year, Integer q, Integer tid, Integer sid) {
		List<PcRemindVo> list = new ArrayList<PcRemindVo>();
		List<PcRemind> items = PcRemindDaoImpl.getListByParentId(id, year, q, tid, sid);
		for (PcRemind item : items) {
			list.add(PcRemindVo.fromPcRemind(item));
		}
		return list;
	}	
	
	public List<PcRemindStatVo> getListRemindStatByParentIdForAdmin(Integer id, Integer year, Integer q) {
		List<PcRemindStatVo> list = new ArrayList<PcRemindStatVo>();
	
		//年度计划
		List<PcRemindStat> y = PcRemindStatDaoImpl.getListWorkPlanByParentId(id, year, 0, 1);
		for (PcRemindStat item : y) {
			list.add(PcRemindStatVo.fromPcRemind(item));
		}
		
		List<PcRemindStat> last_q;
		if (q == 1) {
			Integer last_year = year - 1;
			
			// 去年第四季度执行情况
			last_q = PcRemindStatDaoImpl.getListWorkPlanByParentId(id, last_year, 4, 3);
			for (PcRemindStat item : last_q) {
				list.add(PcRemindStatVo.fromPcRemind(item));
			}
			
			// 去年年终工作总结
			List<PcRemindStat> last_year_end = PcRemindStatDaoImpl.getListWorkPlanByParentId(id, last_year, 0, 4);
			for (PcRemindStat item : last_year_end) {
				list.add(PcRemindStatVo.fromPcRemind(item));
			}			
		} else {
			// 上季度执行情况
			Integer last_qu = q - 1;
			last_q = PcRemindStatDaoImpl.getListWorkPlanByParentId(id, year, last_qu, 3);
			for (PcRemindStat item : last_q) {
				list.add(PcRemindStatVo.fromPcRemind(item));
			}			
		}
		
		// 本季度工作安排
		List<PcRemindStat> q_plan = PcRemindStatDaoImpl.getListWorkPlanByParentId(id, year, q, 2);
		for (PcRemindStat item : q_plan) {
			list.add(PcRemindStatVo.fromPcRemind(item));
		}			
		
		List<PcRemindStat> meeting;
		for(int i=5; i<=9; i++) {
		// 党课
			meeting = null;
			meeting = PcRemindStatDaoImpl.getListMeetingByParentId(id, year, q, i);
	
			for (PcRemindStat item : meeting) {
				list.add(PcRemindStatVo.fromPcRemind(item));
			}
		}
		return list;
	}	

	public List<PcRemindVo> getRealRemindById(Integer agencyId, Integer year,
			Integer quarter) {
		List<PcRemindVo> list = new ArrayList<PcRemindVo>();

		 //年度计划
		PcWorkPlan yearWorkPlan = pcWorkPlanDaoImpl.getWorkPlanYearlyByAgencyId(agencyId, year);
		
		if (yearWorkPlan != null) {
			
			PcWorkPlanVo vo = PcWorkPlanVo.fromPcWorkPlan(yearWorkPlan);
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(vo.getYear());
			remindvo.setQuarter(0);
			remindvo.setAgencyId(vo.getAgencyId());
			remindvo.setStatusId(vo.getStatusId());
			remindvo.setTypeId(vo.getTypeId());
			list.add(remindvo);
		} else {
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(0);		
			remindvo.setStatusId(0);
			remindvo.setTypeId(1);			
			list.add(remindvo);
		}		

		// 计划类
		if (quarter == 1) {
		    // 去年年终总结
			PcWorkPlan yearResultWorkPlan = pcWorkPlanDaoImpl.getWorkPlanYearlySummaryByAgencyId(agencyId, year - 1);
			if (yearResultWorkPlan != null) {	
				PcWorkPlanVo vo = PcWorkPlanVo.fromPcWorkPlan(yearResultWorkPlan);
				PcRemindVo remindvo = new PcRemindVo();
				remindvo.setYear(vo.getYear());
				remindvo.setQuarter(0);						
				remindvo.setAgencyId(vo.getAgencyId());
				remindvo.setStatusId(vo.getStatusId());
				remindvo.setTypeId(vo.getTypeId());
				list.add(remindvo);	

			} else {
				PcRemindVo remindvo = new PcRemindVo();
				remindvo.setYear(year - 1);
				remindvo.setQuarter(0);						
				remindvo.setStatusId(0);
				remindvo.setTypeId(4);			
				list.add(remindvo);
			}
			
			// 上季度执行情况
			PcWorkPlan quarterResultWorkPlan = pcWorkPlanDaoImpl.getResultQuarterByAgencyId(agencyId, year - 1, 4);
			if (quarterResultWorkPlan != null) {
				PcWorkPlanVo vo = PcWorkPlanVo.fromPcWorkPlan(quarterResultWorkPlan);
				PcRemindVo remindvo = new PcRemindVo();
				remindvo.setYear(vo.getYear());
				remindvo.setQuarter(4);		
				remindvo.setAgencyId(vo.getAgencyId());
				remindvo.setStatusId(vo.getStatusId());
				remindvo.setTypeId(vo.getTypeId());
				list.add(remindvo);			

			} else {
				PcRemindVo remindvo = new PcRemindVo();
				remindvo.setYear(year - 1);
				remindvo.setQuarter(4);						
				remindvo.setStatusId(0);
				remindvo.setTypeId(3);			
				list.add(remindvo);
			}			
		} else {
			// 上季度执行情况
			PcWorkPlan quarterResultWorkPlan = pcWorkPlanDaoImpl.getResultQuarterByAgencyId(agencyId, year, quarter -1);
			if (quarterResultWorkPlan != null) {
				PcWorkPlanVo vo = PcWorkPlanVo.fromPcWorkPlan(quarterResultWorkPlan);
				PcRemindVo remindvo = new PcRemindVo();
				remindvo.setYear(year);
				remindvo.setQuarter(quarter -1);				
				remindvo.setAgencyId(vo.getAgencyId());
				remindvo.setStatusId(vo.getStatusId());
				remindvo.setTypeId(vo.getTypeId());
				list.add(remindvo);			

			} else {
				PcRemindVo remindvo = new PcRemindVo();
				remindvo.setYear(year);
				remindvo.setQuarter(quarter -1);				
				remindvo.setStatusId(0);
				remindvo.setTypeId(3);			
				list.add(remindvo);
			}				
		}

		// Quarter work plan.
		PcWorkPlan quarterWorkPlan = pcWorkPlanDaoImpl.getWorkPlanQuarterByAgencyId(agencyId, year, quarter);
		if (quarterWorkPlan != null) {
			PcWorkPlanVo vo = PcWorkPlanVo.fromPcWorkPlan(quarterWorkPlan);
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);			
			remindvo.setAgencyId(vo.getAgencyId());
			remindvo.setStatusId(vo.getStatusId());
			remindvo.setTypeId(vo.getTypeId());
			list.add(remindvo);
		} else {
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);				
			remindvo.setStatusId(0);
			remindvo.setTypeId(2);			
			list.add(remindvo);
		}


		
		// 会议类
		PcMeeting classMeeting = pcMeetingDaoImpl.getMeeting(agencyId, year, quarter, 5);
		if (classMeeting != null) {
			
			PcMeetingVo vo = PcMeetingVo.fromPcMeeting(classMeeting);
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);				
			remindvo.setAgencyId(vo.getAgencyId());
			remindvo.setStatusId(vo.getStatusId());
			remindvo.setTypeId(vo.getTypeId());
			list.add(remindvo);				

		} else {
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);				
			remindvo.setStatusId(0);
			remindvo.setTypeId(5);			
			list.add(remindvo);
		}
		// branch members.
		PcMeeting branchMemberMeeting = pcMeetingDaoImpl.getMeeting(agencyId, year, quarter, 6);
		if (branchMemberMeeting != null) {
			PcMeetingVo vo = PcMeetingVo.fromPcMeeting(branchMemberMeeting);
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);				
			remindvo.setAgencyId(vo.getAgencyId());
			remindvo.setStatusId(vo.getStatusId());
			remindvo.setTypeId(vo.getTypeId());
			list.add(remindvo);		
		} else {
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);				
			remindvo.setStatusId(0);
			remindvo.setTypeId(6);			
			list.add(remindvo);
		}
		
		// branch life.
		PcMeeting branchLifeMeeting = pcMeetingDaoImpl.getMeeting(agencyId, year, quarter, 7);
		if (branchLifeMeeting != null) {
			PcMeetingVo vo = PcMeetingVo.fromPcMeeting(branchLifeMeeting);
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);				
			remindvo.setAgencyId(vo.getAgencyId());
			remindvo.setStatusId(vo.getStatusId());
			remindvo.setTypeId(vo.getTypeId());
			list.add(remindvo);		
		} else {
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);				
			remindvo.setStatusId(0);
			remindvo.setTypeId(7);			
			list.add(remindvo);
		}				
		
		// branch committee.
		PcMeeting branchCommitteeMeeting = pcMeetingDaoImpl.getMeeting(agencyId, year, quarter, 8);
		if (branchCommitteeMeeting != null) {
			PcMeetingVo vo = PcMeetingVo.fromPcMeeting(branchCommitteeMeeting);
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);				
			remindvo.setAgencyId(vo.getAgencyId());
			remindvo.setStatusId(vo.getStatusId());
			remindvo.setTypeId(vo.getTypeId());
			list.add(remindvo);		
		} else {
			PcRemindVo remindvo = new PcRemindVo();
			remindvo.setYear(year);
			remindvo.setQuarter(quarter);				
			remindvo.setStatusId(0);
			remindvo.setTypeId(8);			
			list.add(remindvo);
		}
		return list;
	}	
	
}
