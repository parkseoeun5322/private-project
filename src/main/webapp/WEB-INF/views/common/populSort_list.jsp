<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.data-list { width: 1000px; margin: 0 auto; }
	.data-list h2 { margin: 50px auto 0; text-align: left; font-weight: 600; }
	.data-list > p { color: #787878; text-align: left; margin: 25px 0 10px 0; }
	.title:hover { text-decoration: underline; }
	.pageSet { margin: 30px 0; }
</style>
<script type="text/javascript">
	function go_detail(no, category, title) {
		if(category == "불판") {
			window.open('chat.bu?chatting_roomNo=' + no + '&chatting_title=' + title, '', 'width=400');
		} else if(category == "자료") {
			//$("#bno").attr("name", "drama_board_no").val(no);
			$("#bnoForm").attr("action", "detail.info?drama_board_no=" + no).submit();
		} else if(category == "상품") {
			//$("#bno").attr("name", "shopping_no").val(no);
			$("#bnoForm").attr("action", "detail.tv?shopping_no=" + no).submit();
		} else if(category == "리뷰") {
			//$("#bno").attr("name", "review_no").val(no);
			$("#bnoForm").attr("action", "detail.re?review_no=" + no).submit();
		} else if(category == "블레") {
			//$("#bno").attr("name", "bluray_no").val(no);
			$("#bnoForm").attr("action", "detail.bl?bluray_no=" + no).submit();
		}
	}
</script>
</head>
<body>
	<div class="data-list">
		<h2>"인기순(조회수)" 글 목록</h2>
		<p>Total List: ${page.totalList }</p>
		<table class="table-style-b">
			<tr>
				<th class="w-px80">글 번호</th>
				<th class="w-px80">게시판</th>
				<th class="">제목</th>
				<th class="w-px120">작성일자</th>
				<th class="w-px80">조회수</th>
			</tr>
			<c:forEach items="${page.list }" var="vo">
				<tr>
					<td>${vo.board_rownum }</td>
					<td>${vo.board_category }</td>
					<td>
						<a style="cursor: auto;">${vo.board_header }</a>)
						<a class="mr10 title" 
							href="javascript:go_detail(${vo.board_no }, '${vo.board_category }', '${vo.board_title }')">${vo.board_title }</a>
						<span style="font-weight: 900;">${vo.board_commentcnt }</span>
					</td>
					<td>${vo.board_writedate }</td>
					<td>${vo.board_readcnt }</td>
				</tr>
			</c:forEach>
		</table>
		<form action="list.po" method="post" id="bnoForm">
			<input type="hidden" name="curPage" value="1">
			<input type="hidden" name="returnList" value="Y">
		</form>
	</div>	<!-- .data-list -->
	<div class="pageSet">
		<jsp:include page="/WEB-INF/views/include/page.jsp"/>
	</div>
</body>
</html>