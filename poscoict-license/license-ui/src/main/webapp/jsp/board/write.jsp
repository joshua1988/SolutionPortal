<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<title>Insert title here</title>
<style type="text/css">
	span.right {
		padding-top:5px;
		padding-right:5px;
	}
</style>
<body>
	<div class="card">
		<div class="card-content">
			<form class="form-horizontal" role="form" action="${contextPath }/write" id="write_frm" name="write_frm" method="post" enctype="multipart/form-data">
				<span class="right">
					<security:authorize ifAnyGranted="ROLE_G">
						<a class="waves-effect waves-light btn" onclick="javascript:guestWriteSubmit();">등록</a>
						<a class="waves-effect waves-light btn" onclick="javascript:history.back();">취소</a>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_U,ROLE_S,ROLE_D,ROLE_C">
						<a class="waves-effect waves-light btn" onclick="javascript:writeSubmit2();">등록</a>
						<a class="waves-effect waves-light btn" onclick="javascript:history.back();">취소</a>
					</security:authorize>
				</span>
				<span class="card-title">게시글 쓰기</span>
				<div class="section" style="display:flex; align-items:center; padding: 0.5erm 0;">
					<input type="text" class="form-control" placeholder="제목" name="WRITE_TITLE" id="WRITE_TITLE">
					<span style="width:12%; padding-left:10px;">
						<input type="checkbox" id="test5" name="OPEN_FLAG"/>
      			<label for="test5">비공개</label>
					</span>
				</div>

				<div class="section" style="padding:0 0;">
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

				<div class="section">
					<label for="boardAttach" class="control-label" style="font-size: 13px;">첨부파일</label>
					<input type="file" class="form-control input-sm" name="boardAttach" id="boardAttach" multiple="multiple">
					<%-- Materialize File Uploader --%>
					<%-- <div class="file-field input-field">
			      <div class="btn">
			        <span>첨부파일</span>
			        <input type="file" multiple>
			      </div>
			      <div class="file-path-wrapper">
			        <input class="file-path validate" type="text" name="boardAttach" id="boardAttach" placeholder="다수 파일 업로드 가능">
			      </div>
			    </div> --%>

					<input type="hidden" name="folder" value="${folder }">
			    <input type="hidden" name="subCategory" value="${subCategory }">
				</div>
				<div class="section">
					<security:authorize ifAnyGranted="ROLE_G">
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">account_circle</i>
								<input id="guestID" name="guestID" type="text" class="validate">
								<label for="guestID" style="font-size:inherit;">guestID 필수</label>
							</div>
							<div class="input-field col s6">
								<i class="material-icons prefix">vpn_key</i>
								<input id="guestPW" name="guestPW" type="password" class="validate">
								<label for="guestPW" style="font-size:inherit;">guestPW 필수</label>
							</div>
						</div>
					</security:authorize>
				</div>

			</form>
		</div>
	</div>

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
			remove: '<i class="material-icons" style="vertical-align:bottom; color:#9e9e9e;">delete</i>'
		}
	});
	</script>
</body>
