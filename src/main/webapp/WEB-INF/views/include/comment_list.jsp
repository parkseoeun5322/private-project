<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach items="${list }" var="vo">
		<div data-id="${vo.comment_no }">
			${vo.name } [ ${vo.comment_writedate } ]
			<!-- 로그인한 사용자가 작성한 댓글에 대해 수정/삭제 가능 -->
			<c:if test="${login_info.member_id eq vo.comment_writer }">
				<span style="float: right;">
					<a class="btn-fill-s btn-modify-save">수정</a>
					<a class="btn-fill-s btn-delete-cancel">삭제</a>
				</span>
			</c:if>
			<div class="original">${fn:replace(fn:replace(vo.comment_content, lf, "<br/>"), crlf, "<br/>") }</div>
			<div class="modify" style="display: none; margin-top: 6px;"></div>
		</div>
		<hr>
		
	</c:forEach>
	
	<script type="text/javascript">
		$(".btn-modify-save").on("click", function() {
			var $div = $(this).closest("div");

			$div.children(".modify").css("height", $div.children(".original").height() - 6);
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

		function display(div, mode) {
			/* 수정 상태일 때 : 저장/취소 버튼, 원글은 보이지 않도록, 수정글은 보이도록 */
			/* 보기 상태일 때 : 저장/취소 버튼/원글은 보이도록, 수정글은 보이지 않도록 */
			div.find(".btn-modify-save").text(mode == "m" ? "저장" : "수정");
			div.find(".btn-delete-cancel").text(mode == "m" ? "취소" : "삭제");
			div.children(".original").css("display", mode == "m" ? "none" : "block");
			div.children(".modify").css("display", mode == "m" ? "block" : "none");

		}
	</script>	
</body>
</html>