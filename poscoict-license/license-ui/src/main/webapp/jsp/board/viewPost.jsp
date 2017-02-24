<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="security"
		uri="http://www.springframework.org/security/tags"%>
	<c:set var="contextPath" value="<%=request.getContextPath()%>" />
	<link rel="stylesheet" type="text/css" href="${contextPath }/dist/se2/css/smart_editor2_out.css">

	<!-- code highlighting -->

	<link href="${contextPath}/dist/se2/code_highlight/prism.css" rel="stylesheet" />
	<title>일반 게시판</title>
</head>
<body>
	<div class="card">
		<div class="card-content">
			<div class="section btnSection" style="padding: 0;">
				<span class="right btnGroup">
					<a class="waves-effect waves-light btn" onclick="javascript:movePage('${chartNum}','${folder }','${search==null?null:search }','${select==null?null:select }', '${subCategory }')">
						<i class="material-icons">view_list</i>
					</a>
					<c:if
						test="${ folder eq 'qna' && board.CONTENT_SEQ == 1 && board.ORI_FOLDER_ID != 'notice' }">
						<%-- <a id="getReplyBoardBtn" class="waves-effect waves-light btn" onclick="javascript:getReplyBoard('${folder }','${board.CONTENT_NO }','${search==null?null:search }','${select==null?null:select }','${chartNum}')"> --%>
						<a id="getReplyBoardBtn" class="waves-effect waves-light btn" onclick="javascript:replyBoardOnNewPage('${folder }','${board.CONTENT_NO }','${search==null?null:search }','${select==null?null:select }','${chartNum}')">
							<i class="material-icons">subdirectory_arrow_right</i>
						</a>
					</c:if>
					<security:authorize ifAnyGranted="ROLE_D, ROLE_C">
						<a class="waves-effect waves-light btn" onclick="javascript:modifyForm('${folder }','${board.CONTENT_NO }','${chartNum}','${search==null?null:search }','${select==null?null:select }', '${subCategory }'); return false;">
							<i class="material-icons">border_color</i>
						</a>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_D">
						<a class="waves-effect waves-light btn" onclick="javascript:adminDeleteBoard('${folder }','${board.CONTENT_NO }','${search==null?null:search }','${select==null?null:select }','${chartNum}','${subCategory }'); return false;">
							<i class="material-icons">delete</i>
						</a>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_G, ROLE_S, ROLE_U">
						<a class="waves-effect waves-light btn" onclick="javascript:guestAuthConfirmPopup('${folder }','${board.CONTENT_NO }','${chartNum}','${search==null?null:search }','${select==null?null:select }','${subCategory }'); return false;">
							<i class="material-icons">edit</i>
						</a>
						<a class="waves-effect waves-light btn" onclick="javascript:guestDeleteBoard('${folder }','${board.CONTENT_NO }','${search==null?null:search }','${select==null?null:select }','${chartNum}','${subCategory }'); return false;">
							<i class="material-icons">delete</i>
						</a>
					</security:authorize>
				</span>
				<span class="card-title" style="display:block;">${board.TITLE }</span>
			</div>
			<div class="section viewInfo">
				<span class="badge hide-on-med-and-down" style="font-size:0.8em;">
				<%-- <span style="font-size:0.8em;"> --%>
					<%-- <b>분류 : ${folder} -> ${board.SUBCATEGORY==null?'공지':board.SUBCATEGORY } | </b>
					<b>번호 : ${board.CONTENT_NO } | </b>
					<b>작성자: ${board.USER_NAME } | </b>
					<b>날짜 : ${board.r_CREATION_DATE } | </b>
					<b>조회 : ${board.CLICKS } </b> --%>

					<%-- @@@@ 아래는 Materialize breadcrumbs 이용하여 개편 --%>
					<%-- 분류 : ${folder} -> ${board.SUBCATEGORY==null?'공지':board.SUBCATEGORY } | --%>
					번호 : ${board.CONTENT_NO } |
					${board.USER_NAME } |
					${board.r_CREATION_DATE.substring(2,16)} |
					조회 : ${board.CLICKS }
				</span>
				<span class="hide-on-med-and-up" style="font-size:0.8em;">
					${board.r_CREATION_DATE.substring(2,10)} | ${board.USER_NAME} | 번호 : ${board.CONTENT_NO}
				</span>
			</div>
			<div class="divider"></div>
			<div class="section" style="padding:1rem 0.5rem;">
				<div class="se2_outputarea" style="word-break: break-all; position: static;">
					${board.MAIN_CONTENT }
				</div>
				<c:if test="${not empty attachInfo && attachInfo.size()>0 }">
					<c:forEach items="${attachInfo }" var="attach" varStatus="status">
						<span style="font-size:12px;">
							<i class="tiny material-icons" style="vertical-align:middle;">attach_file</i>첨부파일 ${status.index+1 } :
							<a href="#" onclick="javascript:attachFileDown('${attach.OBJECT_ID }')">
								${attach.ATTACH_FILE_NAME}
							</a><span class="black-text"> (${attach.ATTACH_FILE_SIZE} byte)</span>
						</span>
						<br>
					</c:forEach>
				</c:if>
			</div>
			<div class="divider"></div>
			<div class="section replyInfo" style="font-size: 12px;">
				<%-- Reply Registeration Section --%>
				<c:if test="${board.ORI_FOLDER_ID != 'notice' }">
					<div class="row valign-wrapper">
						<security:authorize ifAnyGranted="ROLE_U,ROLE_S,ROLE_D,ROLE_C,ROLE_G">
							<c:if test="${folder != 'notice'}">
								<div class="input-field valign col s12" style="display:flex;">
				          <i class="material-icons prefix">textsms</i>
									<%-- <textarea id="replyText" class="materialize-textarea" length="120"></textarea> --%>
									<input type="text" id="replyText" class="form-control" style="height:36px;" placeholder="댓글을 입력하세요.">
									<%-- <label for="replyText" style="">댓글을 입력하세요.</label> --%>
									<a class="waves-effect waves-light btn valign"
										onclick="javascript:insertReply('${folder}','${board.CONTENT_NO }','${subCategory}'); return false;"><i class="material-icons">edit</i>
									</a>
				        </div>
								<%-- 게스트 이름 변경하여 댓글 등록
								<div>
									<div class="input-field">
										 <input placeholder="댓글에 표시될 이름 입력" id="guest" type="text" class="validate">
										 <label for="guest">댓글 주인</label>
									 </div>
								</div> --%>
							</c:if>
						</security:authorize>
						<%-- <security:authorize ifAnyGranted="ROLE_G">
							<c:if test="${folder != 'notice'}">
								<div class="input-field valign col s12" style="display:flex;">
				          <i class="material-icons prefix">textsms</i>
									<input type="text" id="replyText" class="form-control" style="height:36px;" placeholder="댓글을 입력하세요.">
									<a class="waves-effect waves-light btn valign" style="width:12%;"
										onclick="javascript:insertReply('${folder}','${board.CONTENT_NO }'); return false;">
										등록
									</a>
				        </div>
							</c:if>
						</security:authorize> --%>
					</div>
				<div id="reply"></div>
				</c:if>

				<security:authorize ifAnyGranted="ROLE_G">
					<c:if test="${sessionScope.USER_NO eq board.USER_NO}">
						<%-- <div class="row">
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
						</div> --%>
					</c:if>
				</security:authorize>
			</div>
			<%-- <div id="replyBoardForm"></div> --%>

		</div>
	</div>

	<script	src="${contextPath }/dist/jquery/jquery.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${contextPath }/dist/se2/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
		$(function() {
			cmtList("${board.CONTENT_NO}", "${board.ORI_FOLDER_ID}");

			$(".se2_outputarea > table").addClass("table");
			$(".se2_outputarea > table").wrap(
					'<div class="table-responsive" />');
		});
	</script>
	<script src="${contextPath}/dist/se2/code_highlight/prism.js"></script>
</body>
