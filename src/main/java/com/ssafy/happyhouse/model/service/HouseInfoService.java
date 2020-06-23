package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import com.ssafy.happyhouse.model.dto.AreaGu;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HousePageBean;

public interface HouseInfoService {
    /**HouseInfo DB에 위도 경도 입력하기 위해서  등록된 모든 집의 동과 지번을 추출한다.  */
    public List<HouseInfo> searchAllHouseInfo();

	public  List<HouseInfo> searchLatlng(HousePageBean  bean);
	
	public HouseInfo searchInfo(HouseDeal deal);
	
	public List<AreaGu> getGuList();

	public List<String> getDongList(int code);

	public HouseInfo searchCURInfo(String dong, String aptName);

}