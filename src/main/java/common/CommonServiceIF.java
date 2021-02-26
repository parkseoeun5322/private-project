package common;

import java.util.List;

import mypage.BoardPage;
import mypage.BoardVO;

public interface CommonServiceIF {
	int board_comment_regist(BoardCommentVO vo);				//댓글 저장 처리
	List<BoardCommentVO> board_comment_list(BoardCommentVO vo);	//댓글 목록 조회
	
	int countWriter(BoardCommentVO vo);							//닉네임 설정
	int selectMaxNickname(BoardCommentVO vo);					//닉네임 설정
	int selectNickname(BoardCommentVO vo);						//닉네임 설정
	
	int comment_update(BoardCommentVO vo);						//댓글 수정
	
	int board_reply_regist(BoardCommentVO vo);					//대댓글 저장 처리
	
	int comment_delete(int comment_no);							//댓글 삭제
	
	BoardPage all_search(BoardPage page);						//전체 검색 리스트 조회
	BoardPage push_sort(BoardPage page);						//추천 수 리스트 조회
	BoardPage popul_sort(BoardPage page);						//인기 순 리스트 조회
	
	int comment_cnt(BoardVO vo);								//글 댓글수
	
	
	
}
