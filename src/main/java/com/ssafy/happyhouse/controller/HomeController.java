package com.ssafy.happyhouse.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.Notice;
import com.ssafy.happyhouse.model.dto.UserInfo;
import com.ssafy.happyhouse.model.service.HouseInfoService;
import com.ssafy.happyhouse.model.service.HouseService;
import com.ssafy.happyhouse.model.service.NoticeService;
import com.ssafy.happyhouse.model.service.UserService;

@Controller
public class HomeController {

	private UserService userService;
	private NoticeService nService;
	private HouseInfoService houseInfoService;
	private HouseService houseService;
	
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	@Autowired
	public void setNoticeService(NoticeService nService) {
		this.nService = nService;
	}
	
	@Autowired
	public void setHouseInfoService(HouseInfoService hService) {
		this.houseInfoService = hService;
	}
	
	@Autowired
	public void setHouseService(HouseService hdService) {
		this.houseService = hdService;
	}
	
	@RequestMapping("/")
	public String home() {
		return "redirect:/index.jsp";
	}
	
	@RequestMapping("/vueqna")
	public String toVueQnA() {
		return "redirect:/vueqna.jsp";
	}
	
	@RequestMapping("/comparehistory")
	public String toCompareHistory() {
		return "redirect:/comparehistory.jsp";
	}
	
	@RequestMapping("/mvlogin.do")
	public String home2() {
		return "redirect:/user/login.jsp";
	}
	
	@RequestMapping("/test.do")
	public String test() {
		List<UserInfo> list = userService.printUserList();
		for (UserInfo u: list)
			System.out.println(u.getName());
		return "test";
	}
	
	@RequestMapping("/test2.do")
	public String test2() throws SQLException {
		Notice nn = nService.getNotice(13);
		System.out.println(nn.getTitle());
		
		List<Notice> list = nService.printNoticeList();
		for (Notice n: list)
			System.out.println(n.getContent());
		return "test";
	}
	
	@RequestMapping("/test3.do")
	public String test3() throws SQLException {
		List<HouseInfo> list = houseInfoService.searchAllHouseInfo();
		for (HouseInfo h: list)
			System.out.println(h.getAptName());
		return "test";
	}
	
	@RequestMapping("/test4.do")
	public String test4() throws SQLException {
		HouseDeal h = houseService.search(1);
		System.out.println(h.getAptName());
		return "test";
	}
	
	@RequestMapping("/scoring")
	public void scoring() throws SQLException {
		houseService.houseDealScoring();
	}
	
	@RequestMapping("/testdeals999")
	public String testpage() throws SQLException {
		String path = "deals999";
		return path;
	}
	
}
