package shopping;

import common.PushVO;
import common.ScrapVO;

public interface ShoppingService {
	ShoppingPage shopping_list(ShoppingPage page);			//글 목록 조회
	ShoppingPage shopping_headerList(ShoppingPage page);	//해당 헤더 검색 후 불판 글 목록 조회
	ShoppingPage shopping_divList(ShoppingPage page);		//글 분류 조회
	int shopping_comment_cnt(ShoppingVO vo);				//게시글 마다 댓글 수
	
	int shopping_insert(ShoppingVO vo);						//글쓰기 저장
	
	int shopping_read(int shopping_no);						//글 조회수 업데이트
	ShoppingVO shopping_detail(int shopping_no);				//상세글 조회
	
	PushVO shopping_pushList(PushVO vo);					//추천 리스트 조회
	boolean shopping_push(PushVO vo);						//글 추천수 업데이트
	boolean shopping_push_cancel(PushVO vo);				//글 추천 취소
	
	ScrapVO shopping_scrapList(ScrapVO vo);					//스크랩 리스트 조회
	boolean shopping_scrap(ScrapVO vo);						//글 스크랩 업데이트
	boolean shopping_scrap_cancel(ScrapVO vo);				//글 스크랩 취소
	
	int shopping_update(ShoppingVO vo);						//글 수정 업데이트
	int shopping_delete(int shopping_no);					//글 삭제 처리
}
