<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#login_form {
		width: 350px; 
		margin: 0 auto;
	}
	
	#login_form > li {
		width: 100%;
	}
	
	#login_form input {
		width: 100%; 
		height: 50px;
		box-sizing: border-box;
		border: 1px solid #919191;
		padding: 0 0 0 10px;
	}

	
	#member_login, #sign_up {
		display: block; 
		height: 50px; 
		line-height: 50px;
		font-weight: 70;
		cursor: pointer;
	}
	
	#member_login { background-color: #919191; color: #ffffff; font-weight: 900; }
	
	#sign_up { 
		background-color: #ffffff; 
		color: #919191; 
		font-weight: 600;
		box-shadow: 2px 2px 5px #919191;
		/* border: 2px solid #666666; */
	}
	
 	#search_id_pw {
		padding: 15px 10px 0 0;
		font-size: 13px;
		color: #666666;
		float: right;
	} 

	
	#login_form > li:last-child {
		overflow: hidden;
	}
	
	#login_form > li:last-child > a {
		width: 50%;
		float: left;
	}
	
	#naver_login {
		display: block;
		height: 50px; 
		overflow: hidden;
		border-radius: 5px;
	}
	
	#naver_login > img {
		display: block; 
		float: left; 
		height: 39px;
		cursor: pointer;
	}
	
	#naver_login > div {
		width: 170px;
		line-height: 39px;
		font-weight: 600; 
		font-size: 13px;
		letter-spacing: -1px;
		letter-spacing: 1.5px; 
		color: #ffffff;
		cursor: pointer;
		border-radius: 5px;
		background-color: #1EC800; 
	}
	
	#kakao_login > img { width: 175px; }
	
</style>
<script type="text/javascript">

	function go_login() {
		if( $("#userId").val() == "" ) {
			alert("아이디를 입력하세요.");
			$("#userId").focus();
			return;
		} else if ( $("#userPw").val() == "" ) {
			alert("비밀번호를 입력하세요.");
			$("#userPw").focus();
			return;
		}
	
		$.ajax({
			url: "login",		//Controller
			data: { userId:$("#userId").val(), userPw:$("#userPw").val()  },
			success: function(data) {
				if (data.member_id != null) {
					if(data.member_token == null && data.member_admin == 'N') {
						alert("인증 이메일을 확인해 주세요!");
						$("#userId").val("");
						$("#userPw").val("");
						return;
					}
					
					location.href = "/deuqoo";
					
				} else  {
					alert("아이디나 비밀번호가 일치하지 않습니다!");
					$("#userId").val("");
					$("#userPw").val("");
				}
			},
			error: function(req, text) {
				alert(text + ":" + req.status);
			}
		});
	} //go_login()
	
	$(function() {
		var member_id, member_nickname, member_token;
		
		Kakao.init("69a692e24dcc89d81399cfd013f48c4e");
		Kakao.isInitialized();

		Kakao.Auth.createLoginButton({
			container: '#kakao_login',
			success: function(response) {
				member_token = Kakao.Auth.getAccessToken();
				
				Kakao.API.request({
					url: '/v2/user/me',
					success: function(response) {
						console.log(response.kakao_account);
						member_id = response.kakao_account.email;
						member_nickname = response.properties.nickname;
						
						console.log("member_id : ", member_id);
						console.log("member_nickname : ", member_nickname);
						console.log("member_token : ", member_token);
						
						$.ajax({
							url: "kakao_login",		//Controller
							data: { member_id:member_id, member_nickname:member_nickname, member_token:member_token },
							success: function(data) {
								if (data) {
									location.href = "/deuqoo";
								} else {
									alert("아이디나 비밀번호가 일치하지 않습니다!");
								}
							},
							error: function(req, text) {
								alert(text + ":" + req.status);
							}
						});
					},
					fail: function(error) {
						console.log("request fail", error);
					}
				}); //Kakao.API.request()
				
			},
			fail: function(error) {
				console.log("fail", error);
			},
		}); //Kakao.Auth.createLoginButton()

		$("#member_login").hover(function() {
			$(this).css({"background-color": "#000000",
				 		"color": "white",
				 		"transition": "0.4s"});
				}, function() {
					$(this).css({"background-color": "",
				 				"color": ""});

				});

		$("#userPw").keyup(function() {
			$("#member_login").css({"background-color": "#000000",
									 "color": "white",
									 "transition": "0.4s"});
			
			if (!$("#userId").val()) {
				$submit.css("background-color", "").css("color", "");
			}
		});
	});
	
</script>
<!-- 카카오톡 API -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
	<div class="container">
		<ul id="login_form" class="mt40">
			<li class="mb10"><input type="text" id="userId" placeholder="아이디" /></li>
			<li class="mb20"><input type="password" id="userPw" 
			    onkeypress="if( event.keyCode==13 ){ go_login(); }" placeholder="비밀번호" /></li>
			<li class="mb10"><a id="member_login" onclick="go_login();">로그인</a></li>
			<li class="mb60">
				<a id="sign_up" href="member">회원가입</a>
				<a id="search_id_pw" href="searchIdPw_view">아이디/비밀번호 찾기 ></a>
			</li>
			<li class="mb10">
				<a id="naver_login" href="naver_login">
					<img src="img/naver_logo.PNG">
					<div>네이버&nbsp;&nbsp;로그인</div>
				</a> <!-- <a id="kakao_login" href="https://kauth.kakao.com/oauth/authorize?client_id=8f9058216b087187fa01c4f671353a08&redirect_uri=http://www.localhost:8080/dteam/kakao_login&response_type=code"> -->
				<a id="kakao_login">
					<!-- <img alt="카카오 로그인" src="img/kakao_login_large_narrow_ko.png" style="width: 170px; height: 45px;" /> -->
				</a>
			</li>
		</ul>
	</div>
</body>
</html>