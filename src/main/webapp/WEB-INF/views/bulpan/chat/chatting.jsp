<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>
 <!-- moment()함수 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<style type="text/css">
	body { overflow-x: hidden; overflow-y: hidden;  }
	li { list-style: none; }
	.chat-container { width: 100%;}
	.chatContent {
		height: 700px;
		width : 100%;
		overflow-y: scroll;
	}
	.chatContent::after { content: ""; display: block; clear: both; }
	
	.chat-fix {
		position: fixed;
		bottom: 0;
		width: 100%;
	}
	
	.chat-date {	
		display: flex;
		flex-basis: 100%;
		align-items: center;
		color: rgba(0, 0, 0, 0.35);
		font-size: 16px;
		margin: 8px 0px;
	}
	
	.chat-date::before, .chat-date::after {
		content: "";
		flex-grow: 1;
		background: rgba(0, 0, 0, 0.35);
		height: 1px;
		font-size: 0px;
		line-height: 0px;
		margin: 0px 16px;
	}
	.chat-wrap { width: 450px; overflow: hidden; }
	.chat-wrap > strong { width: 100%; display: block; margin-bottom: 10px; }
	.chat-wrap > div > p { 
		max-width: 400px; 
		padding: 10px 20px;
		box-sizing: border-box;
		border-radius: 10px;
		line-height: 1.5;
	}
	.chat-wrap > div > strong { padding: 10px 5px 0; }
	
	.me > div > p { background-color: #787878; color: #ffffff; }
	.other > div > p { border: 2px solid #787878; color: #787878; }
	
	.chat-send-wrap::after {content: ""; display: block; clear: both;}
	#msgi { 
		float: left; 
		height: 80px; width: calc(100% - 100px); padding-left: 10px;
		box-sizing: border-box; 
		font-size: 16px; font-family: sans-serif; 
	}
	.send {
		float: left;
		width: 100px; height: 80px;
		line-height: 60px;
		display: block;
    	background-color: #787878;
    	color: #ffffff !important;
    	padding: 10px;
    	border-radius: 5px;
	}

</style>
</head>
<body>
	<div class="chat-container">
		<div class="chatContent" data-room-no="" data-member="${login_info }">
			<div id="list-guestbook">
				<!-- ----------------------------날짜 표시 -->
				<c:forEach items="${firstList }" var="vo2" begin="1" end="1">
					<div class="chat-date"> ${vo2.chatting_date }</div>
					<c:forEach items="${firstList }" var="vo3">
						<c:if test="${vo2.chatting_date ne vo3.chatting_date }">
							<div class="chat-date"> ${vo.chatting_date }</div>
						</c:if>
					</c:forEach>					
				</c:forEach>
				
				<!-- ----------------------------채팅 표시 -->
				<c:forEach items="${firstList }" var="vo">
					<!-- 내 채팅일 경우 -->
					<c:if test="${login_info.member_id eq vo.chatting_writer }">
						<li data-no="${vo.chatting_no }" class="w-pct100 mb20" style="overflow: hidden; padding: 20px;">
							<div class="chat-wrap me fr">
								<strong class="tr">나</strong>
								<div class="chat-content">
									<p class="fr">${vo.chatting_content }</p>
									<strong class="fr"><fmt:formatDate value="${vo.chatting_time }" pattern="HH:mm:ss"/></strong>
								</div>
							</div>
						</li>
					</c:if>
						
					<!-- 다른 사람의 채팅일 경우 -->
					<c:if test="${login_info.member_id ne vo.chatting_writer }">
						<li data-no="${vo.chatting_no }" class="w-pct100 mb20" style="overflow: hidden; padding: 20px;">
							<div class="chat-wrap other">
								<strong class="tl">드덕&nbsp;${vo.chatting_nickName }</strong>
								<div class="chat-content">
									<p class="fl">${vo.chatting_content }</p>
									<strong class="fl"><fmt:formatDate value="${vo.chatting_time }" pattern="HH:mm:ss"/></strong>
								</div>
							</div>
						</li>
					</c:if>
				</c:forEach>
			</div> <!-- #list-guestbook -->
		</div>  <!-- .chatContent -->
		<div class="chat-fix">
			<div class="chat-send-wrap">
				<input type="text" name="msg" id="msgi" onkeypress="if( event.keyCode==13 ){ sendMsg(); }">
<!-- 				<textarea name="msg" id="msgi" rows="2" onkeypress="if( event.keyCode==13 ){ sendMsg(); }"></textarea> -->
				<a class="send">보내기</a>
			</div>
		</div>
	</div>	<!-- .chat-container -->
	<script type="text/javascript">
		var client = null;

		$(document).ready(function() {
			if("${login_info}" == "") { alert("로그인이 필요한 페이지입니다!"); window.close(); }
			
			// 시작할 때 스크롤 내리기
			$(".chatContent").scrollTop($(".chatContent")[0].scrollHeight);
			var date;

			/*
			var fetchList = function () { 
				
				if(isEnd) { return; }
				
				// 채팅 리스트를 가져올 때 시작 번호
				// renderList 함수에서 html 코드의 <div> 태그에 data-no 속성으로
				// data- 속성의 값을 가져오기 위해 data() 함수 사용
				var startNo = $("#list-guestbook li").first().data("no") || 0;
				var endNo = $("#list-guestbook li").last().data("no");
				
				$.ajax({
					url : "/chatList.bu?endNo="
						+ endNo + "&chatting_roomNo=${chatting_roomNo}",
					type : "GET",
					dataType : "json",
					success : function(result) {
						// 컨트롤러에서 가져온 방명록 리스트는 result.data에 담김
						var length = result.size;
						if (length < 5) { isEnd = true; }
						$.each(result, function(index, vo) {
							var html = renderList(vo, 0);
							$("#list-guestbook").prepend(html);
						})
						console.log("스크롤 내릴 높이 : " + position.top)
						var position = $("[data-no=" + endNo + "]").prev().offset(); // 위치 값
						document.querySelector(".chatContent").scrollTo({top: position.top, behavior: 'auto'});
						isScrolled = false;
					},
					error : function(xhr, status, err) {
						console.log("처리실패!");
						console.log(xhr);
						console.log(status);
						console.log(err);
					}
				}); //ajax
			} //fetchList()*/

			var fetchList = function (endNo) {
				var offset = $("[data-no=" + endNo + "]").offset(); // 위치 값
				var position = $("[data-no=" + endNo + "]").position(); // 위치 값
				alert("endNo = " + endNo + ", offset = " + offset.top + ", position = " + position.top);
				document.querySelector(".chatContent").scrollTo({top: position.top, behavior: 'auto'});
			} //fetchList()
			
			var renderList = function(vo, endNo) {
				date = moment(vo.chatting_time).format("HH:mm:ss");
				var nickname = "드덕 " + vo.chatting_nickName;
				var html = "";
				if (endNo == 0) endNo = vo.chatting_no;
				
				// 내가 보낸 채팅일 경우
				if(vo.chatting_writer == "${login_info.member_id }") {
					var content = "<p class='fr'>" + vo.chatting_content + "</p>";
					html = "<li data-no='" + endNo + "' class='w-pct100 mb20' style='overflow: hidden; padding: 20px;'>"
								+ "<div class='chat-wrap me fr'>"
								+ 	"<strong class='tr'>나</strong>"
								+ 	"<div class='chat-content'>" 
								+		content
								+		"<strong class='fr'>" + date + "</strong>"
								+ "</div></div></li>";
					
				} else {	// 남이 보낸 채팅일 경우
					var content = "<p class='fl'>" + vo.chatting_content + "</p>";
					html = "<li data-no='" + endNo + "' class='w-pct100 mb20' style='overflow: hidden; padding: 20px;'>"
								+ "<div  class='chat-wrap other'>"
								+ 	"<strong class='tl'>" + nickname + "</strong>"
								+ 	"<div class='chat-content'>" 
								+		content
								+		"<strong class='fl'>" + date + "</strong>"
								+ "</div></div></li>";
					
				}
				return html;
			} //renderList()

			//--------------------------------------------------------------------
			$(function() {
				var messageInput = $('input[name="msg"]');
				var chatting_roomNo = "${chatting_roomNo}"; 
				var member = $(".chatContent").data("member");
				
				var sock = new SockJS("${pageContext.request.contextPath}/endpoint");
				//var sock = new SockJS("http://localhost/endpoint");
				client = Stomp.over(sock);
				
				function sendMsg() {
					var message = messageInput.val();
					
					if (message == "") { return false; }
					client.send("/app/hello/" + chatting_roomNo, {}, JSON.stringify({
						chatting_content : message,
						chatting_writer : "${login_info.member_id}",
						chatting_roomNo: "${chatting_roomNo}"
					}));
					
					messageInput.val("");
				} //sendMsg()
				
				client.connect({}, function() {
					
					// 입장 시 일반 메시지 들어오는 곳
					client.subscribe("/subscribe/chat/" + chatting_roomNo, function(chat) {
						var content = JSON.parse(chat.body);
						var endNo = content.chatting_no;
						var html = renderList(content, endNo);
						$("#list-guestbook").append(html);
						//fetchList(endNo);
						$(".chatContent").scrollTop($(".chatContent")[0].scrollHeight);
					}); // subscribe()
				}, function() {alert("Could not connect to WebSocket server. Please refresh this page to try again!");}); // connect()

				// 엔터 클릭 시 대화 전송
				$('input[name="msg"]').keypress(function(e) { 
					if (e.keyCode === 13) { 
						e.preventDefault();
						sendMsg();
					} 
				});
				
				// 보내기 버튼 클릭 시 대화 전송
				$(".send").click(function() { sendMsg(); });

				
			}); //$(function(){});

			// 채팅 창을 떠날 시에
			function disconnect() {
				if( client != null) { client.disconnect(); }
			}
			
			window.onbeforeunload = function(e) { disconnect(); }
			function closeConnection() { sock.close(); }
			function viewList() {
				alert('viewList');
				var url = "chatList?page=" + page
						+ "&perPageNum=" + perPageNum;
				location.replace(url);
			}
			
		}); //$(document).ready()

	</script>
</body>
<!-- https://www.cdnpkg.com/sockjs-client/file/sockjs.min.js/?id=70457 -->
</html>