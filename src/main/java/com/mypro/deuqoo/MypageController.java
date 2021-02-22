package com.mypro.deuqoo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import common.BoardCommentPage;
import common.ScrapPage;
import member.MemberVO;
import mypage.BoardPage;
import mypage.MypageServiceImpl;

@Controller
public class MypageController {
	@Autowired MypageServiceImpl service;
	@Autowired ScrapPage spage;
	@Autowired BoardPage bpage;
	@Autowired BoardCommentPage cpage;
	
	@RequestMapping("/comment.my")
	public String mycomment(HttpSession session, Model model, String member_id,
							@RequestParam(defaultValue = "10") int pageList,
							@RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("mycategory", "comm");
		String page = "";
		if(member_id != null) {
			cpage.setCurPage(curPage);
			cpage.setPageList(pageList);
			cpage.setMember_id(member_id);
			
			model.addAttribute("page", service.mypage_comment(cpage));
			page = "mypage/mypage";
		} else {
			page = "member/login";
		}
		
		return page;
	}
	
	@RequestMapping("/document.my")
	public String mydocument(HttpSession session, Model model, String member_id,
							@RequestParam(defaultValue = "10") int pageList,
							@RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("mycategory", "doc");
		String page = "";
		
		if(member_id != null) {
			bpage.setCurPage(curPage);
			bpage.setPageList(pageList);
			bpage.setMember_id(member_id);
			
			model.addAttribute("page", service.mypage_document(bpage));
			page = "mypage/mypage";
		} else {
			page = "member/login";
		}
		
		return page;
	}
	
	@RequestMapping("/scrap.my")
	public String myscrap(HttpSession session, Model model, String search, 
							String keyword, String member_id,
							@RequestParam(defaultValue = "10") int pageList, 
							@RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("mycategory", "scrap");
		String page = "";
		
		if( ((MemberVO) session.getAttribute("login_info")) != null) {
			spage.setCurPage(curPage);
			spage.setSearch(search);
			spage.setKeyword(keyword);
			spage.setPageList(pageList);
			spage.setMember_id(member_id);
			
			model.addAttribute("page", service.mypage_scrap(spage));
			page = "mypage/mypage";
		} else {
			page = "member/login";
		}
		
		return page;
	}
	
	@RequestMapping("/mypage")
	public String mypage(String member_id, HttpSession session, Model model) {
		session.setAttribute("category", "");
		session.setAttribute("mycategory", "info");
		model.addAttribute("vo", service.mypage_info(member_id));
		
		return "mypage/mypage";
	}
}
