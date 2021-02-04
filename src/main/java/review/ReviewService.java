package review;

import common.PushVO;
import common.ScrapVO;

public interface ReviewService {
	ReviewPage review_list(ReviewPage page);			//리뷰 글 목록 조회
	ReviewPage review_headerList(ReviewPage page);		//해당 헤더 검색 후 불판 글 목록 조회
	ReviewPage review_divList(ReviewPage page);			//글 분류 조회
	
	int review_insert(ReviewVO vo);						//리뷰 글쓰기 저장
	
	int review_read(int review_no);						//리뷰 글 조회수 업데이트
	
	ReviewVO review_detail(int review_no);				//리뷰 상세글 조회
	
	PushVO review_pushList(PushVO vo);					//추천 리스트 조회
	boolean review_push(PushVO vo);						//리뷰 글 추천수 업데이트
	boolean review_push_cancel(PushVO vo);				//리뷰 글 추천 취소
	
	int review_update(ReviewVO vo);						//리뷰 글 변경사항 수정
	
	ScrapVO review_scrapList(ScrapVO vo);				//스크랩 리스트 조회
	boolean review_scrap(ScrapVO vo);					//리뷰 글 스크랩 업데이트
	boolean review_scrap_cancel(ScrapVO vo);			//리뷰 글 스크랩 취소
	
	int review_delete(int review_no);					//리뷰 글 삭제
}
