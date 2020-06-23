package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.dto.UserInfo;
import com.ssafy.happyhouse.model.service.UserService;

import io.swagger.annotations.ApiOperation;

@Controller
public class UserController {
	private UserService userService;

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	@ApiOperation(value = "QnA 게시판의 작성자 확인을 위해 현재 로그인한 사용자 id를 반환한다.", response = String.class) 	
	@RequestMapping(value = "/api/user", method = RequestMethod.GET)
	public ResponseEntity<UserInfo> checkuser(HttpServletRequest request){		
			HttpSession session = request.getSession();		
			UserInfo userInfo = (UserInfo) session.getAttribute("userinfo");
			return new ResponseEntity<UserInfo>(userInfo, HttpStatus.OK);
	}
	
	@RequestMapping("/mvlogin")
	public String mvlogin() {
		return "forward:/user/login.jsp";
	}

	@RequestMapping("/mvjoin")
	public String mvjoin() {
		return "redirect:/user/join.jsp";
	}

	@RequestMapping("/mvforgetpw")
	public String mvforgetpw() {
		return "redirect:/user/forgetpw.jsp";
	}

	@RequestMapping("/forgetpw")
	public String findPW(Model model, @RequestParam("id") String id, @RequestParam("phone") String phone) {

		try {
			UserInfo userInfo = userService.findUser(id, phone);
			System.out.println("비밀번호 찾기 시도");
			if (userInfo != null) {
				System.out.println(userInfo.getId());
				System.out.println(userInfo.getPassword());
				model.addAttribute("id", userInfo.getId());
				model.addAttribute("password", userInfo.getPassword());
			} else {
				model.addAttribute("msg", "해당하는 정보를 찾지 못했습니다");
			}

			return "/user/findpwresult";

		} catch (Exception e) {
			model.addAttribute("msg", "작업 중 문제가 발생했습니다");
		}
		return null;
	}

	@RequestMapping("/login")
	public String login(HttpServletRequest request, @RequestParam("id") String id,
			@RequestParam("password") String password) {

		System.out.println(id + " " + password);
		try {
			UserInfo userInfo = userService.login(id, password);
			if (userInfo != null) {
				/*
				 * 로그인 성공시 userInfo를 request에 담아서 보내면, 그 요청을 받은 main2.jsp에서 한번만 그 정보를 가져다 쓸 수
				 * 있다. main2.jsp 뿐 아니라 그 이후의 다른 페이지에서도 로그인 정보를 유지하려면 session을 사용해야 함! request 대신
				 * session 객체에 setAttribute를 하면 된다. 받는 페이지에서도 session으로 받고.
				 */
				HttpSession session = request.getSession();
				session.setAttribute("userinfo", userInfo);
				return "forward:/main";
			} else {
				request.setAttribute("msg", "아이디 또는 비밀번호 확인 후 다시 시도해주세요");
				return "forward:/mvlogin";
			}
		} catch (Exception e) {
			request.setAttribute("msg", "로그인 중 문제가 발생했습니다");
		}
		return null;
	}

	@RequestMapping("/join")
	public String join(@RequestParam("id") String id, @RequestParam("password") String password,
			@RequestParam("name") String name, @RequestParam("address") String address,
			@RequestParam("contact") String contact) {

		System.out.println(id + " " + password + " " + name + " " + address + " " + contact);

		userService.join(new UserInfo(id, password, name, address, contact, false));
		return "/user/login";
	}

	@RequestMapping("/mypage")
	public String myPage() {
		return "/user/myPage";
	}

	@RequestMapping("/delete")
	public String delete(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserInfo u = (UserInfo) session.getAttribute("userinfo");
		String id = u.getId();
		String password = request.getParameter("password");
		String path = "/user/login.jsp";
		boolean isDeleted = userService.delete(id, password);
		if (isDeleted) {
			System.out.println("탈퇴완료");
			session.invalidate();
			model.addAttribute("msg", "탈퇴 완료 ! 이용해주셔서 감사합니다");
			return "/user/login";
		} else {
			System.out.println("탈퇴실패");
			model.addAttribute("errorMessage", "비밀번호가 잘못되었습니다");
			return "/user/userDelete";
		}
	}

	@RequestMapping("/modify")
	public String modify(HttpServletRequest request, @RequestParam("id") String id,
			@RequestParam("password") String password, @RequestParam("name") String name,
			@RequestParam("address") String address, @RequestParam("contact") String contact, 
			@RequestParam("isAdmin") boolean isAdmin) {

		UserInfo user = new UserInfo();
		user.setId(id);
		user.setPassword(password);
		user.setName(name);
		user.setAddress(address);
		user.setContact(contact);
		user.setIsAdmin(isAdmin);

		userService.modify(user);
		System.out.println("회원정보 수정 완료");

		HttpSession session = request.getSession();
		session.removeAttribute("userinfo");
		session.setAttribute("userinfo", user);

		return "/user/myPage";
	}

	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();

		return "redirect:/user/login.jsp";
	}

	@RequestMapping("/userlist")
	public String viewUserList(Model model) {
		try {
			List<UserInfo> list = userService.printUserList();
			model.addAttribute("userList", list);
			return "/user/userlist";
		} catch (Exception e) {
			return "redirect:/error.jsp";
		}
	}

}
