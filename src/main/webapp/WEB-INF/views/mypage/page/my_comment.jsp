<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function comment_delete(no) {
		$("[name=comment_no]").val(no);
		$("#commentForm").submit();
	}
</script>
</head>
<body>
	<div class="data-list">
		<h1>작성 댓글 보기</h1>
		<p>Total: ${page.totalList }</p>
		<table class="table-style-b">
			<tr>
				<th class="w-px80">게시판</th>
				<th class="">제목</th>
				<th class="w-px200">문서 제목</th>
				<th class="w-px120">작성일자</th>
				<th class="w-px70">삭제</th>
			</tr>	
			<c:forEach items="${page.list }" var="vo">
				<tr>
					<td>${vo.comment_category }</td>
					<td>
						<a style="font-weight: 500;" class="mr10 my_title" 
							href="javascript:go_detail(${vo.comment_bno }, '${vo.comment_category }', '${vo.comment_title }')">${vo.comment_content }</a>
					</td>
					<c:if test="${empty vo.comment_title }">
						<td style="color: #ff0000">삭제된 글</td>
					</c:if>
					<c:if test="${not empty vo.comment_title }">
						<td>${vo.comment_title }</td>
					</c:if>
					<td><fmt:formatDate value="${vo.comment_writedate }" pattern="yyyy-MM-dd"/></td>
					<td><a class="my_delete" style="margin: 0 0 0 3px;" onclick="comment_delete(${vo.comment_no})">삭제</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>	<!-- .data-list -->
	<form id="commentForm" action="comment_delete" method="post">
		<input type="hidden" name="comment_no" value="">
		<input type="hidden" name="returnList" value="Y">
		<input type="hidden" name="member_id" value="${login_info.member_id }">
	</form>
	<div class="pageSet">
		<jsp:include page="/WEB-INF/views/include/page.jsp"/>
	</div>
</body>
</html>