package com.partycommittee.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.persistence.daoimpl.PcRemindConfigDaoImpl;
import com.partycommittee.persistence.po.PcRemindConfig;
import com.partycommittee.remote.vo.PcRemindConfigVo;


@Transactional
@Service("PcRemindConfigService")
public class PcRemindConfigService {

	@Resource(name="PcRemindConfigDaoImpl")
	private PcRemindConfigDaoImpl pcRemindConfigDaoImpl;
	public void setPcRemindLockDaoImpl(PcRemindConfigDaoImpl pcRemindConfigDaoImpl) {
		this.pcRemindConfigDaoImpl = pcRemindConfigDaoImpl;
	}

	public List<PcRemindConfigVo> getRemindConfigLists() {
		List<PcRemindConfigVo> list = new ArrayList<PcRemindConfigVo>();
		List<PcRemindConfig> polist = pcRemindConfigDaoImpl.getRemindConfigLists();
		for(PcRemindConfig vo: polist) {
			list.add(PcRemindConfigVo.fromPcRemindLock(vo));
		}
		return list;
	}
	

	public List<PcRemindConfigVo> updateItems(List<PcRemindConfigVo> list) {
		try {
			if (list != null && list.size() > 0) {
				for (PcRemindConfigVo vo: list) {
					pcRemindConfigDaoImpl.updateRemindConfig(PcRemindConfigVo.toPcRemindLock(vo));
				}
			}
			
			return this.getRemindConfigLists();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

}
