package com.ssafy.happyhouse.model.dto;

import java.sql.Date;
import java.time.LocalTime;

public class QnA {
	private int qnaNo;
	private String qnaTitle;
	private String qnaContent;
	private String qnaUserid;
	private String qnaDatetime;
	private String replyContent;
	private String replyDatetime;
	private String replyUserid;
	
	@Override
	public String toString() {
		return "QnA [qnaNo=" + qnaNo + ", qnaTitle=" + qnaTitle + ", qnaContent=" + qnaContent + ", qnaUserid="
				+ qnaUserid + ", qnaDatetime=" + qnaDatetime + ", replyContent=" + replyContent + ", replyDatetime="
				+ replyDatetime + ", replyUserid=" + replyUserid + "]";
	}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public String getQnaTitle() {
		return qnaTitle;
	}

	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}

	public String getQnaContent() {
		return qnaContent;
	}

	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}

	public String getQnaUserid() {
		return qnaUserid;
	}

	public void setQnaUserid(String qnaUserid) {
		this.qnaUserid = qnaUserid;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public String getReplyUserid() {
		return replyUserid;
	}

	public void setReplyUserid(String replyUserid) {
		this.replyUserid = replyUserid;
	}

	public String getQnaDatetime() {
		return qnaDatetime;
	}

	public void setQnaDatetime(String qnaDatetime) {
		this.qnaDatetime = qnaDatetime;
	}

	public String getReplyDatetime() {
		return replyDatetime;
	}

	public void setReplyDatetime(String replyDatetime) {
		this.replyDatetime = replyDatetime;
	}



}
