package com.mypro.deuqoo;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import bluray.BlurayPage;
import bluray.BlurayServiceImpl;
import bluray.BlurayVO;
import member.MemberVO;
import mypage.BoardPage;
import mypage.MypageServiceImpl;
import common.CommonService;
import common.PushVO;
import common.ScrapVO;

@Controller
public class BlurayController {
	@Autowired BlurayPage page;
	@Autowired BlurayServiceImpl service;
	@Autowired CommonService common;
	
	@Autowired MypageServiceImpl myservice;
	@Autowired BoardPage bpage;
	
	//글 삭제처리 요청
	@RequestMapping("/delete.bl")
	public String delete(int bluray_no, String myPage, 
						 HttpSession session, Model model) {
		//선택한 방명록 글을 DB에서 삭제한 후 목록화면으로 연결
		service.bluray_delete(bluray_no);
		String member_id = ((MemberVO)session.getAttribute("login_info")).getMember_id();
		
		// 마이페이지에서 상세 페이지로 넘어왔을 경우
		if(myPage != null) {
			model.addAttribute("url", "document.my");
			model.addAttribute("member_id", member_id);
		} else {
			model.addAttribute("page", page);
			model.addAttribute("url", "list.bl");
		}
		
		return "bluray/redirect";
	}
	
	//글 변경사항 수정 요청
	@RequestMapping("/update.bl")
	public String update(BlurayVO vo, Model model) {
		vo.setBluray_content(common.videoUrl(vo.getBluray_content()));
		// → 동영상 url 처리
		
		service.bluray_update(vo);
		// → 업데이트 처리
		
		model.addAttribute("url", "detail.bl");
		model.addAttribute("bluray_no", vo.getBluray_no());
		
		return "bluray/redirect";
	}
	
	// 글 수정화면 요청
	@RequestMapping("/modify.bl")
	public String modify(int bluray_no, Model model) {
		//선택한 방명록 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", service.bluray_detail(bluray_no));
		model.addAttribute("less", "&lt;");
		model.addAttribute("greater", "&gt;");
		
		return "bluray/modify";
	}
	
	// 글 상세 정보 조회
	@RequestMapping("/detail.bl")
	public String detail(@RequestParam int bluray_no, String returnList, String myPage, 
						Model model, HttpSession session) {
		service.bluray_read(bluray_no);		//조회수 증가
				
		PushVO pvo = new PushVO();
		ScrapVO svo = new ScrapVO();
				
		if(session.getAttribute("login_info") != null) {
			// 해당 글 추천 정보 받아오기
			pvo.setPush_boardNo(bluray_no);
			pvo.setPush_category("블레");
			pvo.setPush_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
			model.addAttribute("push", service.bluray_pushList(pvo));
			
			// 해당 글 스크랩 정보 받아오기
			svo.setScrap_boardNo(bluray_no);
			svo.setScrap_category("블레");
			svo.setScrap_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
			model.addAttribute("scrap", service.bluray_scrapList(svo));
		}
		
		// list 메소드를 거치지 않고 detail로 넘어온 경우 curPage를 1로 초기화함으로써
		// page.jsp에 오류가 발생하지 않도록 한다.
		if(returnList != null) {
			page.setCurPage(1);
		}
		
		//선택한 방명록 글 정보를 DB에서 조회해와 상세화면에 출력
		model.addAttribute("vo", service.bluray_detail(bluray_no));
		model.addAttribute("less", "&lt;");
		model.addAttribute("greater", "&gt;");
		model.addAttribute("page", page);
		model.addAttribute("myPage", myPage);
		
		return "bluray/detail";
	}
	
	//글 저장 처리 요청
	@RequestMapping("/insert.bl")
	public String insert(BlurayVO vo, HttpSession session) {
		vo.setBluray_writer(((MemberVO) session.getAttribute("login_info")).getMember_id());
		vo.setBluray_content(common.videoUrl(vo.getBluray_content()));
		service.bluray_insert(vo);

		// 불판 글 목록 화면으로 이동
		return "redirect:list.bl";
	}
	
	//글 쓰기 화면 요청
	@RequestMapping("/new.bl")
	public String bulpan() {

		return "bluray/new";
	}
	
	//글 목록 화면 요청
	@RequestMapping("/list.bl")
	public String list(HttpSession session, Model model, String search, 
						String keyword, String header, String division,
						@RequestParam(defaultValue = "10") int pageList, 
						@RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "bl");
		
		BlurayPage list = null;

		// DB에서 글 정보를 조회해와 목록화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setPageList(pageList);
		page.setHeader(header);
		page.setDivision(division);

		if (header != null && !header.equals("")) {
			// 말머리 검색 후 글 목록 화면 요청 시
			list = service.bluray_headerList(page);
			
		} else if (division != null && !division.equals("")) {
			list = service.bluray_divList(page);
			
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
			list = service.bluray_list(page);
		}
		
		model.addAttribute("page", list);
		
		// 댓글 수 구하기
		List<BlurayVO> vo_list = list.getList();
		for (BlurayVO vo: vo_list) {
			vo.setBluray_commentcnt(service.bluray_comment_cnt(vo));
		}
		
		return "bluray/list";
	} //list()
}
