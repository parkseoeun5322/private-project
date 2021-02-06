<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/basic.css">
<link rel="stylesheet" type="text/css" href="css/common.css?v=<%=new java.util.Date().getTime()%>">
<title>Insert title here</title>
<style type="text/css">
	.comment_list { 
		padding: 10px 25px;
    	border-bottom: 1px solid #ddd;
   		margin: 0 0 20px 0; 
   	}
	.comment_info { overflow: hidden; padding: 8px 0; height: 35px; }
	.comment_info > span:first-child > a { font-weight: 900; }
	.comment_info > span:first-child > span { font-size: 12px; color: #aaa; }
	.btn-fill-s { padding: 2px 7px; line-height: 26px; font-size: 13px; border-radius: 5px; }
	.btn-modify-save { background-color: #787878; color: #fff !important; border: 1px solid #787878; }
	.btn-delete-cancel, .btn-reply { color: #787878; border: 1px solid #787878; }
	#btnReply {}
</style>
</head>
<body>
	<c:forEach items="${list }" var="cvo">
		<div data-id="${cvo.comment_no }" class="comment_list">
			<div class="comment_info">
				<span class="fl">
					<c:if test="${board_writer eq cvo.comment_writer }">
						<a href="" class="mr10" style="color: #19d48c;">W</a> 
					</c:if>
					<c:if test="${board_writer ne cvo.comment_writer }">
						<a href="" class="mr10">드덕 ${cvo.comment_nickname }</a> 
					</c:if>
					<span>
						<fmt:formatDate value="${cvo.comment_writedate }" pattern="yy/MM/dd HH:mm:ss"/>
					</span>
				</span>
				<!-- 로그인한 사용자가 작성한 댓글에 대해 수정/삭제 가능 -->
				<span class="fr mr20">
					<c:if test="${login_info.member_id eq cvo.comment_writer }">
						<a class="btn-fill-s btn-modify-save" onclick="$('#form${cvo.comment_no }').submit();">수정</a>
						<a class="btn-fill-s btn-delete-cancel">삭제</a>
						<a class="btn-fill-s btn-reply">댓글</a>
					</c:if>
					<c:if test="${login_info.member_id ne cvo.comment_writer }">
						<a class="btn-fill-s btn-reply" id="#btnReply">댓글</a>
					</c:if>
				</span>
			</div> <!-- .comment_info -->
			<div class="original mb20 tl">${cvo.comment_content }</div>
			<div class="modify" style="display: none; margin-top: 6px;"></div>
			<form action="comment_modify" method="post" id="form${cvo.comment_no }">
				<input type="hidden" name="comment_content" value="${cvo.comment_content }">
				<input type="hidden" name="comment_no" value="${cvo.comment_no }">
				<input type="hidden" name="comment_bno" value="${cvo.comment_bno }">
				<input type="hidden" name="comment_category" value="${cvo.comment_category }">
			</form>
		</div> <!-- .comment_list -->
	</c:forEach>
	
	<script type="text/javascript">
		$(".btn-reply").on("click", function() {
			alert("답글");
		});
		
		/*
		$(".btn-modify-save").on("click", function() {
			var $div = $(this).parent("div.comment_list");

			//$div.children(".modify").css("height", $div.children(".original").height() - 6);
			// 수정했을 때 댓글 길이에 따라 스크롤이 생기는 것을 막기 위해 높이를 고정시킴
			
			if($(this).text() == "수정") {
	
				var tag = "<textarea style='width: 99%; height: 90%; resize: none'>"
						+ $div.children(".original").html().replace(/<br>/g, "\n");	
						+ "</textarea>";
				$div.children(".modify").html(tag);
				display($div, "m");
			} else {
				var comment = { id: $div.data("id"), content: $div.children(".modify").find("textarea").val() };
				
				$.ajax({
					url: "board/comment/update",
					data: JSON.stringify( comment ),
					type: "post",
					contentType: "application/json",
					success: function(data) {
						alert("댓글 변경 " + data);
						comment_list();
					}, error: function(req, text) {
						alert(text + " : " + req.status)
					}
				});
			}
		});

		$(".btn-delete-cancel").on("click", function() {
			var $div = $(this).closest("div");
			if( $(this).text() == "취소" ) {
				display($div, "d");
			} else {
				if (confirm("정말 삭제?")) {
					$.ajax({
						url: "board/comment/delete/" + $div.data("id"),
						success: function() {
							comment_list();
						}, error: function(req, text) {
							alert(text + " : " + req.status);
						}
					});
				}
			}
		});
		*/
		/*
		function display(div, mode) {
			// 수정 상태일 때 : 저장/취소 버튼, 원글은 보이지 않도록, 수정글은 보이도록
			// 보기 상태일 때 : 저장/취소 버튼/원글은 보이도록, 수정글은 보이지 않도록
			div.find(".btn-modify-save").text(mode == "m" ? "저장" : "수정");
			div.find(".btn-delete-cancel").text(mode == "m" ? "취소" : "삭제");
			div.children(".original").css("display", mode == "m" ? "none" : "block");
			div.children(".modify").css("display", mode == "m" ? "block" : "none");

		}
		*/
	</script>	
</body>
</html>