package com.mypro.deuqoo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.BoardCommentVO;
import common.CommonServiceImpl;
import common.PushVO;
import common.ScrapVO;
import drama.DramaBoardServiceImpl;
import member.MemberVO;
import review.ReviewServiceImpl;
import review.ReviewVO;
import shopping.ShoppingServiceImpl;

@Controller
public class CommonController {
	@Autowired CommonServiceImpl common_service;
	@Autowired ReviewServiceImpl review_service;
	@Autowired ShoppingServiceImpl shopping_service;
	@Autowired DramaBoardServiceImpl dramaboard_service;
	
	//대댓글 DB 저장
	@ResponseBody @RequestMapping(value= "/board/reply/regist", 
								  produces = "application/text; charset=utf-8")
	public String reply_regist(@RequestBody BoardCommentVO vo, HttpSession session) {
		MemberVO id = (MemberVO) session.getAttribute("login_info");
		vo.setComment_writer(id.getMember_id());	//작성자를 로그인한 아이디로 저장
		vo.setComment_reply("Y");
		
		// 닉네임 설정
		if(common_service.countWriter(vo) <= 0) {
			vo.setComment_nickname(common_service.selectMaxNickname(vo) + 1);
		} else {
			vo.setComment_nickname(common_service.selectNickname(vo));
		}
		
		return common_service.board_reply_regist(vo) > 0 ? "성공" : "실패";
	}
	
	// 댓글 수정 업데이트
	@RequestMapping("/comment_update")
	public String update(BoardCommentVO vo, Model model) {
		String page = "";
		
		common_service.comment_update(vo);
		
		if(vo.getComment_category().equals("리뷰")) {
			model.addAttribute("url", "detail.re");
			model.addAttribute("review_no", vo.getComment_bno());
			page = "review/redirect";
		} else if(vo.getComment_category().equals("상품")) {
			model.addAttribute("url", "detail.tv");
			model.addAttribute("shopping_no", vo.getComment_bno());
			page = "shopping/redirect";
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
	public String comment_list(@PathVariable int comment_bno, String board_category,
								String board_writer, Model model) {
		BoardCommentVO vo = new BoardCommentVO();
		vo.setComment_bno(comment_bno);
		vo.setComment_category(board_category);
		model.addAttribute("list", common_service.board_comment_list(vo));
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
		if(id != null) {
			vo.setComment_writer(id.getMember_id());		//작성자를 로그인한 아이디로 저장 
		} else {
			return 0;
		}
		
		// 닉네임 설정
		if(common_service.countWriter(vo) <= 0) {
			vo.setComment_nickname(common_service.selectMaxNickname(vo) + 1);
		} else {
			vo.setComment_nickname(common_service.selectNickname(vo));
		}
		
		return common_service.board_comment_regist(vo);
	} //comment_regist()
	
	//--------------------------------------------------------------
	
	//스크랩 취소
	@ResponseBody
	@RequestMapping("/scrap_cancel")
	public boolean scrap_cancel(int scrap_boardNo, String scrap_no, String scrap_category) {
		ScrapVO vo = new ScrapVO();
		vo.setScrap_no(Integer.parseInt(scrap_no));
		vo.setScrap_boardNo(scrap_boardNo);
		
		boolean result = false;
		if(scrap_category.equals("리뷰")) {
			result = review_service.review_scrap_cancel(vo);
		} else if(scrap_category.equals("상품")) {
			result = shopping_service.shopping_scrap_cancel(vo);
		} else if(scrap_category.equals("자료")) {
			result = dramaboard_service.dramaboard_scrap_cancel(vo);
		}
		
		return result;
	}	
	
	// 해당 글 스크랩
	@ResponseBody
	@RequestMapping("/scrap")
	public boolean scrap(int scrap_boardNo, String scrap_category, 
						 String scrap_title, HttpSession session) {
		ScrapVO vo = new ScrapVO();
		vo.setScrap_boardNo(scrap_boardNo);
		vo.setScrap_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
		vo.setScrap_title(scrap_title);
		vo.setScrap_category(scrap_category);
		
		boolean result = false;
		if(scrap_category.equals("리뷰")) {
			result =  review_service.review_scrap(vo);
		} else if(scrap_category.equals("상품")) {
			result =  shopping_service.shopping_scrap(vo);
		} else if(scrap_category.equals("자료")) {
			result = dramaboard_service.dramaboard_scrap(vo);
		}
		return result;
	}	
	
	// 글 추천 취소
	@ResponseBody
	@RequestMapping("/push_cancel")
	public boolean push_cancel(int push_boardNo, String push_no, String push_category) {
		PushVO vo = new PushVO();
		vo.setPush_no(Integer.parseInt(push_no));
		vo.setPush_boardNo(push_boardNo);
		
		boolean result = false;
		if(push_category.equals("리뷰")) {
			result =  review_service.review_push_cancel(vo);
		} else if(push_category.equals("상품")) {
			result = shopping_service.shopping_push_cancel(vo);
		} else if(push_category.equals("자료")) {
			result = dramaboard_service.dramaboard_push_cancel(vo);
		}
		return result;
	}
	
	
	// 글 추천 수 증가
	@ResponseBody
	@RequestMapping("/push")
	public boolean push(int push_no, String push_category, HttpSession session) {
		PushVO vo = new PushVO();
		vo.setPush_boardNo(push_no);
		vo.setPush_id( ((MemberVO) session.getAttribute("login_info")).getMember_id() );
		vo.setPush_category(push_category);
		
		boolean result = false;
		if(push_category.equals("리뷰")) {
			result =  review_service.review_push(vo);
		} else if(push_category.equals("상품")) {
			result = shopping_service.shopping_push(vo);
		} else if(push_category.equals("자료")) {
			result = dramaboard_service.dramaboard_push(vo);
		}
		return result;
		
	}
}
