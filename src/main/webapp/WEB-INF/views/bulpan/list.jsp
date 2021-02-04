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
	function go_delete(no) {
		if(confirm("정말 삭제하시겠습니까?")) {
			$("[name=bulpan_no]").val(no);
			$("form").attr("action", "delete.bu");
			$("form").submit();
		}
	}
	function go_modify(no) {
		$("[name=bulpan_no]").val(no);
		$("form").attr("action", "modify.bu");
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
		).click(function() {
			if("${login_info}" == "") { 
				alert("로그인이 필요한 페이지입니다."); 
				return false; 
			}
		}); 
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
					<td>${vo.bulpan_rownum }</td>
					<td>${vo.board_category }</td>
					<td>
						<a onclick="go_submit('${vo.bulpan_header }')">${vo.bulpan_header }</a>)
						<a href="javascript:void(window.open('chat.bu?chatting_roomNo=${vo.bulpan_no }', '', 'width=400'))">${vo.bulpan_title }</a>
						<c:if test="${login_info.member_id eq vo.bulpan_writer}">
							<a class="fr" id="deleteBtn" href="javascript:go_delete(${vo.bulpan_no })">삭제</a>
							<a class="fr" id="resetBtn" href="javascript:go_modify(${vo.bulpan_no })">수정</a>
						</c:if>
					</td>
					<td>${vo.bulpan_writedate }</td>
					<td>${vo.bulpan_readcnt }</td>
				</tr>
			</c:forEach>
		</table>
	</div>	<!-- .data-list -->
	<div class="list-bottom">
		<form action="list.bu" method="post" class="form-style-b">
			<input type="hidden" name="curPage" value="1">
			<input type="hidden" name="header" value="${page.header }">
			<input type="hidden" name="division" value="${page.division }">
			<input type="hidden" name="bulpan_no">
			<div>
				<ul>
					<li>
						<select name="search" class="w-px80">
							<option value="bulpan_title">제목</option>
						</select>
					</li>
					<li><input type="text" name="keyword" class="w-px200" value="${page.keyword }"></li>
					<li class="w-px50"><a class="btn-fill" onclick="$('form').submit();">검색</a></li>
				</ul>
				<ul>
					<c:if test="${not empty login_info }">
						<li class="w-px70">
							<a href="new.bu" class="btn-fill">글쓰기</a>
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