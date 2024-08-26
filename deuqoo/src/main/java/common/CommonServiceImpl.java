package common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mypage.BoardPage;
import mypage.BoardVO;

@Service
public class CommonServiceImpl implements CommonServiceIF {
	@Autowired CommonDAO dao;
	
	@Override
	public int board_comment_regist(BoardCommentVO vo) {
		return dao.board_comment_regist(vo);
	}

	@Override
	public List<BoardCommentVO> board_comment_list(BoardCommentVO vo) {
		return dao.board_comment_list(vo);
	}

	@Override
	public int countWriter(BoardCommentVO vo) {
		return dao.countWriter(vo);
	}

	@Override
	public int selectMaxNickname(BoardCommentVO vo) {
		return dao.selectMaxNickname(vo);
	}

	@Override
	public int selectNickname(BoardCommentVO vo) {
		return dao.selectNickname(vo);
	}

	@Override
	public int comment_update(BoardCommentVO vo) {
		return dao.comment_update(vo);
	}

	@Override
	public int board_reply_regist(BoardCommentVO vo) {
		return dao.board_reply_regist(vo);
	}

	@Override
	public int comment_delete(int comment_no) {
		return dao.comment_delete(comment_no);
	}

	@Override
	public BoardPage all_search(BoardPage page) {
		return dao.all_search(page);
	}

	@Override
	public int comment_cnt(BoardVO vo) {
		return dao.comment_cnt(vo);
	}

	@Override
	public BoardPage push_sort(BoardPage page) {
		return dao.push_sort(page);
	}

	@Override
	public BoardPage popul_sort(BoardPage page) {
		return dao.popul_sort(page);
	}

}
