<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div class="list-top">
	<ul>
		<li ${division eq 'to' ? 'class="on"' : '' }>
			<c:if test="${category eq 'bu' }">
				<a data-div="" href="list.bu">전체</a>
			</c:if>
			<c:if test="${category eq 're' }">
				<a data-div="" href="list.re">전체</a>
			</c:if>
		</li>
		<li ${division eq 'ko' ? 'class="on"' : '' }><a onclick="go_div('한드')" >한드</a></li>
		<li ${division eq 'am' ? 'class="on"' : '' }><a onclick="go_div('미드')">미드</a></li>
		<li ${division eq 'br' ? 'class="on"' : '' }><a onclick="go_div('영드')">영드</a></li>
		<li ${division eq 'ja' ? 'class="on"' : '' }><a onclick="go_div('일드')">일드</a></li>
		<li ${division eq 'ch' ? 'class="on"' : '' }><a onclick="go_div('중드')">중드</a></li>
		<li ${division eq 'et' ? 'class="on"' : '' }><a onclick="go_div('기타')">기타</a></li>
	</ul>
</div>
<script type="text/javascript">
	function go_div(data) {
		$("[name=division]").val(data);
		$("form").submit();
	}
</script>
