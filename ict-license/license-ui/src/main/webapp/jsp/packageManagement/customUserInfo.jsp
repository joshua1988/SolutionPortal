<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">
/* body{ padding-bottom: 90px; } */
#addContract .form-group {
	margin-bottom: 0.5px; 
	padding-left: 15px;
	padding-right: 15px;
}
.form-group label{
	font-size: 12px;
}
.checkbox label {
 	font-size: 12px; 
}
</style>
<title>Insert title here</title>
</head>
<body>
<!-- <div class="row"> -->
<form class="form-horizontal" role="form" method="post" name="modifyCustomUser">
	<div class="panel panel-default">
   	  <div class="panel-heading"><strong>커스텀 유저 생성</strong></div>
   	  <div class="panel-body" id="addContract">
   	  	  <div class="form-group has-error">
			  <label class="control-label" for="USER_NO">* 아이디</label>
			  <input disabled="disabled" type="text" class="form-control input-sm" id="USER_NO_D" name="USER_NO_D" value="${userInfo.getUSER_NO() }">
			  <input type="hidden" id="USER_NO" name="USER_NO" value="${userInfo.getUSER_NO() }">
		  </div>
		  <div class="form-group has-error">
			  <label class="control-label" for="USER_NAME">* 닉네임</label>
			  <input disabled="disabled" type="text" class="form-control input-sm" id="USER_NAME" name="USER_NAME" value="${userInfo.getUSER_NAME() }">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_NAME">담당자</label>
			  <input disabled="disabled" type="text" class="form-control input-sm" id="MANAGER_NAME" name="MANAGER_NAME" value="${userInfo.getMANAGER_NAME() }">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="USER_ADDRESS">회사주소</label>
			  <input disabled="disabled" type="text" class="form-control input-sm" id="USER_ADDRESS" name="USER_ADDRESS" value="${userInfo.getUSER_ADDRESS() }">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_OFFICE_PHON">전화번호</label>
			  <input disabled="disabled" type="text" class="form-control input-sm" id="MANAGER_OFFICE_PHON" name="MANAGER_OFFICE_PHON" value="${userInfo.getMANAGER_OFFICE_PHON() }">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_CEL_PHON">휴대번호</label>
			  <input disabled="disabled" type="text" class="form-control input-sm" id="MANAGER_CEL_PHON" name="MANAGER_CEL_PHON" value="${userInfo.getMANAGER_CEL_PHON() }">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_EMAIL">이메일</label>
			  <input disabled="disabled" type="text" class="form-control input-sm" id="MANAGER_EMAIL" name="MANAGER_EMAIL" value="${userInfo.getMANAGER_EMAIL() }">
		  </div>
		  <br>  
		  <div class="col-xs-12">
		  	  <button type="button" class="btn btn-info btn-sm modify_button" onclick="javascript:changeButton(); return false;">정보수정하기</button>
	    	  <button type="button" class="btn btn-success btn-sm modify_submit_button" onclick="javascript:modifyCustomUserInfo('${userInfo.getUSER_NO() }');" style="display: none;">정보수정완료</button>
		  </div>
		  
		  <hr>
		  <strong>- 권한 설정</strong>
		  <div class="row">
		  <div class="col-xs-12">
		  	<div class="col-xs-6">
		  	  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox">
					      	<label>
					      		<input disabled="disabled" type="checkbox" value="true" name="MENU_NOTICE" id="MENU_NOTICE" <c:if test="${userPermission.isMENU_NOTICE() }">checked="checked"</c:if> onclick="javascript:noticeCheckbox(); return false;">메뉴생성/글 보기 - <strong>공지</strong>
					      	</label>
					      </div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_NOTICE_WRITE" <c:if test="${userPermission.isFUNCTION_NOTICE_WRITE() }">checked="checked"</c:if>>글 등록/삭제</label></div>
					  </div>
				  </div>
			  </div>
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="MENU_PRESENTATION" <c:if test="${userPermission.isMENU_PRESENTATION() }">checked="checked"</c:if>>메뉴생성 - <strong>제품소개</strong></label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					      <label style="font-size: 12px; color: gray;">제품소개 메뉴입니다.</label>
					  </div>
				  </div>
			  </div>
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="MENU_GUEST_PACKAGE_DOWNLOAD" <c:if test="${userPermission.isMENU_GUEST_PACKAGE_DOWNLOAD() }">checked="checked"</c:if>>메뉴생성/다운로드(Guest) - <strong>교육용 솔루션 패키지</strong></label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					      <label style="font-size: 12px; color: gray;">교육용 솔루션을 다운 받을 수 있습니다.</label>
					  </div>
				  </div>
			  </div>
		  	</div>
			<div class="col-xs-6">
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="MENU_GLUE" <c:if test="${userPermission.isMENU_GLUE() }">checked="checked"</c:if>>메뉴생성/글 보기 - <strong>Glue</strong></label></div>
					      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUE_ADMIN" <c:if test="${userPermission.isFUNCTION_GLUE_ADMIN() }">checked="checked"</c:if>>어드민 권한 (유저 비밀글 보기)</label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					  	  <ul class="list-unstyled">
					  	  	<li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUE_WRITE" <c:if test="${userPermission.isFUNCTION_GLUE_WRITE() }">checked="checked"</c:if>>글 등록/삭제</label></div></li>
					  	  	<li>
							  <ul>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_NOTICE" <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_NOTICE() }">checked="checked"</c:if>>글 등록/삭제 (공지사항)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_QNA" <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_QNA() }">checked="checked"</c:if>>글 등록/삭제 (Q&amp;A)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_FAQ" <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_FAQ() }">checked="checked"</c:if>>글 등록/삭제 (FAQ)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_TECH" <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_TECH() }">checked="checked"</c:if>>글 등록/삭제 (기술문서)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_OLDTECH" <c:if test="${userPermission.isFUNCTION_GLUE_WRITE_OLDTECH() }">checked="checked"</c:if>>글 등록/삭제 (기술문서(예전))</label></div></li>
							  </ul>
					  	  	</li>
					  	  	<li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUE_REPLY" <c:if test="${userPermission.isFUNCTION_GLUE_REPLY() }">checked="checked"</c:if>>본문 덧글 등록 (리플)</label></div></li>
					  	  	<li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUE_REPLY_BOARD_QNA" <c:if test="${userPermission.isFUNCTION_GLUE_REPLY_BOARD_QNA() }">checked="checked"</c:if>>본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
					  	  </ul>
					  </div>
				  </div>
			  </div>
			 </div>
		  </div>
		  </div>
		  
		  <div class="row">
		  <div class="col-xs-12">
			  <div class="col-xs-6">
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="MENU_GLUEMASTER" <c:if test="${userPermission.isMENU_GLUEMASTER() }">checked="checked"</c:if>>메뉴생성/글 보기 - <strong>GlueMaster</strong></label></div>
					      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUEMASTER_ADMIN" <c:if test="${userPermission.isFUNCTION_GLUEMASTER_ADMIN() }">checked="checked"</c:if>>어드민 권한 (유저 비밀글 보기)</label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					  	  <ul class="list-unstyled">
					  	  	<li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUEMASTER_WRITE" <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE() }">checked="checked"</c:if>>글 등록/삭제</label></div></li>
					  	  	<li>
					  	  		<ul>
					  	  		  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_NOTICE" <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE_NOTICE() }">checked="checked"</c:if>>글 등록/삭제 (공지사항)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_QNA" <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE_QNA() }">checked="checked"</c:if>>글 등록/삭제 (Q&amp;A)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_FAQ" <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE_FAQ() }">checked="checked"</c:if>>글 등록/삭제 (FAQ)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_TECH" <c:if test="${userPermission.isFUNCTION_GLUEMASTER_WRITE_TECH() }">checked="checked"</c:if>>글 등록/삭제 (기술문서)</label></div></li>
					  	  		</ul>
					  	  	</li>
					  	  	<li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUEMASTER_REPLY" <c:if test="${userPermission.isFUNCTION_GLUEMASTER_REPLY() }">checked="checked"</c:if>>본문 덧글 등록 (리플)</label></div></li>
					  	  	<li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUEMASTER_REPLY_BOARD_QNA" <c:if test="${userPermission.isFUNCTION_GLUEMASTER_REPLY_BOARD_QNA() }">checked="checked"</c:if>>본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
					  	  </ul>
					  </div>
				  </div>
			  </div>
			  </div>
			  <div class="col-xs-6">
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="MENU_GLUEMOBILE" <c:if test="${userPermission.isMENU_GLUEMOBILE() }">checked="checked"</c:if>>메뉴생성/글 보기 - <strong>GlueMobile</strong></label></div>
					      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_ADMIN" <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_ADMIN() }">checked="checked"</c:if>>어드민 권한 (유저 비밀글 보기)</label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					  	  <ul class="list-unstyled">
					  	  	<li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_WRITE" <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE() }">checked="checked"</c:if>>글 등록/삭제</label></div></li>
					  	  	<li>
					  	  		<ul>
					  	  		  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_NOTICE" <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE_NOTICE() }">checked="checked"</c:if>>글 등록/삭제 (공지사항)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_QNA" <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE_QNA() }">checked="checked"</c:if>>글 등록/삭제 (Q&amp;A)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_FAQ" <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE_FAQ() }">checked="checked"</c:if>>글 등록/삭제 (FAQ)</label></div></li>
								  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_TECH" <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_WRITE_TECH() }">checked="checked"</c:if>>글 등록/삭제 (기술문서)</label></div></li>
					  	  		</ul>
					  	  	</li>
					  	  	<li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_REPLY" <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_REPLY() }">checked="checked"</c:if>>본문 덧글 등록 (리플)</label></div></li>
					  	  	<li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA" <c:if test="${userPermission.isFUNCTION_GLUEMOBILE_REPLY_BOARD_QNA() }">checked="checked"</c:if>>본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
					  	  </ul>
					  </div>
				  </div>
			  </div>
			  </div>
		  </div>
		  </div>
		  
		  <div class="row">
		  <div class="col-xs-12">
		  	<div class="col-xs-6">
				  <div class="panel panel-default">
					  <div class="panel-heading">
					      <h5 class="panel-title">
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="MENU_UCUBE" <c:if test="${userPermission.isMENU_UCUBE() }">checked="checked"</c:if>>메뉴생성/글 보기 - <strong>uCUBE</strong></label></div>
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_UCUBE_ADMIN" <c:if test="${userPermission.isFUNCTION_UCUBE_ADMIN() }">checked="checked"</c:if>>어드민 권한 (유저 비밀글 보기)</label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						  	  <ul class="list-unstyled">
						  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_UCUBE_WRITE" <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE() }">checked="checked"</c:if>>글 등록/삭제</label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
							  	  		  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_NOTICE" <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE_NOTICE() }">checked="checked"</c:if>>글 등록/삭제 (공지사항)</label></div></li>
										  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_QNA" <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE_QNA() }">checked="checked"</c:if>>글 등록/삭제 (Q&amp;A)</label></div></li>
										  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_FAQ" <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE_FAQ() }">checked="checked"</c:if>>글 등록/삭제 (FAQ)</label></div></li>
										  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_TECH" <c:if test="${userPermission.isFUNCTION_UCUBE_WRITE_TECH() }">checked="checked"</c:if>>글 등록/삭제 (기술문서)</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_UCUBE_REPLY" <c:if test="${userPermission.isFUNCTION_UCUBE_REPLY() }">checked="checked"</c:if>>본문 덧글 등록 (리플)</label></div></li>
						  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_UCUBE_REPLY_BOARD_QNA" <c:if test="${userPermission.isFUNCTION_UCUBE_REPLY_BOARD_QNA() }">checked="checked"</c:if>>본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
						  	  </ul>
						  </div>
					  </div>
				  </div>
			  </div>
		  	  <div class="col-xs-6">
				  <div class="panel panel-default">
					  <div class="panel-heading">
					      <h5 class="panel-title">
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="MENU_POSBEE" <c:if test="${userPermission.isMENU_POSBEE() }">checked="checked"</c:if>>메뉴생성/글 보기 - <strong>PosBee</strong></label></div>
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_POSBEE_ADMIN" <c:if test="${userPermission.isFUNCTION_POSBEE_ADMIN() }">checked="checked"</c:if>>어드민 권한 (유저 비밀글 보기)</label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						  	  <ul class="list-unstyled">
						  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_POSBEE_WRITE" <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE() }">checked="checked"</c:if>>글 등록/삭제</label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
							  	  		  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_NOTICE" <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE_NOTICE() }">checked="checked"</c:if>>글 등록/삭제 (공지사항)</label></div></li>
										  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_QNA" <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE_QNA() }">checked="checked"</c:if>>글 등록/삭제 (Q&amp;A)</label></div></li>
										  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_FAQ" <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE_FAQ() }">checked="checked"</c:if>>글 등록/삭제 (FAQ)</label></div></li>
										  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_TECH" <c:if test="${userPermission.isFUNCTION_POSBEE_WRITE_TECH() }">checked="checked"</c:if>>글 등록/삭제 (기술문서)</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_POSBEE_REPLY" <c:if test="${userPermission.isFUNCTION_POSBEE_REPLY() }">checked="checked"</c:if>>본문 덧글 등록 (리플)</label></div></li>
						  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_POSBEE_REPLY_BOARD_QNA" <c:if test="${userPermission.isFUNCTION_POSBEE_REPLY_BOARD_QNA() }">checked="checked"</c:if>>본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
						  	  </ul>
						  </div>
					  </div>
				  </div>
			  </div>
		  </div>
		  </div>
		  
		  <div class="row">
		  <div class="col-xs-12">
		  		<div class="col-xs-6">
				  <div class="panel panel-default">
					  <div class="panel-heading">
					      <h5 class="panel-title">
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="MENU_MANAGEMENT" <c:if test="${userPermission.isMENU_MANAGEMENT() }">checked="checked"</c:if>>메뉴생성 - <strong>고객관리</strong></label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
					  		  <ul class="list-unstyled">
						  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="MENU_MANAGEMENT_CHECK" name="SUB_MENU_MANAGEMENT_COMPLETE" <c:if test="${userPermission.isSUB_MENU_MANAGEMENT_COMPLETE() }">checked="checked"</c:if>>서브메뉴/고객 정보 보기 - <strong>완료 계약건</strong></label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
						  	  	  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_MANAGEMENT_INPUT_USER" <c:if test="${userPermission.isFUNCTION_MANAGEMENT_INPUT_USER() }">checked="checked"</c:if>>고객 등록/수정/삭제</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="MENU_MANAGEMENT_CHECK" name="SUB_MENU_MANAGEMENT_PROGRESS" <c:if test="${userPermission.isSUB_MENU_MANAGEMENT_PROGRESS() }">checked="checked"</c:if>>서브메뉴/고객 정보 보기 - <strong>진행중 계약건</strong></label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
						  	  	  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_PROGRESS_INPUT_USER" <c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">checked="checked"</c:if>>가계약 등록/수정/삭제</label></div></li>
						  	  	  	  	  <li><div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="FUNCTION_PROGRESS_COMMENT" <c:if test="${userPermission.isFUNCTION_PROGRESS_COMMENT() }">checked="checked"</c:if>>Comment 등록</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  </ul>
						  </div>
					  </div>
				  </div>
			  	</div>
		  	 <div class="col-xs-6">
				  <div class="panel panel-default">
					  <div class="panel-heading">
					      <h5 class="panel-title">
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="MENU_SOLUTION_UPLOAD" name="MENU_SOLUTION_UPLOAD" <c:if test="${userPermission.isMENU_SOLUTION_UPLOAD() }">checked="checked"</c:if>>메뉴생성 - <strong>솔루션 패키지 관리</strong></label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_GLUE" <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_GLUE() }">checked="checked"</c:if>>패키지 등록/삭제 (Glue)</label></div>
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_GLUEMASTER" <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_GLUEMASTER() }">checked="checked"</c:if>>패키지 등록/삭제 (GlueMaster)</label></div>
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE" <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_GLUEMOBILE() }">checked="checked"</c:if>>패키지 등록/삭제 (GlueMobile)</label></div>
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_UCUBE" <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_UCUBE() }">checked="checked"</c:if>>패키지 등록/삭제 (uCUBE)</label></div>
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_POSBEE" <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_POSBEE() }">checked="checked"</c:if>>패키지 등록/삭제 (PosBee)</label></div>
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_ETC" <c:if test="${userPermission.isFUNCTION_SOLUTION_UPLOAD_ETC() }">checked="checked"</c:if>>패키지 등록/삭제 (기타파일)</label></div>
						  </div>
					  </div>
				  </div>
			  </div>
		  </div>
		  </div>
		  
		  <div class="row">
		  	<div class="col-xs-12">
		  	  <div class="col-xs-6">
				  <div class="panel panel-default">
					  <div class="panel-heading">
					      <h5 class="panel-title">
						      <div class="checkbox"><label><input disabled="disabled" type="checkbox" value="true" name="MENU_CUSTOMBOARD" <c:if test="${userPermission.isMENU_CUSTOMBOARD() }">checked="checked"</c:if>>메뉴생성/게시판 생성 - <strong>자료실</strong></label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						      <label style="font-size: 12px; color: gray;">게시판 생성 및 자료를 등록 할 수 있는 메뉴 입니다.</label>
						  </div>
				 	  </div>
				  </div>
			  </div>
		  	</div>
		  </div>
		
		<br>  
		<div class="col-xs-12">
			<button type="button" class="btn btn-info btn-sm modify_button_per" onclick="javascript:changeButtonPerm(); return false;">권한수정하기</button>
	    	<button type="button" class="btn btn-success btn-sm modify_submit_button_per" onclick="javascript:modifyCustomUserPermission('${userInfo.getUSER_NO() }');" style="display: none;">권한수정완료</button>
		</div>
		</div>
	  </div>
</form>
</body>
</html>