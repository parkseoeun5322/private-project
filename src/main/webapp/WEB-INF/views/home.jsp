<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>  
<html>
<head>
	<title>Home</title>
	<style type="text/css">
		#content { width: 1080px; margin: 0 auto; }
		.post_wrap { width: 100%; overflow: hidden; margin: 20px 0 0 0; }
		.post_wrap > div { float: left; }
		.post_wrap > div:first-child { margin-right: 20px; }
		.post {
			width: 49%;
			border: 1px solid #ddd;
			padding: 20px;
			box-sizing: border-box;
		}
		.post_top { overflow: hidden; margin: 0 0 10px 0; }
		.post_top > div { float: left; }
		.post_button { margin-left: 358px; }
		.prev_btn, .next_btn { width: 35px; height: 35px; }
		.prev_btn { margin-right: -10px; background: url("img/chevron_left.png") no-repeat left; }
		.next_btn { background: url("img/chevron_right.png") no-repeat center; }
		
		.post_list.on { display: block; }
		.post_list { display: none; }
		
		.post_list > li {
			overflow: hidden;
			display: -webkit-box;
			-webkit-line-clamp: 1;	 /*보이게 할 줄 수 */
			-webkit-box-orient: vertical;
			word-wrap: break-word;	/* 영문인 경우 */
			text-align: left;
			line-height: 30px;
		}
		.post_list > li > a > b { margin: 0 10px 0 0; }
		
		/* 드라마 포스터 */
		#poster_wrap { width: 1080px; position: relative; }
		#poster_gallery { overflow: hidden; }
		#poster_gallery > li { 
			width: 333.3333px; height: 470px; 
			overflow: hidden; float: left; 
			margin: 10px; 
		}
		#poster_gallery > li > a > img { width: 100%; }
		#poster_btn { margin-left: 830px; }
	</style>
	<script type="text/javascript">
		
		$(function() {
			var $buttons = $(".chevron_btn");
			var $contents_list = $(".post_list_wrap");
			var $contents = $(".post_list");
			var $poster_gallery = $("#poster_gallery");

			$poster_gallery.css("width", ${drama_size} * 100 / 3 + "%");
			
			// 글 목록 <> 버튼 클릭 시 실행되는 메소드
			$buttons.on("click", function () {
				var index = $(this).attr("data-index");
				console.log("index = " + index);
				console.log("index / 2 = " + index / 2);
				console.log("index % 2 = " + index % 2);
				
				$contents_list.eq( Math.floor(index / 2) ).children().removeClass("on");
				// 첫/두번째 블록의 < > 클릭시 첫/두번째 블록(.post_list_wrap)의 자식, 글 목록(.post_list) 2개에 on 선택자를 지움
				// 즉, 클릭하지 않은 블록의 글 목록(.post_list)의 선택자는 변화 없음
				
				$contents_list.eq( Math.floor(index / 2) ).children().eq(index % 2).addClass("on");
	            // 첫/두 번째 블록의 < 클릭시 인덱스는 0을 반환(index % 2)하여 
	            // on 선택자를 추가함으로써 각 블록의 첫 번째 글목록(.post_list 중 첫 번째)이 보이게끔 함
			});
			
			// 포스터 슬라이드
			var timerId = window.setInterval(slideImage, 2000);
			
			$("#poster_wrap").hover(
	                function() {
	                    window.clearInterval(timerId);
	                },
	                function() {
	                    timerId = window.setInterval(slideImage, 2000);
	                }
	            );
			
			$("#poster_btn").hover(
	                function() {
	                    window.clearInterval(timerId);
	                },
	                function() {
	                    timerId = window.setInterval(slideImage, 2000);
	                }
	            );
	        
	        $("#poster_next_btn").on("click", function () {
	            // li 마지막 자식 요소를 ul($poster_gallery) 요소의 처음으로 옮기고 ul 요소를 li 요소의 너비만큼 왼쪽으로 이동시킨다.
	            $poster_gallery.prepend( $poster_gallery.children(":last") ).css("margin-left", "-353.3333px")
	                // 그 다음 ul 요소를 li 요소의 너비만큼 오른쪽으로 이동시킨다.
	                .animate({ "margin-left": 0 });
	        });
	        
	        $("#poster_prev_btn").on("click", function () { 
	            // ul 요소의 다음 사진이 나오도록 왼쪽으로 이동시킨다.
	            slideImage(); 
	        });
	        
			function slideImage() {
	            $poster_gallery.css({"width": ${drama_size} * 100 / 3 + "%", 
		            				 "margin-left": "-353.3333px", "transition": "0.4s"});
	
	            window.setTimeout(function () {
	                $poster_gallery.removeAttr("style").children(":first").appendTo($poster_gallery);
	                $poster_gallery.css({"width": ${drama_size} * 100 / 3 + "%"});
	            }, 400);
	        } // slideImage()
		});
	</script>
</head>
<body>
	<div id="content">
		<div class="post_wrap">
			<div class="post">
				<section>
					<div class="post_top">
						<div class="post_title"><a class="btn-fill" href="list.po">인기순</a></div>
						<div class="post_button">
							<button data-index="0" class="chevron_btn prev_btn"></button>
							<button data-index="1" class="chevron_btn next_btn"></button>
						</div>
					</div>
					<div class="post_list_wrap" data-index="0">
						<ul class="post_list on">
							<c:forEach items="${popul }" var="po" varStatus="status">
								<c:if test="${status.index lt 5 }">
									<li><a href=""><b>${po.board_category }</b>${po.board_header }) ${po.board_title }</a></li>
								</c:if>
							</c:forEach>
						</ul>
						<ul class="post_list">
							<c:forEach items="${popul }" var="po" varStatus="status">
								<c:if test="${status.index ge 5 }">
									<li><a href=""><b>${po.board_category }</b>${po.board_header }) ${po.board_title }</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>	
				</section>
			</div> <!-- .post -->
			<div class="post">
				<section>
					<div class="post_top">
						<div class="post_title"><a class="btn-fill" href="list.pu">추천순</a></div>
						<div class="post_button">
							<button data-index="2" class="chevron_btn prev_btn"></button>
							<button data-index="3" class="chevron_btn next_btn"></button>
						</div>
					</div>
					<div class="post_list_wrap" data-index="1">
						<ul class="post_list on">
							<c:forEach items="${push }" var="pu" varStatus="status">
								<c:if test="${status.index lt 5 }">
									<li><a href=""><b>${pu.board_category }</b>${pu.board_header }) ${pu.board_title }</a></li>
								</c:if>
							</c:forEach>
						</ul>
						<ul class="post_list">
							<c:forEach items="${push }" var="pu" varStatus="status">
								<c:if test="${status.index ge 5 }">
									<li><a href=""><b>${pu.board_category }</b>${pu.board_header }) ${pu.board_title }</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>	
				</section>
			</div>
		</div> <!-- .post_wrap -->
		<div class="post_wrap" style="border: 1px solid #ddd; padding: 20px 10px;">
			<div class="post_title">
				<a class="btn-fill" style="margin-left: 10px;">방영중인 드라마</a>
			</div>
			<div id="poster_btn">
				<button class="prev_btn" id="poster_prev_btn"></button>
				<button class="next_btn" id="poster_next_btn"></button>
			</div>
			<div id="poster_wrap">
				<ul id="poster_gallery">
					<c:forEach items="${drama }" var="drama">
						<li><a>
							<img alt="${drama }" 
								 src="/deuqoo/resources/upload/drama/${drama }.jpg"
								 onerror="this.src='/deuqoo/resources/upload/drama/이미지준비중.jpg'">
						</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="post_wrap">
			<div class="post">
				<section>
					<div class="post_top">
						<div class="post_title"><a class="btn-fill" href="list.bu">불&nbsp;&nbsp;판</a></div>
						<div class="post_button">
							<button data-index="4" class="chevron_btn prev_btn"></button>
							<button data-index="5" class="chevron_btn next_btn"></button>
						</div>
					</div>
					<div class="post_list_wrap" data-index="4">
						<ul class="post_list on">
							<c:forEach items="${bulpan.list }" var="vo" varStatus="status">
								<c:if test="${status.index lt 5 }">
									<li><a href=""><b>${vo.board_category }</b>${vo.bulpan_header }) ${vo.bulpan_title }</a></li>
								</c:if>
							</c:forEach>
						</ul>
						<ul class="post_list">
							<c:forEach items="${bulpan.list }" var="vo" varStatus="status">
								<c:if test="${status.index ge 5 }">
									<li><a href=""><b>${vo.board_category }</b>${vo.bulpan_header }) ${vo.bulpan_title }</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>	
				</section>
			</div> <!-- .post -->			
			<div class="post">
				<section>
					<div class="post_top">
						<div class="post_title"><a class="btn-fill" href="list.re">드라마 리뷰</a></div>
						<div class="post_button" style="margin-left: 320px;">
							<button data-index="6" class="chevron_btn prev_btn"></button>
							<button data-index="7" class="chevron_btn next_btn"></button>
						</div>
					</div>
					<div class="post_list_wrap" data-index="5">
						<ul class="post_list on">
							<c:forEach items="${review.list }" var="vo" varStatus="status">
								<c:if test="${status.index lt 5 }">
									<li><a href=""><b>${vo.board_category }</b>${vo.review_header }) ${vo.review_title }</a></li>
								</c:if>
							</c:forEach>
						</ul>
						<ul class="post_list">
							<c:forEach items="${review.list }" var="vo" varStatus="status">
								<c:if test="${status.index ge 5 }">
									<li><a href=""><b>${vo.board_category }</b>${vo.review_header }) ${vo.review_title }</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>	
				</section>
			</div> <!-- .post -->			
		</div> <!-- .post_wrap -->
	</div> <!-- #content -->
</body>
</html>
