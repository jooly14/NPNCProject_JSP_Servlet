package com.npnc.board.dto;

import java.sql.Timestamp;

public class RDto {
	
	private int ridx;
	private int bidx;
	private String id;
	private String rContent;
	private Timestamp regDate;
	
	
	
	
	public RDto(int ridx, int bidx, String id, String rContent, Timestamp regDate) {
		super();
		this.ridx = ridx;
		this.bidx = bidx;
		this.id = id;
		this.rContent = rContent;
		this.regDate = regDate;
	}
	
	public RDto() {}

	public int getRidx() {
		return ridx;
	}
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setRidx(int ridx) {
		this.ridx = ridx;
	}
	public int getBidx() {
		return bidx;
	}
	public void setBidx(int bidx) {
		this.bidx = bidx;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
	

	@Override
	public String toString() {
		return "RDto [ridx=" + ridx + ", bidx=" + bidx + ", rContent=" + rContent + ", regDate=" + regDate + "]";
	}
}
