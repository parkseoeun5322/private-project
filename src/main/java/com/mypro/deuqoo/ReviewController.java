package com.mypro.deuqoo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import bulpan.BulpanPage;
import bulpan.BulpanVO;
import common.CommonService;
import common.PushVO;
import common.ScrapVO;
import member.MemberVO;
import review.ReviewPage;
import review.ReviewServiceImpl;
import review.ReviewVO;

@Controller
public class ReviewController {
	@Autowired ReviewServiceImpl service;
	@Autowired ReviewPage page;
	@Autowired CommonService common;
	
	//방명록 삭제처리 요청
	@RequestMapping("/delete.re")
	public String delete(int review_no, Model model) {
		//선택한 방명록 글을 DB에서 삭제한 후 목록화면으로 연결
		service.review_delete(review_no);
		model.addAttribute("page", page);
		model.addAttribute("url", "list.re");
		
		return "review/redirect";
	}
	
	//스크랩 취소
	@ResponseBody
	@RequestMapping("/scrap_cancel")
	public boolean scrap_cancel(int scrap_boardNo, String scrap_no) {
		ScrapVO vo = new ScrapVO();
		vo.setScrap_no(Integer.parseInt(scrap_no));
		vo.setScrap_boardNo(scrap_boardNo);
		
		//boolean result = false;
		//result = service.review_push_cancel(vo);
		
		return service.review_scrap_cancel(vo);
	}	
	
	// 해당 글 스크랩
	@ResponseBody
	@RequestMapping("/scrap")
	public boolean scrap(int scrap_boardNo, String scrap_category, 
						 String scrap_title, HttpSession session) {
		ScrapVO vo = new ScrapVO();
		vo.setScrap_boardNo(scrap_boardNo);
		vo.setScrap_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
		vo.setScrap_category(scrap_category);
		vo.setScrap_title(scrap_title);
		
		return service.review_scrap(vo);
	}
	
	//리뷰 글 변경사항 수정 요청
	@RequestMapping("/update.re")
	public String update(ReviewVO vo, Model model) {
		
		service.review_update(vo);
		
		//return "redirect:detail.re?review_no=" + vo.getReview_no();
		// → url이 바뀌는 문제가 생김
		
		//redirect.addFlashAttribute("id", vo.getId());
		//return "redirect:detail.bo";
		// → 수정한 후 detail.bo로 돌아갔을 때 새로고침하면 오류
		
		model.addAttribute("url", "detail.re");
		model.addAttribute("review_no", vo.getReview_no());
		return "review/redirect";
	}
	
	//리뷰 글 수정화면 요청
	@RequestMapping("/modify.re")
	public String modify(int review_no, Model model) {
		//선택한 방명록 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", service.review_detail(review_no));
		
		return "review/modify";
	}
	
	// 글 추천 취소
	@ResponseBody
	@RequestMapping("/push_cancel")
	public boolean push_cancel(int push_boardNo, String push_no) {
		System.out.println("review_no : " + push_boardNo + ", push_no : " + push_no);
		PushVO vo = new PushVO();
		vo.setPush_no(Integer.parseInt(push_no));
		vo.setPush_boardNo(push_boardNo);
		
		//boolean result = false;
		//result = service.review_push_cancel(vo);
		
		return service.review_push_cancel(vo);
	}
	
	
	// 글 추천 수 증가
	@ResponseBody
	@RequestMapping("/push")
	public boolean push(int push_no, String push_category, HttpSession session) {
		PushVO vo = new PushVO();
		vo.setPush_boardNo(push_no);
		vo.setPush_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
		vo.setPush_category(push_category);
		
		return service.review_push(vo);
	}
	
	// 리뷰 글 상세정보 조회
	@RequestMapping("/detail.re")
	public String detail(int review_no, Model model, HttpSession session) {
		service.review_read(review_no);		//조회수 증가
		
		PushVO pvo = new PushVO();
		ScrapVO svo = new ScrapVO();
		
		if(session.getAttribute("login_info") != null) {
			// 해당 글 추천 정보 받아오기
			pvo.setPush_boardNo(review_no);
			pvo.setPush_category("리뷰");
			pvo.setPush_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
			model.addAttribute("push", service.review_pushList(pvo));
			
			// 해당 글 스크랩 정보 받아오기
			svo.setScrap_boardNo(review_no);
			svo.setScrap_category("리뷰");
			svo.setScrap_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
			model.addAttribute("scrap", service.review_scrapList(svo));
		}
		
		//선택한 방명록 글 정보를 DB에서 조회해와 상세화면에 출력
		model.addAttribute("vo", service.review_detail(review_no));
		model.addAttribute("page", page);
		
		return "review/detail";
	}
	
	//리뷰 글 저장 처리 요청
	@RequestMapping("/insert.re")
	public String insert(ReviewVO vo, HttpSession session) {
		vo.setReview_writer(((MemberVO) session.getAttribute("login_info")).getMember_id());
		service.review_insert(vo);

		// 불판 글 목록 화면으로 이동
		return "redirect:list.re";
	}
	
	// 리뷰 글쓰기 화면 요청
	@RequestMapping("/new.re")
	public String bulpan() {

		return "review/new";
	}
	
	// 리뷰 글 목록 화면 요청
	@RequestMapping("/list.re")
	public String list(Model model, HttpSession session, String search, 
						String keyword, String header, String division,
						@RequestParam(defaultValue = "10") int pageList, 
						@RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "re");

		// DB에서 글 정보를 조회해와 목록화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setPageList(pageList);
		page.setHeader(header);
		page.setDivision(division);

		if (header != null && !header.equals("")) {
			// 말머리 검색 후 글 목록 화면 요청 시
			model.addAttribute("page", service.review_headerList(page));
			
		} else if (division != null && !division.equals("")) {
			model.addAttribute("page", service.review_divList(page));
			
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
			model.addAttribute("page", service.review_list(page));
		}

		return "review/list";
	}
}
