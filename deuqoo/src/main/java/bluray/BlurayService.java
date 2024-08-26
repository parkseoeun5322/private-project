package bluray;

import common.PushVO;
import common.ScrapVO;

public interface BlurayService {
	BlurayPage bluray_list(BlurayPage page);		//글 목록 조회
	BlurayPage bluray_headerList(BlurayPage page);	//해당 헤더 검색 후 불판 글 목록 조회
	BlurayPage bluray_divList(BlurayPage page);		//글 분류 조회
	int bluray_comment_cnt(BlurayVO vo);			//게시글 마다 댓글 수
	
	int bluray_insert(BlurayVO vo);					//글 저장 처리
	int bluray_read(int bluray_no);					//글 조회수 증가
	BlurayVO bluray_detail(int bluray_no);			//상세글 조회
	
	PushVO bluray_pushList(PushVO vo);				//추천 리스트 조회
	boolean bluray_push(PushVO vo);					//글 추천수 업데이트
	boolean bluray_push_cancel(PushVO vo);			//글 추천 취소
	
	ScrapVO bluray_scrapList(ScrapVO vo);			//스크랩 리스트 조회
	boolean bluray_scrap(ScrapVO vo);				//글 스크랩 업데이트
	boolean bluray_scrap_cancel(ScrapVO vo);		//글 스크랩 취소
	
	int bluray_update(BlurayVO vo);					//글 수정 업데이트
	int bluray_delete(int bluray_no);				//글 삭제 처리


}
