package bulpan;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatServiceImpl implements ChatService {
	@Autowired private ChatDAO dao;

	@Override
	public List<ChatVO> selectFirstChatList(int roomNo) {
		return dao.selectFirstChatList(roomNo);
	}

	@Override
	public int insertChat(ChatVO vo) {
		return dao.insertChat(vo);
	}

	@Override
	public int countWriter(ChatVO vo) {
		return dao.countWriter(vo);
	}

	@Override
	public int selectNickname(ChatVO vo) {
		return dao.selectNickname(vo);
	}

	@Override
	public int selectMaxNickname(ChatVO vo) {
		return dao.selectMaxNickname(vo);
	}

}
