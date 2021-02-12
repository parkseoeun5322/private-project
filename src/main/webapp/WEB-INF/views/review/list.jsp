<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css"> 
</style>
<script type="text/javascript" charset="utf-8">
	function go_detail(no) {
		$("[name=review_no]").val(no);
		$("form").attr("action", "detail.re");
		$("form").submit();
	}

	function go_submit(data) {
		$("[name=header]").val(data);
		$("form").submit();
	}

	$(function() {
		
		$(".table-style-b td a").hover(
			function() {
	        	$(this).css('text-decoration','underline');
	    	}, function() {
	        	$(this).css('text-decoration','');
	        }
		);
	});
</script>
</head>
<body>
	<div class="divSet">
		<jsp:include page="/WEB-INF/views/include/division.jsp"/>
	</div>
	<div class="data-list">
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
					<td>${vo.review_rownum }</td>
					<td>${vo.board_category }</td>
					<td>
						<a onclick="go_submit('${vo.review_header }')">${vo.review_header }</a>)
						<a class="mr10" href="javascript:go_detail(${vo.review_no })">${vo.review_title }</a>
						<span style="font-weight: 900;">${vo.review_commentcnt }</span>
					</td>
					<td>${vo.review_writedate }</td>
					<td>${vo.review_readcnt }</td>
				</tr>
			</c:forEach>
		</table>
	</div>	<!-- .data-list -->
	<div class="list-bottom">
		<form action="list.re" method="post" class="form-style-b">
			<input type="hidden" name="curPage" value="1">
			<input type="hidden" name="header" value="">
			<input type="hidden" name="division" value="">
			<input type="hidden" name="review_no">
			<div>
				<ul>
					<li>
						<select name="search" class="w-px80">
							<option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>
							<option value="review_title" ${page.search eq 'title' ? 'selected' : '' }>제목</option>
							<option value="review_content" ${page.search eq 'content' ? 'selected' : '' }>내용</option>
						</select>
					</li>
					<li><input type="text" name="keyword" class="w-px200" value="${page.keyword }"></li>
					<li class="w-px50"><a class="btn-fill" onclick="$('form').submit();">검색</a></li>
				</ul>
				<ul>
					<c:if test="${not empty login_info }">
						<li class="w-px70">
							<a href="new.re" class="btn-fill">글쓰기</a>
						</li>
					</c:if>
				</ul>
			</div>
		</form>
	</div>
	<div class="pageSet">
		<jsp:include page="/WEB-INF/views/include/page.jsp"/>
	</div>
</body>
</html>