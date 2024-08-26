<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/cs_common_module_210201.css">
<style type="text/css">
	.cs_common_module_wrap { width: 960px; margin: 30px auto 0; }
	
	.btn_refresh, .relation_box._offer_box,
	.tab_list, .blind, ._kgs_page,
	.area_scroll_middle > li:last-child { display: none !important; }
	
	.category, .area_text_box { font-size: 18px !important; }
	.info_txt, ._text, ._count { font-size: 0.7em !important; }
	.cs_common_module .offer_box { font-size: 0.7em !important; line-height: 1.6rem !important; }
</style>
<script type="text/javascript">
	var naverUrl = "https://search.naver.com/search.naver";
	
	function goOtherCR() { return false; }
	
	$(document).ready(function() {
		//방영중 / 방영예정 버튼 클릭 시
		$(".area_text_box").on("click", function() {
			$(this).removeAttr("href");
			$(".area_scroll_middle > li").attr("aria-selected", "false");
			$(this).parent("li").attr("aria-selected", "true");

			if( $(this).text() == "방영예정" ) {
				$(this).prop("href", "list.so");
			} else if( $(this).text() == "방영중" ) {
				$(this).prop("href", "list.dr");
			}
		});

		//드라마 제목 클릭 시 네이버 페이지 이동
   		$("a._text").on("click", function () {
			var url = $(this).attr("href");
			if(url.indexOf("https")) {
				$(this).attr("target", "_blank");
				$(this).prop("href", naverUrl + url);
			}
   	   	});
   	   	
		//드라마 제목 클릭 시 네이버 페이지 이동
   		$("a._text").on("click", function () {
			var url = $(this).attr("href");
			if(url.indexOf("https")) {
				$(this).attr("target", "_blank");
				$(this).prop("href", naverUrl + url);
			}
   	   	});

		//방송사 a요소 클릭 시 네이버 페이지 이동
   		$("a.broadcaster").on("click", function () {
			var url = $(this).attr("href");
			if(url.indexOf("https")) {
				$(this).attr("target", "_blank");
				$(this).prop("href", naverUrl + url);
			}
   	   	});

   	   	//드라마 썸네일 사진 클릭 시 네이버 페이지 이동
   		$("a.thumb").on("click", function () {
			var url = $(this).attr("href");
			if(url.indexOf("https")) {
				$(this).attr("target", "_blank");
				$(this).prop("href", naverUrl + url);
			}
   	   	});
	});
</script>
</head>
<body>
	<div class="cs_common_module_wrap">
		${drama }
	</div>
</body>
</html>