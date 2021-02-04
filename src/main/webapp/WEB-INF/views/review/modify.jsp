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
		<form action="update.re" method="post" class="form-style-i" enctype="multipart/form-data">
			<input type="hidden" name="review_no" value="${vo.review_no }">
			<ul>
				<li>
					<select>
							<option disabled selected>말머리 찾기</option>
					</select>
				</li>
				<li>
					<input type="text" name="review_header" class="need" title="말머리" value="${vo.review_header }">
				</li>
			</ul>
			<ul>
				<li>
					<select name="review_division" id="selecDiv" title="분류">
							<option disabled selected>분류</option>
							<option value="한드" ${vo.review_division eq '한드' ? 'selected' : '' }>한드</option>
							<option value="미드" ${vo.review_division eq '미드' ? 'selected' : '' }>미드</option>
							<option value="영드" ${vo.review_division eq '영드' ? 'selected' : '' }>영드</option>
							<option value="일드" ${vo.review_division eq '일드' ? 'selected' : '' }>일드</option>
							<option value="중드" ${vo.review_division eq '중드' ? 'selected' : '' }>중드</option>
							<option value="기타" ${vo.review_division eq '기타' ? 'selected' : '' }>기타</option>
					</select>
				</li>			
				<li>
					<input type="text" name="review_title" class="need" title="제목" value="${vo.review_title }">
				</li>
			</ul>
			<ul>
				<li>
					<textarea name="review_content" id="smartEditor" title="내용" >${vo.review_content }</textarea>
				</li>
			</ul>
		</form>
		<div class="btnSet">
			<a class="btn-fill" id="saveBtn" onclick="if( necessary() ) { $('form').submit() }">등록</a>
			<a class="btn-empty" href="javascript:history.go(-1)">취소</a>
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
				bUseVerticalResizer : false, 
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseModeChanger : false 
			} 
		}); 
		
		$(function() {
			$("#saveBtn").click(function() { 
				oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []); 
				//textarea의 id를 적어줍니다. 
				var selecDiv = $("#selecDiv > option:selected").val();
				var content = document.getElementById("smartEditor").value;
				
				if (selecDiv == "") { 
					alert("분류를 선택해주세요"); 
					return; 
				}
				 
				if(content == "" || content == null || content == '&nbsp;' || 
				   content == '<br>' || content == '<br/>' || 
				   content == '<p>&nbsp;</p>') { 
					   alert("본문을 작성해주세요."); 
					   oEditors.getById["smartEditor"].exec("FOCUS"); //포커싱 
					   return; 
				} //이 부분은 스마트에디터 유효성 검사 부분이니 참고하시길 바랍니다.
				
				if(confirm("글을 수정하시겠습니까?")) { 
					$("form").submit(); 
				}
			}); 
		});

	</script>
</body>
</html>