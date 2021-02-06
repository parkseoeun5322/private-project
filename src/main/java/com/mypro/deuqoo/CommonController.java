package com.mypro.deuqoo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.BoardCommentVO;
import common.CommonServiceImpl;
import member.MemberVO;

@Controller
public class CommonController {
	@Autowired CommonServiceImpl service;
	
	// 댓글 수정 업데이터
	@RequestMapping("/comment_update")
	public String update(BoardCommentVO vo, Model model) {
		String page = "";
		
		service.comment_update(vo);
		
		if(vo.getComment_category().equals("리뷰")) {
			model.addAttribute("url", "detail.re");
			model.addAttribute("review_no", vo.getComment_bno());
			page = "review/redirect";
		}
		
		return page;
	}
	
	
	//댓글 수정화면 요청
	@RequestMapping("/comment_modify")
	public String modify(int comment_no, int comment_bno, String comment_content, 
						 String comment_category, Model model) {
		model.addAttribute("comment_no", comment_no);
		model.addAttribute("comment_bno", comment_bno);
		model.addAttribute("comment_content", comment_content);
		model.addAttribute("comment_category", comment_category);
		
		return "common/comment_modify";
	}
	
	//댓글 목록화면 조회
	@RequestMapping("/board/comment/{comment_bno}")
	public String comment_list(@PathVariable int comment_bno, String board_writer, Model model) {
		model.addAttribute("list", service.board_comment_list(comment_bno));
		model.addAttribute("board_writer", board_writer);
		
		//model.addAttribute("crlf", "\r\n");
		//model.addAttribute("lf", "\n");
		
		return "common/comment/comment_list";
	} //comment_list()
	
	// 방명록 댓글 저장 처리
	@ResponseBody @RequestMapping("/board/comment/regist")
	public int comment_regist(BoardCommentVO vo, HttpSession session) {
		//화면에서 입력한 정보를 DB에 저장한 후 ajax쪽으로 돌아간다.
		MemberVO id = (MemberVO) session.getAttribute("login_info");
		vo.setComment_writer(id.getMember_id());		//작성자를 로그인한 아이디로 저장 
		
		// 닉네임 설정
		if(service.countWriter(vo) <= 0) {
			vo.setComment_nickname(service.selectMaxNickname(vo) + 1);
		} else {
			vo.setComment_nickname(service.selectNickname(vo));
		}
		
		return service.board_comment_regist(vo);
	} //comment_regist()
}
