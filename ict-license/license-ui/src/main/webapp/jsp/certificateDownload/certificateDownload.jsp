<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<script type="text/javascript">
function certificationDownload(name){
	$("#licenseInfo").empty();
	$("#licensedPop").append('<div id="licenseInfo"></div>');
	var url = "certificateDownloadInfo";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{licenseFileName:name },
		success: function(data){
			$("#licensedPop").modal("show");
			$("#licenseInfo").append(data);
		}
	});
}

function techSupportCertificationInfo(id){
	$("#licenseInfo").empty();
	$("#licensedPop").append('<div id="licenseInfo"></div>');
	var url = "techSupportCertificationInfo";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{productFileId:id },
		success: function(data){
			$("#licensedPop").modal("show");
			$("#licenseInfo").append(data);
		}
	});
}
</script>
</head>
<body>

<!-- <div class="row"> -->
<c:if test="${empty list }">
	<label style="font-size: 13px; color: gray;">패키지가 존재 하지 않습니다.</label>
</c:if>
	<c:if test="${not empty list.product && list.product.size()>0 }">
    <c:forEach var="packageL" items="${list.product }">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">${packageL.PRODUCT_FILE_NAME }</h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse in">
			  
			  <div class="panel-body">
				<dl class="dl-horizontal">
				  <dt>패키지 버젼</dt>
				  <dd>${packageL.PRODUCT_FILE_NAME }</dd>		
				  <dt>설명</dt>
				  <dd>${packageL.MAIN_CONTENT }</dd>
				  <dt>다운로드(패키지)</dt>
				  <dd><button type="button" class="btn btn-info btn-xs" onclick="javascript:fileDownload2('pakage','${packageL.PRODUCT_FILE_ID }')">
				  		다운로드</button>
				  </dd>	 	  
				  <dt>라이선스</dt>
				  <dd>
				  	  <c:if test="${not empty packageL.LICENSE_FILE_NAME }">
				  	  <button type="button" class="btn btn-info btn-xs" onclick="javascript:fileDownload2('license','${packageL.LICENSE_FILE_NAME }')">라이선스 다운로드</button>
				  	  </c:if>
	  	  			  <c:if test="${empty packageL.LICENSE_FILE_NAME }">
						라이선스 파일없음
					  </c:if>
					  <button type="button" class="btn btn-success btn-xs" onclick="javascript:certificationDownload('${packageL.LICENSE_FILE_NAME }')">라이선스 인증서 보기</button>
				  	  <button type="button" class="btn btn-success btn-xs" onclick="javascript:techSupportCertificationInfo('${packageL.PRODUCT_FILE_ID }')">기술지원 확약서 보기</button>
				  </dd>
				</dl>
				<hr>
				<c:forEach var="temp" items="${list }">
					<c:if test="${temp.key == packageL.PRODUCT_FILE_ID }">
						<c:forEach var="patch" items="${temp.value }">
							<dl class="dl-horizontal">	  
							  <dt>설명</dt>
							  <dd>${patch.MAIN_CONTENT }</dd>
							  <dt>다운로드(패치)</dt>
							  <dd>
							  	<button type="button" class="btn btn-info btn-xs" onclick="javascript:fileDownload2('patch','${patch.OBJECT_ID }')">
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
		  
	</c:forEach>
	</c:if>
<!-- </div>	 -->

<!-- <div class="row">	 -->
	<c:if test="${not empty list.etcList && list.etcList.size()>0 }">
		<div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">기타파일</h4>
		    </div>
		    <div class="panel-body">
		  	<c:forEach var="list" items="${list.etcList }">
			  <dl class="dl-horizontal">
			  	<dt>다운로드</dt>
			    <dd>
			    	<button type="button" class="btn btn-info btn-xs" onclick="javascript:fileDownload2('pakage','${list.ETC_ID }')">
			    	다운로드</button> 
			    	<strong>${list.ETC_FILE_NAME }</strong> ${list.MAIN_CONTENT }
			    </dd>
			  </dl>
			</c:forEach>
			</div>
		 </div>
	</c:if>
<!-- </div>   -->

<div class="modal fade" id="licensedPop" tabindex="-1" role="dialog" aria-labelledby="licensedPopModalLabel" aria-hidden="true" data-backdrop="static"></div>

</body>
</html>