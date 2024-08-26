<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>드쿠</title>
		<link rel="icon" type="image/x-icon" href="img/main_logo.png">	<!-- 타이틀 바의 아이콘 설정 -->
		<link rel="stylesheet" type="text/css" href="css/basic.css">
		<link rel="stylesheet" type="text/css" href="css/board.css">
		<link rel="stylesheet" type="text/css" href="css/common.css?v=<%=new java.util.Date().getTime()%>">
		<script type="text/javascript" 
				src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<!-- fontawesome을 사용하기 위해 라이브러리 추가 -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/js/all.min.js"></script>
	</head>
<body>
	<tiles:insertAttribute name="header"/>
	<div id="content">
		<tiles:insertAttribute name="content"/>
	</div>
	<tiles:insertAttribute name="footer"/>
</body>
</html>
