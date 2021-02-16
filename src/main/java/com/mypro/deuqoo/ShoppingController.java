package com.mypro.deuqoo;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import common.CommonService;
import common.PushVO;
import common.ScrapVO;
import member.MemberVO;
import review.ReviewVO;
import shopping.ShoppingPage;
import shopping.ShoppingServiceImpl;
import shopping.ShoppingVO;

@Controller
public class ShoppingController {
	@Autowired CommonService common;
	@Autowired ShoppingServiceImpl service;
	@Autowired ShoppingPage page;
	
	//글 삭제처리 요청
	@RequestMapping("/delete.tv")
	public String delete(int shopping_no, Model model) {
		//선택한 방명록 글을 DB에서 삭제한 후 목록화면으로 연결
		service.shopping_delete(shopping_no);
		model.addAttribute("page", page);
		model.addAttribute("url", "list.tv");
		
		return "shopping/redirect";
	}
	
	//리뷰 글 변경사항 수정 요청
	@RequestMapping("/update.tv")
	public String update(ShoppingVO vo, Model model) {
		
		service.shopping_update(vo);
		
		//return "redirect:detail.re?review_no=" + vo.getReview_no();
		// → url이 바뀌는 문제가 생김
		
		//redirect.addFlashAttribute("id", vo.getId());
		//return "redirect:detail.bo";
		// → 수정한 후 detail.bo로 돌아갔을 때 새로고침하면 오류
		
		model.addAttribute("url", "detail.tv");
		model.addAttribute("shopping_no", vo.getShopping_no());
		return "shopping/redirect";
	}
	
	// 글 수정화면 요청
	@RequestMapping("/modify.tv")
	public String modify(int shopping_no, Model model) {
		//선택한 방명록 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", service.shopping_detail(shopping_no));
		
		return "shopping/modify";
	}	
	
	// 글 상세 정보 조회
	@RequestMapping("/detail.tv")
	public String detail(int shopping_no, Model model, HttpSession session) {
		service.shopping_read(shopping_no);		//조회수 증가
		
		PushVO pvo = new PushVO();
		ScrapVO svo = new ScrapVO();
		
		if(session.getAttribute("login_info") != null) {
			// 해당 글 추천 정보 받아오기
			pvo.setPush_boardNo(shopping_no);
			pvo.setPush_category("상품");
			pvo.setPush_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
			model.addAttribute("push", service.shopping_pushList(pvo));
			
			// 해당 글 스크랩 정보 받아오기
			svo.setScrap_boardNo(shopping_no);
			svo.setScrap_category("상품");
			svo.setScrap_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
			model.addAttribute("scrap", service.shopping_scrapList(svo));
		}
		
		//선택한 방명록 글 정보를 DB에서 조회해와 상세화면에 출력
		model.addAttribute("vo", service.shopping_detail(shopping_no));
		model.addAttribute("page", page);
		
		return "shopping/detail";
	}
	
	
	//TV 속 이 상품 글 저장 처리 요청
	@RequestMapping("/insert.tv")
	public String insert(ShoppingVO vo, HttpSession session) {
		vo.setShopping_writer(((MemberVO) session.getAttribute("login_info")).getMember_id());
		service.shopping_insert(vo);

		// 불판 글 목록 화면으로 이동
		return "redirect:list.tv";
	}
	
	// 리뷰 글쓰기 화면 요청
	@RequestMapping("/new.tv")
	public String bulpan() {

		return "shopping/new";
	}	
	
	//글 목록 화면 요청
	@RequestMapping("/list.tv")
	public String list(HttpSession session, Model model, String search, 
						String keyword, String header, String division,
						@RequestParam(defaultValue = "10") int pageList, 
						@RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "tv");
		
		// TV 속 이 상품 크롤링
		common.shopping_crawling(model);
		
		ShoppingPage list = null;

		// DB에서 글 정보를 조회해와 목록화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setPageList(pageList);
		page.setHeader(header);
		page.setDivision(division);

		if (header != null && !header.equals("")) {
			// 말머리 검색 후 글 목록 화면 요청 시
			list = service.shopping_headerList(page);
			
		} else if (division != null && !division.equals("")) {
			list = service.shopping_divList(page);
			
			if (division.equals("한드")) {
				session.setAttribute("division", "ko");
			} else if (division.equals("미드")) {
				session.setAttribute("division", "am");
			} else if (division.equals("영드")) {
				session.setAttribute("division", "br");
			} else if (division.equals("일드")) {
				session.setAttribute("division", "ja");
			} else if (division.equals("중드")) {
				session.setAttribute("division", "ch");
			} else if (division.equals("기타")) {
				session.setAttribute("division", "et");
			}
			
		} else {
			// 보통 글 목록 화면 요청 시 & 검색 후 글 목록 화면 요청 시
			session.setAttribute("division", "to");
			list = service.shopping_list(page);
		}
		
		model.addAttribute("page", list);
		
		// 댓글 수 구하기
		List<ShoppingVO> vo_list = list.getList();
		for (ShoppingVO vo: vo_list) {
			vo.setShopping_commentcnt(service.shopping_comment_cnt(vo));
		}
		
		return "shopping/list";
		
	} //list()
}
