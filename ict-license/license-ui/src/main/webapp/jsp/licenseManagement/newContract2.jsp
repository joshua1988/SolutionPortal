<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<fmt:formatDate var="startDate" value="${userInfo.USER_START_DATE }" pattern="yyyy-MM-dd"/>
<script type="text/javascript">
function addProduct(){
	var no = $(".contract1").length;
	$("#plus").append(
			'<div class="well well-sm contract1">'+
			'<div class="form-group"><label class="control-label">제품구분</label>'+
			'<c:if test="${not empty file }"><select class="form-control input-sm" name="PRODUCT_FILE_ID['+no+']"><c:forEach var="file" items="${file }"><c:if test="${file.FILE_CATEGORY != \'etc\' }"><option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option></c:if></c:forEach></select></c:if>'+
			'</div><div class="form-group"><label class="control-label">제품키</label>'+
			'<input class="form-control input-sm license'+no+'" type="text" name="LICENSE_KEY['+no+']"></div>'+
			'<div class="form-group"><label class="control-label">수량</label>'+
			'<select class="form-control input-sm" name="LICENSE_QUANTITY" id="LICENSE_QUANTITY['+no+']"><c:forEach begin="1" end="100" step="1" varStatus="status">'+
			'<option value="${status.index }">${status.index }</option></c:forEach></select></div>'+
			'<div class="form-group"><label class="control-label">라이센스파일 :: <input type="checkbox" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'">'+
			'<small style="color: gray;">라이센스 파일이 필요 없을 시 체크</small></label>'+
			'<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'">'+
			'<input type="file" class="form-control input-sm file'+no+'" name="file['+no+']"></div>'+
			'</div>'
			);
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
<form class="form-horizontal" role="form" name="convertUser" action="${contextPath }/convertUser" method="post" enctype="multipart/form-data">
	<div class="panel panel-default">
   	  <div class="panel-heading"><strong>고객정보</strong></div>
   	  <div class="panel-body" id="addContract">
	      <div class="form-group has-error">
		    <label for="USER_NO" class="control-label">계약번호</label>
		    <input type="text" class="form-control input-sm" id="USER_NO" name="USER_NO">
		    <input type="hidden" name="objectId" value="${objectId }">
		  </div>
		  <div class="form-group has-error">
		    <label for="USER_NAME" class="control-label">회사명</label>
		    <input type="text" class="form-control input-sm" id="USER_NAME" name="USER_NAME" value="${userInfo.USER_NAME }">
		  </div>
		  <div class="form-group">
		    <label for="USER_ADDRESS" class="control-label">회사주소</label>
		    <input type="text" class="form-control input-sm" id="USER_ADDRESS" name="USER_ADDRESS" value="${userInfo.USER_ADDRESS }">
		  </div>		  
		  <div class="form-group">
		    <label for="PROJECT_NAME" class="control-label">프로젝트명</label>
		    <input type="text" class="form-control input-sm" id="PROJECT_NAME" name="PROJECT_NAME" value="${userInfo.PROJECT_NAME }">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_NAME" class="control-label">담당자</label>
		    <input type="text" class="form-control input-sm" id="MANAGER_NAME" name="MANAGER_NAME" value="${userInfo.MANAGER_NAME }">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_OFFICE_PHON" class="control-label">전화번호</label>
		    <input type="text" class="form-control input-sm" id="MANAGER_OFFICE_PHON" name="MANAGER_OFFICE_PHON" value="${userInfo.MANAGER_OFFICE_PHON }">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_CEL_PHON" class="control-label">휴대번호</label>
		    <input type="text" class="form-control input-sm" id="MANAGER_CEL_PHON" name="MANAGER_CEL_PHON" value="${userInfo.MANAGER_CEL_PHON }">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_EMAIL" class="control-label">이메일</label>
		    <input type="text" class="form-control input-sm" id="MANAGER_EMAIL" name="MANAGER_EMAIL" value="${userInfo.MANAGER_EMAIL }">
		  </div>
		  <div class="form-group">
		    <label class="control-label">수주사</label>
		    	<c:if test="${not empty company }">
		      	<select class="form-control input-sm" style="width: 100%;"  name="ORDER_COMPANY_CODE">
		      		<c:forEach var="company" items="${company }">
				  		<option value="${company.COMPANY_CODE }" <c:if test="${company.COMPANY_CODE eq userInfo.ORDER_COMPANY_CODE }">selected</c:if>>
				  		${company.COMPANY_NAME }</option>
				  	</c:forEach>
				</select>
				</c:if>
		  </div>
		  <div class="form-group has-error">
		    <label for="packageVersion" class="control-label">계약일자</label>
		    <div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				<input type="text" id="startDatepicker" class="form-control" placeholder="계약일자"  name="USER_START_DATE" value="${startDate }">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="packageVersion" class="control-label">제품설치일자</label>
		    <div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				<input type="text" id="setUpDatepicker" class="form-control" placeholder="제품설치일자"  name="PRODUCT_SETUP_DATE">
		    </div>
		  </div>
	  </div>
	</div>
	  
	  <div class="panel panel-default">
		  <div class="panel-heading"><strong>기타파일 선택</strong></div>
	      <div class="panel-body">
	      	<c:if test="${not empty file }">
	      	<c:forEach var="list" items="${file }">
	      		<c:if test="${list.FILE_CATEGORY eq 'etc' }">
				    <div class="checkbox">
				  	<label>
				    <input type="checkbox" value="${list.OBJECT_ID }" name="etcFile">
				    <strong>${list.PACKAGE_VERSION }</strong>  ${list.MAIN_CONTENT }
				  	</label>
				 	</div>
		 		</c:if>
			</c:forEach>
			</c:if>	
	 	  </div>
 	  </div>
 	  
 	  <div class="panel panel-default">
	  	  <div class="panel-heading"><strong>제품등록</strong>
	  	  	<c:if test="${not empty userInfo.PRODUCT_FILE_NAME && userInfo.PRODUCT_FILE_NAME != 'N' }"> 
	  	  	<small>계약예정제품: ${userInfo.PRODUCT_FILE_NAME }</small>
	  	  	</c:if>
	  	  </div>
	  	  <div class="panel-body">
	      	<button type="button" class="btn btn-primary btn-xs" onclick="javascript:addProduct(); return false;">
	      		<span class="glyphicon glyphicon-plus"></span> &nbsp;추가
	   	  	</button>
	      	<button type="button" class="btn btn-default btn-xs" onclick="javascrip:newRomoveProduct(); return false;">
	     	<span class="glyphicon glyphicon-minus"></span> &nbsp;제거
	      	</button>
	      	<div id="plus"></div>
	  	  </div>
      </div>

	  <hr>
	  
	  <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">취소</button>
	  <button type="button" class="btn btn-primary btn-sm" onclick="javascript:convertUser111();">
	  	<span class="glyphicon glyphicon-open"></span> &nbsp;등록
	  </button>
</form>	        
<!-- </div> -->
<script type="text/javascript">
$(function() {
	$( "#startDatepicker" ).datepicker();
	$( "#startDatepicker" ).change(function() {
		$( "#startDatepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	});
    
	$( "#setUpDatepicker" ).datepicker();
	$( "#setUpDatepicker" ).change(function() {
		$( "#setUpDatepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	});
});
</script>
</body>
</html>