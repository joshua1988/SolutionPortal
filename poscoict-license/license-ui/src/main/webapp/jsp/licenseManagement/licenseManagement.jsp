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
<style type="text/css">
.form-group{margin-bottom: 2px;}
</style>
<title>Insert title here</title>
</head>
<body>
		<div class="row" style="margin-left: 2px;">
			<c:if test="${userPermission.isFUNCTION_MANAGEMENT_INPUT_USER() }">
	    	<button type="submit" class="btn btn-success btn-sm" onclick="javascript:page('newContract');">
				<span class="glyphicon glyphicon-user"></span> &nbsp;신규
			</button>
			</c:if>
			<security:authorize ifAnyGranted="ROLE_D,ROLE_S,ROLE_C">
			<button type="button" class="btn btn-success btn-sm" onclick="javascript:generateExcel(); return false;">
				<span class="glyphicon glyphicon-list-alt"></span> &nbsp;엑셀
			</button>
			</security:authorize>
		    <select class="input-sm" id="managementSelect" name="managementSelect">
			  <option selected="selected" value="0">회사명</option>
			  <option value="1">계약번호</option>
			  <security:authorize ifAnyGranted="ROLE_D">
			  <option value="2">수주사</option>
			  </security:authorize>
			</select>
			<input type="text" onkeydown="javascript:if(event.keyCode == 13){searchCompany();}" class="input-sm" id="managementText" name="managementText" placeholder="Search">
			<button type="button" class="btn btn-info btn-sm" onclick="javascript:searchCompany();">검색</button>
		</div>
		
		<hr>
		
<!-- 		<div class="row"> -->
				<div class="list-group">
					<c:if test="${not empty list }">
						<c:forEach var="list" items="${list }" varStatus="status">
							<a href="#" class="list-group-item col-xs-12" onclick="javascript:getInfomation('${list.USER_NO }');">
								  <p style="line-height: 1; font-size: 12px;">
									<h4><strong>${list.USER_NAME } (${list.PROJECT_NAME })</strong></h4>
								    <span class="label label-default <c:if test="${list.PRODUCT_SETUP_DATE!=null }">label-info</c:if>">설치: ${list.PRODUCT_SETUP_DATE==null?'설치안됨':list.PRODUCT_SETUP_DATE }</span>
									<strong>계약번호: </strong>${list.USER_NO } / <strong>계약일자: </strong>${list.USER_START_DATE }
								  </p>
							</a>
						</c:forEach>
					</c:if>
				</div>
<!-- 		</div> -->
  
</body>
</html>