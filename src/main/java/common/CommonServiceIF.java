package common;

import java.util.List;

public interface CommonServiceIF {
	int board_comment_regist(BoardCommentVO vo);				//댓글 저장 처리
	List<BoardCommentVO> board_comment_list(int comment_bno);	//댓글 목록 조회
	
	int countWriter(BoardCommentVO vo);							//닉네임 설정
	int selectMaxNickname(BoardCommentVO vo);					//닉네임 설정
	int selectNickname(BoardCommentVO vo);						//닉네임 설정
	
	int comment_update(BoardCommentVO vo);						//댓글 수정
	
}
