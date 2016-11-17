<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">
td {
	text-align: center;
}
.td-left {
	width: 35%;
}
</style>
<body>
<form class="form-horizontal" role="form" name="modifyProfile" method="post">
	<div class="card-panel">
		<div class="card-header">
			<h5>고객 정보</h5>
		</div>
		<div class="card-content">
			<div class="panel-body" id="addContract">
				<c:if test="${not empty user }">
					<div class="row">
						<div class="input-field col s6">
							<i class="material-icons prefix">filter_7</i>
							<input id="USER_NO" name="USER_NO" type="text" class="validate" value="${user.getUSER_NO() }" disabled>
							<label for="USER_NO">계약번호</label>
						</div>
						<div class="input-field col s6">
							<i class="material-icons prefix">business</i>
							<input id="USER_NAME" name="USER_NAME" type="text" class="validate" value="${user.getUSER_NAME() }" disabled>
							<label for="USER_NAME">회사명</label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">place</i>
							<input id="USER_ADDRESS" name="USER_ADDRESS" type="text" class="validate" value="${user.getUSER_ADDRESS() }" disabled>
							<label for="USER_ADDRESS">회사주소</label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s4">
							<i class="material-icons prefix">content_paste</i>
							<input id="PROJECT_NAME" name="PROJECT_NAME" type="text" class="validate" value="${user.getPROJECT_NAME() }" disabled>
							<label for="PROJECT_NAME">프로젝트명</label>
						</div>
						<div class="input-field col s4">
							<i class="material-icons prefix">account_circle</i>
							<input id="MANAGER_NAME" name="MANAGER_NAME" type="text" class="validate" value="${user.getMANAGER_NAME() }" disabled>
							<label for="MANAGER_NAME">담당자</label>
						</div>
						<div class="input-field col s4">
							<i class="material-icons prefix">phone</i>
							<input id="MANAGER_OFFICE_PHON" name="MANAGER_OFFICE_PHON" type="text" class="validate" value="${user.getMANAGER_OFFICE_PHON() }" disabled>
							<label for="MANAGER_OFFICE_PHON">전화번호</label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s4">
							<i class="material-icons prefix">phone_iphone</i>
							<input id="MANAGER_CEL_PHON" name="MANAGER_CEL_PHON" type="text" class="validate" value="${user.getMANAGER_CEL_PHON() }" disabled>
							<label for="MANAGER_CEL_PHON">휴대번호</label>
						</div>
						<div class="input-field col s4">
							<i class="material-icons prefix">email</i>
							<input id="MANAGER_EMAIL" name="MANAGER_EMAIL" type="email" class="validate" value="${user.getMANAGER_EMAIL() }" disabled>
							<label for="MANAGER_EMAIL" data-error="이메일 형식을 준수하세요" data-success="올바른 이메일입니다">이메일</label>
						</div>
						<div class="input-field col s4">
							<%-- <label>수주사</label> --%>
							<c:if test="${not empty company }">
								<select id="ORDER_COMPANY_CODE" name="ORDER_COMPANY_CODE" disabled>
									<option disabled selected value="">수주사 선택</option>
									<c:forEach var="company" items="${company }">
										<option value="${company.COMPANY_CODE }" <c:if test="${company.COMPANY_NAME eq user.getORDER_COMPANY_CODE() }">selected</c:if> >${company.COMPANY_NAME }</option>
									</c:forEach>
								</select>
							</c:if>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s6">
							<i class="material-icons prefix">event_note</i>
							<%-- <input type="text" id="startDatepicker" class="form-control" placeholder="계약일자"  name="USER_START_DATE" value="${user.getUSER_START_DATE() }" disabled> --%>
							<input type="date" class="datepicker" id="startDatepicker" name="USER_START_DATE" value="${user.getUSER_START_DATE() }" disabled>
							<label for="startDatepicker">계약일자</label>
						</div>
						<div class="input-field col s6">
							<i class="material-icons prefix">event_note</i>
							<%-- <input type="text" id="setUpDatepicker" class="form-control" placeholder="제품설치일자"  name="PRODUCT_SETUP_DATE" value="${user.getPRODUCT_SETUP_DATE() }" disabled> --%>
							<input type="date" class="datepicker" id="setUpDatepicker" name="PRODUCT_SETUP_DATE" value="${user.getPRODUCT_SETUP_DATE() }" disabled>
							<label for="setUpDatepicker">제품설치일자</label>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>

	<div class="card-panel">
		<div class="card-header">
			<h5>기타파일 선택</h5>
		</div>
		<div class="card-content">
			<c:if test="${not empty etcUserFile }">
				<c:forEach var="list" items="${etcUserFile }">
					<%-- <c:if test="${list.FILE_CATEGORY eq 'etc' }"> --%>
						<div class="">
							<input type="checkbox" id="${list.OBJECT_ID }" value="${list.OBJECT_ID }" name="etcFile" disabled="disabled" <c:if test="${list.CT eq '1' }">checked</c:if>>
							<label class="black-text" for="${list.OBJECT_ID }">
								<i class="material-icons" style="vertical-align:top;">attachment</i>
								<%-- ${list.FILE_CATEGORY } --%>
								<strong>${list.PACKAGE_VERSION }</strong> ${list.MAIN_CONTENT }
							</label>
						</div>
					<%-- </c:if> --%>
				</c:forEach>
			</c:if>
		</div>
	</div>

  <c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
		<div class="">
			<a class="waves-effect waves-light btn modify_button" onclick="javascript:modifyInfo(); return false;"><i class="material-icons left">account_box</i>고객정보 수정</a>
			<a class="waves-effect waves-light btn modify_submit_button" onclick="javascript:modifyPro();" style="display: none;"><i class="material-icons left">save</i>수정완료</a>
			<a class="waves-effect waves-light btn" onclick="javascript:userExpire('${user.getUSER_NO() }');"><i class="material-icons left">delete</i>고객 삭제</a>
			<a class="waves-effect waves-light btn" onclick="javascript:initializationPassword('${user.getUSER_NO() }'); return false;"><i class="material-icons left">settings_backup_restore</i>비밀번호 초기화</a>
			<input type="hidden" name="oldUserNo" class="oldUserNo" value="${user.getUSER_NO() }">
		</div>
  </c:if>
</form>

	<c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
	<div class="card-panel">
		<div class="card-header" id="addProduct">
			<h5>제품 추가등록</h5>
		</div>
		<div class="card-content">
			<a class="waves-effect waves-light btn" onclick="javascript:addProduct(); return false;"><i class="material-icons left">add</i>추가</a>
			<a class="waves-effect waves-light btn" onclick="javascript:removeProduct(); return false;"><i class="material-icons left">remove</i>제거</a>
			<form name="plusProduct" enctype="multipart/form-data">
				<div id="plus"></div>
			</form>
		</div>
	</div>
	</c:if>

	<c:if test="${not empty product }">
		<div class="card-panel">
			<div class="card-header">
				<h5>제품 정보</h5>
			</div>
			<div class="card-content">
				<c:forEach var="pro" items="${product }" varStatus="status">
					<table>
						<tbody>
							<tr class="center">
								<td class="td-left">제품구분</td>
								<td>${pro.PRODUCT_FILE_NAME }</td>
							</tr>
							<tr>
								<td class="td-left">제품키</td>
								<td>${pro.LICENSE_KEY }</td>
							</tr>
							<tr>
								<td class="td-left">수량</td>
								<td>
									${pro.LICENSE_QUANTITY }
								</td>
							</tr>
							<tr>
								<td class="td-left">라이센스 파일</td>
								<td>
									<c:if test="${not empty pro.LICENSE_FILE_NAME }">
										${pro.LICENSE_FILE_NAME }
									</c:if>
									<c:if test="${empty pro.LICENSE_FILE_NAME }">
										<del>파일없음</del>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
					<c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
						<div align="center" style="padding:5px 5px;">
							<a class="waves-effect waves-light btn modal-trigger"
								onclick="javascript:productModifyForm('${user.getUSER_NO() }','${pro.LICENSE_KEY }'); return false;" href="#modal1">
								<i class="material-icons left">edit</i>수정
							</a>
							<a class="waves-effect waves-light btn"
								onclick="javascript:destroyProduct('${user.getUSER_NO() }','${pro.LICENSE_KEY }','1'); return false;">
								<i class="material-icons left">delete</i>삭제
							</a>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</c:if>

	<!-- Modal Structure -->
	<div id="modal1" class="modal">
	 <div class="modal-content">
	   <h5>제품정보 수정</h5>
		 <form name="modifyProduct" method="post" enctype="multipart/form-data" id="effect">
			 <table>
			 	<tbody>
			 		<tr>
			 			<td>제품구분</td>
						<td id="productFileId">
							<%-- content --%>
						</td>
			 		</tr>
					<tr>
						<td>제품키</td>
						<td>
							<input type='text' id="dataProductLicenseKey" name='LICENSE_KEY' value=data.product.LICENSE_KEY>
						</td>
					</tr>
					<tr>
						<td>수량</td>
						<td id="quantity">
							<select id="LICENSE_QUANTITY" name="LICENSE_QUANTITY">
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
								<option>6</option>
								<option>7</option>
								<option>8</option>
								<option>9</option>
								<option>10</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>라이센스 파일변경</td>
						<td align="">
							<input name="selectFile" type="radio" id="select1" onclick='javascript:displayFileSection(0)' checked="checked"/>
      				<label for="select1">기존</label>
							<input name="selectFile" type="radio" id="select2" onclick='javascript:displayFileSection(1)'/>
							<label for="select2">수정</label>
							<input type="checkbox" id="modifyFileCheck" name='CHECKBOX' onclick='javascript:modifyFileCheck();'/>
							<label for="modifyFileCheck">파일없음 체크</label>
							<input type='modifyFile' name='file' id='file' class='modifyFile' style='display: none;'>
						</td>
					</tr>
			 	</tbody>
			 </table>
			 <input type="hidden" name="userNo" value=data.userNo>
			 <input type="hidden" name="licenseKey" value=data.licenseKey>
		 </form>
	 </div>
	 <div class="modal-footer">
	   <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat" onclick="javascript:product(1);">변경</a>
		 <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">취소</a>
	 </div>
	</div>

<%-- Modal --%>
<%-- <div class="modal fade" id="modifyPop" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title"><p class="text-muted"><strong>제품 정보 수정</strong></p></h4>
      </div>
      <div class="modal-body">
		<form name="modifyProduct" method="post" enctype="multipart/form-data" id="effect">

		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="javascript:product(1);">변경</button>
      </div>
    </div>
  </div>
</div> --%>


	<script type="text/javascript">
	function addProduct(){
		var no = $(".contract1").length;

		if(no == 0){
			$("#addProduct").prepend(
				// ' <button class="btn btn-success btn-xs" onclick="javascript:moreProduct();" id="Enrollment">제품등록</button>'
				'<a class="waves-effect waves-light btn right" onclick="javascript:moreProduct();" id="Enrollment">'+
				// '<i class="material-icons left">cloud</i>제품등록</a>'
				'제품등록</a>'
			);
		}

		$("#plus").append(
			'<div class="contract1" style="margin:15px 15px;">'+
			'<div class="row">'+
				'<div class="col s6">'+
					'제품구분'+
					'<c:if test="${not empty file }">'+
						'<select class="" name="PRODUCT_FILE_ID['+no+']">'+
							'<c:forEach var="file" items="${file }">'+
								'<c:if test="${file.FILE_CATEGORY != etc }">'+
									'<option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option>'+
								'</c:if>'+
							'</c:forEach>'+
						'</select>'+
					'</c:if>'+
				'</div>'+
				'<div class="col s6">'+
					'제품키'+
					'<input type="text" class="license'+no+'" name="LICENSE_KEY['+no+']">'+
				'</div>'+
			'</div>'+
			'<div class="row">'+
				'<div class="col s6">'+
					'수량'+
					'<select id="selectedNum" name="LICENSE_QUANTITY">'+
						'<c:forEach begin="1" end="10" step="1" varStatus="status">'+
							'<option value="${status.index }">${status.index }</option>'+
						'</c:forEach>'+
					'</select>'+
				'</div>'+
				'<div class="col s6">'+
					'<span style="padding-right:1rem;">라이센스 파일</span>'+
					'<input type="checkbox" class="filled-in" id="fileCheck'+no+'" onclick="javascript:fileCheck('+no+');"/>'+
					'<label for="fileCheck'+no+'" onclick="javascript:fileCheck('+no+');">파일 필요 없을시 체크</label>'+
					'<input type="file" class="file'+no+'" name="file['+no+']">'+
					'<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'">'+
				'</div>'+
			'</div>'+
			'</div>'

			// '<div class="well well-sm contract1">'+
			// '<div class="form-group"><label class="control-label">제품구분</label>'+
			// '<c:if test="${not empty file }"><select class="form-control input-sm" name="PRODUCT_FILE_ID['+no+']"><c:forEach var="file" items="${file }"><c:if test="${file.FILE_CATEGORY != \'etc\'}"><option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option></c:if></c:forEach></select></c:if>'+
			// '</div><div class="form-group"><label class="control-label">제품키</label>'+
			// '<input class="form-control input-sm license'+no+'" type="text" name="LICENSE_KEY['+no+']"></div>'+
			// '<div class="form-group"><label class="control-label">수량</label>'+
			// '<select class="form-control input-sm" name="LICENSE_QUANTITY" id="LICENSE_QUANTITY['+no+']"><c:forEach begin="1" end="100" step="1" varStatus="status">'+
			// '<option value="${status.index }">${status.index }</option></c:forEach></select></div>'+
			// '<div class="form-group"><label class="control-label">라이센스파일 :: <input type="checkbox" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'">'+
			// '<small style="color: gray;">라이센스 파일이 필요 없을 시 체크</small></label>'+
			// '<input type="file" class="form-control input-sm file'+no+'" name="file['+no+']"></div>'+
			// '<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'"></div>'
			);

			$("select").material_select();

			$("#fileCheck" + no).on('change', function () {
				var ischecked = $("#fileCheck"+no).prop("checked");
				// console.log("ischecked : ", ischecked);
				if(ischecked){
					$(".file"+no).attr("disabled","disabled");
					$(".fileCheckVal"+no).val("true");
				}else{
					$(".file"+no).removeAttr("disabled");
					$(".fileCheckVal"+no).val("false");
				}
			});
	}

	// function fileCheck(no){
	// 	console.log("clicked");
	//
	// 	$("#fileCheck"+no).on('change', function () {
	// 		console.log("checked");
	// 	});
	//
	// 	var ischecked = $("#fileCheck"+no).prop("checked");
	// 	console.log("ischecked : ", ischecked);
	// 	if(ischecked){
	// 		$(".file"+no).attr("disabled","disabled");
	// 		$(".fileCheckVal"+no).val("true");
	// 	}else{
	// 		$(".file"+no).removeAttr("disabled");
	// 		$(".fileCheckVal"+no).val("false");
	// 	}
	// }

	function removeProduct(){
		var no = $(".contract1").length;
		if(no == 1){
			$("#Enrollment").remove();
		}
		$(".contract1:last").remove();
	}

	function productModifyForm(user, key){
		var url = "productModifyForm";
		jQuery.ajax({
			type:"POST",
			url:url,
			data:{userNo:user,licenseKey:key},
			dataType:"json",
			success: function(data){
				var productFileId = "<select name='PRODUCT_FILE_ID'>";
				$(data.file).each(function(index){
					productFileId+="<option value='"+data.file[index].OBJECT_ID;
					if(data.file[index].FILE_CATEGORY != 'etc'){
						if(data.product.PRODUCT_FILE_ID == data.file[index].OBJECT_ID){
							productFileId+="' selected>"+data.file[index].FILE_CATEGORY+" "+data.file[index].PACKAGE_VERSION+"</option>";
						}else{
							productFileId+="'>"+data.file[index].FILE_CATEGORY+" "+data.file[index].PACKAGE_VERSION+"</option>";
						}
					}
				});
				productFileId+="</select>";

				// 예전
				// $("#effect").empty();
				// $("#effect").append(
				// 	  	  	"<dl class='dl-horizontal'>"
				// 	  	  	+"<dt>제품구분</dt>"
				// 		+"<dd>"+productFileId+"</dd>"
				// 		+"<dt>제품키</dt>"
				// 		+"<dd><input type='text' class='form-control input-sm' name='LICENSE_KEY' value='"+data.product.LICENSE_KEY+"'></dd>"
				// 		+"<dt>수량</dt>"
				// 		+"<dd>"+quantity+"</dd>"
				// 		+"<dt>라이센스 파일변경</dt><dd><input type='radio' name='selectFile' checked='checked' value='fixed' onclick='javascript:displayFileSection(0)'>"
				// 		+"<label>기존</label><input type='radio' name='selectFile' value='change' onclick='javascript:displayFileSection(1)'><label>수정</label>"
				// 		+"<input type='checkbox' class='modifyFileCheck' name='CHECKBOX' value='true' onclick='javascript:modifyFileCheck();'><label style='color: #6B77C6; font-size:12px;'>파일없음 체크</label>&nbsp;&nbsp;<input type='file' name='file' id='file' class='modifyFile' style='display: none;'></dd>"
				// 		+"<input type='hidden' name='userNo' value='"+data.userNo+"'>"
				// 		+"<input type='hidden' name='licenseKey' value='"+data.licenseKey+"'>"
				// 		+"</dl>"
				// );

				// 개선
				$("#productFileId").prepend(productFileId);
				console.log("productFileId : ", productFileId);
				$("#dataProductLicenseKey").val(data.product.LICENSE_KEY);
				console.log("data.product.LICENSE_KEY : ", data.product.LICENSE_KEY);
				console.log("data.product.LICENSE_QUANTITY : ", data.product.LICENSE_QUANTITY);

				// $("#quantity").append(data.product.LICENSE_QUANTITY);
				if(data.product.LICENSE_QUANTITY){
					// $("#LICENSE_QUANTITY option:eq(2)").attr("selected","selected");
					$("#LICENSE_QUANTITY").val(data.product.LICENSE_QUANTITY).attr("selected","selected");
				}

				$('select').material_select();

			}
		});
	}
	</script>
</body>
