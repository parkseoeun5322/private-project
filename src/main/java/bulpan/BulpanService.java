package bulpan;

public interface BulpanService {
	int bulpan_insert(BulpanVO vo);					//불판 글쓰기 저장
	BulpanPage bulpan_list(BulpanPage page);		//불판 글 목록 조회
	int bulpan_read(int bulpan_no);					//불판 조회수 증가
	BulpanPage bulpan_headerList(BulpanPage page);	//해당 헤더 검색 후 불판 글 목록 조회
	BulpanVO bulpan_detail(int bulpan_no);			//글 수정을 위해 DB에 글 정보 조회
	int bulpan_update(BulpanVO vo);					//글 변경사항 저장
	int bulpan_delete(int bulpan_no);				//글 삭제
}
