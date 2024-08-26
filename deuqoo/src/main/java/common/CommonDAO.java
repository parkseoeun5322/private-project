package common;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bluray.BlurayVO;
import mypage.BoardPage;
import mypage.BoardVO;

@Repository
public class CommonDAO implements CommonServiceIF {
	@Autowired private SqlSession sql;
	
	@Override
	public int board_comment_regist(BoardCommentVO vo) {
		return sql.insert("common.mapper.comment_regist", vo);
	}

	@Override
	public List<BoardCommentVO> board_comment_list(BoardCommentVO vo) {
		sql.update("common.mapper.comment_rootUpdate", vo);
		return sql.selectList("common.mapper.comment_list", vo);
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

	@Override
	public int comment_delete(int comment_no) {
		return sql.delete("common.mapper.comment_delete", comment_no);
	}

	@Override
	public BoardPage all_search(BoardPage page) {
		page.setTotalList((Integer)sql.selectOne("common.mapper.allSearchTotal", page));
		List<BoardVO> list = sql.selectList("common.mapper.allSearchList", page);
		page.setList(list);
		return page;
	}

	@Override
	public int comment_cnt(BoardVO vo) {
		return sql.selectOne("common.mapper.comment_cnt", vo);
	}

	@Override
	public BoardPage push_sort(BoardPage page) {
		page.setTotalList((Integer)sql.selectOne("common.mapper.pushSortTotal", page));
		List<BoardVO> list = sql.selectList("common.mapper.pushSortList", page);
		page.setList(list);
		page.setTotalList(100);
		return page;
	}

	@Override
	public BoardPage popul_sort(BoardPage page) {
		page.setTotalList((Integer)sql.selectOne("common.mapper.pushSortTotal", page));
		List<BoardVO> list = sql.selectList("common.mapper.populSortList", page);
		page.setList(list);
		page.setTotalList(100);
		return page;
	}

}
