package shopping;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.PushVO;
import common.ScrapVO;


@Service
public class ShoppingServiceImpl implements ShoppingService {
	@Autowired ShoppingDAO dao;
	
	@Override
	public ShoppingPage shopping_list(ShoppingPage page) {
		return dao.shopping_list(page);
	}

	@Override
	public ShoppingPage shopping_headerList(ShoppingPage page) {
		return dao.shopping_headerList(page);
	}

	@Override
	public ShoppingPage shopping_divList(ShoppingPage page) {
		return dao.shopping_divList(page);
	}

	@Override
	public int shopping_comment_cnt(ShoppingVO vo) {
		return dao.shopping_comment_cnt(vo);
	}

	@Override
	public int shopping_insert(ShoppingVO vo) {
		return dao.shopping_insert(vo);
	}

	@Override
	public int shopping_read(int shopping_no) {
		return dao.shopping_read(shopping_no);
	}

	@Override
	public ShoppingVO shopping_detail(int shopping_no) {
		return dao.shopping_detail(shopping_no);
	}

	@Override
	public PushVO shopping_pushList(PushVO vo) {
		return dao.shopping_pushList(vo);
	}

	@Override
	public boolean shopping_push(PushVO vo) {
		return dao.shopping_push(vo);
	}

	@Override
	public boolean shopping_push_cancel(PushVO vo) {
		return dao.shopping_push_cancel(vo);
	}

	@Override
	public ScrapVO shopping_scrapList(ScrapVO vo) {
		return dao.shopping_scrapList(vo);
	}

	@Override
	public boolean shopping_scrap(ScrapVO vo) {
		return dao.shopping_scrap(vo);
	}

	@Override
	public boolean shopping_scrap_cancel(ScrapVO vo) {
		return dao.shopping_scrap_cancel(vo);
	}

	@Override
	public int shopping_update(ShoppingVO vo) {
		return dao.shopping_update(vo);
	}

	@Override
	public int shopping_delete(int shopping_no) {
		return dao.shopping_delete(shopping_no);
	}

}
