package com.ssafy.happyhouse.model.dto;

public class Notice {
	private int num;
	private String title;
	private String content;
	private String writeDate;
	private String userId;
	
	public Notice() {}

	public Notice(int num, String title, String content, String writeDate, String userId) {
		super();
		this.num = num;
		this.title = title;
		this.content = content;
		this.writeDate = writeDate;
		this.userId = userId;
	}

	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
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
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
}
