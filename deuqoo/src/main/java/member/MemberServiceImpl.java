package member;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired private MemberDAO dao;
	
	@Override
	public MemberVO member_login(HashMap<String, String> map) {
		return dao.member_login(map);
	}

	@Override
	public boolean member_insert(MemberVO vo) {
		return dao.member_insert(vo);
	}

	@Override
	public boolean member_id_check(String userid) {
		return dao.member_id_check(userid);
	}

	@Override
	public boolean member_nickname_check(String nickname) {
		return dao.member_nickname_check(nickname);
	}

	@Override
	public int update_token(MemberVO vo) {
		return dao.update_token(vo);
	}

	@Override
	public int update_loginDate(MemberVO vo) {
		return dao.update_loginDate(vo);
	}

	@Override
	public MemberVO social_login(String member_id) {
		return dao.social_login(member_id);
	}

	@Override
	public boolean naver_insert(MemberVO vo) {
		return dao.naver_insert(vo);
	}

	@Override
	public boolean kakao_insert(MemberVO vo) {
		return dao.kakao_insert(vo);
	}
	
}
