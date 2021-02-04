<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		#poster_gallery { width: 200%; overflow: hidden; }
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
            $poster_gallery.css({"margin-left": "-353.3333px", "transition": "0.4s"});

            window.setTimeout(function () {
                $poster_gallery.removeAttr("style").children(":first").appendTo($poster_gallery);
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
						<div class="post_title"><a class="btn-fill" href="">인기순</a></div>
						<div class="post_button">
							<button data-index="0" class="chevron_btn prev_btn"></button>
							<button data-index="1" class="chevron_btn next_btn"></button>
						</div>
					</div>
					<div class="post_list_wrap" data-index="0">
						<ul class="post_list on">
							<li><a href=""><b>불판</b>펜트하우스) ※15화 불판※</a></li>
							<li><a href=""><b>상품</b>런온) 1~2화 신세경 패션 모음(스압주의)</a></li>
							<li><a href=""><b>리뷰</b>스위트홈) 원작이랑 캐릭터&내용 다른 점</a></li>
							<li><a href=""><b>블레</b>브람스를좋아하세요) 블루레이 기수요 조사</a></li>
							<li><a href=""><b>드모</b>경이로운소문) [미방분] 김세정, 행복했던 가족과의 과거 (feat.삼촌)#경이로운소문 | EP.8</a></li>
						</ul>
						<ul class="post_list">
							<li><a href=""><b>상품</b>스타트업) 서달미(수지) 가방 모음 jpg(스압)</a></li>
							<li><a href=""><b>블레</b>365) ※※블레 기수요※※</a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) 오윤희 극혐이다...</a></li>
							<li><a href=""><b>드모</b>슬기로운의사생활) ep.25 99즈 아로하 노래방 풀버전 풀어드립니다! 슬기로운 메이킹 ; Episode 03-2 | 슬기로운 하드털이</a></li>
							<li><a href=""><b>리뷰</b>손더게스트) 넷플릭스에 떴다!!</a></li>
						</ul>
					</div>	
				</section>
			</div> <!-- .post -->
			<div class="post">
				<section>
					<div class="post_top">
						<div class="post_title"><a class="btn-fill" href="">추천순</a></div>
						<div class="post_button">
							<button data-index="2" class="chevron_btn prev_btn"></button>
							<button data-index="3" class="chevron_btn next_btn"></button>
						</div>
					</div>
					<div class="post_list_wrap" data-index="1">
						<ul class="post_list on">
							<li><a href=""><b>리뷰</b>드라마) 2021년 넷플릭스 오리지널 드라마 라인업.jpg</a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) 초반회차 레전드짤 이후 또 레전드짤 나온 김소연(피주의).jpgif</a></li>
							<li><a href=""><b>리뷰</b>스위트홈) 멜로서사 상욱유리.jpg (ㅅㅍ)</a></li>
							<li><a href=""><b>리뷰</b>제발그남자만나지마요) AI 개발자 여주X기계치 소방관 남주.jpgif(짤모음)</a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) 사약 들이마시게 하는 오윤희X하윤철.jpgif</a></li>
						</ul>
						<ul class="post_list">
							<li><a href=""><b>리뷰</b>스타트업) 오늘의 수확 덮지평.jpgif</a></li>
							<li><a href=""><b>리뷰</b>스위트홈) 은혁은유 붕대씬 뉴짤.gif</a></li>
							<li><a href=""><b>리뷰</b>런온) 나 집 없는데... 왜 그래요, 설레게?.gif</a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) "제가 잘못 살았다면 그건 다 아버지때문이에요".gif</a></li>
							<li><a href=""><b>리뷰</b>카이로스) 엔딩 연출 미친 걸 넘어서 희열쩌는 부분.jpgif(기울어지는거 말고)</a></li>
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
					<li><a><img alt="펜트하우스 메인 포스터" src="https://photocloud.sbs.co.kr/origin/edit/S01_P451614724/5f8f8874246b193f1944b887-p.jpg"></a></li>
					<li><a><img alt="런온 메인 포스터" src="https://w.namu.la/s/eb12b8c8886fcb41e1a07cd502d112bfe679303b5aa136c253366444625885b6846ce12855d0d3cbc7aa56e5d403c78ea29f12fcb2eb387c8d3f08257a959fb941df40a74454dac3296dcbed79cd2663bbbd8e806bc90eb7eecb2b79cef692fcdf46355021885bbdf110a18f7e2d3d07"></a></li>
					<li><a><img alt="여신강림 메인 포스터" src="http://img.lifestyler.co.kr/uploads/program/cheditor/2020/11/5MRYQHB63IOC7PGMZODV.jpg"></a></li>
					<li><a><img alt="경이로운 소문 메인 포스터" src="http://img.lifestyler.co.kr/uploads/program/cheditor/2020/11/Q1YWXW9ZOJSGFDHCUGIA.jpg"></a></li>
					<li><a><img alt="낮과 밤 메인 포스터" src="http://img.lifestyler.co.kr/uploads/program/2/2211/menu/4/board/0/0/f132490097117973955(0).jpg"></a></li>
					<li><a><img alt="날아라 개천용 메인 포스터" src="https://photocloud.sbs.co.kr/origin/edit/S01_P451725585/5f841ae1246b193f19449ed9-p.png"></a></li>
				</ul>
			</div>
		</div>
		<div class="post_wrap">
			<div class="post">
				<section>
					<div class="post_top">
						<div class="post_title"><a class="btn-fill" href="">불&nbsp;&nbsp;판</a></div>
						<div class="post_button">
							<button data-index="4" class="chevron_btn prev_btn"></button>
							<button data-index="5" class="chevron_btn next_btn"></button>
						</div>
					</div>
					<div class="post_list_wrap" data-index="4">
						<ul class="post_list on">
							<li><a href=""><b>불판</b>펜트하우스) ※16화 불판※</a></li>
							<li><a href=""><b>불판</b>런온) 6화 달리자~~</a></li>
							<li><a href=""><b>불판</b>경이로운소문) 드디어 막화!!!</a></li>
							<li><a href=""><b>불판</b>여신강림) ~~대망의 6화~~</a></li>
							<li><a href=""><b>불판</b>날아라개천용) 10화 불판 달리즈아</a></li>
						</ul>
						<ul class="post_list">
							<li><a href=""><b>불판</b>런온) 런온데이!! 5화 불판 </a></li>
							<li><a href=""><b>불판</b>경이로운소문) 15화 달리즈아~~</a></li>
							<li><a href=""><b>불판</b>여신강림 ※※5화 불판※※</a></li>
							<li><a href=""><b>불판</b>펜트하우스) 미리 깔아보는 15화 불판</a></li>
							<li><a href=""><b>불판</b>비밀의 남자) 11화 같이 달릴 사람!!</a></li>
						</ul>
					</div>	
				</section>
			</div> <!-- .post -->			
			<div class="post">
				<section>
					<div class="post_top">
						<div class="post_title"><a class="btn-fill" href="">드라마 리뷰</a></div>
						<div class="post_button" style="margin-left: 320px;">
							<button data-index="6" class="chevron_btn prev_btn"></button>
							<button data-index="7" class="chevron_btn next_btn"></button>
						</div>
					</div>
					<div class="post_list_wrap" data-index="5">
						<ul class="post_list on">
							<li><a href=""><b>리뷰</b>브리저튼) 새벽까지 8화 다 봤다...</a></li>
							<li><a href=""><b>리뷰</b>런온) 오늘 회차보고 짜증났던 포인트(불호)</a></li>
							<li><a href=""><b>리뷰</b>스위트홈) 보다보니 궁금한 점(ㅅㅍ)</a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) 찐남주 같았던 조연캐릭터 서사.jpg</a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) 심수련이 주단태 칼로 찔러도 인정</a></li>
						</ul>
						<ul class="post_list">
							<li><a href=""><b>리뷰</b>펜트하우스) 순옥적 허용이라지만 이해안가는 점(ㅅㅍ) </a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) 오윤희 흑화 제대로 했네...</a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) 이번 회차 보니까 오윤희가 최종빌런인거 맞네</a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) 금사빠 마성의 남자 주단태</a></li>
							<li><a href=""><b>리뷰</b>펜트하우스) 주단태는 확실히 천서진으로 노선 튼거???</a></li>
						</ul>
					</div>	
				</section>
			</div> <!-- .post -->			
		</div> <!-- .post_wrap -->
	</div> <!-- #content -->
</body>
</html>
