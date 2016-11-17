<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<title>인증서 다운로드</title>
<script type="text/javascript"> 
$(document).ready(function(){        	
	document.oncontextmenu = function(e) {
		   alertPopup("오른쪽버튼을 이용할 수 없습니다.");
		   return false;
	};
});
function pdfDownload(name){
	var form = document.createElement("form");     
	form.setAttribute("method","post");                    
	form.setAttribute("action","pdfDownload");
	
	document.body.appendChild(form);

	var fileName = createEl("fileName", name);
	form.appendChild(fileName);
	form.submit(); 
} 
</script>
</head>
<body>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body">
			<img src="${contextPath }/jsp/certificateDownload/${ImgFileName }" alt="인증서" style="width: 400px; height: 600px;">
      </div>
      <div class="modal-footer">
		<a href="#" class="btn btn-primary" onclick="javascript:pdfDownload('${PDFFileName }')">다운로드</a> 
        <a href="#" class="btn btn-default" data-dismiss="modal">닫기</a>
      </div>
    </div>
  </div>
</body>
</html>