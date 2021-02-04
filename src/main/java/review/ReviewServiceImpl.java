package review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.PushVO;
import common.ScrapVO;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired ReviewDAO dao;
	
	@Override
	public ReviewPage review_list(ReviewPage page) {
		return dao.review_list(page);
	}

	@Override
	public ReviewPage review_headerList(ReviewPage page) {
		return dao.review_headerList(page);
	}

	@Override
	public int review_insert(ReviewVO vo) {
		return dao.review_insert(vo);
	}

	@Override
	public int review_read(int review_no) {
		return dao.review_read(review_no);
	}

	@Override
	public ReviewVO review_detail(int review_no) {
		return dao.review_detail(review_no);
	}

	@Override
	public PushVO review_pushList(PushVO vo) {
		return dao.review_pushList(vo);
	}

	@Override
	public boolean review_push(PushVO vo) {
		return dao.review_push(vo);
	}

	@Override
	public boolean review_push_cancel(PushVO vo) {
		return dao.review_push_cancel(vo);
	}

	@Override
	public int review_update(ReviewVO vo) {
		return dao.review_update(vo);
	}
	
	@Override
	public ScrapVO review_scrapList(ScrapVO vo) {
		return dao.review_scrapList(vo);
	}

	@Override
	public boolean review_scrap(ScrapVO vo) {
		return dao.review_scrap(vo);
	}

	@Override
	public boolean review_scrap_cancel(ScrapVO vo) {
		return dao.review_scrap_cancel(vo);
	}

	@Override
	public int review_delete(int review_no) {
		return dao.review_delete(review_no);
	}

}
