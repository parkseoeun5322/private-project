package com.mypro.deuqoo;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import common.CommonService;
import common.PushVO;
import common.ScrapVO;
import drama.DramaBoardPage;
import drama.DramaBoardServiceImpl;
import drama.DramaBoardVO;
import member.MemberVO;

@Controller
public class DramaController {
	@Autowired CommonService common;
	@Autowired DramaBoardServiceImpl service;
	@Autowired DramaBoardPage page;
	
	//글 삭제처리 요청
	@RequestMapping("/delete.info")
	public String delete(int drama_board_no, String myPage, 
			 			HttpSession session, Model model) {
		//선택한 방명록 글을 DB에서 삭제한 후 목록화면으로 연결
		service.dramaboard_delete(drama_board_no);
		String member_id = ((MemberVO)session.getAttribute("login_info")).getMember_id();
		
		// 마이페이지에서 상세 페이지로 넘어왔을 경우
		if(myPage != null) {
			model.addAttribute("url", "document.my");
			model.addAttribute("member_id", member_id);
		} else {
			model.addAttribute("page", page);
			model.addAttribute("url", "list.info");
		}
		
		return "drama/redirect";
	}
	
	//글 변경사항 수정 요청
	@RequestMapping("/update.info")
	public String update(DramaBoardVO vo, Model model) {
		System.out.println(vo.getDrama_board_content());
		vo.setDrama_board_content(common.videoUrl(vo.getDrama_board_content()));
		// → 동영상 url 처리
		
		service.dramaboard_update(vo);
		// → 업데이트 처리
		
		model.addAttribute("url", "detail.info");
		model.addAttribute("drama_board_no", vo.getDrama_board_no());
		
		return "drama/redirect";
	}
	
	// 글 수정화면 요청
	@RequestMapping("/modify.info")
	public String modify(int drama_board_no, Model model) {
		//선택한 방명록 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", service.dramaboard_detail(drama_board_no));
		model.addAttribute("less", "&lt;");
		model.addAttribute("greater", "&gt;");
		
		return "drama/info_modify";
	}
	
	// 글 상세 정보 조회
	@RequestMapping("/detail.info")
	public String detail(@RequestParam int drama_board_no, String returnList, String myPage,
						Model model, HttpSession session) {
		service.dramaboard_read(drama_board_no);		//조회수 증가
		
		PushVO pvo = new PushVO();
		ScrapVO svo = new ScrapVO();
		
		if(session.getAttribute("login_info") != null) {
			// 해당 글 추천 정보 받아오기
			pvo.setPush_boardNo(drama_board_no);
			pvo.setPush_category("자료");
			pvo.setPush_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
			model.addAttribute("push", service.dramaboard_pushList(pvo));
			
			// 해당 글 스크랩 정보 받아오기
			svo.setScrap_boardNo(drama_board_no);
			svo.setScrap_category("자료");
			svo.setScrap_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
			model.addAttribute("scrap", service.dramaboard_scrapList(svo));
		}
		
		//선택한 방명록 글 정보를 DB에서 조회해와 상세화면에 출력
		DramaBoardVO vo = new DramaBoardVO();
		vo = service.dramaboard_detail(drama_board_no);
		
		// list 메소드를 거치지 않고 detail로 넘어온 경우 curPage를 1로 초기화함으로써
		// page.jsp에 오류가 발생하지 않도록 한다.
		if(returnList != null) {
			page.setCurPage(1);
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("less", "&lt;");
		model.addAttribute("greater", "&gt;");
		model.addAttribute("page", page);
		model.addAttribute("myPage", myPage);
		
		return "drama/info_detail";
	}
	
	//글 저장 처리 요청
	@RequestMapping("/insert.info")
	public String insert(DramaBoardVO vo, HttpSession session) {
		vo.setDrama_board_writer( ( (MemberVO) session.getAttribute("login_info")).getMember_id() );
		vo.setDrama_board_content(common.videoUrl(vo.getDrama_board_content()));
		service.dramaboard_insert(vo);

		//글 목록 화면으로 이동
		return "redirect:list.info";
	}
	
	// 글쓰기 화면 요청
	@RequestMapping("/new.info")
	public String bulpan() {

		return "drama/info_new";
	}
	
	// 글 목록 화면 요청
	@RequestMapping("/list.info")
	public String list(Model model, HttpSession session, String search, 
						String keyword, String header, String division,
						@RequestParam(defaultValue = "10") int pageList, 
						@RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "dr");
		
		DramaBoardPage list;

		// DB에서 글 정보를 조회해와 목록화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setPageList(pageList);
		page.setHeader(header);
		page.setDivision(division);

		if (header != null && !header.equals("")) {
			// 말머리 검색 후 글 목록 화면 요청 시
			list = service.dramaboard_headerList(page);
			
		} else if (division != null && !division.equals("")) {
			list = service.dramaboard_divList(page);
			
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
			list = service.dramaboard_list(page);
		}
		
		model.addAttribute("page", list);
		
		// 댓글 수 구하기
		List<DramaBoardVO> vo_list = list.getList();
		for (DramaBoardVO vo: vo_list) {
			vo.setDrama_board_commentcnt(service.dramaboard_comment_cnt(vo));
		}

		return "drama/info_list";
	}
	
	// 방영중 드라마 정보 화면 출력
	@RequestMapping("/list.dr")
	public String list_ing(HttpSession session, Model model) {
		session.setAttribute("category", "dr");
		
		String ingUrl = "?where=nexearch&sm=tab_etc&query=드라마";
		common.drama_crawling(model, ingUrl);
		
		return "drama/drama_list";
	}
	
	// 방영예정 드라마 정보 화면 출력
	@RequestMapping("/list.so")
	public String list_soon(HttpSession session, Model model) {
		session.setAttribute("category", "dr");
		
		String soonUrl = "?where=nexearch&sm=tab_etc&query=방영예정한국드라마";
		common.drama_crawling(model, soonUrl);
		
		return "drama/drama_list";
	}
}
