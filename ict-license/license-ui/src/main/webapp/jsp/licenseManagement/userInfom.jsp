<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<script type="text/javascript">
function addProduct(){
	var no = $(".contract1").length;
	
	if(no == 0){
		$("#addProduct").append(
		' <button class="btn btn-success btn-xs" onclick="javascript:moreProduct();" id="Enrollment">제품등록</button>'
		);
	}
	
	$("#plus").append(
			'<div class="well well-sm contract1">'+
			'<div class="form-group"><label class="control-label">제품구분</label>'+
			'<c:if test="${not empty file }"><select class="form-control input-sm" name="PRODUCT_FILE_ID['+no+']"><c:forEach var="file" items="${file }"><c:if test="${file.FILE_CATEGORY != \'etc\'}"><option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option></c:if></c:forEach></select></c:if>'+
			'</div><div class="form-group"><label class="control-label">제품키</label>'+
			'<input class="form-control input-sm license'+no+'" type="text" name="LICENSE_KEY['+no+']"></div>'+
			'<div class="form-group"><label class="control-label">수량</label>'+
			'<select class="form-control input-sm" name="LICENSE_QUANTITY" id="LICENSE_QUANTITY['+no+']"><c:forEach begin="1" end="100" step="1" varStatus="status">'+
			'<option value="${status.index }">${status.index }</option></c:forEach></select></div>'+
			'<div class="form-group"><label class="control-label">라이센스파일 :: <input type="checkbox" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'">'+
			'<small style="color: gray;">라이센스 파일이 필요 없을 시 체크</small></label>'+
			'<input type="file" class="form-control input-sm file'+no+'" name="file['+no+']"></div>'+
			'<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'"></div>'
			);
}
	
function romoveProduct(){
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
			var productFileId = "<select name='PRODUCT_FILE_ID' class='form-control input-sm'>";
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

			var quantity = "<select name='LICENSE_QUANTITY' id='LICENSE_QUANTITY' class='form-control input-sm'>";
			for(var i=1; i<101; i++){
				quantity+="<option value='"+i; 
				if(data.product.LICENSE_QUANTITY == i){
					quantity+="' selected>"+i+"</option>";
				}else{
					quantity+="'>"+i+"</option>";
				}
			}
			quantity+="</select>";

			$("#effect").empty();
			$("#effect").append(
		  	  	  	"<dl class='dl-horizontal'>"
		  	  	  	+"<dt>제품구분</dt>"
					+"<dd>"+productFileId+"</dd>"
					+"<dt>제품키</dt>"
					+"<dd><input type='text' class='form-control input-sm' name='LICENSE_KEY' value='"+data.product.LICENSE_KEY+"'></dd>"
					+"<dt>수량</dt>"
					+"<dd>"+quantity+"</dd>"
					+"<dt>라이센스 파일변경</dt><dd><input type='radio' name='selectFile' checked='checked' value='fixed' onclick='javascript:displayFileSection(0)'>"
					+"<label>기존</label><input type='radio' name='selectFile' value='change' onclick='javascript:displayFileSection(1)'><label>수정</label>"
					+"<input type='checkbox' class='modifyFileCheck' name='CHECKBOX' value='true' onclick='javascript:modifyFileCheck();'><label style='color: #6B77C6; font-size:12px;'>파일없음 체크</label>&nbsp;&nbsp;<input type='file' name='file' id='file' class='modifyFile' style='display: none;'></dd>"
					+"<input type='hidden' name='userNo' value='"+data.userNo+"'>"
					+"<input type='hidden' name='licenseKey' value='"+data.licenseKey+"'>"
					+"</dl>"
			);
		}
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
</script>
<style type="text/css">
body{ padding-bottom: 90px;}
#addContract .form-group, .contract1 .form-group {
	margin-bottom: 0.5px; 
	padding-left: 15px;
	padding-right: 15px;
}
.form-group label{
	font-size: 12px;
}
</style>
<title>Insert title here</title>
</head>
<body>
<!-- <div class="container"> -->
<form class="form-horizontal" role="form" name="modifyProfile" method="post">
	<div class="panel panel-default">
   	  <div class="panel-heading"><strong>고객정보</strong></div>
   	  <div class="panel-body" id="addContract">
   	  	  <c:if test="${not empty user }">
	      <div class="form-group has-error">
		    <label for="USER_NO" class="control-label">계약번호</label>
		    <input type="text" class="form-control input-sm" name="USER_NO" id="USER_NO" disabled="disabled" value="${user.getUSER_NO() }">
		  </div>
		  <div class="form-group has-error">
		    <label for="USER_NAME" class="control-label">회사명</label>
		    <input type="text" class="form-control input-sm" name="USER_NAME" id="USER_NAME" disabled="disabled" value="${user.getUSER_NAME() }">
		  </div>
		  <div class="form-group">
		    <label for="USER_ADDRESS" class="control-label">회사주소</label>
		    <input type="text" class="form-control input-sm" name="USER_ADDRESS" id="USER_ADDRESS" disabled="disabled" value="${user.getUSER_ADDRESS() }">
		  </div>		  
		  <div class="form-group">
		    <label for="PROJECT_NAME" class="control-label">프로젝트명</label>
		    <input type="text" class="form-control input-sm" name="PROJECT_NAME" id="PROJECT_NAME" disabled="disabled" value="${user.getPROJECT_NAME() }">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_NAME" class="control-label">담당자</label>
		    <input type="text" class="form-control input-sm" name="MANAGER_NAME" id="MANAGER_NAME" disabled="disabled" value="${user.getMANAGER_NAME() }">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_OFFICE_PHON" class="control-label">전화번호</label>
		    <input type="text" class="form-control input-sm" name="MANAGER_OFFICE_PHON" id="MANAGER_OFFICE_PHON" disabled="disabled" value="${user.getMANAGER_OFFICE_PHON() }">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_CEL_PHON" class="control-label">휴대번호</label>
		    <input type="text" class="form-control input-sm" name="MANAGER_CEL_PHON" id="MANAGER_CEL_PHON" disabled="disabled" value="${user.getMANAGER_CEL_PHON() }">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_EMAIL" class="control-label">이메일</label>
		    <input type="text" class="form-control input-sm" name="MANAGER_EMAIL" id="MANAGER_EMAIL" disabled="disabled" value="${user.getMANAGER_EMAIL() }">
		  </div>
		  <div class="form-group">
		    <label class="control-label">수주사</label>
		    	<c:if test="${not empty company }">
		      	<select class="form-control input-sm" name="ORDER_COMPANY_CODE" disabled="disabled">
		      		<c:forEach var="company" items="${company }">
				  		<option value="${company.COMPANY_CODE }" <c:if test="${company.COMPANY_NAME eq user.getORDER_COMPANY_CODE() }">selected</c:if> >${company.COMPANY_NAME }</option>
				  	</c:forEach>
				</select>
				</c:if>
		  </div>
		  <div class="form-group has-error">
		    <label for="packageVersion" class="control-label">계약일자</label>
		    <div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				<input type="text" id="startDatepicker" name="USER_START_DATE" class="form-control" disabled="disabled" value="${user.getUSER_START_DATE() }">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="packageVersion" class="control-label">제품설치일자</label>
		    <div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				<input type="text" id="setUpDatepicker" name="PRODUCT_SETUP_DATE" class="form-control" disabled="disabled" value="${user.getPRODUCT_SETUP_DATE() }">
		    </div>
		  </div>
		  </c:if>
	  </div>
	</div>
	  
	  <c:if test="${not empty etcUserFile }">
	  <div class="panel panel-default">
		  <div class="panel-heading"><strong>기타파일 선택</strong></div>
	      <div class="panel-body">
	      	<c:forEach var="list" items="${etcUserFile }">
		    <div class="checkbox">
			  	<label>
			    <input type="checkbox" value="${list.OBJECT_ID }" name="etcFile" disabled="disabled" <c:if test="${list.CT eq '1' }">checked</c:if>>
			    <strong>${list.PACKAGE_VERSION }</strong>  ${list.MAIN_CONTENT }
			  	</label>
		 	</div>
			</c:forEach>
	 	  </div>
 	  </div>
 	  </c:if>
 	  
 	  <c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
 	  <div class="btn-group">
		  <button type="button" class="btn btn-info btn-xs modify_button" onclick="javascript:modifyInfo(); return false;">고객정보 수정</button>
		  <button type="button" class="btn btn-info btn-xs modify_submit_button" onclick="javascript:modifyPro();" style="display: none;">수정완료</button>
		  <button type="button" class="btn btn-default btn-xs" onclick="javascript:userExpire('${user.getUSER_NO() }');">고객삭제</button>
		  <button type="button" class="btn btn-default btn-xs" onclick="javascript:initializationPassword('${user.getUSER_NO() }'); return false;">비밀번호 초기화</button>
		   <input type="hidden" name="oldUserNo" class="oldUserNo" value="${user.getUSER_NO() }">
	  </div>
	  </c:if>
</form>	  
	
	   <hr>
	   
	  <c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }"> 
	  <div class="panel panel-default">
	  	  <div class="panel-heading" id="addProduct"><strong>제품 추가 등록</strong></div>
	  	  <div class="panel-body">
	      	<button type="button" class="btn btn-info btn-xs" onclick="javascript:addProduct(); return false;">
	      		<span class="glyphicon glyphicon-plus"></span> &nbsp;추가
	   	  	</button>
	      	<button type="button" class="btn btn-default btn-xs" onclick="javascrip:romoveProduct(); return false;">
	     	<span class="glyphicon glyphicon-minus"></span> &nbsp;제거
	      	</button>
	      	
	      	<form name="plusProduct" enctype="multipart/form-data">
	      	<div id="plus"></div>
	      	</form>
	  	  </div>
      </div>
      </c:if>
	  
	  <c:if test="${not empty product }">
	  <div class="panel panel-default">
	  	  <div class="panel-heading"><strong>제품 정보</strong></div>
	  	  <div class="panel-body">
			  <c:forEach var="pro" items="${product }" varStatus="status">
	  	  	  <div class="well">
	  	  	  	  <dl class="dl-horizontal">
	  	  	  	  	<dt>제품구분</dt>
	  	  	  	  	<dd>${pro.PRODUCT_FILE_NAME }</dd>
	  	  	  	  	
	  	  	  	  	<dt>제품키</dt>
	  	  	  	  	<dd>${pro.LICENSE_KEY }</dd>
	  	  	  	  	
	  	  	  	  	<dt>수량</dt>
	  	  	  	  	<dd>${pro.LICENSE_QUANTITY }</dd>
	  	  	  	  	
	  	  	  	  	<dt>라이센스 파일</dt>
	  	  	  	  	<dd>
	  	  	  	  		<c:if test="${not empty pro.LICENSE_FILE_NAME }">
						${pro.LICENSE_FILE_NAME }
						</c:if>
						<c:if test="${empty pro.LICENSE_FILE_NAME }">
						<del>파일없음</del>
						</c:if>
	  	  	  	  	</dd>
	  	  	  	  	
	  	  	  	  	<c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
	  	  	  	  	<dt></dt>
	  	  	  	  	<dd>
	  	  	  	  	  <button type="button" class="btn btn-info btn-xs" onclick="javascript:productModifyForm('${user.getUSER_NO() }','${pro.LICENSE_KEY }'); return false;" data-toggle="modal" data-target="#modifyPop">수정</button>
					  &nbsp;<button type="button" class="btn btn-default btn-xs" onclick="javascript:destroyProduct('${user.getUSER_NO() }','${pro.LICENSE_KEY }','1'); return false;">삭제</button>
	  	  	  	  	</dd>
	  	  	  	  	</c:if>
	  	  	  	  </dl>
			  </div>
		      </c:forEach>
	  	  </div>
      </div>
      </c:if>
      	        
<!-- </div> -->

<div class="modal fade" id="modifyPop" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel" aria-hidden="true">
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
</div>
  
</body>
</html>