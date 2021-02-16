package drama;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.PushVO;
import common.ScrapVO;

@Repository
public class DramaBoardDAO implements DramaBoardService {
	@Autowired private SqlSession sql;
	
	@Override
	public DramaBoardPage dramaboard_list(DramaBoardPage page) {
		page.setTotalList((Integer)sql.selectOne("dramaboard.mapper.total", page));
		List<DramaBoardVO> list = sql.selectList("dramaboard.mapper.list", page);
		page.setList(list);
		return page;
	}

	@Override
	public DramaBoardPage dramaboard_headerList(DramaBoardPage page) {
		page.setTotalList((Integer)sql.selectOne("dramaboard.mapper.headerTotal", page));
		List<DramaBoardVO> list = sql.selectList("dramaboard.mapper.headerList", page);
		page.setList(list);
		return page;
	}

	@Override
	public DramaBoardPage dramaboard_divList(DramaBoardPage page) {
		page.setTotalList((Integer)sql.selectOne("dramaboard.mapper.divTotal", page));
		List<DramaBoardVO> list = sql.selectList("dramaboard.mapper.divList", page);
		page.setList(list);
		return page;
	}

	@Override
	public int dramaboard_comment_cnt(DramaBoardVO vo) {
		return sql.selectOne("dramaboard.mapper.comment_cnt", vo);
	}

	@Override
	public int dramaboard_insert(DramaBoardVO vo) {
		return sql.insert("dramaboard.mapper.insert", vo);
	}

	@Override
	public int dramaboard_read(int drama_board_no) {
		return sql.update("dramaboard.mapper.read", drama_board_no);
	}

	@Override
	public DramaBoardVO dramaboard_detail(int drama_board_no) {
		return sql.selectOne("dramaboard.mapper.detail", drama_board_no);
	}

	@Override
	public PushVO dramaboard_pushList(PushVO vo) {
		return sql.selectOne("dramaboard.mapper.pushList", vo);
	}

	@Override
	public boolean dramaboard_push(PushVO vo) {
		boolean result = false;
		if ( sql.insert("dramaboard.mapper.pushInsert", vo) > 0 &&
			 sql.update("dramaboard.mapper.push", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public boolean dramaboard_push_cancel(PushVO vo) {
		boolean result = false;
		if ( sql.delete("dramaboard.mapper.pushDelete", vo) > 0 &&
			 sql.update("dramaboard.mapper.pushCancel", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public ScrapVO dramaboard_scrapList(ScrapVO vo) {
		return sql.selectOne("dramaboard.mapper.scrapList", vo);
	}

	@Override
	public boolean dramaboard_scrap(ScrapVO vo) {
		boolean result = false;
		if ( sql.insert("dramaboard.mapper.scrapInsert", vo) > 0 &&
			 sql.update("dramaboard.mapper.scrap", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public boolean dramaboard_scrap_cancel(ScrapVO vo) {
		boolean result = false;
		if ( sql.insert("dramaboard.mapper.scrapDelete", vo) > 0 &&
			 sql.update("dramaboard.mapper.scrapCancel", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public int dramaboard_update(DramaBoardVO vo) {
		return sql.update("dramaboard.mapper.update", vo);
	}

	@Override
	public int dramaboard_delete(int drama_board_no) {
		return sql.delete("dramaboard.mapper.delete", drama_board_no);
	}

}
