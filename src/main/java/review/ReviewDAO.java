package review;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bulpan.BulpanVO;
import common.PushVO;
import common.ScrapVO;

@Repository
public class ReviewDAO implements ReviewService {
	@Autowired private SqlSession sql;
	
	@Override
	public ReviewPage review_list(ReviewPage page) {
		page.setTotalList((Integer)sql.selectOne("review.mapper.total", page));
		List<ReviewVO> list = sql.selectList("review.mapper.list", page);
		page.setList(list);
		return page;
	}

	@Override
	public ReviewPage review_headerList(ReviewPage page) {
		page.setTotalList((Integer)sql.selectOne("review.mapper.headerTotal", page));
		List<ReviewVO> list = sql.selectList("review.mapper.headerList", page);
		page.setList(list);
		return page;
	}

	@Override
	public int review_insert(ReviewVO vo) {
		return sql.insert("review.mapper.insert", vo);
	}

	@Override
	public int review_read(int review_no) {
		return sql.update("review.mapper.read", review_no);
	}

	@Override
	public ReviewVO review_detail(int review_no) {
		return sql.selectOne("review.mapper.detail", review_no);
	}
	
	@Override
	public PushVO review_pushList(PushVO vo) {
		return sql.selectOne("review.mapper.pushList", vo);
	}

	@Override
	public boolean review_push(PushVO vo) {
		boolean result = false;
		if ( sql.insert("review.mapper.pushInsert", vo) > 0 &&
			 sql.update("review.mapper.push", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public boolean review_push_cancel(PushVO vo) {
		boolean result = false;
		if ( sql.delete("review.mapper.pushDelete", vo) > 0 &&
			 sql.update("review.mapper.pushCancel", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public int review_update(ReviewVO vo) {
		return sql.update("review.mapper.update", vo);
	}
	
	@Override
	public ScrapVO review_scrapList(ScrapVO vo) {
		return sql.selectOne("review.mapper.scrapList", vo);
	}

	@Override
	public boolean review_scrap(ScrapVO vo) {
		boolean result = false;
		if ( sql.insert("review.mapper.scrapInsert", vo) > 0 &&
			 sql.update("review.mapper.scrap", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public boolean review_scrap_cancel(ScrapVO vo) {
		boolean result = false;
		if ( sql.insert("review.mapper.scrapDelete", vo) > 0 &&
			 sql.update("review.mapper.scrapCancel", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public int review_delete(int review_no) {
		return sql.delete("review.mapper.delete", review_no);
	}

	@Override
	public ReviewPage review_divList(ReviewPage page) {
		page.setTotalList((Integer)sql.selectOne("review.mapper.divTotal", page));
		List<ReviewVO> list = sql.selectList("review.mapper.divList", page);
		page.setList(list);
		return page;
	}


}
