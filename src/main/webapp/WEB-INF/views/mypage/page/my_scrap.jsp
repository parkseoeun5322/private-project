<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
</style>
<script type="text/javascript">
	function scrap_delete(bno, no, category) {
		if(confirm("스크랩을 취소하시겠습니까?")) {
			$.ajax({
				url: "scrap_cancel",
				data: { scrap_boardNo: bno, 
						scrap_no: no,
						scrap_category: category },
				success: function(data) {
					console.log(data);
					if(data) {
						alert("스크랩이 취소되었습니다.");
						window.location.reload();
					} else {
						alert("관리자에게 문의하세요.");
					}
				}, //success
				error: function(req, text) {
					console.log(text + " : " + req.status);
					alert("관리자에게 문의하세요.");
				}
			});
		}
	} //scrap_delete()
</script>
</head>
<body>
	<div class="data-list">
		<h1>스크랩 보기</h1>
		<p>Total: ${page.totalList }</p>
		<table class="table-style-b">
			<tr>
				<th class="w-px80">게시판</th>
				<th class="">제목</th>
				<th class="w-px120">날짜</th>
				<th class="w-px80">취소</th>
			</tr>	
			<c:forEach items="${page.list }" var="vo">
				<c:if test="${not empty vo.scrap_content }">
					<tr>
						<td>${vo.scrap_category }</td>
						<td>
							<a class="mr10 my_title" href="javascript:go_detail(${vo.scrap_boardNo }, '${vo.scrap_category }')">${vo.scrap_title }</a>
						</td>
						<td>${vo.scrap_date }</td>
						<td><a class="my_delete" onclick="scrap_delete(${vo.scrap_boardNo}, ${vo.scrap_no }, '${vo.scrap_category }');">취소</a></td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</div>	<!-- .data-list -->
	<div class="list-bottom">
		<form action="scrap.my" method="post" class="form-style-b">
			<input type="hidden" name="curPage" value="1">
			<input type="hidden" name="member_id" value="${page.member_id }">
			<div style="width: 500px;">
				<ul>
					<li>
						<select name="search" class="w-px80">
							<option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>
							<option value="scrap_title" ${page.search eq 'title' ? 'selected' : '' }>제목</option>
							<option value="scrap_content" ${page.search eq 'content' ? 'selected' : '' }>내용</option>
						</select>
					</li>
					<li><input type="text" name="keyword" class="w-px200" value="${page.keyword }"></li>
					<li class="w-px50"><a class="btn-fill" onclick="$('form').submit();">검색</a></li>
				</ul>
			</div>
		</form>
	</div>
	<div class="pageSet">
		<jsp:include page="/WEB-INF/views/include/page.jsp"/>
	</div>
</body>
</html>