package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dto.CompareHistory;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.model.dto.HouseScore;

public interface HouseDao {
	public List<HouseDeal> searchAll(HousePageBean  bean) throws SQLException;
	/**
	 * 아파트 식별 번호에 해당하는 아파트 거래 정보를 검색해서 반환. 
	 * @param no	검색할 아파트 식별 번호
	 * @return		아파트 식별 번호에 해당하는 아파트 거래 정보를 찾아서 리턴한다, 없으면 null이 리턴됨
	 */
	public HouseDeal search(int no) throws SQLException;
	public List<HouseDeal> searchForGraph(String dong, String aptName, double area);
	public boolean compareSave(String userid, int leftno, int rightno, String weight);
	public List<CompareHistory> getCompareHistory(String id);
	
	public void houseDealScoring();
	public HouseScore getScore(int no);
}
