<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<body>
	<form class="form-horizontal" name="insertReplyBoard" enctype="multipart/form-data">
		<div class="card">
			<div class="card-content">
				<span class="right" style="padding-top:5px; padding-right:5px;">
					<security:authorize ifAnyGranted="ROLE_G">
						<a class="waves-effect waves-light btn" onclick="javascript:guestReplySubmit();">
							<i class="material-icons">create</i></a>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_U,ROLE_S,ROLE_D,ROLE_C">
						<a class="waves-effect waves-light btn" onclick="javascript:replyBoard();">
							<i class="material-icons">create</i></a>
					</security:authorize>
					<a class="waves-effect waves-light btn" onclick="javascript:history.back(); return false;">
						<i class="material-icons">clear</i></a>
				</span>
				<span class="card-title">답글 달기</span>
				<div class="section" style="display:flex; align-items:center; padding:0 0;">
					<input type="text" class="reply_title" name="reply_title" id="reply_title" value="${replyBoardForm.TITLE }">
					<span id="unopened" style="width:12%; padding-left:10px;">
						<input type="checkbox" id="reply_openFlag" name="reply_openFlag" value="N" <c:if test="${replyBoardForm.OPEN_FLAG eq 'N' }">checked</c:if>/>
						<label for="reply_openFlag">비공개</label>
					</span>
				</div>
				<div class="section" style="padding:0 0;">
					<textarea class="form-control" rows="20" style="width: 100%;" id="reply_content" name="reply_content">
						<br><br>
						============================원본===========================
						<br>
						${board.MAIN_CONTENT }
					</textarea>
					<label for="boardAttach" class="control-label" style="font-size: 12px;">첨부파일 추가</label>
					<input type="file" class="form-control input-sm" name="boardAttach" id="boardAttach" multiple="multiple">
				</div>
				<div class="section">
					<security:authorize ifAnyGranted="ROLE_G">
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">account_circle</i>
								<input id="guestID" name="guestID" type="text" class="form-control validate" placeholder="guestID 필수">
							</div>
							<div class="input-field col s6">
								<i class="material-icons prefix">vpn_key</i>
								<input id="guestPW" name="guestPW" type="password" class="form-control validate" placeholder="guestPW 필수">
							</div>
						</div>
					</security:authorize>
				</div>

				<!-- 아래부터 시작 -->
		 		<input type="hidden" name="content_no" value="${replyBoardForm.CONTENT_NO }">
		 		<input type="hidden" name="subCategory" value="${replyBoardForm.SUBCATEGORY }">
		 		<input type="hidden" name="folder" value="${folder }">
		 		<input type="hidden" name="chartNum" value="${chartNum }">
		 		<input type="hidden" name="search" value="${search }">
		 		<input type="hidden" name="select" value="${select }">
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

	function createEl(name, value){
		var input_id = document.createElement("input");
		input_id.setAttribute("type", "hidden");
		input_id.setAttribute("name", name);
		input_id.setAttribute("value", value);

		return input_id;
	}

	function guestReplySubmit(){
		if(document.getElementById("guestID").value.replace(/\s/g, "")=="" || document.getElementById("guestPW").value.replace(/\s/g, "")==""){
			alertPopup("임시 아이디와 패스워드를 입력해 주세요.");
			return;
		} else {
			replyBoard();
		}
	}
</script>
</body>
