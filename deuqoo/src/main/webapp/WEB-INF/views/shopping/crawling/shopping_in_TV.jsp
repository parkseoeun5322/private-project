<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/search1_210114.css">
<link rel="stylesheet" type="text/css" href="css/sp_tv_201112.css">
<style type="text/css">
.shopping_wrap { width: 1266px; margin: 30px auto 0; }
.shopping_wrap::after { content: ""; display: block; clear: both; }
.shopping_wrap section { width: 402px; float: left; }
.tv_tab_scroll_wrap { display: none; }
.flick_bx.flick_width.on { display: none; }
</style>
<script type="text/javascript">
	var index;
	var naverUrl = "https://search.naver.com/search.naver";
	
	function tCR() { return false; }
	function goOtherCR() { return false; }

	// 크롤링한 부분의 href 속성 바꾸기
   	$(document).ready(function() {

		//드라마 제목 부분 클릭 시 네이버 페이지 이동
   		$("a.link").on("click", function () {
			var url = $(this).attr("href");
			if(url.indexOf("https")) {
				$(this).attr("target", "_blank");
				$(this).prop("href", naverUrl + url);
			}
   	   	});

   	   	// 다른 사이트 더보기 a요소 클릭 시 네이버 페이지 이동
   		$("a.other_link").on("click", function () {
			var url = $(this).attr("href");
			if(url.indexOf("https")) {
				$(this).attr("target", "_blank");
				$(this).prop("href", naverUrl + url);
			}
   	   	});

   	   	// 관련 ~패션 a요소 클릭 시 네이버 페이지 이동
   		$("a.item").on("click", function () {
			var url = $(this).attr("href");
			if(url.indexOf("https")) {
				$(this).attr("target", "_blank");
				$(this).prop("href", naverUrl + url);
			}
   	   	});
        
   	}); //document.ready

	$(function() {
		index = 0;
		var $bullets = $(".cmm_dpgs > span");
		var length = $bullets.last().attr("data-index");

		$bullets.on("click", function() {
			index = $(this).attr("data-index");
			
			// 이전 버튼 색상 바꾸기
			if(index == 1) { $("._prev").removeClass("on"); }
			else { $("._prev").addClass("on"); }
			
			// 다음 버튼 색상 바꾸기
			if (index == length) { $("._next").removeClass("on"); }
			else { $("._next").addClass("on"); }

			// 불릿 색상 바꾸기
			$(this).siblings().removeClass("cmm_dp_on");
			$(this).addClass("cmm_dp_on");
			
			if(index == 1) $(this).parents(".cmm_pgs").siblings(".api_flicking_wrap").children("div").removeClass("on");

			for(var i = 0; i < index - 1; i++) {
				$(this).parents(".cmm_pgs").siblings(".api_flicking_wrap")
				.children("div").eq(i).addClass("on");
				for(var j = i + 1; j < length - 1; j++) {
					$(this).parents(".cmm_pgs").siblings(".api_flicking_wrap")
					.children("div").eq(j).removeClass("on");
				}
			}
		}); //$bullets.click
		
		$("._next").on("click", function() {
			var k = $(this).siblings(".cmm_dpgs").children(".cmm_dp_on").attr("data-index");
			
			if (k == length) { return; }

			//이전 버튼 색상 바꾸기
			if(k != 0) { $("._prev").addClass("on"); }

			// 다음 버튼 색상 바꾸기
			if (k >= length - 1) { $(this).removeClass("on"); }
			else { $(this).addClass("on"); }

			// 블릿 색상 바꾸기
			$(this).siblings(".cmm_dpgs").children("._dot").removeClass("cmm_dp_on");
			$(this).siblings(".cmm_dpgs").children("._dot").eq(k).addClass("cmm_dp_on");

			// 요소 옮기기
			for(var i = 0; i < k; i++) {
				$(this).parents(".cmm_pgs").siblings(".api_flicking_wrap").children("div").eq(i).addClass("on");		
			}
		}); //$next.click

		$("._prev").on("click", function() {
			var k = $(this).siblings(".cmm_dpgs").children(".cmm_dp_on").attr("data-index");
			var now = $(this).siblings(".cmm_dpgs").children(".cmm_dp_on").attr("title");

			if(now == "현재 페이지") { return false; }

			// 이전 버튼 색상 바꾸기
			if(k == 2) { $(this).removeClass("on"); } 
			else { $(this).addClass("on"); }

			// 다음 버튼 색상 바꾸기
			if (k <= length) { $("._next").addClass("on"); }
			
			$(this).siblings(".cmm_dpgs").children("._dot").removeClass("cmm_dp_on");
			$(this).siblings(".cmm_dpgs").children("._dot").eq(k - 2).addClass("cmm_dp_on");

			for(var i = k - 2; i < length - 1; i++) {
				$(this).parents(".cmm_pgs").siblings(".api_flicking_wrap").children("div").eq(i).removeClass("on");		
			}
		}); //$next.click
		
	});
</script>
</head>
<body>
	<div class="shopping_wrap">${drama0 }${drama1 }${drama2 }</div>
</body>
</html>