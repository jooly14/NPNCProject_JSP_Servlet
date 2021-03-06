package com.npnc.board.dto;

import java.sql.Timestamp;
import java.util.Vector;

public class BDto {	//게시글 dto
	private int idx;	//글번호
	private String title;	//글제목
	private String id;		//작성자 아이디
	private String content;	//글내용
	private Timestamp regdate;	//작성시간
	private int hit;		//조회수
	private String file;	//파일경로
	private int category;	
	private int good;		//좋아요 갯수
	private int bad;		//싫어요 갯수
	private Vector<RDto> replys;	//댓글 게시글
	private int replyCnt;
	
	public BDto() {}	//기본 생성자
	public BDto(int idx, String title, String id, String content, Timestamp regdate, int hit, String file, int category,
			int good, int bad, Vector<RDto> replys, int replyCnt) {
		this.idx = idx;
		this.title = title;
		this.id = id;
		this.content = content;
		this.regdate = regdate;
		this.hit = hit;
		this.file = file;
		this.category = category;
		this.good = good;
		this.bad = bad;
		this.replys = replys;
		this.replyCnt = replyCnt;
	}
	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public int getBad() {
		return bad;
	}
	public void setBad(int bad) {
		this.bad = bad;
	}
	public Vector<RDto> getReplys() {
		return replys;
	}
	public void setReplys(Vector<RDto> replys) {
		this.replys = replys;
	}
	
}
