<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>불판 - 채팅</title>
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/common.css?v=<%=new java.util.Date().getTime()%>">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<!-- fontawesome을 사용하기 위해 라이브러리 추가 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/js/all.min.js"></script>
</head>
<body>
	<tiles:insertAttribute name="content2"/>
</body>
</html>