<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/basic.css">
<link rel="stylesheet" type="text/css" href="css/common.css?v=<%=new java.util.Date().getTime()%>">
<title>Insert title here</title>
<style type="text/css">
	p { line-height: 33px; } /* 댓글 개행 시 줄간격 처리 */
	.comment_list { 
		padding: 10px 25px;
    	border-bottom: 1px solid #ddd;
   		margin: 0 0 20px 0; 
   	}
	.comment_info { overflow: hidden; padding: 8px 0; height: 35px; }
	.comment_info > span:first-child > a { font-weight: 900; }
	.comment_info > span:first-child > span { font-size: 12px; color: #aaa; }
	.btn-fill-s { padding: 2px 7px; line-height: 26px; font-size: 13px; border-radius: 5px; }
	.btn-modify-save { background-color: #787878; color: #fff !important; border: 1px solid #787878; }
	.btn-delete-cancel, .btn-reply { color: #787878; border: 1px solid #787878; }
	.comment_btn { width: 60px; margin: 10px 0 0 860px; }
	.reply { position: relative; margin: 0 0 0 30px; }
	.reply > svg { position: absolute; top: 7px; left: -25px; color: #ccc; }
</style>
</head>
<body>
	<c:forEach items="${list }" var="cvo">
		<div data-id="${cvo.comment_no }" class="comment_list">
		<c:if test="${cvo.comment_reply eq 'Y' }">
			<div class="reply">
				<i class="fas fa-share fa-flip-vertical"></i>
		</c:if>
				<div class="comment_info">
					<span class="fl">
						<c:if test="${board_writer eq cvo.comment_writer }">
							<a href="" class="mr10" style="color: #19d48c;">W</a> 
						</c:if>
						<c:if test="${board_writer ne cvo.comment_writer }">
							<a href="" class="mr10">드덕 ${cvo.comment_nickname }</a> 
						</c:if>
						<span>
							<fmt:formatDate value="${cvo.comment_writedate }" pattern="yy/MM/dd HH:mm:ss"/>
						</span>
					</span>
					<!-- 로그인한 사용자가 작성한 댓글에 대해 수정/삭제 가능 -->
					<span class="fr mr20">
						<c:if test="${login_info.member_id eq cvo.comment_writer }">
							<a class="btn-fill-s btn-modify-save" onclick="$('#form${cvo.comment_no }').submit();">수정</a>
							<a class="btn-fill-s btn-delete-cancel">삭제</a>
						</c:if>
						<c:if test="${cvo.comment_reply eq 'N' }">	<!-- 대댓글 작성시 -->
							<a class="btn-fill-s btn-reply" onclick="go_reply(${cvo.comment_no });">댓글</a>
						</c:if>
						<c:if test="${cvo.comment_reply eq 'Y' }"> <!-- 대대댓글 작성시 -->
							<c:if test="${board_writer eq cvo.comment_writer }">	<!-- 작성자일 경우 -->
								<a class="btn-fill-s btn-reply" onclick="go_reply(${cvo.comment_no }, 'W');">댓글</a>
							</c:if>
							<c:if test="${board_writer ne cvo.comment_writer }">
								<a class="btn-fill-s btn-reply" onclick="go_reply(${cvo.comment_no }, 'rere');">댓글</a>
							</c:if>
						</c:if>
					</span>
				</div> <!-- .comment_info -->
				<div class="original mb20 tl">${cvo.comment_content }</div>
				<c:if test="${cvo.comment_reply eq 'Y' }">
					</div>	
				</c:if>
				<form action="comment_modify" method="post" id="form${cvo.comment_no }">
					<input type="hidden" name="comment_content" value='${cvo.comment_content }'>
					<input type="hidden" name="comment_no" value="${cvo.comment_no }">
					<input type="hidden" name="comment_bno" value="${cvo.comment_bno }">
					<input type="hidden" name="comment_category" value="${cvo.comment_category }">
					<input type="hidden" name="comment_nickname" value="${cvo.comment_nickname }">
					<input type="hidden" name="comment_root" value="${cvo.comment_root }">
				</form>
		</div> <!-- .comment_list -->
	</c:forEach>	
	<!-- SmartEditor 에서 필요한 javascript 로딩  -->
	<script src="smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
		var oEditors2 = [];
		var first = true;

		// 스마트 에디터가 적용된 textarea를 추가해주는 메소드
		function addEditor(tag, html) {
			$(tag).append(html);	
			nhn.husky.EZCreator.createInIFrame({ 
				oAppRef : oEditors2, 
				elPlaceHolder : "recomment", 
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
			
		} //addEditor()
		
		// 대댓글 작성 시 (댓글의 댓글 버튼 클릭 시)
		function go_reply(comment_no, status) {
			var formTag = "#form" + comment_no;
			var textTag = ".text" + comment_no;
			var textHtml = '<textarea name="comment_recontent" id="recomment" class="text' 
						+ comment_no + '" style="width: 898px;"></textarea>'
						+ '<a class="btn-fill comment_btn" onclick="save_reply(' + comment_no + ')">등록</a> ';
			if(status == 'rere') {
				var nickname = $(formTag).find("input[name=comment_nickname]").val();
				var text = "<p><span style='color: #19d48c; font-weight: 900;'>@" + nickname + "</span>&nbsp;</p>"
				textHtml = '<textarea name="comment_recontent" id="recomment" class="text' 
					+ comment_no + '" style="width: 898px;">' + text + '</textarea>'
					+ '<a class="btn-fill comment_btn" onclick="save_reply(' + comment_no + ',0)">등록</a>';
			} else if(status == 'W') {
				var text = "<p><span style='color: #19d48c; font-weight: 900;'>@W</span>&nbsp;</p>"
				textHtml = '<textarea name="comment_recontent" id="recomment" class="text' 
					+ comment_no + '" style="width: 898px;">' + text + '</textarea>'
					+ '<a class="btn-fill comment_btn" onclick="save_reply(' + comment_no + ',0)">등록</a>';
			}
			
			// 처음 클릭 한 경우에는 무조건 추가(아직 추가된 textarea가 하나도 없을 경우)		
			if(first) {
				addEditor(formTag, textHtml, status);
				first = false;
			}
			
			// 해당 textarea(클릭한 댓글 밑에 추가된 textarea)를 제외한 textarea가 존재할 경우 제거
			// 이미 해당 textarea(클릭한 댓글 밑에 추가된 textarea)가 추가된 경우 더이상 추가 x
			if($("#recomment").not(textTag).length != 0) {
				// 제거
				$(".comment_list").find("iframe").remove();
				$("#recomment").remove();
				$(".comment_btn").remove();

				//추가
				addEditor(formTag, textHtml);
			}

		} //go_reply
		
		function save_reply(no, status) {
			var $form = $("#form" + no);
			var content = oEditors2.getById["recomment"].getIR();

			// 공백 제거 유효성 검사
			var text = content.replace(/[<][^>]*[>]/gi, "");
			text = text.replace(/&nbsp;/gi, "");
			text = text.trim();
			if (text == "") { 
				alert("댓글을 작성해주세요."); 
				oEditors2.getById["recomment"].exec("FOCUS"); //포커싱 
				return; 
			}

			var root = $form.find("input[name=comment_no]").val();
			if(status == 0) root = $form.find("input[name=comment_root]").val();
			
			var reply = {  
				comment_bno: $form.find("input[name=comment_bno]").val(),
				comment_content: content,
				comment_category: $form.find("input[name=comment_category]").val() ,
				comment_root: root 
			};

			if(confirm("댓글을 등록하시겠습니까?")) {
				$.ajax({
					url: "board/reply/regist",
					data: JSON.stringify( reply ),
					type: "post",
					contentType: "application/json",
					success: function(response) {
						alert("댓글이 등록되었습니다.");
						oEditors2.getById["recomment"].exec("SET_IR", ['']);
						comment_list();
					}, error: function(req, text) {
						alert(text + ":" + req.status);
					}
				});
			}
		} //save_reply()
	</script>	
</body>
</html>