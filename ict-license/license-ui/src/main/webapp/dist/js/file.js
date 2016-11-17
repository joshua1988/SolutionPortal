function packageManager(mode, localId){
	saveLocalStoragy(localId);
	
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
					+"<div class='modal-dialog'>"
					+"<div class='modal-content'>"
					+"<div class='modal-header'>"
					+"<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>"
					+"<h4 class='modal-title'><p class='text-muted'><strong>"+data.map.COMPANY_NAME+"</strong></p></h4>"
					+"</div>"
					+"<div class='modal-body'>"
					+"<form name='modifyCompanyFrm'>"
					+"<dl>"
					+"<dt>아이디</dt><dd><input type='text' class='form-control' name='USER_NO' value='"+data.map.USER_NO+"'></dd>"
					+"<dt>회사명</dt><dd><input type='text' class='form-control' name='USER_NAME' value='"+data.map.COMPANY_NAME+"'></dd>"
					+"<dt>주소</dt><dd><input type='text' class='form-control' name='USER_ADDRESS' value='"+data.map.USER_ADDRESS+"'></dd>"
					+"<dt>담당자</dt><dd><input type='text' class='form-control' name='MANAGER_NAME' value='"+data.map.MANAGER_NAME+"'></dd>"
					+"<dt>전화번호</dt><dd><input type='text' class='form-control' name='MANAGER_OFFICE_PHON' value='"+data.map.MANAGER_OFFICE_PHON+"'></dd>"
					+"<dt>휴대번호</dt><dd><input type='text' class='form-control' name='MANAGER_CEL_PHON' value='"+data.map.MANAGER_CEL_PHON+"'></dd>"
					+"<dt>이메일</dt><dd><input type='text' class='form-control' name='MANAGER_EMAIL' value='"+data.map.MANAGER_EMAIL+"'></dd>"
					+"</dl>"
					+"<input type='hidden' name='oriCompanyId' value='"+data.map.USER_NO+"'>"
					+"<div class='btn-group'>"
					+"<button type='button' class='btn btn-info' data-dismiss='modal'>닫기</button>"
					+"<button id='hideButton' class='btn btn-default' data-dismiss='modal' onclick='javascript:modifyCompanyInfo(); return false;'>수정</button>"
					+"<button id='hideButton' class='btn btn-default' data-dismiss='modal' onclick='javascript:expireOrderCompany("+"\""+data.map.USER_NO+"\""+");return false;'>제거</button>"
					+"</div>"
					+"</form></div></div></div>"
					);
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
	var list = f.packageVersion;
	$(".addOption").empty();
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
					$(list).append(temp);
				}else{
					$(list).append('<option value="0" selected="selected">없 음</option>');
					alertPopup("버젼정보가 없습니다.");
				}
			}
		});
	}
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
	var folder = f.folderCategory.value.replace(/\s/g, "");
	var file = f.file.value.replace(/\s/g, "");
	var comment = f.comment.value.replace(/\s/g, "");
	var version = f.packageVersion.value.replace(/\s/g, "");
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
	var text = flag=='Y'?"비":"";
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