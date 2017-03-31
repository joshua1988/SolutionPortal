function newRomoveProduct(){
	$(".contract1:last").remove();
}

function generateExcel(){
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","generateExcel");
	document.body.appendChild(form);
	form.submit();
}

function getInfomation(no){
	var userNo = createEl("userNo", no);
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","userInform");
	document.body.appendChild(form);
	form.appendChild(userNo);
	form.submit();
}

function getProgressInfomation(no){
	var userNo = createEl("objectId", no);
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","progressUserInfom");
	document.body.appendChild(form);
	form.appendChild(userNo);
	form.submit();
}

function insertComment(id){
	var comment = document.getElementById("COMMENT").value.replace(/\s/g, "");

	if(checkBytes(comment) > 2000){
		alertPopup("글자 수가 2000byte를 넘었습니다.");
		return false;
	}
	if(comment == ""){
		alertPopup("메모를 작성 해주세요.");
		return false;
	}
	comment = document.getElementById("COMMENT").value.replace(/\s/g, "&nbsp;");

	var inst = confirmPopup("등록 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		form.setAttribute("method","post");
		form.setAttribute("action","insertComment");
		var obid = createEl("objectId", id);
		var comm = createEl("comment", comment);

		document.body.appendChild(form);
		form.appendChild(obid);
		form.appendChild(comm);
		form.submit();
	});

}

function changeUserStatus(id, st, text){
	var inst = confirmPopup(text+" 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		form.setAttribute("method","post");
		form.setAttribute("action","changeUserStatus");
		var obid = createEl("objectId", id);
		var status = createEl("uStatus", st);

		document.body.appendChild(form);
		form.appendChild(obid);
		form.appendChild(status);
		form.submit();
	});
}

function fileCheck(no){
	var ischecked = $(".fileCheck"+no).is(":checked");
	if(ischecked){
		$(".file"+no).attr("disabled","disabled");
		$(".fileCheckVal"+no).val("true");
	}else{
		$(".file"+no).removeAttr("disabled");
		$(".fileCheckVal"+no).val("false");
	}
}

function modifyInfo(){
	$("input:not('#LICENSE_QUANTITY')").removeAttr("disabled");
	$("select").removeAttr("disabled");
	$(".modify_button").css("display","none");
	$(".modify_submit_button").css("display","");
	$(".modify_cancle").css("display","");
	$("#etcFIle").css("display","");
}

function modifyPro(){
	var f = document.modifyProfile;
	console.log("modifyPro f.USER_NO.value : ", f.USER_NO.value);
	var no = f.USER_NO.value.replace(/\s/g, "");
	var name = f.USER_NAME.value.replace(/\s/g, "");
	var date = f.USER_START_DATE.value.replace(/\s/g, "");

	if(no == ""){
		alertPopup("계약번호를 입력해 주세요.");
		return;
	}
	if(name == ""){
		alertPopup("회사명을 입력해 주세요.");
		return;
	}
	if(date == ""){
		alertPopup("계약일자를 입력해 주세요.");
		return;
	}

	f.action="modifyProfile";
	f.submit();
}

function modifyProgressButton(){
	$("input").removeAttr("disabled");
	$("select").removeAttr("disabled");
	$(".modify_button").css("display","none");
	$(".modify_submit_button").css("display","");
	$(".modify_cancle").css("display","");

	// 추가
	$("select").material_select();
}

function modifyProgress(){
	var f = document.modifyProgressInfo;
	var name = f.P_USER_NAME.value.replace(/\s/g, "");
	var pro = f.P_PROJECT_NAME.value.replace(/\s/g, "");

	if(name == ""){
		alertPopup("회사명을 입력해 주세요.");
		return;
	}
	if(pro == ""){
		alertPopup("프로젝트명을 입력해 주세요.");
		return;
	}

	var inst = confirmPopup("수정 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		f.action="modifyProgressInfo";
		f.submit();
	});
}

function addProgressUser(){
	var f = document.addProgressContract;
	var user = f.USER_NAME.value.replace(/\s/g, "");
	var project = f.PROJECT_NAME.value.replace(/\s/g, "");

	if(user == ""){
		alertPopup("회사명을 입력해 주세요.");
		return;
	}
	if(project == ""){
		alertPopup("프로젝트명을 입력해 주세요.");
		return;
	}

	f.submit();
}

function addUser(){
	var f = document.addContract;
	var no = f.USER_NO.value.replace(/\s/g, "");
	var name = f.USER_NAME.value.replace(/\s/g, "");
	var date = f.USER_START_DATE.value.replace(/\s/g, "");
	var check = true;

	if(no == ""){
		alertPopup("계약번호를 입력해 주세요.");
		return;
	}
	if(name == ""){
		alertPopup("회사명을 입력해 주세요.");
		return;
	}
	if(date == ""){
		alertPopup("계약일자를 입력해 주세요.");
		return;
	}

	var no = $(".contract1").length;
	if(no>0){
		for(var i=0; i<no; i++){
			var license = $(".license"+i).val();
			if(license.replace(/\s/g, "")=="" ){
				alertPopup("제품키를 입력해 주세요.");
				check = false;
				return false;
			}

			// 17.03.31(금),
			// 제품등록 탭 추가 후 라이센스 파일 체크 안하면 그냥 등록 되어야 하는데,
			// 파일 선택하라는 경보떠서 일단 주석 처리

			// var temp = $(".fileCheck"+i).is(":checked");
			// if(!temp){
			// 	if($(".file"+i).val()==""){
			// 		alertPopup("파일을 선택해 주세요.");
			// 		check = false;
			// 		return false;
			// 	}
			// }
		}
	}

	if(check == true){
		var form = document.addContract;
		form.submit();
	};
}

function displayFileSection(mode){
	if(mode=='1')
		$(".modifyFile").css("display","");
	else
		$(".modifyFile").css("display","none");
}

function modifyFileCheck(){
	var ischecked = $("#modifyFileCheck").is(":checked");
	if(ischecked){
		$(".modifyFile").attr("disabled","disabled");
		$(".modifyFileCheck").val("false");
	}else{
		$(".modifyFile").removeAttr("disabled");
		$(".modifyFileCheck").val("true");
	}
}

function product(mode){
	var inst = confirmPopup("수정 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.modifyProduct;
		form.action="modifyProduct";
		form.submit();
	});
}

function moreProduct(){
	var user = $(".oldUserNo").val();
	var check = true;

	var no = $("#plus .contract1").length;
	if(no>0){
		for(var i=0; i<no; i++){
			var license = $(".license"+i).val();
			if(license.replace(/\s/g, "")=="" ){
				alertPopup("제품키를 입력해 주세요.");
				check = false;
				return false;
			}

			var temp = $("#fileCheck"+i).prop("checked");
			if(!temp){
				if($(".file"+i).val()==""){
					alertPopup("파일을 선택해 주세요.");
					check = false;
					return false;
				}
			}
		}
	}

	if(check==true){
		var form = document.plusProduct;
		var userNo = createEl("userNo", user);
		form.appendChild(userNo);
		form.setAttribute("method","post");
		form.setAttribute("action","plusProduct");
		form.submit();
	}
}

function userExpire(user){
	var inst = confirmPopup("유저를 삭제 하시겠습니까? 리스트에서만 제거 되고 데이터는 서버에 남게 됩니다.");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		var userNo = createEl("userNo", user);
		form.setAttribute("method","post");
		form.setAttribute("action","userExpire");
		document.body.appendChild(form);
		form.appendChild(userNo);
		form.submit();
	});
}

function progressUserExpire(id){
	var inst = confirmPopup("유저를 삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		var objectId = createEl("objectId", id);
		form.setAttribute("method","post");
		form.setAttribute("action","progressUserExpire");
		document.body.appendChild(form);
		form.appendChild(objectId);
		form.submit();
	});
}

function initializationPassword(user){
	var inst = confirmPopup("비밀번호를 초기화 하시겠습니까?");
	inst.open();
	var url = "initializationPassword";
	$('.remodal-confirm').on('click', function () {
		jQuery.ajax({
			type:"POST",
			url:url,
			data:{userNo: user },
			success: function(data){
				if(data == 'success'){
					alertPopup("비밀번호 초기화 완료");
				}
			}
		});
	});
}

function destroyProduct(user, key){
	var inst = confirmPopup("정말 삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		form.setAttribute("method","post");
		form.setAttribute("action","destroyProduct");

		document.body.appendChild(form);

		var userNo = createEl("userNo", user);
		var licenseKey = createEl("licenseKey", key);
		form.appendChild(userNo);
		form.appendChild(licenseKey);

		form.submit();
	});
}

function searchCompany(){
	var temp = document.getElementById("managementText").value.replace(/\s/g, "");

	if(temp == "" || temp.length <= 1){
		alertPopup("두 글자 이상 입력해 주세요");
		return;
	}

	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","management");

	document.body.appendChild(form);
	var choose = $("#managementSelect > option:selected").val();
	var text = document.getElementById("managementText").value;

	var search = createEl("search", text);
	var select = createEl("select", choose);
	form.appendChild(search);
	form.appendChild(select);
	form.submit();
}

function searchProgressCompany(){
	var temp = document.getElementById("progressText").value.replace(/\s/g, "");

	if(temp == "" || temp.length <= 1){
		alertPopup("두 글자 이상 입력해 주세요");
		return;
	}

	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","progress");

	document.body.appendChild(form);
	var choose = $("#progressSelect > option:selected").val();
	var text = document.getElementById("progressText").value;
	var search = createEl("search", text);
	var select = createEl("select", choose);
	form.appendChild(search);
	form.appendChild(select);
	form.submit();
}

function getSubCategoryList(sub){
	var form = document.createElement("form");
	form.setAttribute("action","progress");
	form.setAttribute("method","POST");
	document.body.appendChild(form);
	var subCategory = createEl("subCategory", sub);
	form.appendChild(subCategory);

	form.submit();
}

function deleteComment(id, no){
	var inst = confirmPopup("정말 삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		form.setAttribute("action","deleteComment");
		form.setAttribute("method","POST");
		document.body.appendChild(form);
		var objectId = createEl("objectId", id);
		var commentNo = createEl("commentNo", no);
		form.appendChild(objectId);
		form.appendChild(commentNo);

		form.submit();
	});
}

function modifyCommentForm(f,id,no,index){
	var t = $("."+f);
	var text = t.text();
	t.append('<div class="row" style="margin-left: 2px; margin-right: 2px; " id="modifyTextArea'+index+'">'
			+'<hr><textarea class="form-control" id="newComment'+index+'" style="resize: none; ">'+text+'</textarea><div class="btn-group">'
			+'<button type="button" class="btn btn-default btn-xs" onclick="javascript:modifyCancel(\''+index+'\'); return false;">취소</button>'
			+'<button type="button" class="btn btn-info btn-xs" onclick="javascript:modifyComment(\''+index+'\',\''+id+'\',\''+no+'\');">수정</button></div></div>'
	);
	document.getElementById('modifybutton'+index).style.display ='none';
}

function modifyCancel(index){
	document.getElementById('modifybutton'+index).style.display ='';
	$("#modifyTextArea"+index).remove();
}

function modifyComment(index,id,no){
	var text = document.getElementById('newComment'+index).value.replace(/\s/g, "");

	if(checkBytes(text) > 2000){
		alertPopup("글자 수가 2000byte를 넘었습니다.");
		return false;
	}

	if(text == ""){
		alertPopup("메모를 입력해 주세요");
		return;
	}

	text = document.getElementById('newComment'+index).value.replace(/\s/g, "&nbsp;");

	var inst = confirmPopup("수정 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		form.setAttribute("action","modifyComment");
		form.setAttribute("method","POST");
		document.body.appendChild(form);
		var objectId = createEl("objectId", id);
		var commentNo = createEl("commentNo", no);
		var comment = createEl("comment", text);
		form.appendChild(objectId);
		form.appendChild(commentNo);
		form.appendChild(comment);

		form.submit();
	});
}

function getUserContractForm(id){
	var url="userContractForm";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{objectId: id},
		success: function(data){
			$("#content").empty();
			$("#content").append(data);
		}
	});
}

function convertUser111(){
	var f = document.convertUser;
	var no = f.USER_NO.value.replace(/\s/g, "");
	var name = f.USER_NAME.value.replace(/\s/g, "");
	var date = f.USER_START_DATE.value.replace(/\s/g, "");

	if(no == ""){
		alertPopup("계약번호를 입력해 주세요.");
		return;
	}
	if(name == ""){
		alertPopup("회사명을 입력해 주세요.");
		return;
	}
	if(date == ""){
		alertPopup("계약일자를 입력해 주세요.");
		return;
	}

	var no = $(".contract1").length;
	if(no>0){
		for(var i=0; i<no; i++){
			var license = $(".license"+i).val();
			if(license.replace(/\s/g, "")=="" ){
				alertPopup("제품키를 입력해 주세요.");
				return false;
			}

			var temp = $(".fileCheck"+i).is(":checked");
			if(!temp){
				if($(".file"+i).val()==""){
					alertPopup("파일을 선택해 주세요.");
					return false;
				}
			}
		}
	}

	var inst = confirmPopup("정식 고객으로 등록 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.convertUser;
		form.submit();
	});
}


function fileCheck(no){
	var ischecked = $(".fileCheck"+no).is(":checked");
	if(ischecked){
		$(".file"+no).attr("disabled","disabled");
		$(".fileCheckVal"+no).val("true");
	}else{
		$(".file"+no).removeAttr("disabled");
		$(".fileCheckVal"+no).val("false");
	}
}
