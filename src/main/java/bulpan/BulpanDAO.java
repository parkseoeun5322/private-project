package bulpan;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BulpanDAO implements BulpanService {
	@Autowired private SqlSession sql;
	
	@Override
	public int bulpan_insert(BulpanVO vo) {
		return sql.insert("bulpan.mapper.insert", vo);
	}

	@Override
	public BulpanPage bulpan_list(BulpanPage page) {
		page.setTotalList((Integer)sql.selectOne("bulpan.mapper.total", page));
		List<BulpanVO> list = sql.selectList("bulpan.mapper.list", page);
		page.setList(list);
		return page;
	}

	@Override
	public int bulpan_read(int bulpan_no) {
		return sql.update("bulpan.mapper.read", bulpan_no);
	}

	@Override
	public BulpanPage bulpan_headerList(BulpanPage page) {
		page.setTotalList((Integer)sql.selectOne("bulpan.mapper.headerTotal", page));
		List<BulpanVO> list = sql.selectList("bulpan.mapper.headerList", page);
		page.setList(list);
		return page;
	}

	@Override
	public BulpanVO bulpan_detail(int bulpan_no) {
		return sql.selectOne("bulpan.mapper.detail", bulpan_no);
	}

	@Override
	public int bulpan_update(BulpanVO vo) {
		return sql.update("bulpan.mapper.update", vo);
	}

	@Override
	public int bulpan_delete(int bulpan_no) {
		return sql.delete("bulpan.mapper.delete", bulpan_no);
	}

}
