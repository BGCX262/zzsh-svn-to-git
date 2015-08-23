package com.partycommittee.persistence.po;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "pc_bulletin")
public class PcBulletin implements Serializable {
	private static final long serialVersionUID = 7128028905512465920L;
	
	private Integer id;
	private String title;
	private String content;
	private Integer isIndex;
	private String member;
	private Date pubTime;

	private Date expireTime;
	
	@Id
	@Column(name = "id", unique = true, nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	

	@Column(name = "title")
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name = "content")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	@Column(name = "is_index")
	public Integer getIsIndex() {
		return isIndex;
	}
	public void setIsIndex(Integer isIndex) {
		this.isIndex = isIndex;
	}
	
	@Column(name = "member")
	public String getMember() {
		return member;
	}
	public void setMember(String member) {
		this.member = member;
	}
	
	@Column(name = "expire_time")
	public Date getExpireTime() {
		return expireTime;
	}
	public void setExpireTime(Date expireTime) {
		this.expireTime = expireTime;
	}

	@Column(name = "pub_time")
	public Date getPubTime() {
		return pubTime;
	}

	public void setPubTime(Date pubTime) {
		this.pubTime = pubTime;
	}

	
}
