function packageManager(mode, localId){
	// saveLocalStoragy(localId);

	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","licenseManager");

	document.body.appendChild(form);

	var objectId = createEl("mode", mode);
	form.appendChild(objectId);
	form.submit();
}
function fileDownload(cate, id){
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","sdkFileDown");

	document.body.appendChild(form);

	var category = createEl("category", cate);
	var objectId = createEl("objectId", id);
	form.appendChild(category);
	form.appendChild(objectId);
	form.submit();
}

function fileDownload2(cate, id){
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","licenseFileDown");

	document.body.appendChild(form);

	var category = createEl("category", cate);
	var objectId = createEl("objectId", id);
	form.appendChild(category);
	form.appendChild(objectId);
	form.submit();
}

function createEl(name, value){
	var input_id = document.createElement("input");
	input_id.setAttribute("type", "hidden");
	input_id.setAttribute("name", name);
	input_id.setAttribute("value", value);

	return input_id;
}

function patchList(choose) {
	var url = "patchList";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{menu:choose},
		success: function(data){
			$("#fileList").empty();
			$("#fileList").append(data);
		}
	});
}

//function getOrderCompanyList() {
//	var url = "orderCompanyList";
//	jQuery.ajax({
//		type:"POST",
//		url:url,
//		success: function(data){
//			$("#fileList").empty();
//			$("#fileList").append(data);
//		}
//	});
//}

function optionCheck(f){
	if(f.folderCategory.value=='etc'){
		$("#packageVersion").attr("style","display:none");
		$(".packageVersionLabel").attr("style","display:none");
	}
	else{
		$("#packageVersion").attr("style","display:");
		$(".packageVersionLabel").attr("style","display:");
	}
}

function orderCompanyInfo(company) {
	var url = "orderCompanyInfo";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{companyId:company},
		dataType:"json",
		success: function(data){
			$("#companyInfoPop").empty();
			$("#companyInfoPop").append(""
				+"<div class='modal-content'>"
				+"<form name='modifyCompanyFrm'>"
				+"<div class='row'>"
				+"<div class='input-field col s6'>"
				+"<input placeholder='아이디 입력' id='USER_NO' type='text' name='USER_NO' value='"+data.map.USER_NO+"'>"
				+"<label for='USER_NO'>* 아이디</label>"
				+"</div>"
				+"<div class='input-field col s6'>"
				+"<input placeholder='수주사명 입력' id='USER_NAME' type='text' class='validate' name='USER_NAME' value='"+data.map.COMPANY_NAME+"'>"
				+"<label for='USER_NAME'>* 수주사명</label>"
				+"</div>"
				+"</div>"
				+"<div class='row'>"
				+"<div class='input-field col s6'>"
				+"<input placeholder='담당자 입력' id='MANAGER_NAME' type='text' class='validate' name='MANAGER_NAME' value='"+data.map.MANAGER_NAME+"'>"
				+"<label for='MANAGER_NAME'>담당자</label>"
				+"</div>"
				+"<div class='input-field col s6'>"
				+"<input placeholder='회사주소 입력' id='USER_ADDRESS' type='text' class='validate' name='USER_ADDRESS' value='"+data.map.USER_ADDRESS+"'>"
				+"<label for='USER_ADDRESS'>회사주소</label>"
				+"</div>"
				+"</div>"
				+"<div class='row'>"
				+"<div class='input-field col s6'>"
				+"<input placeholder='전화번호 입력' id='MANAGER_OFFICE_PHON' type='text' class='validate' name='MANAGER_OFFICE_PHON' value='"+data.map.MANAGER_OFFICE_PHON+"'>"
				+"<label for='MANAGER_OFFICE_PHON'>전화번호</label>"
				+"</div>"
				+"<div class='input-field col s6'>"
				+"<input placeholder='휴대번호 입력' id='MANAGER_CEL_PHON' type='text' class='validate' name='MANAGER_CEL_PHON' value='"+data.map.MANAGER_CEL_PHON+"'>"
				+"<label for='MANAGER_CEL_PHON'>휴대번호</label>"
				+"</div>"
				+"</div>"
				+"<div class='row'>"
				+"<div class='input-field col s12'>"
				+"<input placeholder='이메일 입력' id='MANAGER_EMAIL' type='email' class='validate' name='MANAGER_EMAIL' value='"+data.map.MANAGER_EMAIL+"'>"
				+"<label for='MANAGER_EMAIL'>이메일</label>"
				+"</div>"
				+"</div>"
				+"<input type='hidden' name='oriCompanyId' value='"+data.map.USER_NO+"'>"
				+"</form>"
				+"</div>"
				+"<div class='modal-footer'>"
				+"<a href='#' class='modal-action waves-effect waves-green btn-flat' onclick='javascript:expireOrderCompany("+"\""+data.map.USER_NO+"\""+"); return false;'><i class='material-icons left'>delete</i>제거</a>"
				+"<a href='#' class='modal-action modal-close waves-effect waves-green btn-flat' onclick='javascript:modifyCompanyInfo(); return false;'><i class='material-icons left'>create</i>수정</a>"
				+"</div>"
			);

			// 16.11.07 - 동적으로 텍스트 값 넣었을 때, validate 처리 하는 방법
			$("label").addClass("active");
		}
	});
}

function modifyCompanyInfo(){
	var f = document.modifyCompanyFrm;
	if(f.USER_NO.value.replace(/\s/g, "")==''){
		alertPopup("아이디를 입력해 주세요.");
		return false;
	}
	if(f.USER_NAME.value.replace(/\s/g, "")==''){
		alertPopup("수주사명을 입력해 주세요.");
		return false;
	}

	var form = document.modifyCompanyFrm;
	form.setAttribute("method","post");
	form.setAttribute("action","modifyCompanyInfo");
	form.submit();

//	var url = "modifyCompanyInfo";
//	var formData = $("form[name=modifyCompanyFrm]").serialize();
//	jQuery.ajax({
//		type:"POST",
//		url:url,
//		data:formData,
//		success: function(data){
//			getOrderCompanyList();
//			alertPopup("수정 되었습니다.");
//		}
//	});
}

function expireOrderCompany(companyId){
	var inst = confirmPopup("목록에서 제거 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		form.setAttribute("method","post");
		form.setAttribute("action","expireOrderCompany");
		document.body.appendChild(form);

		var param1 = createEl("companyId", companyId);
		form.appendChild(param1);
		form.submit();
	});

//	var inst = confirmPopup("목록에서 제거 하시겠습니까?");
//	inst.open();
//	var url = "expireOrderCompany";
//	$('.remodal-confirm').on('click', function () {
//		$.post(url,
//				{companyId:companyId},
//				function(data){
//					alertPopup("제거 완료");
//					getOrderCompanyList();
//				});
//	});
}

function getVersionInfo(f){
	var text = f.folderCategory.value;
	console.log("text : ", text);
	var list = f.packageVersion;
	var header = "<select class='addOption' name='packageVersion' id='packageVersion'>";
	var footer = "</select>";

	$(".selectBox").empty();
	if(text!='0'){
		var url = "versionList";
		jQuery.ajax({
			type:"POST",
			url:url,
			data:{menu:text},
			success: function(result){
				if(result!='null'){
					var strArray = result.split(":");
					var temp = "";
					temp += '<option value="0" selected="selected">선 택</option>';
					for(var i=0;i<strArray.length;i++){
						temp += "<option value='"+strArray[i]+"'>"+strArray[i]+"</option>";
					}

					temp = header + temp + footer;
					console.log("temp : ", temp);
					$(".selectBox").append(temp);
				}else{
					$(".select-wrapper addOption").append('<option value="0" selected="selected">없 음</option>');
					alertPopup("버젼정보가 없습니다.");
				}
				$('select').material_select();
			}
		});
	} else {
		var fragmentElement = header + "<option value='999' selected='selected'>패키지 버젼</option>" + footer ;
		$(".selectBox").append(fragmentElement);
	}
	$('select').material_select();
}

function deletePackage(category, id, mode){

	var inst = confirmPopup("삭제 하시겠습니까?");
	inst.open();
	var url = "deletePackage";
	$('.remodal-confirm').on('click', function () {
		$.post(url,
				{category:category, objectId:id},
				function(data){
					if(data=='Y'){
						patchList(mode);
						$.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close();
					}else if(data=='P'){
						alertPopup("삭제 권한이 없습니다.");
					}else{
						alertPopup("패키지와 매핑된 사용자가 있습니다.");
					}
				});
//		$.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close();
	});
}
function deletePatch(category, id, mode){
	var inst = confirmPopup("삭제 하시겠습니까?");
	inst.open();
	var url = "deletePackage";
	$('.remodal-confirm').on('click', function () {
		$.post(url,
				{category:category, objectId:id},
				function(data){
					patchList(mode);
				});
		$.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close();
	});
}

//function dddd(dd){
//	var temp = "0";
//	if(dd=="uCUBE") temp="0";
//	if(dd=="GlueMaster") temp="1";
//	if(dd=="GlueFrameowrk") temp="2";
//	if(dd=="PosBee") temp="3";
//	if(dd=="etc") temp="4";
//
//	return temp;
//}

function packageUp(){
	var f = document.packageUpload;
	formCheck(f);
}

function patchUp(){
	var f = document.patchUpload;
	formCheck(f);
}

function addOrderCompanyFormCheck(){
	var f = document.addOrderCompany;
	var no = f.USER_NO.value.replace(/\s/g, "");
	var name = f.USER_NAME.value.replace(/\s/g, "");
	if(no == ""){
		alertPopup("아이디를 입력해 주세요.");
		return;
	}
	if(name == ""){
		alertPopup("수주사명을 입력해 주세요.");
		return;
	}

	f.submit();
}

function formCheck(f){
	// console.log("formCheck's form : ", f);

	var folder = f.folderCategory.value.replace(/\s/g, "");
	var file = f.file.value.replace(/\s/g, "");
	var comment = f.comment.value.replace(/\s/g, "");
	var version = f.packageVersion.value.replace(/\s/g, "");

	// console.log("folder : ", folder);
	// console.log("file : ", file);
	// console.log("comment : ", comment);
	// console.log("version : ", version);

	if(folder == "0"){
		alertPopup("패키지를 선택하세요.");
		return;
	}
	if((version == "" || version == "0")&&folder!='etc'){
		alertPopup("패키지버젼을 선택 및 작성해 주세요");
		return;
	}
	if(file == ""){
		alertPopup("파일을 선택하세요.");
		return;
	}
	if(comment == ""){
		alertPopup("부가설명을 작성해 주세요.");
		return;
	}
	f.submit();
}

function openPackage(id, flag, mode){

	console.log("openPackage clicked");

	// var flag = 'Y'?"비":"";
	if (flag == "Y") {
		flag = "비";
	}	else {
		flag = "";
	}

	var text = flag;
	text += "공개로 전환 하시겠습니까?";
	var inst = confirmPopup(text);
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		form.setAttribute("method","post");
		form.setAttribute("action","openPackage");
		document.body.appendChild(form);

		var param1 = createEl("objectId", id);
		var param2 = createEl("flag", flag);
		var param3 = createEl("mode", mode);
		form.appendChild(param1);
		form.appendChild(param2);
		form.appendChild(param3);
		form.submit();
	});
}
