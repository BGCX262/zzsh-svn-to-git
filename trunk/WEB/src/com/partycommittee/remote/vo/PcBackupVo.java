package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;

import com.partycommittee.persistence.po.PcBackup;

public class PcBackupVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964606L;

	private Integer id;

	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public Date getBackupTime() {
		return backupTime;
	}
	public void setBackupTime(Date backupTime) {
		this.backupTime = backupTime;
	}

	private String filename;
	private Date backupTime;


	public static PcBackupVo fromPcBackup(PcBackup pevo) {
		PcBackupVo vo = new PcBackupVo();
		vo.setId(pevo.getId());
		vo.setFilename(pevo.getFilename());
		vo.setBackupTime(pevo.getBackupTime());
		return vo;
	}
	
	public static PcBackup toPcBackup(PcBackupVo pevo) {
		PcBackup vo = new PcBackup();
		vo.setId(pevo.getId());
		vo.setId(pevo.getId());
		vo.setFilename(pevo.getFilename());
		vo.setBackupTime(pevo.getBackupTime());;
		return vo;
	}
}
