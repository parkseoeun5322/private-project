package com.mypro.deuqoo;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.CommonService;

@Controller
public class ShoppingController {
	@Autowired private CommonService common;
	
	//글 목록 화면 요청
	@RequestMapping("/list.tv")
	public String list(HttpSession session, Model model) {
		session.setAttribute("category", "tv");
		
		// TV 속 이 상품 크롤링
		common.shopping_crawling(model);
		
		return "shopping/list";
		
	} //list()
}
