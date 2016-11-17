<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<body>
	<c:if test="${list.size() == 0 }">
		<%-- <div>
			<span class="badge red left white-text" style="padding-left: 5px;">덧글이 없습니다.</span>
		</div> --%>
	</c:if>
	<c:if test="${list.size() > 0 }">
		<div class="divider"></div>
		<br>
		<div style="height:30px;">
			<span class="badge" style="position:inherit;">덧글(${list.size() })</span>
		</div>
	</c:if>
	<div style="font-size:14px; padding:0 10px;">
		<c:if test="${!empty list }">
		<c:forEach var="list" items="${list }" varStatus="status">
		  <div style="overflow-wrap: break-word;">
				<span class="blue-text text-darken-3">${list.r_CREATION_DATE }</span> &nbsp;&nbsp; ${list.RE_MAIN_CONTENT } &nbsp;&nbsp;
				<div class="chip">
			    <img src="${contextPath }/dist/images/${list.USER_NAME}.png" alt="${list.USER_NAME}">
			    ${list.USER_NAME}
			  </div>
				<i class="material-icons hoverable" style="vertical-align:middle;"
					onclick="javascript:cDeleteReply('${list.ORI_BOARD_ID }','${list.RE_CONTENT_NO}','${list.CONTENT_NO }'); return false;">close</i>
		  </div>
		</c:forEach>
		</c:if>
	</div>
</body>
