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
		<form action="insert.bu" method="post" class="form-style-i">
			<ul>
				<li>
					<select>
							<option disabled selected>말머리 찾기</option>
					</select>
				</li>
				<li>
					<input type="text" name="bulpan_header" class="need" title="말머리"
							placeholder="말머리 입력" onfocus="this.placeholder=''"
							onblur="this.placeholder='말머리 입력'">
				</li>
			</ul>
			<ul>
				<li>
					<select name="bulpan_division" id="selecDiv" title="분류" class="need_div">
							<option disabled selected>분류</option>
							<option value="한드">한드</option>
							<option value="미드">미드</option>
							<option value="영드">영드</option>
							<option value="일드">일드</option>
							<option value="중드">중드</option>
							<option value="기타">기타</option>
					</select>
				</li>			
				<li>
					<input type="text" name="bulpan_title" class="need" title="제목"
							placeholder="제목" onfocus="this.placeholder=''"
							onblur="this.placeholder='제목'">
				</li>
			</ul>
			<ul style="margin: 150px 0;"></ul>
		</form>
		<div class="btnSet">
			<a class="btn-fill" onclick="if( necessary() ) { $('form').submit() }">등록</a>
			<a class="btn-empty" href="list.bu">취소</a>
		</div>
	</div>
	<script type="text/javascript" src="js/need_check.js"></script>
</body>
</html>