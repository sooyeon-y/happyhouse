package com.ssafy.happyhouse;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dao.HouseDao;
import com.ssafy.happyhouse.model.dao.HouseDaoImpl;
import com.ssafy.happyhouse.model.dto.HouseDeal;


public class HouseDealScoring {
	
	static HouseDao dao = new HouseDaoImpl();

	public static void main(String[] args) {
		dao.houseDealScoring();
	}
}
