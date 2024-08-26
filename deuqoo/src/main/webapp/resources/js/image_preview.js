/**
 * 
 */
 //이미지 여부 판단
		function isImage(filename) {
			//abc.txt, abc.png, abc.jpg
			var ext = filename.substring( filename.lastIndexOf(".") + 1 ).toLowerCase();
			// → ext : 확장자를 담는 변수

			var imgs = ["jpg", "jpeg", "gif", "png", "bmp"];	//이미지 확장자를 담은 배열
			if(imgs.indexOf(ext) > -1 ) return true;		//이미지가 아니면 배열의 인덱스는 -1
			else return false;	
		}
		
		$("#attach-file").on("change", function() {
			alert("change 함수 들어옴");
			//파일 정보의 파일명이 이미지파일인 경우 미리보기
			var attach = this.files[0];
			if( attach ) {
				if( isImage( attach.name ) ) {
					var img = "<img class='file-img' id='preview-img' src='' />";
					$(".se2_inputarea").html(img);

					var reader = new FileReader();
					reader.onload = function(e) {
						$("#preview-img").attr("src", e.target.result);
					}
					reader.readAsDataURL(attach);
				} else {
					$(".se2_inputarea").html("");
				}
			}
			
		});

		$("#delete-file").on("click", function() {
			$("#preview").html("");
		});
 