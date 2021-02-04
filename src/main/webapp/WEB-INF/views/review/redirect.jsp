<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" action="${url }">
	<input type="text" name="review_no" value="${review_no }" />
	<input type="text" name="curPage" value="${page.curPage }" />
	<input type="text" name="search" value="${page.search }" />
	<input type="text" name="keyword" value="${page.keyword }" />
	<input type="text" name="pageList" value="${page.pageList }" />
	<input type="text" name="viewType" value="${page.viewType }" />
</form>
<script>$("form").submit()</script>