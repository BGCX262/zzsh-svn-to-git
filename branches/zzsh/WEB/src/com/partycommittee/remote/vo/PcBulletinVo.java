package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;

import com.partycommittee.persistence.po.PcBulletin;;

public class PcBulletinVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964606L;

	private Integer id;

	private String title;
	private String content;
	private Integer isIndex;
	private String member;
	private Date expireTime;
	private Date pubTime;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}


	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public Integer getIsIndex() {
		return isIndex;
	}
	public void setIsIndex(Integer isIndex) {
		this.isIndex = isIndex;
	}
	
	public String getMember() {
		return member;
	}
	public void setMember(String member) {
		this.member = member;
	}
	
	public Date getExpireTime() {
		return expireTime;
	}
	public void setExpireTime(Date expireTime) {
		this.expireTime = expireTime;
	}
	
	public Date getPubTime() {
		return pubTime;
	}

	public void setPubTime(Date pubTime) {
		this.pubTime = pubTime;
	}
	


	public static PcBulletinVo fromPcBulletin(PcBulletin pevo) {
		PcBulletinVo vo = new PcBulletinVo();
		vo.setId(pevo.getId());
		vo.setTitle(pevo.getTitle());
		vo.setContent(pevo.getContent());
		vo.setIsIndex(pevo.getIsIndex());
		vo.setMember(pevo.getMember());
		vo.setExpireTime(pevo.getExpireTime());
		vo.setPubTime(pevo.getPubTime());
		return vo;
	}
	
	public static PcBulletin toPcBulletin(PcBulletinVo pevo) {
		PcBulletin vo = new PcBulletin();
		vo.setId(pevo.getId());
		vo.setTitle(pevo.getTitle());
		vo.setContent(pevo.getContent());
		vo.setIsIndex(pevo.getIsIndex());
		vo.setMember(pevo.getMember());
		vo.setExpireTime(pevo.getExpireTime());
		vo.setPubTime(pevo.getPubTime());
		return vo;
	}
}
