<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.info_wrap { width: 1000px; margin: 50px auto; line-height: 45px; position: relative; }
	.info_wrap > table { width: 675px; border: 1px solid #ddd; }
	.info_wrap span { color: #ff6b6b !important; margin: 0 0 0 3px; }
	.info_wrap th { background-color: #f7f7f7; width: 230px; }
	.info_wrap tr:not(:last-child) { border-bottom: 1px solid #ddd; }
	
	.info { position: absolute; top: 0; right: 0; width: 300px; text-align: left; }
	.info h3 { font-size: 25px; }
	.info hr { border: 0; border-top: 1px solid #ddd; margin: 15px 0; }
	.info li a { color: #787878; }
	.info h3, .info ul { margin: 0 0 0 15px; }
</style>
<script type="text/javascript">
	function updatePw() {
		if("${vo.member_loginType}" == "N" || "${vo.member_loginType}" == "K") {
			alert("소셜 로그인은 비밀번호 변경이 불가합니다.");
		} else {
			$('#idForm').attr('action','modifyPw.my'); 
			$('#idForm').submit();
		}
	} //updatePw()

	function deleteInfo() {
		if(confirm("정말 탈퇴하시겠습니까?")) {
			$('#idForm').attr('action','delete.my'); 
			$('#idForm').submit();
		}
	} //deleteInfo()
</script>
</head>
<body>
	<div class="info_wrap">
		<table>
			<tr>
				<th>아이디(이메일)<span>*</span></th>
				<td>${vo.member_id }</td>
			</tr>
			<tr>
				<th>닉네임<span>*</span></th>
				<td>${vo.member_nickname }</td>
			</tr>
			<c:if test="${not empty vo.member_name }">
				<tr>
					<th>이름</th>
					<td>${vo.member_name }</td>
				</tr>
			</c:if>
			<tr>
				<th>가입일</th>
				<td>${vo.member_signup_date }</td>
			</tr>
			<tr>
				<th>최근 로그인</th>
				<td>${vo.member_recent_login_date }</td>
			</tr>
			<tr>
				<th>소셜 로그인</th>
				<td>
					<c:if test="${vo.member_loginType eq 'M' }">X</c:if>
					<c:if test="${vo.member_loginType eq 'N' }">O (네이버)</c:if>
					<c:if test="${vo.member_loginType eq 'K' }">O (카카오)</c:if>
				</td>
			</tr>
		</table>
		<div class="info">
			<h3>회원 정보</h3>
			<hr>
			<ul>
				<li><a onclick="$('#idForm').attr('action','modifyInfo.my'); $('#idForm').submit();">회원 정보 변경</a></li>
				<li><a onclick="updatePw();">비밀번호 변경</a></li>
				<li><a onclick="deleteInfo();">탈퇴</a></li>
			</ul>
		</div>
	</div>
</body>
</html>