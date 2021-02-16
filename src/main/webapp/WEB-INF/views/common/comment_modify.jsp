<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	form { width: 1000px; margin: 0 auto; }
	.comment_wrap { background-color: #f2f2f2; }
	.title {
		width: 1000px;
	    margin: 30px auto; padding: 20px 0;
    	font-size: 20px; font-weight: 900;
    	border-top: 2px solid #000;
    	border-bottom: 2px solid #000;
    	background-color: #f7f7f7;
	}
</style>
</head>
<body>
	<div class="title">댓글 수정</div>
	<form action="comment_update" method="post">
		<input type="hidden" name="comment_no" value="${comment_no }">
		<input type="hidden" name="comment_bno" value="${comment_bno }">
		<input type="hidden" name="comment_category" value="${comment_category }">
		<div class="comment_wrap">
			<div id="comment_list" class="left"></div>
			<div id="comment_regist">
				<textarea name="comment_content" id="comment">${comment_content }</textarea>
			</div>
			<div>
				<div style="padding: 35px 0 10px 0;">
					<a class="btn-fill" style="display: inline;" onclick="go_update();">등&nbsp;&nbsp;&nbsp;록</a>
					<a class="btn-empty">돌아가기</a>
				</div>
			</div>
		</div> <!-- .comment_wrap -->
	</form>
	
	<!-- SmartEditor 에서 필요한 javascript 로딩  -->
	<script src="smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>	
	<script type="text/javascript">

		window.onload = function() {
			if("${login_info}" == "") location.href = "/deuqoo";
		}
		
		var oEditors = [];
		
		nhn.husky.EZCreator.createInIFrame({ 
			oAppRef : oEditors, 
			elPlaceHolder : "comment", 
			//저는 textarea의 id와 똑같이 적어줬습니다. 
			sSkinURI: "smarteditor/SmartEditor2Skin_C.html",
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

		function go_update() {
			oEditors.getById["comment"].exec("UPDATE_CONTENTS_FIELD", []);
			$("form").submit();
		}

		//oEditors.getById["comment"].exec("SET_IR", ["${comment_content}"]);
		
		/*
		function comment_regist() {
			if(confirm("댓글을 등록하시겠습니까?")) { 
				$.ajax({
					url: "board/comment/regist",
					data: { comment_content: oEditors.getById["comment"].getIR(), 
							//comment_content: $("#comment").val(), 
							// → 스마트 에디터로 인해 textarea 값이 바로 출력되지 않고 한번 reload된 후에 출력됨
							comment_bno:${vo.review_no},
							comment_category: "${vo.board_category}" },
					success: function(response) {
						if(response == 1) {
							alert("댓글이 등록되었습니다.");
							$("#comment").val("");	//입력한 댓글 초기화
							comment_list();
						}
					}, error: function(req, text) {
						alert(text + ":" + req.status);
					}
				});
			}
		} //comment_regist()
		
		$(function() {
			$("#commentBtn").click(function() { 
				oEditors.getById["comment"].exec("UPDATE_CONTENTS_FIELD", []); 

				var content = document.getElementById("comment").value;
				 
				if(content == "" || content == null || content == '&nbsp;' || 
				   content == '<br>' || content == '<br/>' || 
				   content == '<p>&nbsp;</p>') { 
					   alert("본문을 작성해주세요."); 
					   oEditors.getById["comment"].exec("FOCUS"); //포커싱 
					   return; 
				}

			}); 
		});
		*/
	</script>
</body>
</html>