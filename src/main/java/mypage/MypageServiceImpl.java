package mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.BoardCommentPage;
import common.ScrapPage;
import common.ScrapVO;
import member.MemberVO;

@Service
public class MypageServiceImpl implements MypageService {
	@Autowired MypageDAO dao;

	@Override
	public MemberVO mypage_info(String member_id) {
		return dao.mypage_info(member_id);
	}

	@Override
	public ScrapPage mypage_scrap(ScrapPage page) {
		return dao.mypage_scrap(page);
	}

	@Override
	public BoardPage mypage_document(BoardPage page) {
		return dao.mypage_document(page);
	}

	@Override
	public BoardCommentPage mypage_comment(BoardCommentPage page) {
		return dao.mypage_comment(page);
	}
}
