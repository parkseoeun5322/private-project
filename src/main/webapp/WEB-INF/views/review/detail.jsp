<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">	
</style>
<script type="text/javascript">
	//추천하기 버튼 클릭 시
	function go_push() {
		var $thumbsUp = $("#thumbs-up");
		if( $thumbsUp.children().attr("data-prefix") == "far" ) {
			if(confirm("추천하시겠습니까?")) {
				$.ajax({
					url: "push",
					data: { push_no: ${vo.review_no},
							push_category: "${vo.board_category}" },
					success:function(data) {
						if(data) {
							window.location.reload();
						} else {
							alert("관리자에게 문의하세요.");
						}
					}, //success
					error: function(req, text) {
						console(text + " : " + req.status);
						alert("관리자에게 문의하세요.");
					}
				});
			}
			
		}

		if( $thumbsUp.children().attr("data-prefix") == "fas" ) {
			if(confirm("이미 추천한 게시글입니다.\n추천을 취소하시겠습니까?")) {
				$.ajax({
					url: "push_cancel",
					data: { push_boardNo: ${vo.review_no}, 
							push_no: "${push.push_no}",
							push_category: "${vo.board_category}" },
					success:function(data) {
						console.log(data);
						if(data) {
							alert("추천이 취소되었습니다.");
							window.location.reload();
						} else {
							alert("관리자에게 문의하세요.");
						}
					}, //success
					error: function(req, text) {
						console.log(text + " : " + req.status);
						alert("관리자에게 문의하세요.");
					}
				});
			}
		}
	} //go_push()
	
	// 스크랩 버튼 클릭시
	function go_scrap() {
		// 해당 사용자가 스크랩을 하지 않았을 때
		if("${scrap}" == "") {
			if(confirm("스크랩하시겠습니까")) {
				$.ajax({
					url: "scrap",
					data: { scrap_boardNo: ${vo.review_no},
							scrap_category: "${vo.board_category}",
							scrap_title: "${vo.review_title}" },
					success:function(data) {
						if(data) {
							window.location.reload();
						} else {
							alert("관리자에게 문의하세요.");
						}
					}, //success
					error: function(req, text) {
						console(text + " : " + req.status);
						alert("관리자에게 문의하세요.");
					}
				});				
			}
		} else {	//이미 스크랩을 했을 때
			if(confirm("이미 스크랩한 게시글입니다. \n스크랩을 취소하시겠습니까?")) {
				$.ajax({
					url: "scrap_cancel",
					data: { scrap_boardNo: ${vo.review_no}, 
							scrap_no: "${scrap.scrap_no}",
							scrap_category: "${vo.board_category}" },
					success:function(data) {
						console.log(data);
						if(data) {
							alert("스크랩이 취소되었습니다.");
							window.location.reload();
						} else {
							alert("관리자에게 문의하세요.");
						}
					}, //success
					error: function(req, text) {
						console.log(text + " : " + req.status);
						alert("관리자에게 문의하세요.");
					}
				});
				
			}
		}
	} //go_scrap()
	
</script>
</head>
<body>
	<div class="detail_style">
		<ul>
			<li>
				<div>${vo.board_category }</div>
				<div><a href="">${vo.review_header })</a>${vo.review_title }</div>
				<div>${vo.review_writedate }</div>
			</li>
			<li>
				<div>
					<span>조회수<b>${vo.review_readcnt }</b></span>
					<span id="pushCnt">추천수<b>${vo.review_pushcnt }</b></span>
					<span>댓글<b>${vo.review_commentcnt }</b></span>
				</div>
			</li>
			<li>${fn:replace( fn:replace(vo.review_content, less, '<'), greater, '>') }</li>
			<li>
				<div class="fl"><a onclick="$('form').submit()"><i class="fas fa-bars"></i>목록</a></div>
<%-- 				<c:if test="${not empty returnList }">
					<div class="fl"><a href="list.re"><i class="fas fa-bars"></i>목록</a></div>
				</c:if> --%>
				
				<c:if test="${login_info ne null }">
					<div class="fr">
						<span>
							<a onclick="go_push()" id="thumbs-up">
								<c:if test="${push eq null }">
									<i class="far fa-thumbs-up"></i>
								</c:if>
								<c:if test="${push ne null }">
									<i class="fas fa-thumbs-up"></i>
								</c:if>
							추천</a>
						</span>
						<!-- <i class="fas fa-thumbs-up"></i> -->
						<span><a onclick="go_scrap()">스크랩<b>${vo.review_scrapcnt }</b></a></span>
					</div>
				</c:if>
				<c:if test="${login_info.member_id eq vo.review_writer }">
					<div class="fr"><a onclick="$('#pageForm').attr('action', 'modify.re'); $('#pageForm').submit()">수정</a></div>
					<div class="fr"><a onclick="if(confirm('정말 삭제하시겠습니까?')) { $('#pageForm').attr('action', 'delete.re'); $('#pageForm').submit() }">삭제</a></div>
				</c:if>
			</li>
		</ul>
		<form id="pageForm" action="list.re" method="post">
			<input type="hidden" name="review_no" value="${vo.review_no }" />
			<input type="hidden" name="curPage" value="${page.curPage }" />
			<input type="hidden" name="search" value="${page.search }" />
			<input type="hidden" name="keyword" value="${page.keyword }" />
			<input type="hidden" name="pageList" value="${page.pageList }" />
			<input type="hidden" name="myPage" value="${myPage }" />
		</form>
			<c:if test="${login_info ne null }">
				<div class="comment_wrap">
					<div id="comment_list" class="left">
						
					</div>
					<div id="comment_regist">
						<textarea name="comment_content" id="comment"></textarea>
						<a onclick="comment_regist()" class="btn-fill" id="commentBtn">등록</a>
					</div>
				</div> <!-- .comment_wrap -->
			</c:if>
	</div> <!-- .detail_style -->
	
	<!-- SmartEditor 에서 필요한 javascript 로딩  -->
	<script src="smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>	
	<script type="text/javascript">
	
		comment_list();
	
		function comment_list() {
			$.ajax({
				url: "board/comment/${vo.review_no}",
				data: { board_writer: "${vo.review_writer}",
						board_category: "${vo.board_category }" },	//글 작성자 정보를 보내 댓글 목록에 표시
				success: function(data) {
					$("#comment_list").html(data);
					
				}, error: function(req, text) {
					alert(text + " : " + req);
	
				}
			});
			
		} //comment_list()

		// 에디터 -------------------------------------------------
		
		var oEditors1 = [];
		
		nhn.husky.EZCreator.createInIFrame({ 
			oAppRef : oEditors1, 
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

		function comment_regist() {
			var content = oEditors1.getById["comment"].getIR();

			// 공백 제거 유효성 검사
			var text = content.replace(/(<p>|<\/p>)/gi, "");
			text = text.replace(/<br>/gi, "");
			text = text.replace(/&nbsp;/gi, "");
			text = text.trim();

			if (text == "") { 
				alert("댓글을 작성해주세요."); 
				oEditors1.getById["comment"].exec("FOCUS"); //포커싱 
				return; 
			}
			
			if(confirm("댓글을 등록하시겠습니까?")) {
				$.ajax({
					url: "board/comment/regist",
					data: { comment_content: content, 
							//comment_content: $("#comment").val(), 
							// → 스마트 에디터로 인해 textarea 값이 바로 출력되지 않고 한번 reload된 후에 출력됨
							comment_bno:${vo.review_no},
							comment_category: "${vo.board_category}" },
					success: function(response) {
						if(response == 1) {
							alert("댓글이 등록되었습니다.");
							oEditors1.getById["comment"].exec("SET_IR", ['']);
							//$("#comment").val("");	//입력한 댓글 초기화
							comment_list();
						} else if(response == 0) {
							alert("로그아웃되었습니다.")
							location.href = "/deuqoo/login_view";
						}
					}, error: function(req, text) {
						alert("관리자에게 문의하세요");
					}
				});
			}
		} //comment_regist()
		
	</script>
</body>
</html>