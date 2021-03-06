package com.npnc.category.dto;

public class CDto {	//카테고리 dto
	private int idx;
	private String name;
	private int readgrade;
	private int writegrade;
	
	public CDto() {
		// TODO Auto-generated constructor stub
	}

	public CDto(int idx, String name, int readgrade, int writegrade) {
		this.idx = idx;
		this.name = name;
		this.readgrade = readgrade;
		this.writegrade = writegrade;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getReadgrade() {
		return readgrade;
	}

	public void setReadgrade(int readgrade) {
		this.readgrade = readgrade;
	}

	public int getWritegrade() {
		return writegrade;
	}

	public void setWritegrade(int writegrade) {
		this.writegrade = writegrade;
	}
	
}
