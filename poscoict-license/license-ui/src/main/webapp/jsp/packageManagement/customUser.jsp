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
.form-group {
	margin-bottom: 0;
}
.form-group label{
	font-size: 12px;
}
</style>
<title>커스텀 유져 생성</title>
</head>
<body>
	<div class="well" style="margin: 0 auto 10px; background-color: white;">
		<button type="button" class="btn btn-default btn-sm" onclick="javascript:page('addCustomUserForm'); return false;"><b>커스텀 유져 생성</b></button>
	</div>

	<div class="well" style="background-color: white;">
		<c:if test="${empty list && list.size()<1 }">
			<label style="font-size: 13px; color: gray;">정보가 존재 하지 않습니다.</label>
		</c:if>
		<c:if test="${not empty list && list.size()>0 }">	
			<c:forEach var="list" items="${list }">
				<div class="panel panel-default">
				    <div class="panel-heading">
				      <h4 class="panel-title">
				      	  <div class="btn-group">
				      	  <button type="button" class="btn btn-info btn-xs" onclick="javascript:getCustomUserInfo('${list.USER_NO }'); return false;">보기/수정</button>
				      	  <button type="button" class="btn btn-default btn-xs" onclick="javascript:initializationPassword('${list.USER_NO }'); return false;">비번초기화</button>
				          </div>
				      </h4>
				    </div>
				    <div id="collapseOne" class="panel-collapse collapse in">
					  
					  <div class="panel-body table-responsive">
						
						<table class="table">
							<thead>
								<tr>
									<th><span style="color: black;">유저명</span></th>
									<th><span style="color: black;">ID</span></th>
									<th><span style="color: black;">담당자</span></th>
									<th><span style="color: black;">전화번호</span></th>
									<th><span style="color: black;">휴대번호</span></th>
									<th><span style="color: black;">이메일</span></th>
								</tr>
							</thead>
							<tbody>
							<tr>
								<td>${list.USER_NAME }</td>
								<td>${list.USER_NO }</td>
								<td>${list.MANAGER_NAME }</td>
								<td>${list.MANAGER_OFFICE_PHON==''?'없음':list.MANAGER_OFFICE_PHON }</td>
								<td>${list.MANAGER_CEL_PHON==''?'없음':list.MANAGER_CEL_PHON }</td>
								<td>${list.MANAGER_EMAIL==''?'없음':list.MANAGER_EMAIL }</td>
							</tr>
							</tbody>
						</table>
						
					  </div>
				    </div>
				</div>
			</c:forEach>
		</c:if>
	</div>
<%-- <script src="${contextPath }/dist/js/customUser.js"></script> --%>
</body>
</html>