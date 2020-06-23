package com.ssafy.happyhouse.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.dto.Notice;
import com.ssafy.happyhouse.model.service.NoticeService;

@Controller
public class NoticeController {
	private NoticeService nService;


	@Autowired
	public void setnService(NoticeService nService) {
		this.nService = nService;
	}

	@RequestMapping("/main")
	public String printNoticeList(Model model) {
		try {
			List<Notice> list = nService.printNoticeList();
			model.addAttribute("noticeList", list);
			return "/main2";
		} catch (Exception e) {
			return "redirect:/error.jsp";
		}
	}

	@RequestMapping("/noticedetail")
	public String printNoticeDetail(Model model, @RequestParam("no") int no) {
		try {
			Notice notice = nService.getNotice(no);
			model.addAttribute("notice", notice);
			return "/noticedetail";
		} catch (Exception e) {
			return "redirect:/error.jsp";
		}
	}

	@RequestMapping("/noticewritepage")
	public String toWriteNoticePage() {
		try {
			return "redirect:/noticewrite.jsp";
		} catch (Exception e) {
			return "redirect:/error.jsp";
		}
	}

	@RequestMapping("/noticewrite")
	public String writeNotice(@RequestParam("userid") String userid, @RequestParam("title") String title,
			@RequestParam("content") String content) {

		try {
			Notice n = new Notice();

			SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date time = new Date();
			String date = format1.format(time);

			n.setTitle(title);
			n.setContent(content);
			n.setWriteDate(date);
			n.setUserId(userid);

			nService.addNotice(n);
			return "redirect:/main";

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error.jsp";
		}
	}

	@RequestMapping("/noticemodifypage")
	public String toModifyNoticePage(Model model, @RequestParam("num") int no) {
		String path = "/noticemodify";
		try {

			Notice notice = nService.getNotice(no);
			model.addAttribute("notice", notice);
			return path;

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error.jsp";
		}
	}

	@RequestMapping("/noticemodify")
	public String modifyNotice(@RequestParam("num") int num, @RequestParam("userid") String userid,
			@RequestParam("title") String title, @RequestParam("content") String content) {

		try {
			Notice n = new Notice();
			SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date time = new Date();
			String date = format1.format(time);

			n.setNum(num);
			n.setTitle(title);
			n.setContent(content);
			n.setWriteDate(date);
			n.setUserId(userid);

			nService.modifyNotice(n);
			return "redirect:/main";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error.jsp";
		}
	}

	@RequestMapping("/noticedelete")
	public String deleteNotice(@RequestParam("num") int no) {

		try {
			nService.deleteNotice(no);
			return "redirect:/main";
		} catch (Exception e) {
			return "redirect:/error.jsp";
		}
	}

}
