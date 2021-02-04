package bulpan;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChatDAO implements ChatService {
	@Autowired private SqlSession sql;

	@Override
	public List<ChatVO> selectFirstChatList(int chatting_roomNo) {
		return sql.selectList("bulpan.mapper.selectFirstChatList", chatting_roomNo);
	}

	@Override
	public int insertChat(ChatVO chatvo) {
		return sql.insert("bulpan.mapper.insertChat", chatvo);
	}

	@Override
	public int countWriter(ChatVO chatvo) {
		return sql.selectOne("bulpan.mapper.countWriter", chatvo);
	}

	@Override
	public int selectNickname(ChatVO chatvo) {
		return sql.selectOne("bulpan.mapper.selectNickname", chatvo);
	}

	@Override
	public int selectMaxNickname(ChatVO chatvo) {
		return sql.selectOne("bulpan.mapper.selectMaxNickname", chatvo);
	}

}
