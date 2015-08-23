package com.partycommittee.remote.vo.helper;

import java.util.List;

public class PageResultVo<T> {
	
	private PageHelperVo pageHelper;
	private List<T> list;
	public PageHelperVo getPageHelper() {
		return pageHelper;
	}
	public void setPageHelper(PageHelperVo pageHelper) {
		this.pageHelper = pageHelper;
	}
	public List<T> getList() {
		return list;
	}
	public void setList(List<T> list) {
		this.list = list;
	}
}
