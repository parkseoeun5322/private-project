/**
 * 필수 입력 항목에 입력 여부를 반환하는 처리
 */
 function necessary() {
	var need = true;
			
	$(".need").each(function() {
		if( $(this).val() == "") {
			alert($(this).attr("title") + "을/를 입력하세요");
			$(this).focus();
			need = false;
		}
		return need;
	});
	
	$(".selecDiv").each(function() {
		var text = $(this).find('option:selected').val();
		
		if (text == "분류") { 
			alert("분류를 선택해주세요"); 
			need = false;
			return need; 
		}
	});
	
	return need;
	
} //necessary()