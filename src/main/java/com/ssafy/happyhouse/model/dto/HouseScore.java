package com.ssafy.happyhouse.model.dto;

// housedeal_score 테이블에 대응되는 DTO
public class HouseScore {
	private int no;
	private float dealAmount_score;
	private float buildYear_score;
	private float area_score;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public float getDealAmount_score() {
		return dealAmount_score;
	}
	public void setDealAmount_score(float dealAmount_score) {
		this.dealAmount_score = dealAmount_score;
	}
	public float getBuildYear_score() {
		return buildYear_score;
	}
	public void setBuildYear_score(float buildYear_score) {
		this.buildYear_score = buildYear_score;
	}
	public float getArea_score() {
		return area_score;
	}
	public void setArea_score(float area_score) {
		this.area_score = area_score;
	}
	
}
