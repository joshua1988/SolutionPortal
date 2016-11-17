function confirmCustomUserForm() {
	var f = document.addCustomUser;
	f.setAttribute("method","post");
	f.setAttribute("action","addCustomUser");

	if(!confirmUserInfo(f)) return false;
	if(!confirmUserPermission(f)) return false;

	f.submit();
}

function noticeCheckbox() {
	$("input[name=MENU_NOTICE]:checkbox").attr("checked", true);
	alertPopup("필수 메뉴 입니다.");
}

function getCustomUserInfo(no) {
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","customUserInfo");
	document.body.appendChild(form);

	var param1 = createEl("userNo", no);
	form.appendChild(param1);

	form.submit();
}

function modifyCustomUserInfo(no) {
	var f = document.modifyCustomUser;

	if(confirmUserInfo(f)){
		f.setAttribute("method","post");
		f.setAttribute("action","modifyCustomUser");
		document.body.appendChild(f);

		var param1 = createEl("userNo", no);
		var param2 = createEl("mode", "info");
		f.appendChild(param1);
		f.appendChild(param2);
		f.submit();
	}

}

function modifyCustomUserPermission(no) {
	var f = document.modifyCustomUser;

	if(confirmUserPermission(f)){
		f.setAttribute("method","post");
		f.setAttribute("action","modifyCustomUser");
		document.body.appendChild(f);

		var param1 = createEl("userNo", no);
		var param2 = createEl("mode", "permission");
		f.appendChild(param1);
		f.appendChild(param2);
		f.submit();
	}

}

function confirmUserInfo(f) {
	var temp = true;
	if(f.USER_NO.value.replace(/\s/g, "") == ""){
		alertPopup("아이디를 입력해 주세요.");
		temp = false;
	}
	if(f.USER_NAME.value.replace(/\s/g, "") == ""){
		alertPopup("수주사명을 입력해 주세요.");
		temp = false;
	}
	return temp;
}

function changeButton(){
	$("input:text:not('#USER_NO_D')").removeAttr("disabled");
	$(".modify_button").css("display","none");
	$(".modify_submit_button").css("display","");
}

function changeButtonPerm() {
	$("input:checkbox").removeAttr("disabled");
	$(".modify_button_per").css("display","none");
	$(".modify_submit_button_per").css("display","");
}

function confirmUserPermission(f) {
	var temp = true;
	var parent = f.FUNCTION_GLUE_WRITE.checked;
	var child = false;

	// 16.11.09 confirmUserPermission 로직 수정 필요
	// $("input:checkbox[id='GLUE_CHECK']").each(function(){
	// 	if(this.checked) child = this.checked;
	// });
	// if(parent && !child){
	// 	alertPopup("Glue - <글 등록/삭제> 밑 하부 카테고리를 하나 이상 체크해 주세요.");
	// 	temp = false;
	// }else if(!parent && child){
	// 	alertPopup("메뉴 - Q&A -> <글 등록/삭제> 를 체크해 주세요.");
	// 	temp = false;
	// }
	//
	// parent = f.FUNCTION_GLUEMASTER_WRITE.checked;
	// child = false;
	// $("input:checkbox[id='GLUEMASTER_CHECK']").each(function(){
	// 	if(this.checked) child = this.checked;
	// });
	// if(parent && !child){
	// 	alertPopup("GlueMaster - <글 등록/삭제> 밑 하부 카테고리를 하나 이상 체크해 주세요.");
	// 	temp = false;
	// }else if(!parent && child){
	// 	alertPopup("메뉴 - GlueMaster -> <글 등록/삭제> 를 체크해 주세요.");
	// 	temp = false;
	// }
	//
	// parent = f.FUNCTION_GLUEMOBILE_WRITE.checked;
	// child = false;
	// $("input:checkbox[id='GLUEMOBILE_CHECK']").each(function(){
	// 	if(this.checked) child = this.checked;
	// });
	// if(parent && !child){
	// 	alertPopup("GlueMobile - <글 등록/삭제> 밑 하부 카테고리를 하나 이상 체크해 주세요.");
	// 	temp = false;
	// }else if(!parent && child){
	// 	alertPopup("메뉴 - GlueMobile -> <글 등록/삭제> 를 체크해 주세요.");
	// 	temp = false;
	// }
	//
	// parent = f.FUNCTION_UCUBE_WRITE.checked;
	// child = false;
	// $("input:checkbox[id='UCUBE_CHECK']").each(function(){
	// 	if(this.checked) child = this.checked;
	// });
	// if(parent && !child){
	// 	alertPopup("uCUBE - <글 등록/삭제> 밑 하부 카테고리를 하나 이상 체크해 주세요.");
	// 	temp = false;
	// }else if(!parent && child){
	// 	alertPopup("메뉴 - uCUBE -> <글 등록/삭제> 를 체크해 주세요.");
	// 	temp = false;
	// }
	//
	// parent = f.FUNCTION_POSBEE_WRITE.checked;
	// child = false;
	// $("input:checkbox[id='POSBEE_CHECK']").each(function(){
	// 	if(this.checked) child = this.checked;
	// });
	// if(parent && !child){
	// 	alertPopup("PosBee - <글 등록/삭제> 밑 하부 카테고리를 하나 이상 체크해 주세요.");
	// 	temp = false;
	// }else if(!parent && child){
	// 	alertPopup("메뉴 - PosBee -> <글 등록/삭제> 를 체크해 주세요.");
	// 	temp = false;
	// }
	//
	// parent = f.MENU_MANAGEMENT.checked;
	// child = false;
	// $("input:checkbox[id='MENU_MANAGEMENT_CHECK']").each(function(){
	// 	if(this.checked) child = this.checked;
	// });
	// if(parent && !child){
	// 	alertPopup("메뉴 - <고객 관리> 밑 서브메뉴를 체크해 주세요.");
	// 	temp = false;
	// }else if(!parent && child){
	// 	alertPopup("메뉴 - <고객 관리>를 체크해 주세요.");
	// 	temp = false;
	// }
	//
	// parent = f.MENU_SOLUTION_UPLOAD.checked;
	// child = false;
	// $("input:checkbox[id='SOLUTION_CHECK']").each(function(){
	// 	if(this.checked) child = this.checked;
	// });
	// if(parent && !child){
	// 	alertPopup("메뉴 - <솔루션 패키지 관리> 밑 등록할 솔루션을 하나 이상 체크해 주세요.");
	// 	temp = false;
	// }else if(!parent && child){
	// 	alertPopup("메뉴 - <솔루션 패키지 관리>를 체크해 주세요.");
	// 	temp = false;
	// }

	return temp;
}
