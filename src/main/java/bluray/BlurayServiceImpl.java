package bluray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.PushVO;
import common.ScrapVO;

@Service
public class BlurayServiceImpl implements BlurayService {
	@Autowired BlurayDAO dao;
	
	@Override
	public BlurayPage bluray_list(BlurayPage page) {
		return dao.bluray_list(page);
	}

	@Override
	public BlurayPage bluray_headerList(BlurayPage page) {
		return dao.bluray_headerList(page);
	}

	@Override
	public BlurayPage bluray_divList(BlurayPage page) {
		return dao.bluray_divList(page);
	}

	@Override
	public int bluray_comment_cnt(BlurayVO vo) {
		return dao.bluray_comment_cnt(vo);
	}

	@Override
	public int bluray_insert(BlurayVO vo) {
		return dao.bluray_insert(vo);
	}

	@Override
	public int bluray_read(int bluray_no) {
		return dao.bluray_read(bluray_no);
	}

	@Override
	public BlurayVO bluray_detail(int bluray_no) {
		return dao.bluray_detail(bluray_no);
	}

	@Override
	public PushVO bluray_pushList(PushVO vo) {
		return dao.bluray_pushList(vo);
	}

	@Override
	public boolean bluray_push(PushVO vo) {
		return dao.bluray_push(vo);
	}

	@Override
	public boolean bluray_push_cancel(PushVO vo) {
		return dao.bluray_push_cancel(vo);
	}

	@Override
	public ScrapVO bluray_scrapList(ScrapVO vo) {
		return dao.bluray_scrapList(vo);
	}

	@Override
	public boolean bluray_scrap(ScrapVO vo) {
		return dao.bluray_scrap(vo);
	}

	@Override
	public boolean bluray_scrap_cancel(ScrapVO vo) {
		return dao.bluray_scrap_cancel(vo);
	}

	@Override
	public int bluray_update(BlurayVO vo) {
		return dao.bluray_update(vo);
	}

	@Override
	public int bluray_delete(int bluray_no) {
		return dao.bluray_delete(bluray_no);
	}

}
