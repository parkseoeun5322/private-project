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
	
	@RequestMapping("/delete.my")
	public String delete(HttpSession session, MemberVO vo) {
		session.setAttribute("login_info", "");
		service.mypage_deleteInfo(vo.getMember_id());
		
		return "home";
	}
	
	@RequestMapping("/updatePw.my")
	public String updatePw(HttpSession session, Model model, MemberVO vo) {
		session.setAttribute("mycategory", "info");
		
		service.mypage_updatePw(vo);
		
		model.addAttribute("infoType", "detailInfo");
		model.addAttribute("vo", service.mypage_info(vo.getMember_id()));
		
		return "mypage/mypage";
	}
	
	@RequestMapping("/modifyPw.my")
	public String modifyPw(HttpSession session, Model model, String member_id) {
		session.setAttribute("mycategory", "info");
		
		model.addAttribute("infoType", "updatePw");
		model.addAttribute("vo", service.mypage_info(member_id));
		
		return "mypage/mypage";
	}
	
	// 회원 정보 업데이트
	@RequestMapping("/updateInfo.my")
	public String updateInfo(HttpSession session, Model model, MemberVO vo) {
		session.setAttribute("mycategory", "info");
		
		service.mypage_updateInfo(vo);
		
		model.addAttribute("infoType", "detailInfo");
		model.addAttribute("vo", service.mypage_info(vo.getMember_id()));
		
		return "mypage/mypage";
	}
	
	// 회원 정보 수정 화면 요청
	@RequestMapping("/modifyInfo.my")
	public String modifyInfo(HttpSession session, Model model, String member_id) {
		session.setAttribute("mycategory", "info");
		
		MemberVO vo = service.mypage_info(member_id);
		
		if(vo.getMember_loginType().equals("N") || vo.getMember_loginType().equals("K")) {
			vo.setMember_id(vo.getMember_id().substring(1));
		}
		
		model.addAttribute("infoType", "updateInfo");
		model.addAttribute("vo", vo);
		
		return "mypage/mypage";
	}
	
	// 작성 댓글 페이지
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
	
	// 작성 글 페이지
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
	
	// 내 스크랩 페이지
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
		
		MemberVO vo = service.mypage_info(member_id);
		
		if (vo.getMember_loginType().equals("N") || vo.getMember_loginType().equals("K")) {
			vo.setMember_id(vo.getMember_id().substring(1));
		}
		
		model.addAttribute("infoType", "detailInfo");
		model.addAttribute("vo", vo);
		
		return "mypage/mypage";
	}
}
