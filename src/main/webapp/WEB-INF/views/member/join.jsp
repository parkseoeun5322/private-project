<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#frmJoin {
		width: 400px;
		margin: 0 auto 30px;
	}
	
	#frmJoin > div {
		border: 1px solid #919191;
		height: 50px;
		margin-bottom: 30px;
	}
	
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
	
	 .btnSet {
	 	width: 400px;
	 	margin: 0 auto;
	 	overflow: hidden;
	 }
	 
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
		<form action="join" method="post" id='frmJoin' class="mt50">
			<div>
				<span><i class="far fa-envelope"></i></span>
				<input type="text" name="member_id" class="chk" placeholder="아이디(이메일)" style="width: 268px;" />
				<a class="btn-fill btn-chk" id="btn-id">중복 확인</a>
				<div class="common">아이디를 입력하세요(이메일 형식으로 입력해주세요)</div>
			</div>
			<div>
				<span><i class="far fa-user"></i></span>
				<input type="text" name="member_name" placeholder="이름" />
			</div>
			<div>
				<span><i class="fas fa-unlock-alt"></i></span>
				<input type="password" name="member_pw" class="chk" placeholder="비밀번호" />
				<div class="common">비밀번호를 입력하세요(영문대.소문자, 숫자를 모두 포함)</div>
			</div>
			<div>
				<span><i class="fas fa-unlock"></i></span>
				<input type="password" name="pw_ck" class="chk" placeholder="비밀번호 확인" />
				<div class="common">비밀번호를 다시 입력하세요</div>
			</div>
			<div>
				<span><i class="far fa-user-circle"></i></span>
				<input type="text" name="member_nickname" class="chk" placeholder="닉네임" style="width: 268px;" />
				<a class="btn-fill btn-chk" id="btn-nickname">중복 확인</a>
				<div class="common">닉네임을 입력하세요</div>
			</div>
		</form>
		<div class="btnSet">
			<a id="btn-submit" onclick="go_join()">회원가입</a>
			<a id="btn-reset" onclick="history.go(-1)">취소</a>
		</div>
	</div>
	<script type="text/javascript" src="js/join_check.js"></script>
	<script type="text/javascript">
		// 회원가입 버튼 클릭 메소드
		function go_join() {
			
			//아이디
			if( $("[name=member_id]").hasClass("checked") ) {	//중복확인을 한 경우
				if( $("[name=member_id]").siblings("div").hasClass("invalid") ) {
				// 중복 확인 → 이미 사용중인 아이디인 경우 회원가입 불가
					alert("회원가입 불가!\n" + join.userid.unUsable.desc );
					$("[name=member_id]").focus();
					return;
				}
			} else {	//중복확인 하지 않은 경우
				
				// 중복확인 X & 유효성 검사 통과 X인 경우 함수 끝냄
				if( !item_check( $("[name=member_id]") ) ) 	return;	
				else {		// 유효성 검사는 통과했지만 중복확인은 X
					alert("회원가입 불가!\n" + join.userid.valid.desc );
					$("[name=member_id]").focus();
					return;
				}
			}
			
			// 이름
			if( $("[name=member_name]").val() == "" ) {
				alert("성명을 입력하세요");
				$("[name=member_name]").focus();
				return;
			}
			
			// 비밀번호
			// 유효성 검사 통과 X
			if( !item_check( $("[name=member_pw]") ) ) 	return;		// 비밀번호
			if( !item_check( $("[name=pw_ck]") ) ) 		return;		// 비밀번호 확인

			//닉네임
			if( $("[name=member_nickname]").hasClass("checked") ) {		// 중복확인을 한 경우
				if( $("[name=member_nickname]").siblings("div").hasClass("invalid") ) {
				// 중복확인 → 이미 사용중인 아이디인 경우 회원가입 불가
					alert("회원가입 불가!\n" + join.usernickname.unUsable.desc );
					$("[name=member_nickname]").focus();
					return;
				}
			} else {	//중복확인 하지 않은 경우
				// 중복확인 X & 유효성 검사 통과 X
				if( !item_check( $("[name=member_nickname]") ) ) 	return;	
				else {		// 유효성 검사는 통과했지만 중복확인 X
					alert("회원가입 불가!\n" + join.usernickname.valid.desc );
					$("[name=member_nickname]").focus();
					return;
				}
			}		
			
			$("form").submit();
		} //go_join()
		
		// 유효성 검사 실행 함수
		function item_check( item ) {
			var data = join.tag_status( item );
			if( data != undefined ){
				if( data.code == "invalid" ) {
					alert( "회원가입 불가\n" + data.desc );
					item.focus();
					return false;
				} 
				else return true;
			}
		} //item_check()
		
		// 아이디 중복 확인 버튼 클릭 시 발생하는 이벤트 핸들러
		$("#btn-id").on("click", function() {
			userid_check();
		});

		// 닉네임 중복 확인 버튼 클릭 시 발생하는 이벤트 핸들러
		$("#btn-nickname").on("click", function() {
			usernickname_check();
		});

		// 아이디 중복확인
		function userid_check() {			
			//올바른 아이디인 경우만 중복확인 필요
			var $userid = $("[name=member_id]");
			if( $userid.hasClass("checked") ) return;	//이미 중복확인을 한 경우, 함수를 끝냄
			var data = join.tag_status( $userid );
			if( data.code != "valid" ) { 	// 아이디가 이메일 형식이 아닐 경우
				alert("아이디 중복확인 불필요\n" + data.desc);
				$userid.focus();
				return;
			}

			$.ajax({
				url: "id_check",
				data: { id: $userid.val() },
				success: function( data ) {
					data = join.userid_usable( data );
					display_status( $userid.siblings("div"), data);	
					$userid.addClass("checked");	//이미 중복확인을 한 경우
				},
				error: function(req, text) {
					alert(text + ":" + req.status);
				}			
			});	
		} //userid_check()
		
		// 닉네임 중복확인
		function usernickname_check() {
			//올바른 닉네임 경우만 중복확인 필요
			var $usernickname = $("[name=member_nickname]");
			if( $usernickname.hasClass("checked") ) return;	//이미 중복확인을 한 경우, 함수를 끝냄
			var data = join.tag_status( $usernickname );
			if( data.code != "valid" ) { 
				alert(data.desc);
				$usernickname.focus();
				return;
			}

			$.ajax({
				url: "nickname_check",
				data: { nickname: $usernickname.val() },
				success: function( data ) {
					data = join.usernickname_usable( data );
					display_status( $usernickname.siblings("div"), data);	
					$usernickname.addClass("checked");	//이미 중복확인을 한 경우
				},
				error: function(req, text) {
					alert(text + ":" + req.status);
				}			
			});

		} //usernickname_check()
		
		// 아이디에 대해 입력 데이터를 변경시 다시 중복확인할 수 있도록 함
		$(".chk").on("keyup", function() {
			if( $(this).attr("name") == "member_id" ) {
				if( event.keyCode == 13 ) userid_check();
				else {
					$(this).removeClass("checked");
					validate( $(this) );
				}	
			} else if( $(this).attr("name") == "member_nickname") {
				if( event.keyCode == 13 ) usernickname_check();
				else {
					$(this).removeClass("checked");
					validate( $(this) );
				}
			} else	validate( $(this) );
		});
		
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