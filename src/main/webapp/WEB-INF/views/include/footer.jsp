<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer>
	<div class="container w-pct100">
		<div id="newsticker_container">
			<div id="newsticker_wrap" class="pl40">
				<ul class="fl tl">
					<li><a  href="" class="pr20 ftw_b ftsize_px18">공지사항</a></li>
				</ul>
	            <ul id="rolling" class="fl tl">
	                <li><a href="">홈페이지 서비스 점검 안내 (22:00 ~ 24:00)</a></li>
	                <li><a href="">시스템 안정화 작업으로 인한 서비스 사용 제한 안내</a></li>
	                <li><a href="">서비스 일시 장애에 대해 사과드립니다</a></li>
	                <li><a href="">시스템 점검 일정 변경 안내</a></li>
	                <li><a href="">SNS 회원 본인인증 및 성인인증 절차 일시 제한 안내</a></li>
	            </ul>
			</div>
        </div>
		<div class="bottom_gnb_menu">		
			<a href="company">회사소개</a>
			<a href="list.no" ${category eq 'no' ? 'class="active"' : ''}>공지사항</a>
			<a href="list.fa" ${category eq 'fa' ? 'class="active"' : ''}>문의/신고</a>
			<a href="list.qn" ${category eq 'qn' ? 'class="active"' : ''}>테스트룸</a>
			<a href="service">이용약관</a>
			<a href="privacy">개인정보처리방침</a>
		</div>
	</div>
	<div id="address_container">
		<div class="mr10">
			<a href=""><img alt="메인 로고" src="img/main_logo.png" width="80px" style="display: inline;"></a>
		</div>
		<div id="address_wrap" class="ftsize_px14 pt25">
			<p>광주광역시 북구 양산택지소로       대표전화 000)000-0000</p>
			<p class="copyright">Copyright(C) 2021 Deuqoo All Rights Reserved.</p>
		</div>
	</div>
</footer>
<script type="text/javascript">

	var rolling = document.getElementById("rolling");
	window.setInterval(function () {
		
	    rolling.style.marginTop = "-40px";
	    rolling.style.transition = "0.4s";
	    
	    window.setTimeout(function () {
	
	        rolling.removeAttribute("style");
	
	        rolling.appendChild(rolling.firstElementChild);
	        
	    }, 400); // window.setTimeout
	}, 2000); // window.setInterval
</script>
<style>
	footer { width: 100%; margin: 20px auto 0; background-color: #f4f4f4; }
	#newsticker_container { border-top: 1px solid #dddddd; border-bottom: 1px solid #dddddd;}
	#newsticker_wrap { width: 70%; margin: 0 auto; overflow: hidden; }
	#newsticker_wrap::after { content: ""; display: block; clear: both; }
	#newsticker_wrap > ul > li { height: 40px; line-height: 40px; overflow: hidden; }
	#newsticker_wrap > ul > li > a {padding: 10px 0 ;}
	#rolling { height: 30px; overflow: hidden; }
	#rolling > li > a {  font-size: 14px !important; color: rgb(88, 88, 88) !important; }
	.bottom_gnb_menu {
		height: 64px;
	    width: 70%;
	    margin: 0 auto;
	    display: flex;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    -webkit-box-align: center;
	    align-items: center;
}
	.bottom_gnb_menu a {
		width: 14.5%;
	    text-align: center;
	    font-size: 14.5px;
	    color: rgb(88, 88, 88);
	    position: relative;
	    background-color: transparent;
	}
	.bottom_gnb_menu a:hover {
	    font-size: 15px;
	    font-weight: bold;
	    color: #111111;
	}
	
	.bottom_gnb_menu a:not(:last-child)::after {
		content: "";
	    position: absolute;
	    top: 0px;
	    right: -10%;
	    width: 2px;
	    height: 18px;
	    border-right: 1px solid rgb(181, 181, 181);
	    box-sizing: border-box;
	}
	
	#address_container { width: 448px; margin: 0 auto; overflow: hidden; }
	#address_container > div { float: left; }
	#address_wrap > p { margin: 0 0 10px 0; color: #969696; }
</style>