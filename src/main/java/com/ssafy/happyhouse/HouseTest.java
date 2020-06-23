
package com.ssafy.happyhouse;

import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import com.ssafy.happyhouse.model.dao.HouseDao;
import com.ssafy.happyhouse.model.dao.HouseDaoImpl;
import com.ssafy.happyhouse.model.dao.HouseInfoDao;
import com.ssafy.happyhouse.model.dao.HouseInfoDaoImpl;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;

public class HouseTest {

	public static void main(String[] args) throws SQLException {

		System.out.println("--------아파트 실거래가 조회--------");

		HouseDao de = new HouseDaoImpl();
		try {
			List<HouseDeal> list = new LinkedList<>();
			for (int i = 1; i <= 5; i++) {
				HouseDeal deal = de.search(i);
				list.add(deal);
			}
			for (HouseDeal a : list) {
				System.out.println(a);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		HouseInfoDao dao = new HouseInfoDaoImpl();
		System.out.println("--------주택정보 조회--------");

		try {
			List<HouseInfo> deal = dao.searchAllHouseInfo();
			for (int i = 0; i < 10; i++) {
				System.out.println(deal.get(i).toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
