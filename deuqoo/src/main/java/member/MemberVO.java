package member;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	private String member_id, member_pw, member_name, 
				   member_nickname, member_loginType, 
				   member_token, member_admin;
	private Date member_signup_date, member_recent_login_date;
	
	public MemberVO() {}
	
	// 기본 생성자
	public MemberVO(String member_id, String member_pw, String member_name, 
					String member_nickname, String member_loginType, 
					String member_token ,String member_admin, 
					Date member_signup_date, Date member_recent_login_date) {
		super();
		this.member_id = member_id;
		this.member_pw = member_pw;
		this.member_name = member_name;
		this.member_nickname = member_nickname;
		this.member_loginType = member_loginType;
		this.member_token = member_token;
		this.member_admin = member_admin;
		this.member_signup_date = member_signup_date;
		this.member_recent_login_date = member_recent_login_date;
	}
	
	// 네이버 소셜 로그인
	public MemberVO(String member_id, String member_name, String member_nickname, 
					String member_loginType, String member_token) {
		super();
		this.member_id = member_id;
		this.member_name = member_name;
		this.member_nickname = member_nickname;
		this.member_loginType = member_loginType;
		this.member_token = member_token;
	}

	// 카카오 소셜 로그인 
	public MemberVO(String member_id, String member_nickname, String member_loginType, String member_token) {
		super();
		this.member_id = member_id;
		this.member_nickname = member_nickname;
		this.member_loginType = member_loginType;
		this.member_token = member_token;
	}
	
}
