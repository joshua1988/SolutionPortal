<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<script src="${contextPath }/dist/js/file.js"></script>
</head>
<body>
<div style="text-align: left;">
<c:if test="${empty packageList && solutionMode eq 'package' }">
	<label style="font-size: 13px; color: gray;">패키지가 존재 하지 않습니다.</label>
</c:if>

<c:if test="${not empty packageList && packageList.size()>0 }">
   <c:forEach var="packageL" items="${packageList }">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		      	  <c:if test="${packageL.FILE_CATEGORY != 'etc' }">
		          ${packageL.FILE_CATEGORY } 
		          </c:if>
		          ${packageL.PACKAGE_VERSION }
		      </h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse in">
			  
			  <div class="panel-body">
				<dl class="dl-horizontal"> 
				  <dt>패키지 버젼</dt>
				  <dd>${packageL.FILE_CATEGORY } ${packageL.PACKAGE_VERSION } (${packageL.r_CREATION_DATE })</dd>		
				  <dt>설명</dt>
				  <dd>${packageL.MAIN_CONTENT }</dd>
				  <dt>등록자</dt>
				  <dd>${packageL.USER_NAME }</dd>
				  <dt>다운로드(패키지)</dt>
				  <dd>
				  	<button type="button" class="btn btn-success btn-xs" onclick="javascript:fileDownload2('pakage','${packageL.OBJECT_ID }'); return false;">
				  		<span class="glyphicon glyphicon-download-alt"></span> &nbsp;다운로드
				  	</button>
				  	<button type="button" class="btn btn-danger btn-xs" onclick="javascript:deletePackage('package','${packageL.OBJECT_ID }','${mode }'); return false;">
				  		<span class="glyphicon glyphicon-trash"></span> &nbsp;삭제
				  	</button>
					
					<div class="btn-group" data-toggle="buttons">
					  <label class="btn btn-default btn-xs <c:if test="${packageL.GUEST_OPEN=='Y' }">active</c:if>">
					    <input type="radio" name="options"
					    onchange="<c:if test="${packageL.GUEST_OPEN=='N' }">javascript:openPackage('${packageL.OBJECT_ID }','${packageL.GUEST_OPEN }','${mode }'); return false;</c:if>"
					    > 공개
					  </label>
					  <label class="btn btn-default btn-xs <c:if test="${packageL.GUEST_OPEN=='N' }">active</c:if>">
					    <input type="radio" name="options" 
					    onchange="<c:if test="${packageL.GUEST_OPEN=='Y' }">javascript:openPackage('${packageL.OBJECT_ID }','${packageL.GUEST_OPEN }','${mode }'); return false;</c:if>"
					    > 비공개
					  </label>
					</div>
				  </dd>	 	  
				</dl>
				<hr>
				
				<c:if test="${not empty patchList && patchList.size()>0 }">
					<c:forEach var="patch" items="${patchList }" varStatus="status">
						<c:if test="${packageL.OBJECT_ID eq patch.P_OBJECT_ID }">
							<dl class="dl-horizontal">	  
							  <dt>패치 파일명</dt>
							  <dd>${patch.PACKAGE_FILE_NAME } (${patch.r_CREATION_DATE })</dd>
							  <dt>설명</dt>
							  <dd>${patch.MAIN_CONTENT }</dd>
							  <dt>다운로드(패치)</dt>
							  <dd>
							  	<button type="button" class="btn btn-success btn-xs" onclick="javascript:fileDownload2('patch','${patch.OBJECT_ID }'); return false;">
							  		<span class="glyphicon glyphicon-download-alt"></span> &nbsp;다운로드
							  	</button>
							  	<button type="button" class="btn btn-danger btn-xs" onclick="javascript:deletePatch('patch','${patch.OBJECT_ID }','${mode }'); return false;">
							  		<span class="glyphicon glyphicon-trash"></span> &nbsp;삭제
							  	</button>
							  </dd>		  	  
							</dl>
						</c:if>
					</c:forEach>
				</c:if>
			  </div>
		    </div>
		</div>
	</c:forEach>
</c:if>
</div>

<div class="modal fade" id="companyInfoPop" tabindex="-1" role="dialog" aria-labelledby="#companyInfoModalLabel" aria-hidden="true"></div>

</body>
</html>