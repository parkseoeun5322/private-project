<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" action="${url }">
	<input type="text" name="bluray_no" value="${bluray_no }" />
	<input type="text" name="curPage" value="${page.curPage }" />
	<input type="text" name="search" value="${page.search }" />
	<input type="text" name="keyword" value="${page.keyword }" />
	<input type="text" name="pageList" value="${page.pageList }" />
	<input type="text" name="member_id" value="${member_id }" />
</form>
<script>$("form").submit()</script>