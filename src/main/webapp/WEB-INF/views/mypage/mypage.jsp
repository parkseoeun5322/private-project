<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	// 로그아웃 시 메인으로 돌아감
	window.onload = function() { 
		if("${login_info}" == "") {
			alert("로그인이 필요한 페이지입니다.");
			location.href = "/deuqoo";
		}
	}

	function go_detail(bno, category, title) {
		if(title == "") {
			alert("삭제된 글입니다.");
			return;
		} else {
			if(category == "불판") {
				window.open('chat.bu?chatting_roomNo=' + bno + '&chatting_title=' + title, '', 'width=400');
			} else if(category == "자료") {
				$("#bno").attr("name", "drama_board_no").val(bno);
				$("#bnoForm").attr("action", "detail.info");
				$("#bnoForm").submit();
			} else if(category == "상품") {
				$("#bno").attr("name", "shopping_no").val(bno);
				$("#bnoForm").attr("action", "detail.tv");
				$("#bnoForm").submit();
			} else if(category == "리뷰") {
				$("#bno").attr("name", "review_no").val(bno);
				$("#bnoForm").attr("action", "detail.re");
				$("#bnoForm").submit();
			} else if(category == "블레") {
				$("#bno").attr("name", "bluray_no").val(bno);
				$("#bnoForm").attr("action", "detail.bl");
				$("#bnoForm").submit();
			}
		}
	} //go_detail
</script>
<style type="text/css">
	.data-list { width: 1000px; margin: 0 auto; }
	.data-list h1 { margin: 50px auto 0; text-align: left; font-weight: 600; }
	.data-list > p { color: #787878; text-align: left; margin: 25px 0 10px 0; }
	.table-style-b { margin-top: 0; }
	.table-style-b img { max-width: 530px; }
	.my_title:hover { text-decoration: underline; }
	.my_delete {
		background-color: #787878; color: #fff;
		padding: 4px 8px; border-radius: 3px;
		font-weight: 500 !important;
	}
</style>
</head>
<body>
	<div class="list-top">
		<ul>
			<li ${mycategory eq 'info' ? 'class="on"' : '' }><a onclick="$('#idForm').submit();">회원정보 보기</a></li>
			<li ${mycategory eq 'scrap' ? 'class="on"' : '' }><a onclick="$('#idForm').attr('action','scrap.my'); $('#idForm').submit();">스크랩 보기</a></li>
			<li ${mycategory eq 'doc' ? 'class="on"' : '' }><a onclick="$('#idForm').attr('action','document.my'); $('#idForm').submit();">작성글 보기</a></li>
			<li ${mycategory eq 'comm' ? 'class="on"' : '' }><a onclick="$('#idForm').attr('action','comment.my'); $('#idForm').submit();">작성 댓글 보기</a></li>
		</ul>
	</div>
	<section>
		<c:if test="${mycategory eq 'info' }">
			<jsp:include page="/WEB-INF/views/mypage/page/my_info.jsp"/>
		</c:if>
		<c:if test="${mycategory eq 'scrap' }">
			<jsp:include page="/WEB-INF/views/mypage/page/my_scrap.jsp"/>
		</c:if>
		<c:if test="${mycategory eq 'doc' }">
			<jsp:include page="/WEB-INF/views/mypage/page/my_document.jsp"/>
		</c:if>
		<c:if test="${mycategory eq 'comm' }">
			<jsp:include page="/WEB-INF/views/mypage/page/my_comment.jsp"/>
		</c:if>
	</section>
	<form id="bnoForm" action="" method="post">
		<input id="bno" type="hidden" name="">
		<input type="hidden" name="member_id" value="${login_info.member_id }">	<!-- 페이징 처리시 필요 -->
		<input type="hidden" name="curPage" value="1">
		<input type="hidden" name="myPage" value="Y">	<!-- detail 목록 버튼 클릭 시 오류 해결 -->
	</form>
</body>
</html>