<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<style type="text/css">
	span.badge {
		position: inherit;
	}
	.re .material-icons:hover {
		color: #26a69a;
	}
	i {
		font-size: 1.5rem;
	}
</style>
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
			<span class="badge">덧글(${list.size() })</span>
		</div>
	</c:if>
	<div style="font-size:14px; padding:0 10px;">
		<c:if test="${!empty list }">
			<c:forEach var="list" items="${list }" varStatus="status">
				<form class="" action="index.html" method="post" enctype="multipart/form-data">
					<div class="re" style="overflow-wrap: break-word;">
						<div class="chip">
					    <img src="${contextPath }/dist/images/${list.USER_NAME}.png" alt="${list.USER_NAME}">
					    ${list.USER_NAME}
					  </div><br class="hide-on-med-and-up"/>
						${list.RE_MAIN_CONTENT }
						<%-- &nbsp;&nbsp; --%>
						<span class="blue-text text-darken-3">${list.r_CREATION_DATE.substring(2,16) }</span>
						<i class="material-icons" style="vertical-align:middle;"
							onclick="javascript:deleteReply('${list.ORI_FOLDER_ID }','${list.RE_CONTENT_NO}','${list.CONTENT_NO }'); return false;">close</i>
				  </div>
				</form>
			</c:forEach>
		</c:if>
	</div>
</body>
