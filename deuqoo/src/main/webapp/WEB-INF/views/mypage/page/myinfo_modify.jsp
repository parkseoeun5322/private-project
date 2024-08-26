<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#frmJoin { width: 400px; margin: 0 auto 30px; }
	#frmJoin > div { border: 1px solid #919191; height: 50px; margin-bottom: 30px; }
	#frmJoin > div:first-child { background-color: #f5f5f5; }
	#frmJoin > div > span {
		height: 48px;
		display: block;
		float: left;
		padding: 14px 0 0 0;
		border-right: 1px solid #858585;
	}
	
	.btn-chk { float: right; font-size: 14px; margin: 7px 3px 0 0; cursor: pointer; }
	
	.valid, .invalid {
 		font-size: 13px;
 		height: 10px;
 		line-height: 25px;
 		text-align: left;
 		margin: 4px 0 0 50px;
	}
	
	#frmJoin > div > span > svg {
		width: 50px;
		font-size: 25px;
		color: #787878;
	}
	
	#frmJoin input {
		width: 347px;
		height: 48px;
		box-sizing: border-box;
		border: none;
		padding: 0 0 0 10px;
	}
	
	.common { display: none; }
	.valid { color: #919191; display: block; }
	.invalid { color: red; display: block;}
	.btnSet { width: 400px; margin: 0 auto; overflow: hidden; }
	 
	 #btn-submit, #btn-reset {
	 	width: 48.5%;
		display: block; 
		line-height: 35px;
		font-weight: 70;
		cursor: pointer;
		float: left;
	 }
	 
	#btn-submit { background-color: #787878; color: #ffffff; font-weight: 900; margin-right: 5px; }
	#btn-reset { 
		background-color: #ffffff; 
		color: #787878;
		font-weight: 600;
		/* border: 1px solid #000000; */
		box-shadow: 2px 2px 5px #666666;
	}
	
</style>
</head>
<body>
	<div class="contents">
		<h2 class="mb20 tl">회원정보 변경</h2>
		<form action="updateInfo.my" method="post" id='frmJoin'>
			<div>
				<span><i class="far fa-envelope"></i></span>
				<c:if test="${vo.member_loginType eq 'M'}">
					<input type="text" name="member_id" class="chk" value="${vo.member_id }" disabled="disabled"/>
				</c:if>
				<c:if test="${vo.member_loginType eq 'K'}">
					<input type="text" name="member_id" class="chk" value="${vo.member_id } (카카오 로그인)" disabled="disabled"/>
				</c:if>
				<c:if test="${vo.member_loginType eq 'N'}">
					<input type="text" name="member_id" class="chk" value="${vo.member_id } (네이버 로그인)" disabled="disabled"/>
				</c:if>
			</div>
			<div>
				<span><i class="far fa-user"></i></span>
				<input type="text" name="member_name" value="${vo.member_name }" />
			</div>
			<div>
				<span><i class="far fa-user-circle"></i></span>
				<input type="text" name="member_nickname" class="chk" value="${vo.member_nickname }" />
				<div class="common">닉네임을 입력하세요</div>
			</div>
			<input type="hidden" name="member_id" value="${vo.member_id }">
		</form>
		<div class="btnSet">
			<a id="btn-submit" onclick="myinfo_update()">등록</a>
			<a id="btn-reset" onclick="history.go(-1)">취소</a>
		</div>
	</div>
	<script type="text/javascript" src="js/join_check.js"></script>
	<script type="text/javascript">
		var $usernickname = $("[name=member_nickname]");
		var $username = $("[name=member_name]");
		var checkResult = false;
		
		//등록 버튼 클릭 시
		function myinfo_update() {
			// 이름
			if( $username.val() == "" ) {
				alert("성명을 입력하세요");
				$username.focus();
				return;
			}

			//닉네임
			if($usernickname.val() == "") {
				alert("닉네임을 입력하세요");
				$usernickname.focus();
				return;
			} else {
				var data = join.usernickname_status( $usernickname.val() );

				if(data.code == "invalid") { 	//유효성 검사
					display_status( $usernickname.siblings("div"), data)
					return; 
				} else {	//유효성 검사 통과 후 중복확인
					$.ajax({
						url: "nickname_check",
						data: { nickname: $usernickname.val() },
						success: function( data ) {
							if(!data) {
								if ($usernickname.val() != "${vo.member_nickname}") {
									data = join.usernickname_usable( data );
									display_status( $usernickname.siblings("div"), data);	
								}
							}
							checkResult = data;
						},
						error: function(req, text) {
							alert(text + ":" + req.status);
						}			
					});

					if(!checkResult) {	//닉네임 중복시
						if ($usernickname.val() != "${vo.member_nickname}") return;
					}		
					$("#frmJoin").submit();
				}
			}
		} //myinfo_update()

		// 유효성 검사 현황을 알려주는 알림 표시 : validate(), display_status()	
		function validate( tag ) {
			var data = join.tag_status( tag );
			display_status( tag.siblings("div"), data );
		}

		function display_status(div, data) {
			div.text( data.desc );
			div.removeClass();
			div.addClass( data.code );
		}
	
		$(function () {
			// input 태그에 커서 focus가 될 때 발생하는 이벤트
			$("#frmJoin input").focus(function () {
				$(this).css("outline", "none").parent().css("outline", "2px solid #000");				
			});
			
			$("#frmJoin input").blur(function() {
				$(this).parent().css("outline", "none");
			});
			
		});
	</script>
</body>
</html>