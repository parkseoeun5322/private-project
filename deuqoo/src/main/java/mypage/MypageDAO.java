package mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.BoardCommentPage;
import common.BoardCommentVO;
import common.ScrapPage;
import common.ScrapVO;
import member.MemberVO;

@Repository
public class MypageDAO implements MypageService {
	@Autowired private SqlSession sql;

	@Override
	public MemberVO mypage_info(String member_id) {
		return sql.selectOne("mypage.mapper.memberInfo", member_id);
	}

	@Override
	public ScrapPage mypage_scrap(ScrapPage page) {
		page.setTotalList((Integer)sql.selectOne("mypage.mapper.scrapTotal", page));
		List<ScrapVO> list = sql.selectList("mypage.mapper.scrapList", page);
		page.setList(list);
		return page;
	}

	@Override
	public BoardPage mypage_document(BoardPage page) {
		page.setTotalList((Integer)sql.selectOne("mypage.mapper.documentTotal", page));
		List<BoardVO> list = sql.selectList("mypage.mapper.documentList", page);
		page.setList(list);
		return page;
	}

	@Override
	public BoardCommentPage mypage_comment(BoardCommentPage page) {
		page.setTotalList((Integer)sql.selectOne("mypage.mapper.commentTotal", page));
		List<BoardCommentVO> list = sql.selectList("mypage.mapper.commentList", page);
		page.setList(list);
		return page;
	}

	@Override
	public int mypage_updateInfo(MemberVO vo) {
		return sql.update("mypage.mapper.updateInfo", vo);
	}

	@Override
	public int mypage_updatePw(MemberVO vo) {
		return sql.update("mypage.mapper.updatePw", vo);
	}

	@Override
	public int mypage_deleteInfo(String member_id) {
		return sql.delete("mypage.mapper.deleteInfo", member_id);
	}
}
