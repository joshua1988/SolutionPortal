<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<link rel="stylesheet" type="text/css" href="${contextPath }/dist/se2/css/smart_editor2_out.css">
<title>Insert title here</title>
</head>
<body>
		<div class="row">
		<blockquote style="margin: 0;">
		  <p style="line-height: 1;">
			${board.TITLE }
		  </p>
		  <small>
		  		분류: ${board.BOARD_NAME }
		  		<label style="color: #C0CFCB;">|</label> ${board.CONTENT_NO } 번
				<label style="color: #C0CFCB;">|</label> 작성자:${board.USER_NAME }
				<label style="color: #C0CFCB;">|</label> ${board.r_CREATION_DATE }
				<br>
				<c:if test="${not empty attachInfo && attachInfo.size()>0 }">
					<br>
					<c:forEach items="${attachInfo }" var="attach" varStatus="status">
						첨부파일 ${status.index+1 }: 
						<abbr><a href="#" style="color: black;" onclick="javascript:attachFileDown('${attach.OBJECT_ID }')">${attach.ATTACH_FILE_NAME }(${attach.ATTACH_FILE_SIZE }byte)</a></abbr><br>
					</c:forEach>
				</c:if>
		  </small>
		</blockquote>
		</div>
		
		<hr>
		<div class="row" style="margin-left: 5px; margin-right: 5px;">
	   		<div class="se2_outputarea" style="word-break: break-all; position: static;">
	 			${board.MAIN_CONTENT }
	 		</div>
 		</div>
 		
 		<hr>
 		<div class="row" style="padding: 0 30px 0 0;">
 			<div class="btn-group col-xs-6">
			    <button type="button" class="btn btn-success" onclick="javascript:cMovePage('${chartNum }','${board.ORI_BOARD_ID }','${search==null?null:search }','${select==null?null:select }')">목록</button>
				<c:if test="${ board.CONTENT_SEQ == 1 }">
			  	<button type="button" class="btn btn-default replyBoardButton" onclick="javascript:getReplyCustomBoard('${board.ORI_BOARD_ID }','${board.CONTENT_NO }','${search==null?null:search }','${select==null?null:select }','${chartNum}')">답글</button>
			  	</c:if>
			  	<c:if test="${sessionScope.USER_NO eq board.USER_NO}">
			  	<button type="button" class="btn btn-default" onclick="javascript:cModifyForm('${board.ORI_BOARD_ID }','${board.CONTENT_NO }','${chartNum}','${search==null?null:search }','${select==null?null:select }'); return false;">수정</button>
			  	<button type="button" class="btn btn-default" onclick="javascript:cDeleteBoard('${board.ORI_BOARD_ID }','${board.CONTENT_NO }','${search==null?null:search }','${select==null?null:select }','${chartNum}'); return false;">삭제</button>
			  	</c:if>
			</div>
		</div>
		
		<div id="replyBoardForm"></div>
		
		<hr>
		<div style="font-size: 12px;">
 			<div class="well">
	 			<div>
 				<label>1000byte 이하 작성</label>
		 			<div class="input-group">
				      <input type="text" id="replyText" class="form-control">
				      <span class="input-group-btn">
				        <button class="btn btn-default" type="button" onclick="javascript:cInsertReply('${board.ORI_BOARD_ID}','${board.CONTENT_NO }'); return false;">덧글등록</button>
				      </span>
				    </div>
			    </div>
			    <div id="reply"></div>
		    </div>
 		</div>

<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2-jquery.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/dist/se2/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
$(function(){
	cCmtList("${board.CONTENT_NO}","${board.ORI_BOARD_ID}");
	
	$(".se2_outputarea > table").addClass("table");
	$(".se2_outputarea > table").wrap('<div class="table-responsive" />');
});
</script>
</body>
</html>