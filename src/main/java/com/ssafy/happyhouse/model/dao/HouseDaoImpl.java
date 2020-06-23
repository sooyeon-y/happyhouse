package com.ssafy.happyhouse.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dto.CompareHistory;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.model.dto.HouseScore;
import com.ssafy.happyhouse.util.DBUtil;

@Repository
public class HouseDaoImpl implements HouseDao{
   private Map<String, HouseInfo> houseInfo;
   private Map<String, List<HouseDeal>> deals;
   private int size;
   private List<HouseDeal>search;
   private String[] searchType= {HouseDeal.APT_DEAL, HouseDeal.APT_RENT, HouseDeal.HOUSE_DEAL, HouseDeal.HOUSE_RENT};

	private SqlSession sqlSession;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
   
   public List<HouseDeal> searchAll(HousePageBean  bean) throws SQLException{
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
	   
	   return sqlSession.selectList("housedeal.searchAll", map);
   }
   
   /**
    * 아파트 식별 번호에 해당하는 아파트 거래 정보를 검색해서 반환한다.<br/>
    * 법정동+아파트명을 이용하여 HouseInfo에서 건축연도, 법정코드, 지번, 이미지 정보를 찾아서 HouseDeal에 setting한 정보를 반환한다. 
    * @param no   검색할 아파트 식별 번호
    * @return      아파트 식별 번호에 해당하는 아파트 거래 정보를 찾아서 리턴한다, 없으면 null이 리턴됨
    */
   public HouseDeal search(int no) throws SQLException{
	   HouseDeal d = sqlSession.selectOne("housedeal.search", no);
	   // 이미지 갖고오기 위해서... SQL만으로 이거 하려니 어려웠다
	   if (d.getType().equals("1") || d.getType().equals("2")) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("dong", d.getDong());
			map.put("aptName", d.getAptName());
		   String img = sqlSession.selectOne("housedeal.searchimg", map);
		   d.setImg(img);
	   }
	   return d;
   }

	@Override
	public List<HouseDeal> searchForGraph(String dong, String aptName, double area) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("dong", dong.trim()); // 동이름 앞에 이상한 공백문자가 한개 있다... DB에도 그런 것 같지만 이상하게 trim 안해주니 못 찾음
		map.put("aptName", aptName);
		map.put("area", Double.toString(area));

		return sqlSession.selectList("housedeal.searchForGraph", map);
	}

	@Override
	public boolean compareSave(String userid, int leftno, int rightno, String weight) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("leftno", leftno);
		map.put("rightno", rightno);
		map.put("weight", weight);
		return sqlSession.insert("housedeal.compareSave", map) > 0; // 0이 아니면 삽입성공 = true 리턴
	}

	@Override
	public List<CompareHistory> getCompareHistory(String id) {
		return sqlSession.selectList("housedeal.getCompareHistory", id);
	}
	
	
	
	///////////////////////////////////////////////////////////////////////////////
	
	
	
	/* houseDeal에서 데이터 가져와서 점수 계산한 뒤 다시 housedeal_score에 저장하는 메서드 */
	public void houseDealScoring() {
		List<HouseDeal> list = sqlSession.selectList("housedeal.getFullTable");
		System.out.println(list.size());
		
		ArrayList<HouseDeal> sublist = new ArrayList<HouseDeal>();
		int count = 1;
		int size = list.size();
		int tempCode = -1;
		for (HouseDeal d: list) {
			//System.out.println(d.getNo());
			// 구 코드가 바뀔때마다 지금까지 담았던 deal들에 대해 평균-표준편차 계산하고, 리스트 초기화.
			if ((tempCode != -1 && d.getCode() != tempCode) || count == size) {
				
				System.out.println(count);
				
				if (count == size)
					sublist.add(d);
				
				float mean_dealAmount = mean(sublist, 1);
				float mean_buildYear = mean(sublist, 2);
				float mean_area = mean(sublist, 3);
				System.out.println("평균: " + mean_dealAmount + "/" + mean_buildYear + "/" + mean_area);
				
				double stddev_dealAmount = stddev(sublist, 1, mean_dealAmount);
				double stddev_buildYear = stddev(sublist, 2, mean_buildYear);
				double stddev_area = stddev(sublist, 3, mean_area);
				
				for (HouseDeal subd: sublist) {
					int dealAmount = Integer.parseInt(subd.getDealAmount().replace(",", "").trim());
					// 가격은 낮을수록 좋은 것 -> Z점수에 negative
					double t_score_dealAmount = 20 * (-((dealAmount - mean_dealAmount) / stddev_dealAmount)) + 100;
					double t_score_buildYear = 20 * ((subd.getBuildYear() - mean_buildYear) / stddev_buildYear) + 100;
					double t_score_area = 20 * ((subd.getArea() - mean_area) / stddev_area) + 100;
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("dealno", subd.getNo());
					map.put("score_dealAmount", t_score_dealAmount);
					map.put("score_buildYear", t_score_buildYear);
					map.put("score_area", t_score_area);
					sqlSession.insert("score_insert", map);
				}
				
				sublist.clear();
				
			}
			
			if (count == size)
				break;
			
			sublist.add(d);
			tempCode = d.getCode();
			count++;
		}
		
	}

	private float mean(ArrayList<HouseDeal> sublist, int type) {
		
		float total = 0;
		
		for (HouseDeal d: sublist) {
			if (type == 1)
				total += Integer.parseInt(d.getDealAmount().replace(",", "").trim());
			else if (type == 2)
				total += d.getBuildYear();
			else if (type == 3)
				total += d.getArea();
		}
		
		return total / sublist.size();
	}
	
	private double stddev(ArrayList<HouseDeal> sublist, int type, float mean) {
		
		float total = 0;
		
		for (HouseDeal d: sublist) {
			if (type == 1) {
				float value = Integer.parseInt(d.getDealAmount().replace(",", "").trim());
				float diff = Math.abs(value - mean); // 평균과의 편차값
				total += Math.pow(diff, 2); // 편차의 제곱을 모두 더한다
			}
			
			if (type == 2) {
				float value = d.getBuildYear();
				float diff = Math.abs(value - mean); // 평균과의 편차값
				total += Math.pow(diff, 2); // 편차의 제곱을 모두 더한다
			}
			
			if (type == 3) {
				float value = (float) d.getArea();
				float diff = Math.abs(value - mean); // 평균과의 편차값
				total += Math.pow(diff, 2); // 편차의 제곱을 모두 더한다
			}
		}
		
		float variance = total / sublist.size();
		return Math.sqrt(variance); // 분산의 제곱근 = 표준편차
		
	}

	@Override
	public HouseScore getScore(int no) {
		return sqlSession.selectOne("housedeal.getScore", no);
	}

}

