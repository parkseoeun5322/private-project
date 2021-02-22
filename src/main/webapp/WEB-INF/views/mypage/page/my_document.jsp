<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="data-list">
		<h1>작성글 보기</h1>
		<p>Total: ${page.totalList }</p>
		<table class="table-style-b">
			<tr>
				<th class="w-px80">번호</th>
				<th class="w-px80">게시판</th>
				<th class="">제목</th>
				<th class="w-px120">작성일자</th>
			</tr>	
			<c:forEach items="${page.list }" var="vo">
				<tr>
					<td>${vo.board_rownum }</td>
					<td>${vo.board_category }</td>
					<td>
						<a style="font-weight: 500;" class="mr10 my_title" 
							href="javascript:go_detail(${vo.board_no }, '${vo.board_category }', '${vo.board_title }')">${vo.board_title }</a>
					</td>
					<td>${vo.board_writedate }</td>
				</tr>
			</c:forEach>
		</table>
	</div>	<!-- .data-list -->
	<div class="pageSet">
		<jsp:include page="/WEB-INF/views/include/page.jsp"/>
	</div>
</body>
</html>