package com.ssafy.happyhouse.model.dto;

public class CompareHistory {
	private int no;
	private String userid;
	private String date;
	private int compare1;
	private int compare2;
	private String weight;
	
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getCompare1() {
		return compare1;
	}
	public void setCompare1(int compare1) {
		this.compare1 = compare1;
	}
	public int getCompare2() {
		return compare2;
	}
	public void setCompare2(int compare2) {
		this.compare2 = compare2;
	}
	
}
