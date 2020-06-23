package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ssafy.happyhouse.HappyHouseException;
import com.ssafy.happyhouse.model.dao.HouseDao;
import com.ssafy.happyhouse.model.dto.CompareHistory;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.model.dto.HouseScore;

@Service
public class HouseServiceImpl implements HouseService {
	List<HouseDeal> dealList;
	private HouseDao dao;
	
	@Autowired
	public void setHouseDao(HouseDao dao) {
		this.dao = dao;
	}

	private void typeToString(List<HouseDeal> dealList) {
		for (HouseDeal deal: dealList) {
			switch (deal.getType()) {
			case "1":
				deal.setType("아파트 매매");
				break;
			case "2":
				deal.setType("아파트 전월세");
				break;
			case "3":
				deal.setType("연립, 다세대 매매");
				break;
			case "4":
				deal.setType("연립, 다세대 전월세");
				break;
			}
		}
	}

	public List<HouseDeal> searchAll(HousePageBean bean, String orderby) {
		try {

			boolean[] types = bean.getSearchType();
			int cnt = 0;
			for (boolean t : types) {
				if (t) {
					cnt++;
				}
			}
			if (cnt == 0) {
				throw new HappyHouseException("주택타입은 반드시 한개이상을 선택해야합니다. ");
			}

			if (orderby.equals("no")) {
				dealList = dao.searchAll(bean);
				typeToString(dealList);
				Collections.sort(dealList, new Comparator<HouseDeal>() {
					@Override
					public int compare(HouseDeal d1, HouseDeal d2) {
						int n1 = d1.getNo();
						int n2 = d2.getNo();
						return n1 - n2;
					}
				});
				return dealList;
			} else if (orderby.equals("dong")) {
				dealList = dao.searchAll(bean);
				typeToString(dealList);
				Collections.sort(dealList, new Comparator<HouseDeal>() {
					@Override
					public int compare(HouseDeal d1, HouseDeal d2) {
						String dong1 = d1.getDong();
						String dong2 = d2.getDong();
						
						if (dong1.compareTo(dong2) == 0)
							return d1.getNo() - d2.getNo();
						return dong1.compareTo(dong2);
					}
				});
				return dealList;
			} else if (orderby.equals("apt")) {
				dealList = dao.searchAll(bean);
				typeToString(dealList);
				Collections.sort(dealList, new Comparator<HouseDeal>() {
					@Override
					public int compare(HouseDeal d1, HouseDeal d2) {
						String apt1 = d1.getAptName();
						String apt2 = d2.getAptName();
						if (apt1.compareTo(apt2) == 0)
							return d1.getNo() - d2.getNo();
						return apt1.compareTo(apt2);
					}
				});
				return dealList;
			} else if (orderby.equals("dealAmount")) {
				dealList = dao.searchAll(bean);
				typeToString(dealList);
				Collections.sort(dealList, new Comparator<HouseDeal>() {
					@Override
					public int compare(HouseDeal d1, HouseDeal d2) {
						int price1 = Integer.parseInt(d1.getDealAmount().replace(",", "").trim());
						int price2 = Integer.parseInt(d2.getDealAmount().replace(",", "").trim());
						return Integer.compare(price1, price2);
					}
				});
				/*
				for (HouseDeal d: dealList) {
					System.out.println(d.getDealAmount());
				}
				*/
				return dealList;
			} else {
				dealList = dao.searchAll(bean);
				typeToString(dealList);
				return dealList;
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw new HappyHouseException("주택정보 조회중 오류 발생");
		}
	}

	/**
	 * 아파트 식별 번호에 해당하는 아파트 거래 정보를 검색해서 반환.
	 * 
	 * @param no
	 *            검색할 아파트 식별 번호
	 * @return 아파트 식별 번호에 해당하는 아파트 거래 정보를 찾아서 리턴한다, 없으면 null이 리턴됨
	 * @throws SQLException
	 */
	public HouseDeal search(int no) {
		try {
			HouseDeal deal = dao.search(no);
			if (deal == null) {
				throw new HappyHouseException(String.format("거래번호 %d번에 해당하는 주택 거래정보가 존재하지 않습니다.", no));
			}
			return deal;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new HappyHouseException("주택정보 조회중 오류 발생");
		}
	}

	@Override
	public List<HouseDeal> knapsack(int W, String[] items_no, String[] items_price, String[] items_areavalue) {

		int N = items_no.length;
		int[] weights = new int[N];
		float[] vals = new float[N];

		// 거래금액에서 콤마 떼고 int형으로 변환
		int index = 0;
		for (String price : items_price) {
			weights[index++] = Integer.parseInt(price.replace(",", "").trim());
		}

		// 면적 float형으로 변환
		index = 0;
		for (String area : items_areavalue) {
			vals[index++] = Float.parseFloat(area);
		}

		// DP 배열
		float[] dp_arr2 = new float[W + 1];
		boolean[][] trace = new boolean[N + 1][W + 1];

		// knapsack 알고리즘
		/*
		 * for (int i=0; i<N+1; i++) { for (int w=0; w<W+1; w++) { if (i==0 || w==0) {
		 * dp_arr[i][w] = 0; } else if (weights[i-1] <= w) { if ((vals[i-1] +
		 * dp_arr[i-1][w-weights[i-1]]) > dp_arr[i-1][w]) { dp_arr[i][w] = vals[i-1] +
		 * dp_arr[i-1][w-weights[i-1]]; trace[i][w] = true; } else { dp_arr[i][w] =
		 * dp_arr[i-1][w]; } } else { dp_arr[i][w] = dp_arr[i-1][w]; } } }
		 */

		// 1차원 배열 버전 (메모리 최적화)
		for (int i = 0; i < N + 1; i++) {
			for (int w = W; w >= 0; w--) {
				if (i == 0) {
					dp_arr2[w] = 0;
				} else if (weights[i - 1] <= w) {
					if ((vals[i - 1] + dp_arr2[w - weights[i - 1]]) > dp_arr2[w]) {
						dp_arr2[w] = vals[i - 1] + dp_arr2[w - weights[i - 1]];
						trace[i][w] = true;
					}
				}
			}
		}

		ArrayList<Integer> itemlist = new ArrayList<Integer>();
		// 역추적 (어떤 물건들이 들어갔는지 알아내기)
		int i = N;
		int w = W;

		while (true) {
			if (i <= 0)
				break;

			if (trace[i][w] == true) { // true면 i번 물건을 넣었다는 뜻, 왼쪽 위로
				w -= weights[i - 1];
				itemlist.add(i - 1);
				i--;
			} else { // false면 i번 물건을 안 넣었다는 뜻, 한칸 위로
				i--;
			}
		}

		// System.out.println("최적값 (가능한 최대 면적): " + dp_arr[N][W]);
		System.out.println("최적값 (가능한 최대 면적) - 1차원 배열 이용 : " + dp_arr2[W]);

		List<HouseDeal> deals = new ArrayList<HouseDeal>();
		for (int s = itemlist.size() - 1; s >= 0; s--) {
			int next = itemlist.get(s);
			HouseDeal d;
			try {
				d = dao.search(Integer.parseInt(items_no[next]));
				deals.add(d);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println(deals.size());
		typeToString(deals);
		return deals;
	}

	@Override
	public List<HouseDeal> searchForGraph(String dong, String aptName, double area) {
		return dao.searchForGraph(dong, aptName, area);
	}

	@Override
	public boolean compareSave(String userid, int leftno, int rightno, String weight) {
		return dao.compareSave(userid, leftno, rightno, weight);
	}

	@Override
	public List<CompareHistory> getCompareHistory(String id) {
		return dao.getCompareHistory(id);
	}

	@Override
	public void houseDealScoring() {
		dao.houseDealScoring();
	}

	@Override
	public HouseScore getScore(int no) {
		return dao.getScore(no);
	}

}
