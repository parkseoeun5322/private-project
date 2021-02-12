package common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommonServiceImpl implements CommonServiceIF {
	@Autowired CommonDAO dao;
	
	@Override
	public int board_comment_regist(BoardCommentVO vo) {
		return dao.board_comment_regist(vo);
	}

	@Override
	public List<BoardCommentVO> board_comment_list(int comment_bno) {
		return dao.board_comment_list(comment_bno);
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

}
