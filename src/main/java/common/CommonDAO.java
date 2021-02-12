package common;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDAO implements CommonServiceIF {
	@Autowired private SqlSession sql;
	
	@Override
	public int board_comment_regist(BoardCommentVO vo) {
		return sql.insert("common.mapper.comment_regist", vo);
	}

	@Override
	public List<BoardCommentVO> board_comment_list(int comment_bno) {
		sql.update("common.mapper.comment_rootUpdate", comment_bno);
		return sql.selectList("common.mapper.comment_list", comment_bno);
	}

	@Override
	public int countWriter(BoardCommentVO vo) {
		return sql.selectOne("common.mapper.countWriter", vo);
	}

	@Override
	public int selectMaxNickname(BoardCommentVO vo) {
		return sql.selectOne("common.mapper.selectMaxNickname", vo);
	}

	@Override
	public int selectNickname(BoardCommentVO vo) {
		return sql.selectOne("common.mapper.selectNickname", vo);
	}

	@Override
	public int comment_update(BoardCommentVO vo) {
		return sql.update("common.mapper.comment_update", vo);
	}

	@Override
	public int board_reply_regist(BoardCommentVO vo) {
		return sql.insert("common.mapper.reply_regist", vo);
	}

}
