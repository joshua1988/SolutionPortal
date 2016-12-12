<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<body>

	<form class="form-horizontal" role="form" method="post" name="modifyCustomUser">
		<div class="card-panel">
   	  <div class="card-heading"><h5>커스텀 유저 생성</h5></div>
   	  <div class="card-content" id="addContract">
				<div class="row">
					<div class="input-field col s6">
						<input id="USER_NO_D" type="text" class="validate" name="USER_NO_D" value="${userInfo.getUSER_NO() }" disabled>
						<input type="hidden" id="USER_NO" name="USER_NO" value="${userInfo.getUSER_NO() }">
						<label for="USER_NO_D">* 아이디</label>

					</div>
					<div class="input-field col s6">
						<input id="USER_NAME" type="text" class="validate" name="USER_NAME" value="${userInfo.getUSER_NAME() }" disabled>
						<label for="USER_NAME">* 수주사명</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s6">
						<input id="MANAGER_NAME" type="text" class="validate" name="MANAGER_NAME" value="${userInfo.getMANAGER_NAME() }" disabled>
						<label for="MANAGER_NAME">담당자</label>
					</div>
					<div class="input-field col s6">
						<input id="USER_ADDRESS" type="text" class="validate" name="USER_ADDRESS" value="${userInfo.getUSER_ADDRESS() }" disabled>
						<label for="USER_ADDRESS">회사주소</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s6">
						<input id="MANAGER_OFFICE_PHON" type="text" class="validate" name="MANAGER_OFFICE_PHON" value="${userInfo.getMANAGER_OFFICE_PHON() }" disabled>
						<label for="MANAGER_OFFICE_PHON">전화번호</label>
					</div>
					<div class="input-field col s6">
						<input id="MANAGER_CEL_PHON" type="text" class="validate" name="MANAGER_CEL_PHON" value="${userInfo.getMANAGER_CEL_PHON() }" disabled>
						<label for="MANAGER_CEL_PHON">휴대번호</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12">
						<input id="MANAGER_EMAIL" type="email" class="validate" name="MANAGER_EMAIL" value="${userInfo.getMANAGER_EMAIL() }" disabled>
						<label for="MANAGER_EMAIL">이메일</label>
					</div>
				</div>
				<div class="row">
					<div class="col s12">
						<button type="button" class="btn modify_button" onclick="javascript:changeButton(); return false;">정보수정하기</button>
						<button type="button" class="btn modify_submit_button" onclick="javascript:modifyCustomUserInfo('${userInfo.getUSER_NO() }');" style="display: none;">정보수정완료</button>
					</div>
				</div>

			  <h5>권한 설정</h5>
			  <div class="row">
				  <div class="col s12">
				  	<div class="col s6">
							<div class="card-panel">
								<div class="card-header">
									<input type="checkbox" id="MENU_NOTICE" name="MENU_NOTICE"
										<c:if test="${userPermission.isMENU_NOTICE() }">checked="checked"</c:if> onclick="javascript:noticeCheckbox(); return false;"/>
      						<label for="MENU_NOTICE">메뉴생성/글 보기 - <strong>공지</strong></label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
								<div class="card-content">
									<input type="checkbox" id="FUNCTION_NOTICE_WRITE" name="FUNCTION_NOTICE_WRITE"
										<c:if test="${userPermission.isFUNCTION_NOTICE_WRITE() }">checked="checked"</c:if>/>
      						<label for="FUNCTION_NOTICE_WRITE">글 등록 / 삭제</label>
								</div>
								</div>
							</div>
							<div class="card-panel">
								<div class="card-header">
									<input type="checkbox" id="MENU_PRESENTATION" name="MENU_PRESENTATION"
										<c:if test="${userPermission.isMENU_PRESENTATION() }">checked="checked"</c:if>/>
      						<label for="MENU_PRESENTATION">메뉴생성 - <strong>제품소개</strong></label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
								<div class="card-content">
									<label style="font-size: 12px; color: gray;">제품소개 메뉴입니다.</label>
								</div>
								</div>
							</div>
							<div class="card-panel">
								<div class="card-header">
									<input type="checkbox" id="MENU_GUEST_PACKAGE_DOWNLOAD" name="MENU_GUEST_PACKAGE_DOWNLOAD"
										<c:if test="${userPermission.isMENU_GUEST_PACKAGE_DOWNLOAD() }">checked="checked"</c:if>/>
      						<label for="MENU_GUEST_PACKAGE_DOWNLOAD">메뉴생성/다운로드(Guest) - <strong>교육용 솔루션 패키지</strong></label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
								<div class="card-content">
									<label style="font-size: 12px; color: gray;">교육용 솔루션을 다운 받을 수 있습니다.</label>
								</div>
								</div>
							</div>
							<div class="card-panel">
								<div class="card-heading">
									<input type="checkbox" id="MENU_CUSTOMBOARD" name="MENU_CUSTOMBOARD" />
									<label for="MENU_CUSTOMBOARD">메뉴생성 / 게시판 생성 - <strong>자료실</strong></label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<label style="font-size: 12px; color: gray;">게시판 생성 및 자료를 등록 할 수 있는 메뉴입니다.</label>
									</div>
								</div>
							</div>
					  </div>
						<div class="col s6">
							<div class="card-panel">
								<div class="card-header">
									<input type="checkbox" id="MENU_GLUE" name="MENU_GLUE"
										<c:if test="${userPermission.isMENU_GLUE() }">checked="checked"</c:if>/>
      						<label for="MENU_GLUE">메뉴생성 / 글 보기<strong>Glue</strong></label>

									<input type="checkbox" id="FUNCTION_GLUE_ADMIN" name="FUNCTION_GLUE_ADMIN"
										<c:if test="${userPermission.isFUNCTION_GLUE_ADMIN() }">checked="checked"</c:if>/>
      						<label for="FUNCTION_GLUE_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
							       <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE" name="FUNCTION_GLUE_WRITE"
												 <c:if test="${userPermission.isFUNCTION_GLUE_WRITE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUE_WRITE">글 등록 / 삭제</label>
										 </li>
							       <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_NOTICE" name="FUNCTION_GLUE_WRITE_NOTICE"
												 <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_NOTICE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUE_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
										 </li>
							       <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_QNA" name="FUNCTION_GLUE_WRITE_QNA"
												 <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_QNA() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUE_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
										 </li>
							       <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_FAQ" name="FUNCTION_GLUE_WRITE_FAQ"
												 <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_FAQ() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUE_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_TECH" name="FUNCTION_GLUE_WRITE_TECH"
												 <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_TECH() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUE_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_OLDTECH" name="FUNCTION_GLUE_WRITE_OLDTECH"
												 <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_OLDTECH() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUE_WRITE_OLDTECH">글 등록 / 삭제 (예전 기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_REPLY" name="FUNCTION_GLUE_REPLY"
												 <c:if test="${userPermission.isFUNCTION_GLUE_REPLY() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUE_REPLY">본문 덧글 등록 (리플)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_REPLY_BOARD_QNA" name="FUNCTION_GLUE_REPLY_BOARD_QNA"
												 <c:if test="${userPermission.isFUNCTION_GLUE_REPLY_BOARD_QNA() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUE_REPLY_BOARD_QNA">본문에 답글 작성 (새글-Q&amp;A)</label>
										 </li>
							     </ul>
										<ul>
									</div>
								</div>
							</div>
					  </div>
				  </div>
			  </div>

			  <div class="row">
				  <div class="col s12">
					  <div class="col s6">
							<div class="card-panel">
								<div class="card-heading">
									<input type="checkbox" id="MENU_GLUEMASTER" name="MENU_GLUEMASTER"
										<c:if test="${userPermission.isMENU_GLUEMASTER() }">checked="checked"</c:if>/>
      						<label for="MENU_GLUEMASTER">메뉴생성 / 글 보기 - <strong>GlueMaster</strong></label>

									<input type="checkbox" id="FUNCTION_GLUEMASTER_ADMIN" name="FUNCTION_GLUEMASTER_ADMIN"
										<c:if test="${userPermission.isFUNCTION_GLUEMASTER_ADMIN() }">checked="checked"</c:if>/>
      						<label for="FUNCTION_GLUEMASTER_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div class="card-content">
									<ul class="collection">
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE" name="FUNCTION_GLUEMASTER_WRITE"
											 <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE() }">checked="checked"</c:if>/>
										 <label for="FUNCTION_GLUEMASTER_WRITE">글 등록 / 삭제</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE_NOTICE" name="FUNCTION_GLUEMASTER_WRITE_NOTICE"
											 <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE_NOTICE() }">checked="checked"</c:if>/>
										 <label for="FUNCTION_GLUEMASTER_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE_QNA" name="FUNCTION_GLUEMASTER_WRITE_QNA"
											 <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE_QNA() }">checked="checked"</c:if>/>
										 <label for="FUNCTION_GLUEMASTER_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE_FAQ" name="FUNCTION_GLUEMASTER_WRITE_FAQ"
											 <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE_FAQ() }">checked="checked"</c:if>/>
										 <label for="FUNCTION_GLUEMASTER_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE_TECH" name="FUNCTION_GLUEMASTER_WRITE_TECH"
											 <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE_TECH() }">checked="checked"</c:if>/>
										 <label for="FUNCTION_GLUEMASTER_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_REPLY" name="FUNCTION_GLUEMASTER_REPLY"
											 <c:if test="${userPermission.isFUNCTION_GLUEMASTER_REPLY() }">checked="checked"</c:if>/>
										 <label for="FUNCTION_GLUEMASTER_REPLY">본문 덧글 등록 (리플)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_REPLY_BOARD_QNA" name="FUNCTION_GLUEMASTER_REPLY_BOARD_QNA"
											 <c:if test="${userPermission.isFUNCTION_GLUEMASTER_REPLY_BOARD_QNA() }">checked="checked"</c:if>/>
										 <label for="FUNCTION_GLUEMASTER_REPLY_BOARD_QNA">본문에 답글 작성 (새글-Q&amp;A)</label>
									 </li>
								 </ul>
								</div>
							</div>
						</div>
					  <div class="col s6">
							<div class="card-panel">
								<div class="card-heading">
									<input type="checkbox" id="MENU_GLUEMOBILE" name="MENU_GLUEMOBILE"
										<c:if test="${userPermission.isMENU_GLUEMOBILE() }">checked="checked"</c:if>/>
									<label for="MENU_GLUEMOBILE">메뉴생성 / 글 보기 - <strong>GlueMobile</strong></label>

									<input type="checkbox" id="FUNCTION_GLUEMOBILE_ADMIN" name="FUNCTION_GLUEMOBILE_ADMIN"
										<c:if test="${userPermission.isFUNCTION_GLUEMOBILE_ADMIN() }">checked="checked"</c:if>/>
									<label for="FUNCTION_GLUEMOBILE_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE" name="FUNCTION_GLUEMOBILE_WRITE"
												 <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUEMOBILE_WRITE">글 등록 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE_NOTICE" name="FUNCTION_GLUEMOBILE_WRITE_NOTICE"
												 <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE_NOTICE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUEMOBILE_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE_QNA" name="FUNCTION_GLUEMOBILE_WRITE_QNA"
												 <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE_QNA() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUEMOBILE_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE_FAQ" name="FUNCTION_GLUEMOBILE_WRITE_FAQ"
												 <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE_FAQ() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUEMOBILE_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE_TECH" name="FUNCTION_GLUEMOBILE_WRITE_TECH"
												 <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE_TECH() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUEMOBILE_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_REPLY" name="FUNCTION_GLUEMOBILE_REPLY"
												 <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_REPLY() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUEMOBILE_REPLY">본문 덧글 등록 (리플)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA" name="FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA"
												 <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_REPLY_BOARD_QNA() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA">본문에 답글 작성 (새글-Q&amp;A)</label>
										 </li>
									 </ul>
									</div>
								</div>
							</div>
						</div>
				  </div> <%-- col --%>
			  </div>

			  <div class="row">
				  <div class="col s12">
						<div class="col s6">
							<div class="card-panel">
								<div class="card-heading">
									<input type="checkbox" id="MENU_UCUBE" name="MENU_UCUBE"
										<c:if test="${userPermission.isMENU_UCUBE() }">checked="checked"</c:if>/>
									<label for="MENU_UCUBE">메뉴생성 / 글 보기 - <strong>uCUBE</strong></label>

									<input type="checkbox" id="FUNCTION_UCUBE_ADMIN" name="FUNCTION_UCUBE_ADMIN"
										<c:if test="${userPermission.isFUNCTION_UCUBE_ADMIN() }">checked="checked"</c:if>/>
									<label for="FUNCTION_UCUBE_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE" name="FUNCTION_UCUBE_WRITE"
												 <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_UCUBE_WRITE">글 등록 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE_NOTICE" name="FUNCTION_UCUBE_WRITE_NOTICE"
												 <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE_NOTICE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_UCUBE_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE_QNA" name="FUNCTION_UCUBE_WRITE_QNA"
												 <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE_QNA() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_UCUBE_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE_FAQ" name="FUNCTION_UCUBE_WRITE_FAQ"
												 <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE_FAQ() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_UCUBE_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE_TECH" name="FUNCTION_UCUBE_WRITE_TECH"
												 <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE_TECH() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_UCUBE_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_REPLY" name="FUNCTION_UCUBE_REPLY"
												 <c:if test="${userPermission.isFUNCTION_UCUBE_REPLY() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_UCUBE_REPLY">본문 덧글 등록 (리플)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_REPLY_BOARD_QNA" name="FUNCTION_UCUBE_REPLY_BOARD_QNA"
												 <c:if test="${userPermission.isFUNCTION_UCUBE_REPLY_BOARD_QNA() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_UCUBE_REPLY_BOARD_QNA">본문에 답글 작성 (새글-Q&amp;A)</label>
										 </li>
									 </ul>
									</div>
								</div>
							</div>
						</div>
						<div class="col s6">
							<div class="card-panel">
								<div class="card-heading">
									<input type="checkbox" id="MENU_POSBEE" name="MENU_POSBEE"
										<c:if test="${userPermission.isMENU_POSBEE() }">checked="checked"</c:if>/>
									<label for="MENU_POSBEE">메뉴생성 / 글 보기 - <strong>PosBee</strong></label>

									<input type="checkbox" id="FUNCTION_POSBEE_ADMIN" name="FUNCTION_POSBEE_ADMIN"
										<c:if test="${userPermission.isFUNCTION_POSBEE_ADMIN() }">checked="checked"</c:if>/>
									<label for="FUNCTION_POSBEE_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE" name="FUNCTION_POSBEE_WRITE"
												 <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_POSBEE_WRITE">글 등록 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE_NOTICE" name="FUNCTION_POSBEE_WRITE_NOTICE"
												 <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE_NOTICE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_POSBEE_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE_QNA" name="FUNCTION_POSBEE_WRITE_QNA"
												 <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE_QNA() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_POSBEE_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE_FAQ" name="FUNCTION_POSBEE_WRITE_FAQ"
												 <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE_FAQ() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_POSBEE_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE_TECH" name="FUNCTION_POSBEE_WRITE_TECH"
												 <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE_TECH() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_POSBEE_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_REPLY" name="FUNCTION_POSBEE_REPLY"
												 <c:if test="${userPermission.isFUNCTION_POSBEE_REPLY() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_POSBEE_REPLY">본문 덧글 등록 (리플)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_REPLY_BOARD_QNA" name="FUNCTION_POSBEE_REPLY_BOARD_QNA"
												 <c:if test="${userPermission.isFUNCTION_POSBEE_REPLY_BOARD_QNA() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_POSBEE_REPLY_BOARD_QNA">본문에 답글 작성 (새글-Q&amp;A)</label>
										 </li>
									 </ul>
									</div>
								</div>
							</div>
						</div>
				  </div>
			  </div>

			  <div class="row">
				  <div class="col s12">
						<div class="col s6">
							<div class="card-panel">
								<div class="card-heading">
									<input type="checkbox" id="MENU_SOLUTION_UPLOAD" name="MENU_SOLUTION_UPLOAD"
										<c:if test="${userPermission.isMENU_SOLUTION_UPLOAD() }">checked="checked"</c:if>/>
									<label for="MENU_SOLUTION_UPLOAD">메뉴생성 - <strong>솔루션 패키지 관리</strong></label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_GLUE" name="FUNCTION_SOLUTION_UPLOAD_GLUE"
												 <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_GLUE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_SOLUTION_UPLOAD_GLUE">패키지 등록 / 삭제 (Glue)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_GLUEMASTER" name="FUNCTION_SOLUTION_UPLOAD_GLUEMASTER"
												 <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_GLUEMASTER() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_SOLUTION_UPLOAD_GLUEMASTER">패키지 등록 / 삭제 (GlueMaster)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE" name="FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE"
												 <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_GLUEMOBILE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE">패키지 등록 / 삭제 (GlueMobile)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_UCUBE" name="FUNCTION_SOLUTION_UPLOAD_UCUBE"
												 <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_UCUBE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_SOLUTION_UPLOAD_UCUBE">패키지 등록 / 삭제 (uCUBE)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_POSBEE" name="FUNCTION_SOLUTION_UPLOAD_POSBEE"
												 <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_POSBEE() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_SOLUTION_UPLOAD_POSBEE">패키지 등록 / 삭제 (PosBee)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_ETC" name="FUNCTION_SOLUTION_UPLOAD_ETC"
												 <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_ETC() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_SOLUTION_UPLOAD_ETC">패키지 등록 / 삭제 (etc)</label>
										 </li>
									 </ul>
									</div>
								</div>
							</div>
						</div>
						<div class="col s6">
							<div class="card-panel">
								<div class="card-heading">
									<input type="checkbox" id="MENU_MANAGEMENT" name="MENU_MANAGEMENT"
										<c:if test="${userPermission.isMENU_MANAGEMENT() }">checked="checked"</c:if>/>
									<label for="MENU_MANAGEMENT">메뉴생성 - <strong>고객관리</strong></label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="SUB_MENU_MANAGEMENT_COMPLETE" name="SUB_MENU_MANAGEMENT_COMPLETE"
												 <c:if test="${userPermission.isSUB_MENU_MANAGEMENT_COMPLETE() }">checked="checked"</c:if>/>
											 <label for="SUB_MENU_MANAGEMENT_COMPLETE">서브메뉴 / 고객 정보 보기 - <strong>완료 계약건</strong></label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_MANAGEMENT_INPUT_USER" name="FUNCTION_MANAGEMENT_INPUT_USER"
												 <c:if test="${userPermission.isFUNCTION_MANAGEMENT_INPUT_USER() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_MANAGEMENT_INPUT_USER">고객 등록 / 수정 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="SUB_MENU_MANAGEMENT_PROGRESS" name="SUB_MENU_MANAGEMENT_PROGRESS"
												 <c:if test="${userPermission.isSUB_MENU_MANAGEMENT_PROGRESS() }">checked="checked"</c:if>/>
											 <label for="SUB_MENU_MANAGEMENT_PROGRESS">서브메뉴 / 고객 정보 보기 - <strong>진행중 계약건</strong></label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_PROGRESS_INPUT_USER" name="FUNCTION_PROGRESS_INPUT_USER"
												 <c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_PROGRESS_INPUT_USER">가계약 등록 / 수정 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_PROGRESS_COMMENT" name="FUNCTION_PROGRESS_COMMENT"
												 <c:if test="${userPermission.isFUNCTION_PROGRESS_COMMENT() }">checked="checked"</c:if>/>
											 <label for="FUNCTION_PROGRESS_COMMENT">Comment 등록</label>
										 </li>
									 </ul>

									</div>
								</div>
							</div>
						</div>
				  </div>
			  </div>

			  <div class="row">
			  	<div class="col s12">
						<div class="col s6">
							<%-- 자료실 --%>
						</div>
			  	</div>
			  </div>
			</div>
			<div class="card-action">
				<button type="button" class="btn btn-info btn-sm modify_button_per" onclick="javascript:changeButtonPerm(); return false;">권한수정하기</button>
	    	<button type="button" class="btn btn-success btn-sm modify_submit_button_per" onclick="javascript:modifyCustomUserPermission('${userInfo.getUSER_NO() }');" style="display: none;">권한수정완료</button>
			</div>
	  </div>
	</form>

</body>
