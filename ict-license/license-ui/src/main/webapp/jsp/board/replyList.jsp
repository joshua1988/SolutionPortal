<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<title>Insert title here</title>
</head>
<body>
	<br>
	<label>덧글(${list.size() }) </label>
	<c:if test="${list.size() == 0 }">
	<label>덧글이 없습니다. </label>
	</c:if>
	<div class="list-group" style="padding-bottom: 0; padding-top: 0;">
		<c:if test="${!empty list }">
		<c:forEach var="list" items="${list }" varStatus="status">
		  <div class="list-group-item">
		      <h5 class="list-group-item-heading" style="color: gray;">
					${list.r_CREATION_DATE }
		          	&nbsp; ${list.USER_NAME}
		      </h5>
  			  <p class="list-group-item-text">${list.RE_MAIN_CONTENT } 
  			  	<security:authorize ifAnyGranted="ROLE_U,ROLE_S,ROLE_D,ROLE_C">
				<c:if test="${sessionScope.USER_NO == list.r_CREATION_USER }">
  			  		<a href="#" onclick="javascript:deleteReply('${list.ORI_FOLDER_ID }','${list.RE_CONTENT_NO}','${list.CONTENT_NO }'); return false;">
  			  		<img src="${contextPath }/dist/img/delete_reply.png" alt="삭제">
  			  		</a>
  			  	</c:if>
  			  	</security:authorize>
  			  </p>
		  </div>
		</c:forEach>
		</c:if>
	</div>
</body>
</html>