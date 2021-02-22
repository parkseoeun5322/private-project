package bluray;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.PushVO;
import common.ScrapVO;

@Repository
public class BlurayDAO implements BlurayService {
	@Autowired private SqlSession sql;
	
	@Override
	public BlurayPage bluray_list(BlurayPage page) {
		page.setTotalList((Integer)sql.selectOne("bluray.mapper.total", page));
		List<BlurayVO> list = sql.selectList("bluray.mapper.list", page);
		page.setList(list);
		return page;
	}

	@Override
	public BlurayPage bluray_headerList(BlurayPage page) {
		page.setTotalList((Integer)sql.selectOne("bluray.mapper.headerTotal", page));
		List<BlurayVO> list = sql.selectList("bluray.mapper.headerList", page);
		page.setList(list);
		return page;
	}

	@Override
	public BlurayPage bluray_divList(BlurayPage page) {
		page.setTotalList((Integer)sql.selectOne("bluray.mapper.divTotal", page));
		List<BlurayVO> list = sql.selectList("bluray.mapper.divList", page);
		page.setList(list);
		return page;
	}

	@Override
	public int bluray_comment_cnt(BlurayVO vo) {
		return sql.selectOne("bluray.mapper.comment_cnt", vo);
	}

	@Override
	public int bluray_insert(BlurayVO vo) {
		return sql.insert("bluray.mapper.insert", vo);
	}

	@Override
	public int bluray_read(int bluray_no) {
		return sql.update("bluray.mapper.read", bluray_no);
	}

	@Override
	public BlurayVO bluray_detail(int bluray_no) {
		return sql.selectOne("bluray.mapper.detail", bluray_no);
	}

	@Override
	public PushVO bluray_pushList(PushVO vo) {
		return sql.selectOne("bluray.mapper.pushList", vo);
	}

	@Override
	public boolean bluray_push(PushVO vo) {
		boolean result = false;
		if ( sql.insert("bluray.mapper.pushInsert", vo) > 0 &&
			 sql.update("bluray.mapper.push", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public boolean bluray_push_cancel(PushVO vo) {
		boolean result = false;
		if ( sql.delete("bluray.mapper.pushDelete", vo) > 0 &&
			 sql.update("bluray.mapper.pushCancel", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public ScrapVO bluray_scrapList(ScrapVO vo) {
		return sql.selectOne("bluray.mapper.scrapList", vo);
	}

	@Override
	public boolean bluray_scrap(ScrapVO vo) {
		boolean result = false;
		if ( sql.insert("bluray.mapper.scrapInsert", vo) > 0 &&
			 sql.update("bluray.mapper.scrap", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public boolean bluray_scrap_cancel(ScrapVO vo) {
		boolean result = false;
		if ( sql.insert("bluray.mapper.scrapDelete", vo) > 0 &&
			 sql.update("bluray.mapper.scrapCancel", vo) > 0 ) result = true;
		return result;
	}

	@Override
	public int bluray_update(BlurayVO vo) {
		return sql.update("bluray.mapper.update", vo);
	}

	@Override
	public int bluray_delete(int bluray_no) {
		return sql.delete("bluray.mapper.delete", bluray_no);
	}

}
