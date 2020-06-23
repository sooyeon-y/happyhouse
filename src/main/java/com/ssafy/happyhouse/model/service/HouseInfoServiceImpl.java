
package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.HappyHouseException;
import com.ssafy.happyhouse.model.dao.HouseInfoDao;
import com.ssafy.happyhouse.model.dao.HouseInfoDaoImpl;
import com.ssafy.happyhouse.model.dto.AreaGu;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HousePageBean;

@Service
public class HouseInfoServiceImpl implements HouseInfoService {
	private HouseInfoDao dao;

	@Autowired
	public void setHouseInfoDao(HouseInfoDao dao) {
		this.dao = dao;
	}

	@Override
	public List<HouseInfo> searchAllHouseInfo() {
		try {
			return dao.searchAllHouseInfo();
		} catch (SQLException e) {
			throw new HappyHouseException("주택정보 조회 중 오류 발생");
		}
	}

	@Override
	public  List<HouseInfo> searchLatlng(HousePageBean  bean) {
		try {
			return dao.searchLatlng(bean);
		} catch (SQLException e) {
			throw new HappyHouseException("주택정보 조회 중 오류 발생");
		}
	}

	@Override
	public HouseInfo searchInfo(HouseDeal deal) {
		try {
			return dao.searchInfo(deal);
		} catch (SQLException e) {
			throw new HappyHouseException("주택정보 조회 중 오류 발생");
		}
	}

	@Override
	public List<AreaGu> getGuList() {
		return dao.getGuList();
	}

	@Override
	public List<String> getDongList(int code) {
		return dao.getDongList(code);
	}

	public HouseInfo searchCURInfo(String dong, String aptName) {
		try {
			return dao.searchCURInfo(dong,aptName);
		} catch (SQLException e) {
			throw new HappyHouseException("주택정보 조회 중 오류 발생");
		}
	}

}
