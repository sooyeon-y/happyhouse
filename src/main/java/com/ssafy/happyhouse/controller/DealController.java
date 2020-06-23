package com.ssafy.happyhouse.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.dto.AreaGu;
import com.ssafy.happyhouse.model.dto.CompareHistory;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.model.dto.HouseScore;
import com.ssafy.happyhouse.model.dto.UserInfo;
import com.ssafy.happyhouse.model.service.HouseInfoService;
import com.ssafy.happyhouse.model.service.HouseService;
import com.ssafy.happyhouse.model.service.HouseServiceImpl;

@Controller
public class DealController {
	
	private HouseService hService;
	private HouseInfoService hInfoService;

	@Autowired
	public void sethService(HouseService hService) {
		this.hService = hService;
	}
	
	@Autowired
	public void setHouseInfoService(HouseInfoService hInfoService) {
		this.hInfoService = hInfoService;
	}
	
	@RequestMapping("/deallist")
	public String printDealList(Model model) {
		try {
			// 처음에 데이터 안 띄우기로 했으니 페이지 이동만
			/*
			 * HousePageBean bean = beanSetting("1 2 3 4", null, null);
			List<HouseDeal> deals = hService.searchAll(bean, "no");
			model.addAttribute("deals", deals);
			
			model.addAttribute("selectedall", " checked");
			for (int i = 1; i <= 4; i++)
				model.addAttribute("checked" + i, " checked");
			 */
			String path = "deals";
			return path;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
	
	// REST로 변경
	@GetMapping("/dealsearch/{type}/{searchby}/{searchText}/{weight}")
	@ResponseBody
	public HashMap<String, List> printSearchedDealList(Model model,
			@PathVariable("type") String typeString,
			@PathVariable("searchby") String searchby,
			@PathVariable("searchText") String searchText,
			@PathVariable("weight") String weight) {

		String dongName = null;
		String aptName = null;

		// 이제 페이지 이동하지 않으므로 model은 필요 X
		if (searchby.equals("all")) {
			//model.addAttribute("selectedall", " checked");
		} else if (searchby.equals("dong")) {
			dongName = searchText;
		} else if (searchby.equals("apt")) {
			aptName = searchText;
		} 

		System.out.println(typeString + " " + searchby + " " + searchText);

		try {
			HousePageBean bean = beanSetting(typeString, dongName, aptName);
			List<HouseDeal> deals = hService.searchAll(bean, "no");

			System.out.println(deals.size());
			//return deals;
			System.out.println("deals 검색 결과 : "+deals.size());
			
			List<HouseInfo> infos = hInfoService.searchLatlng(bean);
			System.out.println("info 검색 결과 : "+infos.size());
			
			// 점수 파트: 점수 가져오고 점수에 따라 정렬 //
			// 가중치 1을 주면 0.6, 3을 주면 1.0, 5를 주면 1.4가 적용
			float weight1 = 0.4f + (weight.charAt(0) - '0') * 0.2f;
			float weight2 = 0.4f + (weight.charAt(1) - '0') * 0.2f;
			float weight3 = 0.4f + (weight.charAt(2) - '0') * 0.2f;
			for (HouseDeal d: deals) {
				d = scoreSetter(d, weight1, weight2, weight3);
			}
			/*
			deals.sort(new Comparator<HouseDeal>() {
				@Override
				public int compare(HouseDeal o1, HouseDeal o2) {
					float res = o2.getScore_avg() - o1.getScore_avg();
					return res>0 ? 1 : -1;
				}
			});
			*/
			 		
			HashMap<String, List> map = new HashMap<String, List>();
			map.put("deals", deals);
			map.put("infos", infos);
			
			return map;
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
	
	// 그래프에 표시하기 위해 동, 아파트이름, 면적 같은 데이터들 쭉 들고가는 메서드. 마땅한 이름이 생각이 안나...
	@GetMapping("/dealsearch/drawgraph/{dong}/{aptName}/{area}")
	@ResponseBody
	public List<HouseDeal> printDealListForGraph(
			@PathVariable("dong") String dong,
			@PathVariable("aptName") String aptName,
			@PathVariable("area") double area) {
		
		System.out.println(dong);
		System.out.println(aptName);
		System.out.println(area);

		List<HouseDeal> deals = hService.searchForGraph(dong, aptName, area);
		System.out.println(deals.size());
		return deals;
	}

	//apt name이랑 dong 가지고 info 가져오는 메소드
	@GetMapping("/dealsearch/detail_info/{dong}/{aptName}")
	@ResponseBody
	public HouseInfo InfoDetail(
			@PathVariable("dong") String dong,
			@PathVariable("aptName") String aptName) {
			HouseInfo info = hInfoService.searchCURInfo(dong, aptName);
			System.out.println(info);			
			return info;		
	}
	
	@GetMapping("/dealsearch/detail/{no}/{weight}")
	@ResponseBody
	public HashMap<String, Object> printDealDetail(@PathVariable("no") int no, @PathVariable("weight") String weight) {
		System.out.println(no);
		try {
			HouseDeal deal = hService.search(no);
			
			HouseInfo info = hInfoService.searchInfo(deal);
			System.out.println(info);
			
			// 점수계산
			float weight1 = 0.4f + (weight.charAt(0) - '0') * 0.2f;
			float weight2 = 0.4f + (weight.charAt(1) - '0') * 0.2f;
			float weight3 = 0.4f + (weight.charAt(2) - '0') * 0.2f;
			deal = scoreSetter(deal, weight1, weight2, weight3);
			//
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("deal", deal);
			map.put("info", info);
			
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
	
	// 구 리스트 가져오기.
	@GetMapping("/dealsearch/getgulist")
	@ResponseBody
	public List<AreaGu> getGuList(){
		List<AreaGu> list = hInfoService.getGuList();
		return list;
	}
	
	// 선택한 구에 대한 동 리스트 가져오기.
	@GetMapping("/dealsearch/getdonglist/{code}")
	@ResponseBody
	public List<String> getDongList(@PathVariable("code") int code){
		List<String> list = hInfoService.getDongList(code);
		return list;
	}

	// 비교데이터 저장
	@PostMapping("/dealsearch/comparesave/{left}/{right}/{weight}")
	@ResponseBody
	public ResponseEntity<String> compareSave(HttpServletRequest request, 
			@PathVariable("left") int leftno, @PathVariable("right") int rightno, @PathVariable("weight") String weight){
		HttpSession session = request.getSession();		
		UserInfo userInfo = (UserInfo) session.getAttribute("userinfo");
		
 		if (hService.compareSave(userInfo.getId(), leftno, rightno, weight)) {
 			System.out.println("compareSave 성공");
 			return new ResponseEntity<String>("success", HttpStatus.OK);
 		}
 		return new ResponseEntity<String>("fail", HttpStatus.NO_CONTENT);
	}
	
	// 로그인중인 유저의 저장한 비교데이터 불러오기
	@GetMapping("/dealsearch/gethistory")
	@ResponseBody
	public Map<String, List<HouseDeal>> getHistory(HttpServletRequest request){
		HttpSession session = request.getSession();
		UserInfo userInfo = (UserInfo) session.getAttribute("userinfo");
		
		List<CompareHistory> historyList = hService.getCompareHistory(userInfo.getId());
		// hashMap은 순서가 뒤죽박죽 섞이므로 날짜순으로 보여주려면 TreeMap. 근데 순서 반대로는 안되나...
		Map<String, List<HouseDeal>> map = new TreeMap<String, List<HouseDeal>>();
		
		for (CompareHistory history: historyList) {
			int no1 = history.getCompare1();
			int no2 = history.getCompare2();
			String weight = history.getWeight();
			float weight1 = 0.4f + (weight.charAt(0) - '0') * 0.2f;
			float weight2 = 0.4f + (weight.charAt(1) - '0') * 0.2f;
			float weight3 = 0.4f + (weight.charAt(2) - '0') * 0.2f;
			
			HouseDeal deal1 = hService.search(no1);
			deal1 = scoreSetter(deal1, weight1, weight2, weight3);
			
			HouseDeal deal2 = hService.search(no2);
			deal2 = scoreSetter(deal2, weight1, weight2, weight3);
			
			List<HouseDeal> dealList = new ArrayList<HouseDeal>();
			dealList.add(deal1);
			dealList.add(deal2);
			map.put(history.getDate(), dealList);
		}
		
		return map;
	}
	
	public HouseDeal scoreSetter(HouseDeal d, float weight1, float weight2, float weight3) {
		HouseScore hs = hService.getScore(d.getNo());
		float score1 = weight1 * hs.getDealAmount_score();
		float score2 = weight2 * hs.getBuildYear_score();
		float score3 = weight3 * hs.getArea_score();
		d.setScore_dealAmount(score1);
		d.setScore_buildYear(score2);
		d.setScore_area(score3);
		float avg = (score1+score2+score3) / 3.0f;
		d.setScore_avg(avg);
		return d;
	}
	
	// 아래 둘은 이제 안 쓰는 메서드
	@RequestMapping("/knapsack")
	public String knapsackRecommend(Model model, @RequestParam("dealno") String[] items_no,
			@RequestParam("dealamount")String[] items_price,
			@RequestParam("dealarea")String[] items_areavalue,
			@RequestParam("knapsackmoney") int max_money ){
		
		try {
				List<HouseDeal> deals = hService.knapsack(max_money, items_no, items_price, items_areavalue);
	
				int totalMoney = 0;
				float totalArea = 0;
	
				for (HouseDeal d : deals) {
					totalMoney += Integer.parseInt(d.getDealAmount().replace(",", "").trim());
					totalArea += d.getArea();
			}

			model.addAttribute("totalArea", totalArea);
			model.addAttribute("totalMoney", totalMoney);
			model.addAttribute("deals", deals);

			String path = "knapsackresult";
			return path;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;				
	}
	
	@RequestMapping("/sort")
	public String sortDealList(Model model, @RequestParam("type") String[] selectedType,
			@RequestParam("searchby") String searchby,
			@RequestParam("searchtext") String searchText,
			@RequestParam("orderby") String orderby) {

		String typeString = "";
		for (String s : selectedType) {
			typeString += (s + " ");
			model.addAttribute("checked" + s, " checked");
		}
		
		String dongName = null;
		String aptName = null;

		if (searchby.equals("all")) {
			model.addAttribute("selectedall", " checked");
		} else if (searchby.equals("dong")) {
			dongName = searchText;
			model.addAttribute("selecteddong", " checked");
		} else if (searchby.equals("apt")) {
			aptName = searchText;
			model.addAttribute("selectedapt", " checked");
		}

		System.out.println(searchby + " " + searchText);

		if (orderby.equals("no")) {
			model.addAttribute("byno", " checked");
		} else if (orderby.equals("dong")) {
			model.addAttribute("bydong", " checked");
		} else if (orderby.equals("apt")) {
			model.addAttribute("byapt", " checked");
		} else if (orderby.equals("dealAmount")) {
			model.addAttribute("bydealAmount", " checked");
		}
		System.out.println(orderby);

		try {
			HousePageBean bean = beanSetting(typeString, dongName, aptName);
			List<HouseDeal> deals = hService.searchAll(bean, orderby);
			model.addAttribute("deals", deals);

			model.addAttribute("searchtext", searchText);

			model.addAttribute("selectedall", " checked");
			for (int i = 1; i <= 4; i++)
				model.addAttribute("checked" + i, " checked");

			String path = "deals";
			model.addAttribute("orderby", orderby);
			
			return path;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	private static HousePageBean beanSetting(String searchTypeStr, String dong, String aptName) {
		HousePageBean bean = new HousePageBean();
		boolean[] searchType = new boolean[4];
		String[] categoryList = searchTypeStr.split(" ");
		for (int i = 0; i < categoryList.length; i++) {
			int selected = Integer.parseInt(categoryList[i]) - 1;
			searchType[selected] = true;
		}
		bean.setSearchType(searchType);

		if (dong != null) {
			bean.setDong(dong);
		}
		if (aptName != null) {
			bean.setAptname(aptName);
		}

		return bean;
	}

}
