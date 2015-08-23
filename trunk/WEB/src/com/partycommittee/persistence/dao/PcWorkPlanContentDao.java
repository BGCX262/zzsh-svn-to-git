package com.partycommittee.persistence.dao;

import com.partycommittee.persistence.po.PcWorkPlanContent;

public interface PcWorkPlanContentDao {

	public PcWorkPlanContent getContentByWorkPlanId(Integer workPlanId);
	
	public void createContent(PcWorkPlanContent content);

	public void upateContent(PcWorkPlanContent content);

	PcWorkPlanContent getContentByWorkPlanIdAndType(Integer workPlanId, int i);
	
	public void deleteWorkPlanContentByWorkPlanId(Integer workPlanId); 

}
