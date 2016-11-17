<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<title>Insert title here</title>
</head>
<body>
<!-- <div class="row"> -->
<c:if test="${empty map }">
	<label style="font-size: 13px; color: gray;">패키지가 존재 하지 않습니다.</label>
</c:if>
	<c:if test="${not empty map.product && map.product.size()>0 }">
    <c:forEach var="packageL" items="${map.product }">
    	<c:if test="${packageL.FILE_CATEGORY != 'etc' }">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">${packageL.FILE_CATEGORY } ${packageL.PACKAGE_VERSION }</h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse in">
			  
			  <div class="panel-body">
				<dl class="dl-horizontal">
				  <dt>패키지 버젼</dt>
				  <dd>${packageL.FILE_CATEGORY } ${packageL.PACKAGE_VERSION }</dd>		
				  <dt>설명</dt>
				  <dd>${packageL.MAIN_CONTENT }</dd>
				  <dt>다운로드(패키지)</dt>
				  <dd><button type="button" class="btn btn-success btn-xs" onclick="javascript:fileDownload('pakage','${packageL.OBJECT_ID }')">
				  		다운로드</button>
				  </dd>	 	  
				</dl>
				<hr>
				<c:forEach var="temp" items="${map }">
					<c:if test="${temp.key == packageL.OBJECT_ID }">
						<c:forEach var="patch" items="${temp.value }">
							<dl class="dl-horizontal">	  
							  <dt>설명</dt>
							  <dd>${patch.MAIN_CONTENT }</dd>
							  <dt>다운로드(패치)</dt>
							  <dd>
							  	<button type="button" class="btn btn-success btn-xs" onclick="javascript:fileDownload('patch','${patch.OBJECT_ID }')">
							  	다운로드</button>
							  	${patch.PACKAGE_FILE_NAME }
							  </dd>		  	  
							</dl>
						</c:forEach>
					</c:if>
				</c:forEach>
			  </div>
		    </div>
		  </div>
		</c:if>
	</c:forEach>
	</c:if>
<!-- </div>	  -->

<!-- <div class="row">	 -->
	<c:if test="${not empty map.product && map.product.size()>0 }">
		
		<div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">기타파일</h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse in">
		    <div class="panel-body">
		  	<c:forEach var="list" items="${map.product }">
		  		<c:if test="${list.FILE_CATEGORY eq 'etc' }">
		  		<dl class="dl-horizontal">
		  			<dt>다운로드</dt>
		  			<dd>
			  			<button type="button" class="btn btn-success btn-xs" onclick="javascript:fileDownload('pakage','${list.OBJECT_ID }')">
				    	다운로드</button> 
		  				<strong>${list.PACKAGE_VERSION }</strong> ${list.MAIN_CONTENT }
		  			</dd>
		  		</dl>
		  		</c:if>
			</c:forEach>
			</div>
			</div>
		  </div>
	</c:if>
<!-- </div>    -->
</body>
</html>