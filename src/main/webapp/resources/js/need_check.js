/**
 * 필수 입력 항목에 입력 여부를 반환하는 처리
 */
 function necessary() {
	var need = true;
			
	$(".need").each(function() {
		if( $(this).val() == "" ) {
			alert($(this).attr("title") + "을 입력하세요");
			$(this).focus();
			need = false;
			
			return need;
		}
	});
	
	$(".need_div option").each(function() {
		if ( this.value == "" ) {
			alert("분류를 입력하세요");
			need = false;
			
			return need;
		}
	});

	return need;
	
} //necessary()