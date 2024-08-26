package drama;

import common.PushVO;
import common.ScrapVO;

public interface DramaBoardService {
	DramaBoardPage dramaboard_list(DramaBoardPage page);			//글 목록 조회
	DramaBoardPage dramaboard_headerList(DramaBoardPage page);		//해당 헤더 검색 후 불판 글 목록 조회
	DramaBoardPage dramaboard_divList(DramaBoardPage page);			//글 분류 조회
	int dramaboard_comment_cnt(DramaBoardVO vo);					//게시글 마다 댓글 수
	
	int dramaboard_insert(DramaBoardVO vo);							//글 저장 처리
	
	int dramaboard_read(int drama_board_no);						//글 조회수 증가
	DramaBoardVO dramaboard_detail(int drama_board_no);				//상세글 조회
	
	PushVO dramaboard_pushList(PushVO vo);							//추천 리스트 조회
	boolean dramaboard_push(PushVO vo);								//글 추천수 업데이트
	boolean dramaboard_push_cancel(PushVO vo);						//글 추천 취소
	
	ScrapVO dramaboard_scrapList(ScrapVO vo);						//스크랩 리스트 조회
	boolean dramaboard_scrap(ScrapVO vo);							//글 스크랩 업데이트
	boolean dramaboard_scrap_cancel(ScrapVO vo);					//글 스크랩 취소
	
	int dramaboard_update(DramaBoardVO vo);							//글 수정 업데이트
	int dramaboard_delete(int drama_board_no);						//글 삭제 처리
	
}
