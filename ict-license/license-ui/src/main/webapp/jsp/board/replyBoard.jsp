<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<script type="text/javascript">
function replyBoard(){
	var form = document.insertReplyBoard;
	form.setAttribute("method","post");   
	form.setAttribute("action","replyBoard");
	
	var title = document.getElementById("reply_title").value.replace(/\s/g, "");
	oEditors.getById["reply_content"].exec("UPDATE_CONTENTS_FIELD", [ ]);
	var content = document.getElementById("reply_content").value.replace(/\s/g, "");
	if(title == "" || content == "" || content == "<br>"){
		alertPopup("제목 및 본문을 작성해 주세요.");
		return;
	}
	form.submit();
}

function createEl(name, value){
	var input_id = document.createElement("input");  
	input_id.setAttribute("type", "hidden");                  
	input_id.setAttribute("name", name);                        
	input_id.setAttribute("value", value);
	
	return input_id;
}

function cancelReplyBoard(){
	$(".replyBoardButton").css("display","");
	$("#replyBoardForm").empty();
}

function guestReplySubmit(){
	if(document.getElementById("guestIDD").value.replace(/\s/g, "")=="" || document.getElementById("guestPWW").value.replace(/\s/g, "")==""){
		alertPopup("임시 아이디와 패스워드를 입력해 주세요.");
		return;
	}
	
	replyBoard();
}
</script>
<title>답글등록</title>
</head>
<body>
<br>
<div class="well"> 
<form class="form-horizontal" name="insertReplyBoard" enctype="multipart/form-data">
			<div class="row">
				<div class="col-xs-12">
				 	<div class="input-group input-group-sm" style="padding-bottom: 5px;">
					  <span class="input-group-addon">
					  	<input type="checkbox" name="reply_openFlag" style="vertical-align: middle;" value="N" <c:if test="${replyBoardForm.OPEN_FLAG eq 'N' }">checked</c:if>> 
					  	<strong>비공개 | 제목</strong>
					  </span>
					  <input type="text" class="form-control" placeholder="제목" name="reply_title" id="reply_title" value="[RE:]${replyBoardForm.TITLE }">
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-xs-12" style="padding-bottom: 5px;">
				<label for="boardAttach" class="control-label" style="font-size: 12px;">첨부파일 추가</label>
				<input type="file" class="form-control input-sm" name="boardAttach" id="boardAttach" multiple="multiple">
				</div>
			</div>

			<div class="row">
				<div class="col-xs-12">
					<textarea class="form-control" rows="20" style="width: 100%;" id="reply_content" name="reply_content"></textarea>
				</div>
			</div>
			
			<div class="row">
<!-- 		 	<div class="col-xs-12">  -->
		 		<security:authorize ifAnyGranted="ROLE_G">
					<div class="input-group input-group-sm col-xs-12 has-warning">
					  <span class="input-group-addon">필수: 임시ID</span>
					  <input type="text" class="form-control" id="guestIDD" name="guestID" placeholder="guest ID">
					  <span class="input-group-addon">임시PW</span>
					  <input type="password" class="form-control" id="guestPWW" name="guestPW" placeholder="guest PW">
					</div>
					<div class="input-group-sm col-xs-12">
					  	<button type="button" class="btn btn-default btn-sm btn-block" onclick="javascript:cancelReplyBoard(); return false;">취소</button>
					  	<button type="button" class="btn btn-info btn-sm btn-block" onclick="javascript:guestReplySubmit();">답글등록</button>
					</div>
				</security:authorize>
				
				<security:authorize ifAnyGranted="ROLE_U,ROLE_S,ROLE_D,ROLE_C">
				<div class="col-xs-12">
				  	<button type="button" class="btn btn-default btn-sm btn-block" onclick="javascript:cancelReplyBoard(); return false;">취소</button>
				  	<button type="button" class="btn btn-info btn-sm btn-block" onclick="javascript:replyBoard();">답글등록</button>
				</div>
				</security:authorize>
			
		 		<input type="hidden" name="content_no" value="${replyBoardForm.CONTENT_NO }">
		 		<input type="hidden" name="subCategory" value="${replyBoardForm.SUBCATEGORY }">
		 		<input type="hidden" name="folder" value="${folder }">
		 		<input type="hidden" name="chartNum" value="${chartNum }">
		 		<input type="hidden" name="search" value="${search }">
		 		<input type="hidden" name="select" value="${select }">
<!-- 		 	</div>  -->
		 	</div>
</form>
</div> 

<script type="text/javascript" charset="utf-8" src="${contextPath }/dist/se2/js/HuskyEZCreator.js"></script>
<script src='${contextPath }/dist/multifile/jquery.js' type="text/javascript"></script>
<script src='${contextPath }/dist/multifile/jquery.form.js' type="text/javascript"></script>
<script src='${contextPath }/dist/multifile/jquery.MetaData.js' type="text/javascript"></script>
<script src='${contextPath }/dist/multifile/jquery.MultiFile.js' type="text/javascript"></script>
<script type="text/javascript">
 var oEditors = []; 
 oEditors = [];
 nhn.husky.EZCreator.createInIFrame({
     oAppRef: oEditors,
     elPlaceHolder: "reply_content",
     sSkinURI: "${contextPath}/dist/se2/SmartEditor2Skin.html",
     fCreator: "createSEditor2"
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