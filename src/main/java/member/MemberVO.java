package member;

import java.sql.Date;

public class MemberVO {
	/*
	 * member_id				varchar2(20)
	 * member_pw				varchar2(20)
	 * member_name				varchar2(20)
	 * member_nickname			varchar2(50)
	 * member_email				varchar2(50)
	 * member_loginType			varchar2(5) default 'M'
	 * member_token				varchar2(200)
	 * member_signup_date		date default sysdate
	 * member_recent_login_date	date default sysdate
	 * member_admin				varchar2(5) default 'N'
	 */
	
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

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_nickname() {
		return member_nickname;
	}

	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}

	public String getMember_loginType() {
		return member_loginType;
	}

	public void setMember_loginType(String member_loginType) {
		this.member_loginType = member_loginType;
	}
	
	public String getMember_token() {
		return member_token;
	}

	public void setMember_token(String member_token) {
		this.member_token = member_token;
	}

	public String getMember_admin() {
		return member_admin;
	}

	public void setMember_admin(String member_admin) {
		this.member_admin = member_admin;
	}

	public Date getMember_signup_date() {
		return member_signup_date;
	}

	public void setMember_signup_date(Date member_signup_date) {
		this.member_signup_date = member_signup_date;
	}

	public Date getMember_recent_login_date() {
		return member_recent_login_date;
	}

	public void setMember_recent_login_date(Date member_recent_login_date) {
		this.member_recent_login_date = member_recent_login_date;
	}
	
}
