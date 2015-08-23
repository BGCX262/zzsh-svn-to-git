package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.partycommittee.persistence.po.PcUser;

public class FilterVo implements Serializable {
	private static final long serialVersionUID = -8851610779875472544L;

	private String id;
	private String data;	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}

	

}
