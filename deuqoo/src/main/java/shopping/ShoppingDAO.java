package shopping;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.PushVO;
import common.ScrapVO;
import review.ReviewVO;

@Repository
public class ShoppingDAO implements ShoppingService {
	@Autowired private SqlSession sql;
	
	@Override
	public ShoppingPage shopping_list(ShoppingPage page) {
		page.setTotalList((Integer)sql.selectOne("shopping.mapper.total", page));
		List<ShoppingVO> list = sql.selectList("shopping.mapper.list", page);
		page.setList(list);
		return page;
	}

	@Override
	public ShoppingPage shopping_headerList(ShoppingPage page) {
		page.setTotalList((Integer)sql.selectOne("shopping.mapper.headerTotal", page));
		List<ShoppingVO> list = sql.selectList("shopping.mapper.headerList", page);
		page.setList(list);
		return page;
	}

	@Override
	public ShoppingPage shopping_divList(ShoppingPage page) {
		page.setTotalList((Integer)sql.selectOne("shopping.mapper.divTotal", page));
		List<ShoppingVO> list = sql.selectList("shopping.mapper.divList", page);
		page.setList(list);
		return page;
	}

	@Override
	public int shopping_comment_cnt(ShoppingVO vo) {
		return sql.selectOne("shopping.mapper.comment_cnt", vo);
	}

	@Override
	public int shopping_insert(ShoppingVO vo) {
		return sql.insert("shopping.mapper.insert", vo);
	}

	@Override
	public int shopping_read(int shopping_no) {
		return sql.update("shopping.mapper.read", shopping_no);
	}

	@Override
	public ShoppingVO shopping_detail(int shopping_no) {
		return sql.selectOne("shopping.mapper.detail", shopping_no);
	}

	@Override
	public PushVO shopping_pushList(PushVO vo) {
		return sql.selectOne("shopping.mapper.pushList", vo);
	}

	@Override
	public boolean shopping_push(PushVO vo) {
		boolean result = false;
		if ( sql.insert("shopping.mapper.pushInsert", vo) > 0 &&
			 sql.update("shopping.mapper.push", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public boolean shopping_push_cancel(PushVO vo) {
		boolean result = false;
		if ( sql.delete("shopping.mapper.pushDelete", vo) > 0 &&
			 sql.update("shopping.mapper.pushCancel", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public ScrapVO shopping_scrapList(ScrapVO vo) {
		return sql.selectOne("shopping.mapper.scrapList", vo);
	}

	@Override
	public boolean shopping_scrap(ScrapVO vo) {
		boolean result = false;
		if ( sql.insert("shopping.mapper.scrapInsert", vo) > 0 &&
			 sql.update("shopping.mapper.scrap", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public boolean shopping_scrap_cancel(ScrapVO vo) {
		boolean result = false;
		if ( sql.insert("shopping.mapper.scrapDelete", vo) > 0 &&
			 sql.update("shopping.mapper.scrapCancel", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public int shopping_update(ShoppingVO vo) {
		return sql.update("shopping.mapper.update", vo);
	}

	@Override
	public int shopping_delete(int shopping_no) {
		return sql.delete("shopping.mapper.delete", shopping_no);
	}

}
