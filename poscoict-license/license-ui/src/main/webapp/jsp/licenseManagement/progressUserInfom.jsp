<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<fmt:formatDate var="startDate" value="${user.USER_START_DATE }" pattern="yyyy-MM-dd"/>
<style type="text/css">
	.comment .material-icons:hover {
		color: #26a69a;
	}
</style>
<body>
	<form class="form-horizontal" role="form" name="modifyProgressInfo" action="${contextPath }/modifyProgressInfo" method="post">

		<div class="card-panel">
			<div class="card-header" style="padding-bottom:1rem;">
				<h5>고객 정보</h5>
					<strong>작성자: ${user.COMPANY_NAME }<span style="color: #C0CFCB;"> | </span>
					상태: <span style="color: #8B8BCC;">${user.ORDER_STATUS_TEXT }</span>
					</strong>
			</div>
			<div class="card-content">
				<div class="panel-body" id="addContract">
					<c:if test="${not empty user }">
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">business</i>
								<input id="P_USER_NAME" name="P_USER_NAME" type="text" class="validate" value="${user.USER_NAME }" disabled>
								<label for="P_USER_NAME">회사명</label>
							</div>
							<div class="input-field col s6">
								<i class="material-icons prefix">content_paste</i>
								<input id="P_PROJECT_NAME" name="P_PROJECT_NAME" type="text" class="validate" value="${user.PROJECT_NAME }" disabled>
								<label for="P_PROJECT_NAME">프로젝트명</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s12">
								<i class="material-icons prefix">place</i>
								<input id="P_USER_ADDRESS" name="P_USER_ADDRESS" type="text" class="validate" value="${user.USER_ADDRESS }" disabled>
								<label for="P_USER_ADDRESS">회사주소</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">account_circle</i>
								<input id="P_MANAGER_NAME" name="P_MANAGER_NAME" type="text" class="validate" value="${user.MANAGER_NAME }" disabled>
								<label for="P_MANAGER_NAME">담당자</label>
							</div>
							<div class="input-field col s6">
								<i class="material-icons prefix">phone</i>
								<input id="P_MANAGER_OFFICE_PHON" name="P_MANAGER_OFFICE_PHON" type="text" class="validate" value="${user.MANAGER_OFFICE_PHON }" disabled>
								<label for="P_MANAGER_OFFICE_PHON">전화번호</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">phone_iphone</i>
								<input id="P_MANAGER_CEL_PHON" name="P_MANAGER_CEL_PHON" type="text" class="validate" value="${user.MANAGER_CEL_PHON }" disabled>
								<label for="P_MANAGER_CEL_PHON">휴대번호</label>
							</div>
							<div class="input-field col s6">
								<i class="material-icons prefix">email</i>
								<input id="P_MANAGER_EMAIL" name="P_MANAGER_EMAIL" type="email" class="validate" value="${user.MANAGER_EMAIL }" disabled>
								<label for="P_MANAGER_EMAIL" data-error="이메일 형식을 준수하세요" data-success="올바른 이메일입니다">이메일</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">calendar</i>
								<input type="date" class="datepicker" id="startDatepicker2" name="P_USER_START_DATE" value="${startDate }" disabled>
                <label for="startDatepicker2">계약 예정일</label>
							</div>
							<div class="input-field col s6">
								<select class="browser-default" name="P_PRODUCT_FILE_ID" id="P_PRODUCT_FILE_NAME" disabled="disabled">
									<option value="N" selected>미 정</option>
									<c:if test="${not empty file }">
										<c:forEach var="file" items="${file }">
											<c:if test="${file.FILE_CATEGORY != 'etc' }">
												<option class="left" value="${file.OBJECT_ID }" <c:if test="${file.OBJECT_ID eq user.PRODUCT_FILE_ID }">selected</c:if>>
												${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option>
											</c:if>
										</c:forEach>
									</c:if>
								</select>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>

		<%-- button group --%>
		<c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
			<div class="btn-group">
			<input type="hidden" name="objectId" value="${user.OBJECT_ID }">
			<c:if test="${user.ORDER_STATUS != 'G' && user.ORDER_STATUS != 'F' }">
			<button type="button" class="btn btn-default btn-sm modify_button" onclick="javascript:modifyProgressButton(); return false;">정보수정</button>
			</c:if>
			<button type="button" class="btn btn-info btn-sm modify_submit_button" onclick="javascript:modifyProgress();" style="display: none;">수정완료</button>
			<c:if test="${user.ORDER_STATUS != 'G' && user.ORDER_STATUS != 'F' }">
			<button type="button" class="btn btn-default btn-sm" onclick="javascript:progressUserExpire('${user.OBJECT_ID }');">삭제</button>
			</c:if>

			<security:authorize ifAnyGranted="ROLE_S,ROLE_C">
			<c:if test="${user.ORDER_STATUS != 'F' && user.ORDER_STATUS != 'C' }">
			<button type="button" class="btn btn-info btn-sm" onclick="javascript:changeUserStatus('${user.OBJECT_ID }','C','등록요청');">등록요청</button>
			</c:if>
			</security:authorize>
			<security:authorize ifAnyGranted="ROLE_D">
			<c:if test="${user.ORDER_STATUS == 'C' }">
			<button type="button" class="btn btn-default btn-sm" onclick="javascript:changeUserStatus('${user.OBJECT_ID }','R','반려');">반려</button>
			</c:if>
			</security:authorize>
			<c:if test="${user.ORDER_STATUS != 'F' }">
			<button type="button" class="btn btn-info btn-sm" onclick="javascript:getUserContractForm('${user.OBJECT_ID }'); return false;" data-toggle="modal" data-target="#contractPop">고객등록</button>
			</c:if>
			</div>
		</c:if>

		<%-- comment --%>
		<div class="card-panel" style="margin-top:1rem;">
			<div class="card-content">
				<div>
					<c:if test="${userPermission.isFUNCTION_PROGRESS_COMMENT() }">
						<div class="input-field" style="display:flex;">
		          <i class="material-icons prefix">comment</i>
		          <input id="COMMENT" type="text" class="validate">
		          <label for="COMMENT">Comment</label>
							<a class="waves-effect waves-light btn" onclick="javascript:insertComment('${user.OBJECT_ID}'); return false;" style="width:7rem;">등록</a>
		        </div>
					</c:if>
				</div>
				<div>
					<c:if test="${comment.size() == 0 }">
					<%-- <label>comment가 없습니다.</label> --%>
					comment가 없습니다.
					</c:if>
					<div class="comment">
						<c:if test="${!empty comment }">
							<c:forEach var="list" items="${comment }" varStatus="status">
							<div class="<c:if test="${sessionScope.USER_NO == list.r_CREATION_USER }">left-origin</c:if> <c:if test="${sessionScope.USER_NO != list.r_CREATION_USER }">right</c:if>" style="display: block; max-width: 1280px; position: relative; z-index: 0; margin-left: 0px; <c:if test="${sessionScope.USER_NO == list.r_CREATION_USER }">margin-left: 10px;</c:if> <c:if test="${sessionScope.USER_NO != list.r_CREATION_USER }">margin-right: 10px;</c:if>">
								<span class="modifyComment${status.index }">${list.COMMENT }</span>
								<div class="chip">
							    <img src="${contextPath }/dist/images/guest.png" alt="${list.USER_NAME}">
							    ${list.USER_NAME}
							  </div>
								<%-- <span class="blue-text text-darken-2">${list.USER_NAME}</span> --%>
								<span class="blue-text text-darken-2"> ${list.r_CREATION_DATE.substring(0,16) } </span>
								<c:if test="${sessionScope.USER_NO == list.r_CREATION_USER }">
									<i class="material-icons" style="vertical-align:middle;" id="modifybutton${status.index }"
										onclick="javascript:modifyCommentForm('modifyComment${status.index }','${list.OBJECT_ID}','${list.COMMENT_NO }','${status.index }'); return false;">edit</i>
									<i class="material-icons" style="vertical-align:middle;"
										onclick="javascript:deleteComment('${list.OBJECT_ID}','${list.COMMENT_NO }'); return false;">close</i>
								</c:if>

							</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
		</div>

		<%-- history --%>
		<div class="card-panel">
			<div class="card-header">
				<h5>History</h5>
			</div>
			<div class="card-content">
				<c:if test="${not empty log }">
					<ul>
						<c:forEach var="list" items="${log }" varStatus="status">
							<li>
								<span style="font-weight:bold;">상태:</span> <span class="blue-text text-darken-2"> ${list.ORDER_STATUS_TEXT } </span> <label>|</label>
								<span style="font-weight:bold;">이벤트 발생일:</span> ${list.r_CREATION_DATE } <label>|</label> <span style="font-weight:bold;">${list.USER_NAME }</span>
								<c:if test="${not empty list.USER_NO }">
									<label>|</label> <strong>신규유저 전환</strong>
									계약번호: <a href="#" class="alert-link" onclick="javascript:getInfomation('${list.USER_NO }');">${list.USER_NO }</a>
								</c:if>
							</li>
						</c:forEach>
					</ul>
				</c:if>
			</div>
		</div>

	</form>

	<%-- modal --%>
	<div class="modal fade" id="contractPop" tabindex="-1" role="dialog" aria-labelledby="contractModalLabel" aria-hidden="true" data-backdrop="static">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	        <h4 class="modal-title"><p class="text-muted"><strong>고객신규등록</strong></p></h4>
	      </div>
	      <div class="modal-body" id="content">

	      </div>
	    </div>
	  </div>
	</div>

</body>
