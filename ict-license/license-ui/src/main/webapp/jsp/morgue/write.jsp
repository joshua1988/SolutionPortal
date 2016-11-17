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
<title>Insert title here</title>
</head>
<body>
<form role="form" action="${contextPath }/customWrite" id="customW" name="customW" method="post" enctype="multipart/form-data">
	<div class="row">
  		<div class="col-xs-7">
		 	<div class="input-group input-group-sm" style="padding-bottom: 5px;">
			  <span class="input-group-addon"><strong>제목</strong></span>
			  <input type="text" class="form-control" placeholder="제목" name="WRITE_TITLE" id="WRITE_TITLE">
			</div>
		</div>
		<div class="col-xs-5">
		<p style="font-size: 12px; padding-top: 5px;">분류: ${boardName }</p>
		</div>
    </div>
	
	<div class="row">
		  <div class="col-xs-12" style="padding-bottom: 5px;">
		  <label for="boardAttach" class="control-label" style="font-size: 12px;">첨부파일</label>
		  <input type="file" class="form-control input-sm" name="boardAttach" id="boardAttach" multiple="multiple">
		  </div>
	</div>
	  
	<input type="hidden" name="boardId" value="${boardId }">
	
	
	<div class="row">
		<div class="col-xs-12">
	 	<textarea class="form-control" rows="18" style="width: 100%;" id="WRITE_MAIN_CONTENT" name="WRITE_MAIN_CONTENT"></textarea>
		</div>
	</div>
	
	<div class="row" style="padding-bottom: 20px;">
	<div class="col-xs-12">
	 		<button type="button" class="btn btn-default btn-sm btn-block" onclick="javascript:history.back();">취소</button>
	 		<button type="button" class="btn btn-info btn-sm btn-block" onclick="javascript:customWriteSubmit();">등록</button>
	 	</div>
	</div>
</form>

<script type="text/javascript" charset="utf-8" src="${contextPath }/dist/se2/js/HuskyEZCreator.js"></script>
<script src='${contextPath }/dist/multifile/jquery.js' type="text/javascript"></script>
<script src='${contextPath }/dist/multifile/jquery.form.js' type="text/javascript"></script>
<script src='${contextPath }/dist/multifile/jquery.MetaData.js' type="text/javascript"></script>
<script src='${contextPath }/dist/multifile/jquery.MultiFile.js' type="text/javascript"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "WRITE_MAIN_CONTENT",
    sSkinURI: "${contextPath }/dist/se2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});

$('#boardAttach').MultiFile({ 
	max: 10,
	STRING: { 
		remove: '<span class="glyphicon glyphicon-trash"></span>' 
	} 
});
</script>
</body>
</html>