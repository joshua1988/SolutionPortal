<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
	<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
	<link rel="stylesheet" type="text/css" href="${contextPath }/dist/se2/css/smart_editor2_out.css">
	<title>커스텀 게시판</title>
<body>
	<div class="card">
		<div class="card-content">
			<span class="right" style="padding-top:5px;">
				<a class="waves-effect waves-light btn"
					onclick="javascript:cMovePage('${chartNum }','${board.ORI_BOARD_ID }','${search==null?null:search }','${select==null?null:select }')">
					<%-- <i class="material-icons left">view_list</i>목록 --%>
					<i class="material-icons">view_list</i>
				</a>
				<c:if test="${ board.CONTENT_SEQ == 1 }">
					<a class="waves-effect waves-light btn"
						onclick="javascript:getReplyCustomBoard('${board.ORI_BOARD_ID }','${board.CONTENT_NO }','${search==null?null:search }','${select==null?null:select }','${chartNum}')">
						<%-- <i class="material-icons left">reply</i>답글 --%>
						<i class="material-icons">reply</i>
					</a>
			  </c:if>
				<c:if test="${sessionScope.USER_NO eq board.USER_NO}">
					<a class="waves-effect waves-light btn"
						onclick="javascript:cModifyForm('${board.ORI_BOARD_ID }','${board.CONTENT_NO }','${chartNum}','${search==null?null:search }','${select==null?null:select }'); return false;">
						<%-- <i class="material-icons left">edit</i>수정 --%>
						<i class="material-icons">edit</i>
					</a>
					<a class="waves-effect waves-light btn"
						onclick="javascript:cDeleteBoard('${board.ORI_BOARD_ID }','${board.CONTENT_NO }','${search==null?null:search }','${select==null?null:select }','${chartNum}'); return false;">
						<%-- <i class="material-icons left">delete</i>삭제 --%>
						<i class="material-icons">delete</i>
					</a>
		  	</c:if>
			</span>
			<span class="card-title">${board.TITLE }</span>
			<div class="section" style="padding:5px;">
				<span class="badge" style="font-size:0.8em; position:inherit;">
					<%-- @@@@ 아래는 Materialize breadcrumbs 이용하여 개편 --%>
					<%-- 분류 : ${folder} -> ${board.SUBCATEGORY==null?'공지':board.SUBCATEGORY } | --%>
					번호 : ${board.CONTENT_NO } |
					작성자: ${board.USER_NAME } |
					날짜 : ${board.r_CREATION_DATE } |
					조회 : ${board.CLICKS }
				</span>
			</div>
			<div class="divider"></div>
			<div class="section">
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
			<div class="section" style="font-size: 12px;">
				<%-- Reply Registeration Section --%>
				<c:if test="${board.ORI_FOLDER_ID != 'notice' }">
					<div class="row valign-wrapper">
						<div class="input-field valign col s12" style="display:flex;">
		          <i class="material-icons prefix">textsms</i>
							<%-- <textarea id="replyText" class="materialize-textarea" length="120"></textarea> --%>
								<input type="text" id="replyText" class="form-control" style="height:36px;" placeholder="댓글을 입력하세요.">
							<%-- <label for="replyText" style="">댓글을 입력하세요.</label> --%>
							<a class="waves-effect waves-light btn valign" style="width:12%;"
								onclick="javascript:cInsertReply('${board.ORI_BOARD_ID}','${board.CONTENT_NO }'); return false;">
								등록
							</a>
		        </div>
					</div>
				</c:if>
				<div id="reply"></div>
			</div>
			<div id="replyBoardForm"></div>

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
