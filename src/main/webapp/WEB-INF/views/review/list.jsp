<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.list-top { width: 1000px; margin: 20px auto 0; }
 	.list-top > ul { border-bottom: 1px solid #787878; }
 	.list-top > ul::after { content: ""; display: block; clear: both; }
	.list-top > ul > li { 
		float: left; 
		border: 1px solid #ddd; 
		border-top: 0; border-bottom: 0;
		background: #fdfdfd; }
	.list-top > ul > li:not(:last-child) { border-right: 0; }
	.list-top > ul > li.on {
		border: 1px solid #787878;
		border-bottom: 1px solid #fff;
		margin: 0 0 -1px 0;
		background: transparent;
	}
	.list-top > ul > li.on > a { color: #000; padding-top: 1px; font-weight: 700; }
	.list-top > ul > li > a {
		float: left;
		border-top: 1px solid #ddd; 
		display: block;
		height: 35px; line-height: 35px; 
		padding: 0 25px; 
		color: #6b6b6b; font-size: 14px; 
	} 

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
		var $buttons = $(".list-top > ul > li");

		$buttons.on("click", function() {
			$buttons.removeClass("on");
			$(this).addClass("on");
		});
		
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
	<div class="list-top">
		<ul>
			<li class="on"><a data-div="" href="">전체</a></li>
			<li><a data-div="" href="">한드</a></li>
			<li><a data-div="" href="">미드</a></li>
			<li><a data-div="" href="">영드</a></li>
			<li><a data-div="" href="">일드</a></li>
			<li><a data-div="" href="">중드</a></li>
			<li><a data-div="" href="">기타</a></li>
		</ul>
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
					<td>${vo.review_category }</td>
					<td>
						<a onclick="go_submit('${vo.review_header }')">${vo.review_header }</a>)
						<a href="javascript:go_detail(${vo.review_no })">${vo.review_title }</a>
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
			<input type="hidden" name="header" value="${page.header }">
			<input type="hidden" name="review_no">
			<div>
				<ul>
					<li>
						<select name="search" class="w-px80">
							<option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>
							<option value="title" ${page.search eq 'title' ? 'selected' : '' }>제목</option>
							<option value="content" ${page.search eq 'content' ? 'selected' : '' }>내용</option>
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