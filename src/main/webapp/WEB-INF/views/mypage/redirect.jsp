<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" action="${url }">
	<input type="text" name="member_id" value="${member_id }" />
	<input type="text" name="myPage" value="${myPage }" />
</form>
<script>$("form").submit()</script>