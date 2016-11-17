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
	<form class="form-horizontal" role="form" action="${contextPath }/write" id="write_frm" name="write_frm" method="post" enctype="multipart/form-data">
	  <div class="row">
  		<div class="col-xs-7">
		 	<div class="input-group input-group-sm" style="padding-bottom: 5px;">
			  <span class="input-group-addon">
			  	<input type="checkbox" name="OPEN_FLAG" value="N" style="vertical-align: middle;"> 
			  	<strong>비공개 | 제목</strong>
			  </span>
			  <input type="text" class="form-control" placeholder="제목" name="WRITE_TITLE" id="WRITE_TITLE">
			</div>
		</div>
		<div class="col-xs-5">
		<p style="font-size: 12px; padding-top: 5px;">분류1: ${folder } / 분류2: ${subCategory }</p>
		</div>
	  </div>
	  
	  <div class="row">
		  <div class="col-xs-12" style="padding-bottom: 5px;">
		  <label for="boardAttach" class="control-label" style="font-size: 12px;">첨부파일</label>
		  <input type="file" class="form-control input-sm" name="boardAttach" id="boardAttach" multiple="multiple">
		  </div>
	  </div>
	    
	    <input type="hidden" name="folder" value="${folder }">
	    <input type="hidden" name="subCategory" value="${subCategory }">

			  
		 <div class="row">
			 <div class="col-xs-12">
			 <security:authorize ifAnyGranted="ROLE_D, ROLE_S, ROLE_U, ROLE_C">
				 <textarea class="form-control" rows="18" style="width: 100%;" 
					 id="WRITE_MAIN_CONTENT" name="WRITE_MAIN_CONTENT"></textarea>
				 </security:authorize>
				 <security:authorize ifAnyGranted="ROLE_G">
				 <textarea class="form-control" rows="18" style="width: 100%;"
				 id="WRITE_MAIN_CONTENT" name="WRITE_MAIN_CONTENT">
										 
				 * 처음 작성이 아니라면 프로젝트명만 제목에 붙여 주시면 됩니다.<br><br>

				 * 처음 작성이신가요?<br>
					아래 내용을  작성해 주시면 지원 대상 site인지 확인 후 답변을 드립니다.<br>
				1. 프로젝트 / site 명 :<br>
				2. 요청자  소속, 이름 :<br>
				3. 질문 내용, 현상 설명 : <br>
				4. 로그 , application context 등  첨부<br>
				</textarea>
			 </security:authorize>
			 </div>
		 </div>
	  
	  <div class="row" style="padding-bottom: 20px;">
	  		<security:authorize ifAnyGranted="ROLE_G">
	  			<div class="input-group input-group-sm col-xs-12 has-warning">
				  <span class="input-group-addon">필수: 임시ID</span>
				  <input type="text" class="form-control" id="guestID" name="guestID" placeholder="guest ID">
				  <span class="input-group-addon">임시PW</span>
				  <input type="password" class="form-control" id="guestPW" name="guestPW" placeholder="guest PW">
				</div>
				<hr>
				<div class="col-xs-12">
				    <button type="button" class="btn btn-default btn-sm btn-block" onclick="javascript:history.back();">취소</button>
				    <button type="button" class="btn btn-info btn-sm btn-block" onclick="javascript:gusetWriteSubmit();">등록</button>
			    </div>
			</security:authorize>
			
			<security:authorize ifAnyGranted="ROLE_U,ROLE_S,ROLE_D,ROLE_C">
			<div class="col-xs-12">
		  		<button type="button" class="btn btn-default btn-sm btn-block" onclick="javascript:history.back();">취소</button>
		  		<button type="button" class="btn btn-info btn-sm btn-block" onclick="javascript:writeSubmit2();">등록</button>
		  	</div>
		  	</security:authorize>
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