package com.mypro.deuqoo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.CommonService;

@Controller
public class DramaController {
	@Autowired private CommonService common;
	
	@RequestMapping("/list.dr")
	public String list_ing(HttpSession session, Model model) {
		session.setAttribute("category", "dr");
		
		String ingUrl = "?where=nexearch&sm=tab_etc&query=드라마";
		common.drama_crawling(model, ingUrl);
		
		return "drama/drama_list";
	}
	
	@RequestMapping("/list.so")
	public String list_soon(HttpSession session, Model model) {
		session.setAttribute("category", "dr");
		
		String soonUrl = "?where=nexearch&sm=tab_etc&query=방영예정한국드라마";
		common.drama_crawling(model, soonUrl);
		
		return "drama/drama_list";
	}
}
