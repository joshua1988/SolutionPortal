<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
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
<form class="form-horizontal" role="form" name="addProgressContract" action="${contextPath }/addProgressContract" method="post">
	<div class="panel panel-default">
   	  <div class="panel-heading"><strong>고객정보 <small>(진행중)</small></strong></div>
   	  <div class="panel-body" id="addContract">
		  <div class="form-group has-error">
		    <label for="USER_NAME" class="control-label">회사명</label>
		    <input type="text" class="form-control input-sm" id="USER_NAME" name="USER_NAME">
		  </div>
		  <div class="form-group has-error">
		    <label for="PROJECT_NAME" class="control-label">프로젝트명</label>
		    <input type="text" class="form-control input-sm" id="PROJECT_NAME" name="PROJECT_NAME">
		  </div>
		  <div class="form-group">
		    <label for="USER_ADDRESS" class="control-label">회사주소</label>
		    <input type="text" class="form-control input-sm" id="USER_ADDRESS" name="USER_ADDRESS">
		  </div>		  
		  <div class="form-group">
		    <label for="MANAGER_NAME" class="control-label">담당자</label>
		    <input type="text" class="form-control input-sm" id="MANAGER_NAME" name="MANAGER_NAME">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_OFFICE_PHON" class="control-label">전화번호</label>
		    <input type="text" class="form-control input-sm" id="MANAGER_OFFICE_PHON" name="MANAGER_OFFICE_PHON">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_CEL_PHON" class="control-label">휴대번호</label>
		    <input type="text" class="form-control input-sm" id="MANAGER_CEL_PHON" name="MANAGER_CEL_PHON">
		  </div>
		  <div class="form-group">
		    <label for="MANAGER_EMAIL" class="control-label">이메일</label>
		    <input type="text" class="form-control input-sm" id="MANAGER_EMAIL" name="MANAGER_EMAIL">
		  </div>
		  <div class="form-group">
		    <label for="packageVersion" class="control-label">계약 예정일</label>
		    <div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				<input type="text" id="startDatepicker" class="form-control" placeholder="계약예정일"  name="USER_START_DATE">
		    </div>
		  </div>
		  <div class="form-group">
		  		<label for="PRODUCT_FILE_NAME" class="control-label">계약 제품</label>
				<select class="form-control input-sm" name="PRODUCT_FILE_ID" id="PRODUCT_FILE_NAME">
					<option value="N">미 정</option>				
					<c:if test="${not empty file }">
					<c:forEach var="file" items="${file }">
						<c:if test="${file.FILE_CATEGORY != 'etc' }">
						<option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option>
						</c:if>
					</c:forEach>
					</c:if>
				</select>
		  </div>
	  
	  	<hr>
		  <div class="form-group">
		    <label for="COMMENT" class="control-label">comment</label>
		    <textarea class="form-control" rows="3" id="COMMENT" name="COMMENT" style="resize: none;"></textarea>
		  </div>
	  
	  	<hr>
		<div class="form-group text-right">  
		  <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.back();">취소</button>
		  <button type="button" class="btn btn-primary btn-sm" onclick="javascript:addProgressUser();">등록</button>
		</div>
	</div>
	</div>
</form>	  

</body>
</html>