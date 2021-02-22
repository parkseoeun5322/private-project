<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
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
			<c:if test="${category eq 'tv' }">
				<a data-div="" href="list.tv">전체</a>
			</c:if>
			<c:if test="${category eq 'dr' }">
				<a data-div="" href="list.info">전체</a>
			</c:if>
			<c:if test="${category eq 'bl' }">
				<a data-div="" href="list.bl">전체</a>
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
