<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">
</style>
<body>

	<form class="form-horizontal" role="form" action="${contextPath }/addCustomUser" method="post" name="addCustomUser">
		<div class="card-panel">
   	  <div class="card-heading"><h5>커스텀 유저 생성</h5></div>
   	  <div class="card-content" id="addContract">
				<div class="row">
					<div class="input-field col s6">
						<input id="USER_NO" type="text" class="validate" name="USER_NO">
						<label for="USER_NO">* 아이디</label>
					</div>
					<div class="input-field col s6">
						<input id="USER_NAME" type="text" class="validate" name="USER_NAME">
						<label for="USER_NAME">* 수주사명</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s6">
						<input id="MANAGER_NAME" type="text" class="validate" name="MANAGER_NAME">
						<label for="MANAGER_NAME">담당자</label>
					</div>
					<div class="input-field col s6">
						<input id="USER_ADDRESS" type="text" class="validate" name="USER_ADDRESS">
						<label for="USER_ADDRESS">회사주소</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s6">
						<input id="MANAGER_OFFICE_PHON" type="text" class="validate" name="MANAGER_OFFICE_PHON">
						<label for="MANAGER_OFFICE_PHON">전화번호</label>
					</div>
					<div class="input-field col s6">
						<input id="MANAGER_CEL_PHON" type="text" class="validate" name="MANAGER_CEL_PHON">
						<label for="MANAGER_CEL_PHON">휴대번호</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12">
						<input id="MANAGER_EMAIL" type="email" class="validate" name="MANAGER_EMAIL">
						<label for="MANAGER_EMAIL">이메일</label>
					</div>
				</div>

			  <h5>권한 설정</h5>
			  <div class="row">
				  <div class="col s12">
				  	<div class="col s6">
							<div class="card-panel">
								<div class="card-header">
									<input type="checkbox" id="MENU_NOTICE" name="MENU_NOTICE" checked="checked" onclick="javascript:noticeCheckbox(); return false;"/>
      						<label for="MENU_NOTICE">메뉴생성/글 보기 - <strong>공지</strong></label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
								<div class="card-content">
									<input type="checkbox" id="FUNCTION_NOTICE_WRITE" name="FUNCTION_NOTICE_WRITE"/>
      						<label for="FUNCTION_NOTICE_WRITE">글 등록 / 삭제</label>
								</div>
								</div>
							</div>
							<div class="card-panel">
								<div class="card-header">
									<input type="checkbox" id="MENU_PRESENTATION" name="MENU_PRESENTATION" checked="checked"/>
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
									<input type="checkbox" id="MENU_GUEST_PACKAGE_DOWNLOAD" name="MENU_GUEST_PACKAGE_DOWNLOAD" checked="checked"/>
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
									<input type="checkbox" id="MENU_CUSTOMBOARD" name="MENU_CUSTOMBOARD" checked="checked"/>
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
									<input type="checkbox" id="MENU_GLUE" name="MENU_GLUE" checked="checked"/>
      						<label for="MENU_GLUE">메뉴생성 / 글 보기<strong>Glue</strong></label>

									<input type="checkbox" id="FUNCTION_GLUE_ADMIN" name="FUNCTION_GLUE_ADMIN"/>
      						<label for="FUNCTION_GLUE_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
							       <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE" name="FUNCTION_GLUE_WRITE" checked="checked"/>
											 <label for="FUNCTION_GLUE_WRITE">글 등록 / 삭제</label>
										 </li>
							       <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_NOTICE" name="FUNCTION_GLUE_WRITE_NOTICE" />
											 <label for="FUNCTION_GLUE_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
										 </li>
							       <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_QNA" name="FUNCTION_GLUE_WRITE_QNA" checked="checked"/>
											 <label for="FUNCTION_GLUE_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
										 </li>
							       <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_FAQ" name="FUNCTION_GLUE_WRITE_FAQ" />
											 <label for="FUNCTION_GLUE_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_TECH" name="FUNCTION_GLUE_WRITE_TECH" />
											 <label for="FUNCTION_GLUE_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_WRITE_OLDTECH" name="FUNCTION_GLUE_WRITE_OLDTECH" />
											 <label for="FUNCTION_GLUE_WRITE_OLDTECH">글 등록 / 삭제 (예전 기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_REPLY" name="FUNCTION_GLUE_REPLY" checked="checked"/>
											 <label for="FUNCTION_GLUE_REPLY">본문 덧글 등록 (리플)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUE_REPLY_BOARD_QNA" name="FUNCTION_GLUE_REPLY_BOARD_QNA" checked="checked"/>
											 <label for="FUNCTION_GLUE_REPLY_BOARD_QNA">본문에 답글 작성 (새글-Q&amp;A)</label>
										 </li>
							     </ul>
										<ul>
										<%--  이전 버전
											<li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label></div></li>
											<li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_QNA" checked="checked">글 등록 / 삭제 (Q&amp;A)</label></div></li>
											<li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label></div></li>
											<li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_TECH">글 등록 / 삭제 (기술문서)</label></div></li>
											<li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_OLDTECH">글 등록 / 삭제 (예전 기술문서)</label></div></li>
										</ul>
										--%>
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
									<input type="checkbox" id="MENU_GLUEMASTER" name="MENU_GLUEMASTER" checked="checked"/>
      						<label for="MENU_GLUEMASTER">메뉴생성 / 글 보기 - <strong>GlueMaster</strong></label>

									<input type="checkbox" id="FUNCTION_GLUEMASTER_ADMIN" name="FUNCTION_GLUEMASTER_ADMIN"/>
      						<label for="FUNCTION_GLUEMASTER_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div class="card-content">
									<ul class="collection">
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE" name="FUNCTION_GLUEMASTER_WRITE" checked="checked"/>
										 <label for="FUNCTION_GLUEMASTER_WRITE">글 등록 / 삭제</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE_NOTICE" name="FUNCTION_GLUEMASTER_WRITE_NOTICE"/>
										 <label for="FUNCTION_GLUEMASTER_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE_QNA" name="FUNCTION_GLUEMASTER_WRITE_QNA" checked="checked"/>
										 <label for="FUNCTION_GLUEMASTER_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE_FAQ" name="FUNCTION_GLUEMASTER_WRITE_FAQ" />
										 <label for="FUNCTION_GLUEMASTER_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_WRITE_TECH" name="FUNCTION_GLUEMASTER_WRITE_TECH" />
										 <label for="FUNCTION_GLUEMASTER_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_REPLY" name="FUNCTION_GLUEMASTER_REPLY" checked="checked"/>
										 <label for="FUNCTION_GLUEMASTER_REPLY">본문 덧글 등록 (리플)</label>
									 </li>
									 <li class="collection-item">
										 <input type="checkbox" id="FUNCTION_GLUEMASTER_REPLY_BOARD_QNA" name="FUNCTION_GLUEMASTER_REPLY_BOARD_QNA" checked="checked"/>
										 <label for="FUNCTION_GLUEMASTER_REPLY_BOARD_QNA">본문에 답글 작성 (새글-Q&amp;A)</label>
									 </li>
								 </ul>
								</div>
							</div>
						</div>
					  <div class="col s6">
							<div class="card-panel">
								<div class="card-heading">
									<input type="checkbox" id="MENU_GLUEMOBILE" name="MENU_GLUEMOBILE" checked="checked"/>
									<label for="MENU_GLUEMOBILE">메뉴생성 / 글 보기 - <strong>GlueMobile</strong></label>

									<input type="checkbox" id="FUNCTION_GLUEMOBILE_ADMIN" name="FUNCTION_GLUEMOBILE_ADMIN"/>
									<label for="FUNCTION_GLUEMOBILE_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE" name="FUNCTION_GLUEMOBILE_WRITE" checked="checked"/>
											 <label for="FUNCTION_GLUEMOBILE_WRITE">글 등록 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE_NOTICE" name="FUNCTION_GLUEMOBILE_WRITE_NOTICE" />
											 <label for="FUNCTION_GLUEMOBILE_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE_QNA" name="FUNCTION_GLUEMOBILE_WRITE_QNA" checked="checked"/>
											 <label for="FUNCTION_GLUEMOBILE_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE_FAQ" name="FUNCTION_GLUEMOBILE_WRITE_FAQ" />
											 <label for="FUNCTION_GLUEMOBILE_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_WRITE_TECH" name="FUNCTION_GLUEMOBILE_WRITE_TECH" />
											 <label for="FUNCTION_GLUEMOBILE_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_REPLY" name="FUNCTION_GLUEMOBILE_REPLY" checked="checked"/>
											 <label for="FUNCTION_GLUEMOBILE_REPLY">본문 덧글 등록 (리플)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA" name="FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA" checked="checked"/>
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
									<input type="checkbox" id="MENU_UCUBE" name="MENU_UCUBE" checked="checked"/>
									<label for="MENU_UCUBE">메뉴생성 / 글 보기 - <strong>uCUBE</strong></label>

									<input type="checkbox" id="FUNCTION_UCUBE_ADMIN" name="FUNCTION_UCUBE_ADMIN"/>
									<label for="FUNCTION_UCUBE_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE" name="FUNCTION_UCUBE_WRITE" checked="checked"/>
											 <label for="FUNCTION_UCUBE_WRITE">글 등록 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE_NOTICE" name="FUNCTION_UCUBE_WRITE_NOTICE" />
											 <label for="FUNCTION_UCUBE_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE_QNA" name="FUNCTION_UCUBE_WRITE_QNA" checked="checked"/>
											 <label for="FUNCTION_UCUBE_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE_FAQ" name="FUNCTION_UCUBE_WRITE_FAQ" />
											 <label for="FUNCTION_UCUBE_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_WRITE_TECH" name="FUNCTION_UCUBE_WRITE_TECH" />
											 <label for="FUNCTION_UCUBE_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_REPLY" name="FUNCTION_UCUBE_REPLY" checked="checked"/>
											 <label for="FUNCTION_UCUBE_REPLY">본문 덧글 등록 (리플)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_UCUBE_REPLY_BOARD_QNA" name="FUNCTION_UCUBE_REPLY_BOARD_QNA" checked="checked"/>
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
									<input type="checkbox" id="MENU_POSBEE" name="MENU_POSBEE" checked="checked"/>
									<label for="MENU_POSBEE">메뉴생성 / 글 보기 - <strong>PosBee</strong></label>

									<input type="checkbox" id="FUNCTION_POSBEE_ADMIN" name="FUNCTION_POSBEE_ADMIN"/>
									<label for="FUNCTION_POSBEE_ADMIN">어드민 권한 (유저 비밀글 보기 / 프로젝트 폴더 게시판 생성)</label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE" name="FUNCTION_POSBEE_WRITE" checked="checked"/>
											 <label for="FUNCTION_POSBEE_WRITE">글 등록 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE_NOTICE" name="FUNCTION_POSBEE_WRITE_NOTICE" />
											 <label for="FUNCTION_POSBEE_WRITE_NOTICE">글 등록 / 삭제 (공지사항)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE_QNA" name="FUNCTION_POSBEE_WRITE_QNA" checked="checked"/>
											 <label for="FUNCTION_POSBEE_WRITE_QNA">글 등록 / 삭제 (Q&amp;A)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE_FAQ" name="FUNCTION_POSBEE_WRITE_FAQ" />
											 <label for="FUNCTION_POSBEE_WRITE_FAQ">글 등록 / 삭제 (FAQ)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_WRITE_TECH" name="FUNCTION_POSBEE_WRITE_TECH" />
											 <label for="FUNCTION_POSBEE_WRITE_TECH">글 등록 / 삭제 (기술문서)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_REPLY" name="FUNCTION_POSBEE_REPLY" checked="checked"/>
											 <label for="FUNCTION_POSBEE_REPLY">본문 덧글 등록 (리플)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_POSBEE_REPLY_BOARD_QNA" name="FUNCTION_POSBEE_REPLY_BOARD_QNA" checked="checked"/>
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
									<input type="checkbox" id="MENU_SOLUTION_UPLOAD" name="MENU_SOLUTION_UPLOAD"/>
									<label for="MENU_SOLUTION_UPLOAD">메뉴생성 - <strong>솔루션 패키지 관리</strong></label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_GLUE" name="FUNCTION_SOLUTION_UPLOAD_GLUE"/>
											 <label for="FUNCTION_SOLUTION_UPLOAD_GLUE">패키지 등록 / 삭제 (Glue)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_GLUEMASTER" name="FUNCTION_SOLUTION_UPLOAD_GLUEMASTER" />
											 <label for="FUNCTION_SOLUTION_UPLOAD_GLUEMASTER">패키지 등록 / 삭제 (GlueMaster)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE" name="FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE"/>
											 <label for="FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE">패키지 등록 / 삭제 (GlueMobile)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_UCUBE" name="FUNCTION_SOLUTION_UPLOAD_UCUBE" />
											 <label for="FUNCTION_SOLUTION_UPLOAD_UCUBE">패키지 등록 / 삭제 (uCUBE)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_POSBEE" name="FUNCTION_SOLUTION_UPLOAD_POSBEE" />
											 <label for="FUNCTION_SOLUTION_UPLOAD_POSBEE">패키지 등록 / 삭제 (PosBee)</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_SOLUTION_UPLOAD_ETC" name="FUNCTION_SOLUTION_UPLOAD_ETC" />
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
									<input type="checkbox" id="MENU_MANAGEMENT" name="MENU_MANAGEMENT"/>
									<label for="MENU_MANAGEMENT">메뉴생성 - <strong>고객관리</strong></label>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="card-content">
										<ul class="collection">
										 <li class="collection-item">
											 <input type="checkbox" id="SUB_MENU_MANAGEMENT_COMPLETE" name="SUB_MENU_MANAGEMENT_COMPLETE"/>
											 <label for="SUB_MENU_MANAGEMENT_COMPLETE">서브메뉴 / 고객 정보 보기 - <strong>완료 계약건</strong></label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_MANAGEMENT_INPUT_USER" name="FUNCTION_MANAGEMENT_INPUT_USER" />
											 <label for="FUNCTION_MANAGEMENT_INPUT_USER">고객 등록 / 수정 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="SUB_MENU_MANAGEMENT_PROGRESS" name="SUB_MENU_MANAGEMENT_PROGRESS"/>
											 <label for="SUB_MENU_MANAGEMENT_PROGRESS">서브메뉴 / 고객 정보 보기 - <strong>진행중 계약건</strong></label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_PROGRESS_INPUT_USER" name="FUNCTION_PROGRESS_INPUT_USER" />
											 <label for="FUNCTION_PROGRESS_INPUT_USER">가계약 등록 / 수정 / 삭제</label>
										 </li>
										 <li class="collection-item">
											 <input type="checkbox" id="FUNCTION_PROGRESS_COMMENT" name="FUNCTION_PROGRESS_COMMENT" />
											 <label for="FUNCTION_PROGRESS_COMMENT">Comment 등록</label>
										 </li>
									 </ul>

									 	<%-- 이전 버전 --%>
										<%-- <ul class="list-unstyled">
												<li><div class="checkbox"><label><input type="checkbox" value="true" id="MENU_MANAGEMENT_CHECK" name="SUB_MENU_MANAGEMENT_COMPLETE">서브메뉴 / 고객 정보 보기 - <strong>완료 계약건</strong></label></div></li>
												<li>
														<ul>
																<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_MANAGEMENT_INPUT_USER">고객 등록 / 수정 / 삭제</label></div></li>
														</ul>
												</li>
												<li><div class="checkbox"><label><input type="checkbox" value="true" id="MENU_MANAGEMENT_CHECK" name="SUB_MENU_MANAGEMENT_PROGRESS">서브메뉴 / 고객 정보 보기 - <strong>진행중 계약건</strong></label></div></li>
												<li>
														<ul>
																<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_PROGRESS_INPUT_USER">가계약 등록 / 수정 / 삭제</label></div></li>
																<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_PROGRESS_COMMENT">Comment 등록</label></div></li>
														</ul>
												</li>
										</ul> --%>
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
				<button type="button" class="btn btn-primary btn-sm" onclick="javascript:confirmCustomUserForm();">유저 생성</button>
				<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.back();">취소</button>
			</div>
	  </div>
	</form>

</body>
