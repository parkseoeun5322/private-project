package com.mypro.deuqoo;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bulpan.BulpanPage;
import bulpan.BulpanServiceImpl;
import bulpan.BulpanVO;
import bulpan.ChatServiceImpl;
import bulpan.ChatVO;
import common.CommonService;
import lombok.extern.slf4j.Slf4j;
import member.MemberVO;

@Slf4j
@Controller
public class BulpanController {
	@Autowired private ChatServiceImpl chatService;
	@Autowired private BulpanServiceImpl bulService;
	@Autowired private BulpanPage page;
	@Autowired private CommonService common;

	/*
	 * // 채팅 정보 DB 저장
	 * 
	 * @MessageMapping("/hello/{chatting_roomNo}")
	 * 
	 * @SendTo("/subscribe/chat/{chatting_roomNo}") public void
	 * broadcasting(@DestinationVariable int chatting_roomNo, Message<ChatVO> vo) {
	 * System.out.println("들어옴"); System.out.println(chatting_roomNo);
	 * System.out.println(vo);
	 * 
	 * }
	 */

		
	// 채팅 정보 DB 저장
	@MessageMapping("/hello/{chatting_roomNo}")
	@SendTo("/subscribe/chat/{chatting_roomNo}") 
	public ChatVO broadcasting(ChatVO vo) {
		System.out.println("채팅 정보 DB 저장 메소드 들어옴");
		
		// 닉네임 설정
		if(chatService.countWriter(vo) <= 0) {
			vo.setChatting_nickName(chatService.selectMaxNickname(vo) + 1);
			System.out.println("드덕 " + vo.getChatting_nickName());
		} else {
			vo.setChatting_nickName(chatService.selectNickname(vo));
			System.out.println("드덕 " + vo.getChatting_nickName());
		}

		// 난수 생성하여 고유 아이디 설정
		vo.setChatting_id(UUID.randomUUID().toString());
		
		Map<String, Object> map = new HashMap<>();
		map.put("vo", vo);
		
		vo.setChatting_time(new Date(System.currentTimeMillis()));
		
		chatService.insertChat(vo);		// 채팅 정보 DB 저장
		
		return vo;
	}
		 
	// 채팅창으로 입장
	@RequestMapping("/chat.bu")
	public ModelAndView enterChat(@RequestParam int chatting_roomNo, ModelAndView mav, HttpSession session) {
		bulService.bulpan_read(chatting_roomNo);	//조회수 증가
		
		List<ChatVO> firstList = chatService.selectFirstChatList(chatting_roomNo);
		mav.addObject("chatting_roomNo", chatting_roomNo);
		mav.addObject("firstList", firstList);
		mav.setViewName("bulpan/chat/chatting");

		return mav;
	}
	
	//--------------------------------------------------------------------------
	//불판 글 삭제 처리 요청
	@RequestMapping("/delete.bu")
	public String delete(int bulpan_no, Model model) {
		bulService.bulpan_delete(bulpan_no);
		
		return "redirect:list.bu";
	}
	
	//불판 글 변경사항 수정 요청
	@RequestMapping("/update.bu")
	public String update(BulpanVO vo, Model model) {
		bulService.bulpan_update(vo);
		
		//model.addAttribute("url", "list.bu");
		//model.addAttribute("id", vo.getBulpan_no());
		
		//return "bulpan/redirect";
		return "redirect:list.bu";
	}
	
	//불판 글 수정 화면 요청
	@RequestMapping("/modify.bu")
	public String modify(int bulpan_no, Model model) {
		//선택한 방명록 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", bulService.bulpan_detail(bulpan_no));
		
		return "bulpan/modify";
	}

	//불판 글 저장 처리 요청
	@RequestMapping("/insert.bu")
	public String insert(BulpanVO vo, HttpSession session) {
		vo.setBulpan_writer(((MemberVO) session.getAttribute("login_info")).getMember_id());
		bulService.bulpan_insert(vo);

		// 불판 글 목록 화면으로 이동
		return "redirect:list.bu";
	}

	// 불판 글쓰기 화면 요청
	@RequestMapping("/new.bu")
	public String bulpan() {

		return "bulpan/new";
	}

	// 불판 글 목록 화면 요청
	@RequestMapping("/list.bu")
	public String list(Model model, HttpSession session, 
						String search, String keyword, String header,
						@RequestParam(defaultValue = "10") int pageList, 
						@RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "bu");
		
		// DB에서 글 정보를 조회해와 목록화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setPageList(pageList);
		page.setHeader(header);
		
		if (header == null || header.equals("")) {
			// 보통 글 목록 화면 요청 시 & 검색 후 글 목록 화면 요청 시
			model.addAttribute("page", bulService.bulpan_list(page));
		} else {
			// 말머리 검색 후 글 목록 화면 요청 시
			model.addAttribute("page", bulService.bulpan_headerList(page));
		}
		
		return "bulpan/list";
	}

}
