
package com.ssafy.happyhouse.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dto.AreaGu;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.util.DBUtil;

@Repository
public class HouseInfoDaoImpl implements HouseInfoDao {

	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<HouseInfo> searchAllHouseInfo() throws SQLException {
		return sqlSession.selectList("houseinfo.searchAllHouseInfo");
	}

	@Override
	public  List<HouseInfo> searchLatlng(HousePageBean  bean) throws SQLException {
		   boolean[] type = bean.getSearchType();
		   String dong = bean.getDong();
		   String aptName = bean.getAptname();
		   
		   ArrayList<Integer> typelist = new ArrayList<Integer>();
		   for (int i=0; i<type.length; i++) {
			   if (type[i]) typelist.add(i+1);
		   }
		   
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("dong", dong);
			map.put("aptName", aptName);
			map.put("type", typelist);
		   
		   return sqlSession.selectList("houseinfo.searchLatlng", map);
	}

	@Override
	public HouseInfo searchInfo(HouseDeal deal) throws SQLException {

		String dong = deal.getDong().trim();
		String aptName = deal.getAptName().trim();
	   
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("dong", dong);
		map.put("aptName", aptName);
		
		return sqlSession.selectOne("houseinfo.searchInfo", map);
	}

	@Override
	public List<AreaGu> getGuList() {
		return sqlSession.selectList("houseinfo.getgulist");
	}

	@Override
	public List<String> getDongList(int code) {
		return sqlSession.selectList("houseinfo.getdonglist", code);
	}

	public HouseInfo searchCURInfo(String dong, String aptName) throws SQLException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("dong", dong);
		map.put("aptName", aptName);
		
		return sqlSession.selectOne("houseinfo.searchCURInfo", map);
	}
}
