<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
	<div class="main_info">		
		<ul>
			<li class="main_logo"><a href='<c:url value="/"/>'><img alt="홈으로" src="img/main_logo.png"></a></li>
		</ul>
		<ul>
			<c:if test="${empty login_info }">
				<li><a href="login_view" class="login">로그인</a></li>
				<li><a href="join_view">회원가입</a></li>
			</c:if>
			<c:if test="${!empty login_info }">
				<li><a id="mypage"
						href="mypage?member_id=${login_info.member_id }">마이 페이지</a></li>
				<li><a onclick="go_logout()" style="cursor: pointer;">로그아웃</a></li>
			</c:if>
		</ul>	
	</div>
	<div class="category pt20">
		<ul>
			<li><a href="list.bu" ${category eq 'bu' ? 'class="active"' : '' }>불판</a></li>
			<li><a href="" id="second-item" ${category eq 'al' ? 'class="active"' : '' }>드라마의 모든 것</a></li>
			<li><a href="" ${category eq 'tv' ? 'class="active"' : '' }>TV 속 이 상품</a></li>
			<li><a href="list.re" ${category eq 're' ? 'class="active"' : '' }>드라마 리뷰</a></li>
			<li><a href="" ${category eq 'bl' ? 'class="active"' : '' }>블루레이 모집</a></li>
			<li>
				<input type="text" />
				<!-- <span><i class="fas fa-search"></i></span> -->
			</li>
		</ul>
		<div id="dropdown">
			<ul>
				<li><a href="">드라마 정보</a></li>
				<li><a href="">자료 게시판</a></li>
			</ul>
		</div>
	</div>
</header>
<script type="text/javascript">
function go_logout() {
	$.ajax({
		url : "logout",
		success : function() {
			//alert("로그아웃 되었습니다!");
			location.reload();
		},
		error : function() {
			alert(text + ":" + req.status);
		}
	});
} //go_logout()

$(function() {
		
	var $dropdown = $("#dropdown");
	var $secondItem = $("#second-item");
	
	var $category = $(".category");
	var $window = $(window);
	var cateTop = $category.offset().top;	//.category 요소의 위치를 미리 확인
	var headerHeight = $(".main_info").innerHeight();
	
	// '드라마의 모든 것' 카테 부분에 hover할때 발생하는 이벤트 핸들러
	$secondItem.mouseover(function(){
		$dropdown.slideDown(200);
		$secondItem.addClass("active");
    });
	
	// '드라마의 모든 것'을 제외한 카테 부분에 hover할때 발생하는 이벤트 핸들러
	$(".category > ul > li > a:not(#second-item)").mouseover(function() {
		$dropdown.slideUp(200);
		$secondItem.removeClass("active");
	});
	
	// 카테고리 전체 부분에 마우스 영역이 벗어났을 때 발생하는 이벤트 핸들러
	$(".category").mouseleave(function() {
		$dropdown.slideUp(200);
		$secondItem.removeClass("active");
	});
	
	console.log("cateTop = " + cateTop)
    console.log("headerHeight = " + headerHeight)

	// 스크롤 이벤트 핸들러
	$window.on("scroll", function() {
		var scrollTop = $window.scrollTop();	// 스크롤된 높이

		if (scrollTop > cateTop)	// 스크롤 된 높이가 카테고리 요소의 위치보다 더 커질 때
			// 카테고리를 화면 상단에 고정시킨다.
			$category.addClass("fixed");

		// 스크롤 된 높이가 카테고리 요소의 위치보다 더 작아지면
		else
			// 카테고리 요소를 본래 위치로 되돌린다.
			$category.removeClass("fixed");
	}); // window.onscroll
});
</script>
<style type="text/css">
	header { margin: 0 auto; }
	.main_info { background-color: #ffffff; position: relative; }
	.main_info > ul:last-child { position: absolute; top: 20%; right: 15%; }
	.main_info > ul:last-child > li { float: left; }
	.main_info > ul:last-child > li:first-child { border-right: 1px solid #9e9e9e; }
	.main_info > ul:last-child > li > a { color: #9e9e9e; font-size: 15px; padding: 0 10px; }
	/* 메인 로고 */
	.main_logo { width: 100px; margin: 0 auto; }
	.main_logo > a { display: block; }
	.main_logo > a > img { width: 100%; }
	
	/* 카테고리 메뉴 */
	.category { 
		/* width: 100%; */
		/* #nav에 position 속성을 설정하지 않았을 경우
			#nav의 위치만큼 스크롤을 내리자마자 부모 요소로 부터 독립되므로 */
		position: absolute;
		right: 0; left: 0;
		font-size: 18px;
		
		/* #dropdown 요소가 이 요소의 영역을 기준으로 배치되도록 position 스타일 속성 설정 */
		position: relative;
	}
	.category > ul, .category > ul > li { margin: 0; padding: 0; }
	.category > ul { width: 100%; padding-left: 10%; border-bottom: 1px solid #ddd; }
	.category > ul::after { content: ""; display: block; clear: both; }
	.category > ul > li { width: 13%; float: left; }
	
	/* 검색 */
	.category > ul > li:last-child { 
		width: 15%; height: 35px;
		background-color: #ededed; border-radius: 10px;
		margin: -7px 0 0 15px;
	}
	
	.category > ul > li:last-child > input { 
		background-color: #ededed; 
		width: 100%; height: 35px; padding: 0 0 0 40px; border: 0;
		background-image : url('img/search_black.png'); background-position:7px center; background-repeat:no-repeat; background-size: 28px;
  		border-radius: 10px;
	}
	
	.category > ul > li > a { 
		display: block;
		padding-bottom: 20px;
		                 
		/* 막대를 표현하는 가상 요소가 이 요소의 영역을 기준을 배치되도록 설정 */
        position: relative;
     }
	
	/* hover 상태에서 메뉴 항목 아래에 표시되는 막대를 표현하기 위해 가상 요소 추가 */
    .category > ul > li > a::after {
    	/* 가상 요소 선택자에는 반드시 content 속성 설정 */
    	content: "";

        /* a 요소의 영역을 기준으로 아래쪽 가운데에 배치 */
        position: absolute;
        bottom: 0; left: 50%;
        transform: translateX(-50%);

        width: 0; height: 5px;
        background-color: #919191;
        transition: 0.2s;
	}
	
	.category > ul > li > a:hover::after { width: 60%; }
	
	.category.fixed {
		/* 스크롤을 내릴 때 화면 상단에 고정 */
		position: fixed;
		top: 0; right: 0; left: 0;
		background-color: #ffffff;
		z-index: 150;	/* 스크롤을 내렸을 때 content 요소들 위에 있도록 함 */
	}
	
	.active::after { width: 60% !important; }
		
	/* 드롭다운 메뉴 */
	#dropdown { 
		/* #nav 요소의 영역을 기준으로 아래쪽에 배치 */
		position: absolute;
		top: 100%; left: 0; right: 0;
		background-color: #ffffff;
		
		/* 처음에는 드랍다운 메뉴가 화면에 보이지 않도록 설정 */
        display: none; 
	}
	#dropdown > ul { padding-bottom: 10px; border-bottom: 3px solid #919191; }
	#dropdown > ul > li { width: 40%; padding-left: 15%; }
	#dropdown > ul > li > a { width: 100%; display: block; padding: 20px 0 10px 0; }
</style>