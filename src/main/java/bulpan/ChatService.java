package bulpan;

import java.util.List;
import java.util.Map;

public interface ChatService {
	List<ChatVO> selectFirstChatList(int roomNo);	//채팅 목록 조회
	int insertChat(ChatVO vo);						//채팅 정보 저장
	int countWriter(ChatVO vo);						//DB에 저장된 채팅 보낸 사람의 아이디 조회
	int selectNickname(ChatVO vo);		//DB에 저장된 채팅 보낸 사람의 닉네임 조회 (이미 DB에 닉네임이 저장되어있는 경우)
	int selectMaxNickname(ChatVO vo);	//DB에 저장된 채팅 보낸 사람의 닉네임 조회 (DB에 닉네임이 저장 X)
}
