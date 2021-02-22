package mypage;

import common.BoardCommentPage;
import common.ScrapPage;
import member.MemberVO;

public interface MypageService {
	MemberVO mypage_info(String member_id);
	ScrapPage mypage_scrap(ScrapPage page);
	BoardPage mypage_document(BoardPage page);
	BoardCommentPage mypage_comment(BoardCommentPage page);
}
