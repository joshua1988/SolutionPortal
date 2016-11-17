<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<fmt:formatDate var="startDate" value="${user.USER_START_DATE }" pattern="yyyy-MM-dd"/>
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
<form class="form-horizontal" role="form" name="modifyProgressInfo" action="${contextPath }/modifyProgressInfo" method="post" >
	<div class="panel panel-default">
   	  <div class="panel-heading">
   	  		<strong> 고객정보 </strong> <small><strong>작성자: ${user.COMPANY_NAME }<span style="color: #C0CFCB;"> | </span>
   	  		상태: <span style="color: #8B8BCC;">${user.ORDER_STATUS_TEXT }</span></strong></small>
   	  </div>
   	  <div class="panel-body" id="addContract">
		  <div class="form-group has-error">
		    <label for="P_USER_NAME" class="control-label">회사명</label>
		    <input type="text" class="form-control input-sm" id="P_USER_NAME" name="P_USER_NAME" value="${user.USER_NAME }" disabled="disabled">
		  </div>
		  <div class="form-group has-error">
		    <label for="P_PROJECT_NAME" class="control-label">프로젝트명</label>
		    <input type="text" class="form-control input-sm" id="P_PROJECT_NAME" name="P_PROJECT_NAME" value="${user.PROJECT_NAME }" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="P_USER_ADDRESS" class="control-label">회사주소</label>
		    <input type="text" class="form-control input-sm" id="P_USER_ADDRESS" name="P_USER_ADDRESS" value="${user.USER_ADDRESS }" disabled="disabled">
		  </div>		  
		  <div class="form-group">
		    <label for="P_MANAGER_NAME" class="control-label">담당자</label>
		    <input type="text" class="form-control input-sm" id="P_MANAGER_NAME" name="P_MANAGER_NAME" value="${user.MANAGER_NAME }" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="P_MANAGER_OFFICE_PHON" class="control-label">전화번호</label>
		    <input type="text" class="form-control input-sm" id="P_MANAGER_OFFICE_PHON" name="P_MANAGER_OFFICE_PHON" value="${user.MANAGER_OFFICE_PHON }" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="P_MANAGER_CEL_PHON" class="control-label">휴대번호</label>
		    <input type="text" class="form-control input-sm" id="P_MANAGER_CEL_PHON" name="P_MANAGER_CEL_PHON" value="${user.MANAGER_CEL_PHON }" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="P_MANAGER_EMAIL" class="control-label">이메일</label>
		    <input type="text" class="form-control input-sm" id="P_MANAGER_EMAIL" name="P_MANAGER_EMAIL" value="${user.MANAGER_EMAIL }" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="packageVersion" class="control-label">계약 예정일</label>
		    <div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				<input type="text" id="startDatepicker2" class="form-control" placeholder="계약예정일"  name="P_USER_START_DATE" value="${startDate }" disabled="disabled">
		    </div>
		  </div>
		  <div class="form-group">
		  		<label for="P_PRODUCT_FILE_NAME" class="control-label">계약 제품</label>
				<select class="form-control input-sm" name="P_PRODUCT_FILE_ID" id="P_PRODUCT_FILE_NAME"  disabled="disabled">
					<option value="N" selected>미 정</option>				
					<c:if test="${not empty file }">
					<c:forEach var="file" items="${file }">
						<c:if test="${file.FILE_CATEGORY != 'etc' }">
						<option value="${file.OBJECT_ID }" <c:if test="${file.OBJECT_ID eq user.PRODUCT_FILE_ID }">selected</c:if>>
						${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option>
						</c:if>
					</c:forEach>
					</c:if>
				</select>
		  </div>
	  	  
	  	  <c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
	  	  <hr>
	  	   	<div class="btn-group">
		  	  <input type="hidden" name="objectId" value="${user.OBJECT_ID }">
		  	  <c:if test="${user.ORDER_STATUS != 'G' && user.ORDER_STATUS != 'F' }">
			  <button type="button" class="btn btn-default btn-sm modify_button" onclick="javascript:modifyProgressButton(); return false;">정보수정</button>
			  </c:if>
			  <button type="button" class="btn btn-info btn-sm modify_submit_button" onclick="javascript:modifyProgress();" style="display: none;">수정완료</button>
			  <c:if test="${user.ORDER_STATUS != 'G' && user.ORDER_STATUS != 'F' }">
			  <button type="button" class="btn btn-default btn-sm" onclick="javascript:progressUserExpire('${user.OBJECT_ID }');">삭제</button>
			  </c:if>
			  
			  <security:authorize ifAnyGranted="ROLE_S,ROLE_C">
			  <c:if test="${user.ORDER_STATUS != 'F' && user.ORDER_STATUS != 'C' }">
			  <button type="button" class="btn btn-info btn-sm" onclick="javascript:changeUserStatus('${user.OBJECT_ID }','C','등록요청');">등록요청</button>
			  </c:if>
			  </security:authorize>
			  <security:authorize ifAnyGranted="ROLE_D">
			  <c:if test="${user.ORDER_STATUS == 'C' }">
			  <button type="button" class="btn btn-default btn-sm" onclick="javascript:changeUserStatus('${user.OBJECT_ID }','R','반려');">반려</button>
			  </c:if>
			  </security:authorize>
			  <c:if test="${user.ORDER_STATUS != 'F' }">
			  <button type="button" class="btn btn-info btn-sm" onclick="javascript:getUserContractForm('${user.OBJECT_ID }'); return false;" data-toggle="modal" data-target="#contractPop">고객등록</button>
			  </c:if>
	  		</div>
	  	  </c:if>
	  	<hr>
	  	
	  		<div class="well">
	  			<c:if test="${userPermission.isFUNCTION_PROGRESS_COMMENT() }">
	 			<div class="col-xs-12">
		 			<div class="input-group">
				      <textarea class="form-control" id="COMMENT" name="COMMENT" style="resize: none; height: 40px;"></textarea>
				      <span class="input-group-btn">
				        <button class="btn btn-info" type="button" onclick="javascript:insertComment('${user.OBJECT_ID}'); return false;" style="height: 40px;">등록</button>
				      </span>
				    </div>
			    </div>
			    </c:if>
			    <hr>
			    <div class="col-xs-12">

					<c:if test="${comment.size() == 0 }">
					<label>comment가 없습니다.</label>
					</c:if>
					<div class="list-group" style="padding-bottom: 0; padding-top: 0;">
						<c:if test="${!empty comment }">
						<c:forEach var="list" items="${comment }" varStatus="status">
						<div class="popover <c:if test="${sessionScope.USER_NO == list.r_CREATION_USER }">left</c:if> <c:if test="${sessionScope.USER_NO != list.r_CREATION_USER }">right</c:if>" style="display: block; max-width: 1280px; position: relative; z-index: 0; margin-left: 0px; <c:if test="${sessionScope.USER_NO == list.r_CREATION_USER }">margin-left: 10px;</c:if> <c:if test="${sessionScope.USER_NO != list.r_CREATION_USER }">margin-right: 10px;</c:if>">
					        <div class="arrow"></div>
					        <h3 class="popover-title">
					        	${list.r_CREATION_DATE } <strong style="color: #5bc0de;">${list.USER_NAME}</strong>
					        	<c:if test="${sessionScope.USER_NO == list.r_CREATION_USER }">
					        	<button class="btn btn-default btn-xs" type="button" id="modifybutton${status.index }" onclick="javascript:modifyCommentForm('modifyComment${status.index }','${list.OBJECT_ID}','${list.COMMENT_NO }','${status.index }'); return false;">수정</button>
					        	<button class="btn btn-default btn-xs" type="button" onclick="javascript:deleteComment('${list.OBJECT_ID}','${list.COMMENT_NO }'); return false;">삭제</button>
					        	</c:if>
					        </h3>
					        <div class="popover-content">
					          <p class="modifyComment${status.index }">${list.COMMENT }</p>
					        </div>
			      		</div>
			      		</c:forEach>
			      		</c:if>
			      		
					</div>
			    </div>
		    </div>
	  
	  	<hr>
			<div class="well">
				<div class="form-group">
			    	<label for="MANAGER_CEL_PHON" class="control-label"><span class="glyphicon glyphicon-paperclip"></span> history</label>
			    	<c:if test="${not empty log }">
			    	<ul class="list-group">
			    		<c:forEach var="list" items="${log }" varStatus="status">
					    	<li class="list-group-item" style="font-size: 12px;">
								  상태: <strong>${list.ORDER_STATUS_TEXT }</strong> <label style="color: #C0CFCB;">|</label> 
								  이벤트 발생일: ${list.r_CREATION_DATE } <label style="color: #C0CFCB;">|</label> <strong>${list.USER_NAME }</strong>
								  <c:if test="${not empty list.USER_NO }">
								  	<label style="color: #C0CFCB;">|</label> <strong>신규유저 전환</strong> 
								  	계약번호: <a href="#" class="alert-link" onclick="javascript:getInfomation('${list.USER_NO }');">${list.USER_NO }</a>
								  </c:if>
					    	</li>
					    </c:forEach>
				  	</ul>
				  	</c:if>
			  	</div>
			</div>
	</div>
	</div>
</form>	        
<!-- </div> -->

<div class="modal fade" id="contractPop" tabindex="-1" role="dialog" aria-labelledby="contractModalLabel" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title"><p class="text-muted"><strong>고객신규등록</strong></p></h4>
      </div>
      <div class="modal-body" id="content">
		
      </div>
    </div>
  </div>
</div>

</body>
</html>