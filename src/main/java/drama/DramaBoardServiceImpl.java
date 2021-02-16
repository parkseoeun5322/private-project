package drama;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.PushVO;
import common.ScrapVO;

@Service
public class DramaBoardServiceImpl implements DramaBoardService {
	@Autowired DramaBoardDAO dao;
	
	@Override
	public DramaBoardPage dramaboard_list(DramaBoardPage page) {
		return dao.dramaboard_list(page);
	}

	@Override
	public DramaBoardPage dramaboard_headerList(DramaBoardPage page) {
		return dao.dramaboard_headerList(page);
	}

	@Override
	public DramaBoardPage dramaboard_divList(DramaBoardPage page) {
		return dao.dramaboard_divList(page);
	}

	@Override
	public int dramaboard_comment_cnt(DramaBoardVO vo) {
		return dao.dramaboard_comment_cnt(vo);
	}

	@Override
	public int dramaboard_insert(DramaBoardVO vo) {
		return dao.dramaboard_insert(vo);
	}

	@Override
	public int dramaboard_read(int drama_board_no) {
		return dao.dramaboard_read(drama_board_no);
	}

	@Override
	public DramaBoardVO dramaboard_detail(int drama_board_no) {
		return dao.dramaboard_detail(drama_board_no);
	}

	@Override
	public PushVO dramaboard_pushList(PushVO vo) {
		return dao.dramaboard_pushList(vo);
	}

	@Override
	public boolean dramaboard_push(PushVO vo) {
		return dao.dramaboard_push(vo);
	}

	@Override
	public boolean dramaboard_push_cancel(PushVO vo) {
		return dao.dramaboard_push_cancel(vo);
	}

	@Override
	public ScrapVO dramaboard_scrapList(ScrapVO vo) {
		return dao.dramaboard_scrapList(vo);
	}

	@Override
	public boolean dramaboard_scrap(ScrapVO vo) {
		return dao.dramaboard_scrap(vo);
	}

	@Override
	public boolean dramaboard_scrap_cancel(ScrapVO vo) {
		return dao.dramaboard_scrap_cancel(vo);
	}

	@Override
	public int dramaboard_update(DramaBoardVO vo) {
		return dao.dramaboard_update(vo);
	}

	@Override
	public int dramaboard_delete(int drama_board_no) {
		return dao.dramaboard_delete(drama_board_no);
	}
}
