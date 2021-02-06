package common;

import java.util.Random;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Service;

import member.MemberVO;

@Service
public class CommonService {
	// 난수 값(토큰)을 발급해주는 메소드
	public String getRandomCode( int length ){
		char[] charaters = {'a','b','c','d','e','f','g','h','i','j','k','l','m',
							'n','o','p','q','r','s','t','u','v','w','x','y','z',
	        				'0','1','2','3','4','5','6','7','8','9'};
	    StringBuffer sb = new StringBuffer();
	    Random rn = new Random();

	    for( int i = 0 ; i < length ; i++ ){
	    	sb.append( charaters[ rn.nextInt( charaters.length ) ] );
	    }
	        
	    return sb.toString();
	} //getRandomPassword()
	
	// 회원가입 인증 메일 보내기
	public void emailAuthSend(MemberVO vo, String code) {
		HtmlEmail mail = new HtmlEmail();
		mail.setHostName("smtp.naver.com");
		mail.setCharset("utf-8");
		mail.setDebug(true);
		//mail.setSmtpPort(465);
		//mail.setStartTLSEnabled(true);

		mail.setAuthentication("tjdms5322", "qkr2684!");
		mail.setSSLOnConnect(true);

		try {
			mail.setFrom("tjdms5322@naver.com", "관리자");
			mail.addTo(vo.getMember_id(), vo.getMember_name());

			mail.setSubject("[Deuqoo] 회원가입 이메일 인증메일");
			StringBuffer msg = new StringBuffer();
			msg.append("<html>");
			msg.append("<body>");
			msg.append("<h1 style='margin-bottom: 20px;'>이메일 인증</h1>");
			msg.append("<div>");
			msg.append("안녕하세요 [Deuqoo]입니다.<br/> 아래 버튼을 누르고 회원가입을 진행해주세요.");
			msg.append("</div>");
			msg.append("<a href='http://192.168.35.241/deuqoo/emailAuth?code=" + code + "&member_id=" + vo.getMember_id() + "'>이메일 인증하기</a>");
			msg.append("</body>");
			msg.append("</html>");
			mail.setHtmlMsg(msg.toString());

			mail.send();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	} // emailAuthSend()
	
}
