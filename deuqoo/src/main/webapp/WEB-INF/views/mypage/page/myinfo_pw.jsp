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
		<form action="updatePw.my" method="post" id='frmJoin' class="mt50">
			<div>
				<span><i class="far fa-envelope"></i></span>
				<c:if test="${vo.member_loginType eq 'M'}">
					<input type="text" name="member_id" value="${vo.member_id }" disabled="disabled"/>
				</c:if>
				<c:if test="${vo.member_loginType eq 'K'}">
					<input type="text" name="member_id" value="${vo.member_id } (카카오 로그인)" disabled="disabled"/>
				</c:if>
				<c:if test="${vo.member_loginType eq 'N'}">
					<input type="text" name="member_id" value="${vo.member_id } (네이버 로그인)" disabled="disabled"/>
				</c:if>
			</div>
			<div>
				<span><i class="fas fa-lock"></i></span>
				<input type="password" name="current_pw" placeholder="현재 비밀번호" />
				<div class="common"></div>
			</div>
			<div>
				<span><i class="fas fa-unlock-alt"></i></span>
				<input type="password" name="member_pw" class="chk" placeholder="새 비밀번호 (영문 소문자, 숫자, 특수문자 포함 8자 이상)" />
				<div class="common">비밀번호를 입력하세요(영문대.소문자, 숫자를 포함 8자 이상)</div>
			</div>
			<div>
				<span><i class="fas fa-unlock"></i></span>
				<input type="password" name="pw_ck" class="chk" placeholder="새 비밀번호 확인" />
				<div class="common">비밀번호를 다시 입력하세요</div>
			</div>
			<input type="hidden" name="member_id" value="${vo.member_id }">
		</form>
		<div class="btnSet">
			<a id="btn-submit" onclick="update_pw()">등록</a>
			<a id="btn-reset" onclick="history.go(-1)">취소</a>
		</div>
	</div>
	<script type="text/javascript" src="js/join_check.js"></script>
	<script type="text/javascript">
		var $currentpw = $("[name=current_pw]");
		var $memberpw = $("[name=member_pw]");
		var $pwck = $("[name=pw_ck]");
		
		function update_pw() {
			if( $currentpw.val() != "${vo.member_pw}") {
				$currentpw.siblings("div").text("현재 비밀번호가 일치하지 않습니다.");
				resetClass($currentpw, "invalid");
				return;
			} else {
				resetClass($currentpw, "common");
				// 비밀번호
				// 유효성 검사 통과 X
				if( !item_check( $("[name=member_pw]") ) ) return;	//비밀번호
				else resetClass($memberpw, "common");
				
				if( !item_check( $("[name=pw_ck]") ) ) return;		//비밀번호 확인
				else resetClass($pwck, "common");
				
				$("#frmJoin").submit();
			}
		} //update_pw()
		
		$("[type=password]").on("keyup", function() {
			if( $(this).attr("name") == "current_pw" ) {
				if( $currentpw.val() != "${vo.member_pw}") {
					$currentpw.siblings("div").text("현재 비밀번호가 일치하지 않습니다.");
					resetClass($currentpw, "invalid");
					return;
				} else { resetClass($currentpw, "common"); }	
			}

			if( $(this).attr("name") == "member_pw" ) {
				if( !item_check( $("[name=member_pw]") ) ) return;	//비밀번호
				else resetClass($memberpw, "common");
			}

			if( $(this).attr("name") == "pw_ck" ) {
				if( !item_check( $("[name=pw_ck]") ) ) return;		//비밀번호 확인
				else resetClass($pwck, "common");
			}
		});
		
		// 유효성 검사 실행 함수
		function item_check( item ) {
			var data = join.tag_status( item );
			if( data != undefined ){
				if( data.code == "invalid" ) {
					display_status(item.siblings("div"), data);
					item.focus();
					return false;
				} 
				else return true;
			}
		} //item_check()
		
		function resetClass(tag, data) {
			tag.siblings("div").removeClass();
			tag.siblings("div").addClass(data);
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