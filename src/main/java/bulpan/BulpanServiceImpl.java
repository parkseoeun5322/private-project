package bulpan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BulpanServiceImpl implements BulpanService {
	@Autowired private BulpanDAO dao;
	
	@Override
	public int bulpan_insert(BulpanVO vo) {
		return dao.bulpan_insert(vo);
	}

	@Override
	public BulpanPage bulpan_list(BulpanPage page) {
		return dao.bulpan_list(page);
	}

	@Override
	public int bulpan_read(int bulpan_no) {
		return dao.bulpan_read(bulpan_no);
	}

	@Override
	public BulpanPage bulpan_headerList(BulpanPage page) {
		return dao.bulpan_headerList(page);
	}

	@Override
	public BulpanVO bulpan_detail(int bulpan_no) {
		return dao.bulpan_detail(bulpan_no);
	}

	@Override
	public int bulpan_update(BulpanVO vo) {
		return dao.bulpan_update(vo);
	}

	@Override
	public int bulpan_delete(int bulpan_no) {
		return dao.bulpan_delete(bulpan_no);
	}

	@Override
	public BulpanPage bulpan_divList(BulpanPage page) {
		return dao.bulpan_divList(page);
	}

}
