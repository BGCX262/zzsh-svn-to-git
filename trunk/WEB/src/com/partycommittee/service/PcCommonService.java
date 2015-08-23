package com.partycommittee.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.persistence.daoimpl.PcAgencyDaoImpl;
import com.partycommittee.persistence.daoimpl.PcAgencyMappingDaoImpl;
import com.partycommittee.persistence.daoimpl.PcRoleDaoImpl;
import com.partycommittee.persistence.daoimpl.PcUserDaoImpl;
import com.partycommittee.persistence.daoimpl.PcUserRoleDaoImpl;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcAgencyMapping;
import com.partycommittee.persistence.po.PcRole;
import com.partycommittee.persistence.po.PcUser;
import com.partycommittee.persistence.po.PcUserRole;
import com.partycommittee.remote.vo.PcAgencyVo;
import com.partycommittee.remote.vo.PcRoleVo;
import com.partycommittee.remote.vo.PcUserRoleVo;
import com.partycommittee.remote.vo.PcUserVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

@Transactional
@Service("PcCommonService")
public class PcCommonService {
	
	
	public long getMilliseconds(Long clientTime) {
		return System.currentTimeMillis() - clientTime;
	}
	

}
