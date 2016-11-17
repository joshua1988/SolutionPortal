<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<title>Insert title here</title>
</head>
<body>
	<form role="form" name="insertModifyBoard" enctype="multipart/form-data">
	 	<div class="row">
	 		<div class="col-xs-7">
			 	<div class="input-group input-group-sm" style="padding-bottom: 5px;">
				  <span class="input-group-addon">
				  	<input type="checkbox" name="modify_openFlag" id="modify_openFlag" style="vertical-align: middle;" value="N" <c:if test="${board.OPEN_FLAG eq 'N' }">checked</c:if>> 
				  	<strong>비공개 | 제목</strong>
				  </span>
				  <input type="text" class="form-control" placeholder="제목" name="modify_title" class="modify_title" id="modify_title" value="${board.TITLE }">
				</div>
			</div>
			<div class="col-xs-5">
			<p style="font-size: 12px; padding-top: 5px;">분류: ${folder }</p>
			</div>
		</div>
		
		<c:if test="${not empty attachInfo }">
			<blockquote>
			    <small style="vertical-align: middle;">
			    첨부파일<br>
				<c:forEach var="attach" items="${attachInfo }" varStatus="status">
				<div class="checkbox">
					<label>
					<input type="checkbox" style="margin-top: 2px;" name="deleteFile" id="deleteFile" value="${attach.OBJECT_ID }">삭제:첨부파일 ${status.index+1 } - ${attach.ATTACH_FILE_NAME }(${attach.ATTACH_FILE_SIZE }byte)
					<br>
					</label>
				</div>
				</c:forEach>
				</small>
			</blockquote>
		</c:if>
		
		<div class="row">
			<div class="col-xs-12" style="padding-bottom: 5px;">
			<label for="boardAttach" class="control-label" style="font-size: 12px;">첨부파일 추가</label>
			<input type="file" class="form-control input-sm" name="boardAttach" id="boardAttach" multiple="multiple">
			</div>
		</div>
		
	  <div class="row">
	  	<div class="col-xs-12">
		  	<textarea class="form-control" rows="20" id="modify_content" name="modify_content" class="modify_content" style="width: 100%;"></textarea>
		</div>
	  </div>
	  
	  <div class="row">
		<div class="col-xs-12">
		    <button type="button" class="btn btn-default btn-sm btn-block" onclick="javascript:history.back();">취소</button>
		    <button type="button" class="btn btn-info btn-sm btn-block" onclick="javascript:modifyBoard();">수정</button>
	    </div>
	  </div>
	    
    	<input type="hidden" name="content_no" value="${board.CONTENT_NO }">
 		<input type="hidden" name="folder" value="${folder }">
 		<input type="hidden" name="chartNum" value="${chartNum }">
 		<input type="hidden" name="select" value="${select }">
 		<input type="hidden" name="search" value="${search }">
 		<input type="hidden" name="subCategory" value="${board.SUBCATEGORY }">
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
    elPlaceHolder: "modify_content", 
    sSkinURI: "${contextPath}/dist/se2/SmartEditor2Skin.html", 
    fCreator: "createSEditor2", 
    fOnAppLoad : function(){ 
		var paramCn = '${board.MAIN_CONTENT }';
		paramCn = replaceAll(paramCn,"</br>","\n");
        oEditors.getById["modify_content"].exec("PASTE_HTML",[paramCn]); 
    } 
});

$('#boardAttach').MultiFile({ 
	max: 10,
	STRING: { 
		remove: '<span class="glyphicon glyphicon-trash"></span>' 
	} 
});

function replaceAll(sValue, param1, param2) {
    return sValue.split(param1).join(param2);
}
</script> 
</body>
</html>