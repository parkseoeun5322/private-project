<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" action="${url }">
	<input type="text" name="bulpan_no" value="${bulpan_no }" />
	<input type="text" name="curPage" value="${page.curPage }" />
	<input type="text" name="search" value="${page.search }" />
	<input type="text" name="keyword" value="${page.keyword }" />
	<input type="text" name="pageList" value="${page.pageList }" />
</form>
<script>$("form").submit()</script>