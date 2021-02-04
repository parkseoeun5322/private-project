package member;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO implements MemberService {
	@Autowired private SqlSession sql;
	
	@Override
	public MemberVO member_login(HashMap<String, String> map) {
		return sql.selectOne("member.mapper.login", map);
	}

	@Override
	public boolean member_insert(MemberVO vo) {
		return sql.insert("member.mapper.join", vo) > 0 ? true : false;
	}

	@Override
	public boolean member_id_check(String userid) {
		return (Integer) sql.selectOne("member.mapper.id_check", userid) > 0 ? false : true;
	}

	@Override
	public boolean member_nickname_check(String nickname) {
		return (Integer) sql.selectOne("member.mapper.nickname_check", nickname) > 0 ? false : true;
	}

	@Override
	public int update_token(MemberVO vo) {
		return sql.update("member.mapper.update_token", vo);
	}

	@Override
	public int update_loginDate(MemberVO vo) {
		return sql.update("member.mapper.update_loginDate", vo);
	}

	@Override
	public MemberVO social_login(String member_id) {
		return sql.selectOne("member.mapper.socialLogin", member_id);
	}

	@Override
	public boolean naver_insert(MemberVO vo) {
		return sql.insert("member.mapper.naver_join", vo) > 0 ? true : false;
	}

	@Override
	public boolean kakao_insert(MemberVO vo) {
		return sql.insert("member.mapper.kakao_join", vo) > 0 ? true : false;
	}
	
}
