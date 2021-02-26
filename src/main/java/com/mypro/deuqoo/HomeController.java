package com.mypro.deuqoo;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import bulpan.BulpanPage;
import bulpan.BulpanServiceImpl;
import common.CommonService;
import common.CommonServiceImpl;
import mypage.BoardPage;
import mypage.BoardVO;
import review.ReviewPage;
import review.ReviewServiceImpl;

@Controller
public class HomeController {	
	@Autowired CommonServiceImpl common_service;
	@Autowired BulpanServiceImpl bulpan_service;
	@Autowired ReviewServiceImpl review_service;
	@Autowired BoardPage board_page;
	@Autowired BulpanPage bulpan_page;
	@Autowired ReviewPage review_page;
	@Autowired CommonService common;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) {
		session.removeAttribute("category");
		
		board_page.setCurPage(1);
		board_page.setPageList(10);
		
		bulpan_page.setCurPage(1);
		bulpan_page.setPageList(10);
		
		review_page.setCurPage(1);
		review_page.setPageList(10);
		
		List<BoardVO> po_list = (common_service.popul_sort(board_page)).getList();
		List<BoardVO> pu_list = (common_service.push_sort(board_page)).getList();
		
		model.addAttribute("popul", po_list);
		model.addAttribute("push", pu_list);
		model.addAttribute("bulpan", bulpan_service.bulpan_list(bulpan_page));
		model.addAttribute("review", review_service.review_list(review_page));
		
		model.addAttribute("drama", common.ingDrama_crawling());
		model.addAttribute("drama_size", (common.ingDrama_crawling()).size());
				
		return "home";
	}
}
