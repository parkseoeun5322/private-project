<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	// 로그아웃 시 메인으로 돌아감
	window.onload = function() { 
		if("${login_info}" == "") location.href = "/deuqoo";
	}
</script>
</head>
<body>
	<div class="input-wrap">
		<form action="update.bu" method="post" class="form-style-i">
			<ul>
				<li>
					<select>
							<option disabled selected>말머리 찾기</option>
					</select>
				</li>
				<li>
					<input type="text" name="bulpan_header" class="need" title="말머리"
							placeholder="말머리 입력" value="${vo.bulpan_header }"
							onfocus="this.placeholder=''"
							onblur="this.placeholder='말머리 입력'">
				</li>
			</ul>
			<ul>
				<li>
					<input type="text" name="bulpan_title" class="need" title="제목"
							placeholder="제목" value="${vo.bulpan_title }"
							onfocus="this.placeholder=''"
							onblur="this.placeholder='제목'">
				</li>
			</ul>
			<ul style="margin: 150px 0;"></ul>
			<input type="hidden" name="bulpan_no" value="${vo.bulpan_no }">
		</form>
		<div class="btnSet">
			<a class="btn-fill" onclick="if( necessary() ) { $('form').submit() }">등록</a>
			<a class="btn-empty" href="javascript:history.go(-1)">취소</a>
		</div>
	</div>
	<script type="text/javascript" src="js/need_check.js"></script>
</body>
</html>