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
		if("${login_info}" == "") {
			alert("로그인이 필요한 페이지입니다.");
			location.href = "/deuqoo";
		}
	}
</script>
</head>
<body>
	<div class="input-wrap">
		<form action="insert.re" method="post" class="form-style-i" enctype="multipart/form-data">
			<ul>
				<li>
					<select>
							<option disabled selected>말머리 찾기</option>
					</select>
				</li>
				<li>
					<input type="text" name="review_header" class="need" title="말머리"
							placeholder="말머리 입력" onfocus="this.placeholder=''"
							onblur="this.placeholder='말머리 입력'">
				</li>
			</ul>
			<ul>
				<li>
					<select name="review_division" class="selecDiv" title="분류">
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
					<input type="text" name="review_title" class="need" title="제목"
							placeholder="제목" onfocus="this.placeholder=''"
							onblur="this.placeholder='제목'">
				</li>
			</ul>
			<ul>
				<li>
					<textarea name="review_content" id="smartEditor" title="내용"></textarea>
				</li>
			</ul>
		</form>
		<div class="btnSet">
			<a class="btn-fill" id="saveBtn" onclick="go_submit();">등록</a>
			<a class="btn-empty" href="list.re">취소</a>
		</div>
	</div>
	<script type="text/javascript" src="js/need_check.js"></script>
	<!-- SmartEditor 에서 필요한 javascript 로딩  -->
	<script src="smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
		var oEditors = [];
		
		nhn.husky.EZCreator.createInIFrame({ 
			oAppRef : oEditors, 
			elPlaceHolder : "smartEditor", 
			//저는 textarea의 id와 똑같이 적어줬습니다. 
			sSkinURI: "smarteditor/SmartEditor2Skin.html",
			//경로를 꼭 맞춰주세요! 
			fCreator : "createSEditor2", 
			htParams : { 
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseToolbar : true, 
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseVerticalResizer : true, 
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseModeChanger : false 
			} 
		});

		function go_submit() {
			if(necessary ()) {
				var content = oEditors.getById["smartEditor"].getIR();
				
				// 공백 제거 유효성 검사
				var text = content.replace(/[<][^>]*[>]/gi, "");
				text = text.replace(/&nbsp;/gi, "");
				text = text.trim();

				if (text == "") { 
					alert("내용을 입력해주세요."); 
					oEditors.getById["smartEditor"].exec("FOCUS"); //포커싱 
					return; 
				} else {
					oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []);
					$("form").submit();
				}
			}
		} //go_submit()

	</script>
</body>
</html>