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
body{ padding-bottom: 90px; }
#addContract .form-group, .contract1 .form-group {
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
<form class="form-horizontal" role="form" action="${contextPath }/addCustomUser" method="post" name="addCustomUser">
	<div class="panel panel-default">
   	  <div class="panel-heading"><strong>커스텀 유저 생성</strong></div>
   	  <div class="panel-body" id="addContract">
   	  	  <div class="form-group has-error">
			  <label class="control-label" for="USER_NO">* 아이디</label>
			  <input type="text" class="form-control input-sm" id="USER_NO" name="USER_NO">
		  </div>
		  <div class="form-group has-error">
			  <label class="control-label" for="USER_NAME">* 닉네임</label>
			  <input type="text" class="form-control input-sm" id="USER_NAME" name="USER_NAME">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_NAME">담당자</label>
			  <input type="text" class="form-control input-sm" id="MANAGER_NAME" name="MANAGER_NAME">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="USER_ADDRESS">회사주소</label>
			  <input type="text" class="form-control input-sm" id="USER_ADDRESS" name="USER_ADDRESS">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_OFFICE_PHON">전화번호</label>
			  <input type="text" class="form-control input-sm" id="MANAGER_OFFICE_PHON" name="MANAGER_OFFICE_PHON">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_CEL_PHON">휴대번호</label>
			  <input type="text" class="form-control input-sm" id="MANAGER_CEL_PHON" name="MANAGER_CEL_PHON">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_EMAIL">이메일</label>
			  <input type="text" class="form-control input-sm" id="MANAGER_EMAIL" name="MANAGER_EMAIL">
		  </div>
		  
		  <hr>
		  <strong>- 권한 설정</strong>
		  <div class="row">
		  <div class="col-xs-12">
		  	<div class="col-xs-6">
		  	  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_NOTICE" id="MENU_NOTICE" checked="checked" onclick="javascript:noticeCheckbox(); return false;">메뉴생성/글 보기 - <strong>공지</strong></label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_NOTICE_WRITE">글 등록/삭제</label></div>
					  </div>
				  </div>
			  </div>
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_PRESENTATION" checked="checked">메뉴생성 - <strong>제품소개</strong></label></div>
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
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_GUEST_PACKAGE_DOWNLOAD" checked="checked">메뉴생성/다운로드(Guest) - <strong>교육용 솔루션 패키지</strong></label></div>
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
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_GLUE" checked="checked">메뉴생성/글 보기 - <strong>Glue</strong></label></div>
					      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUE_ADMIN">어드민 권한 (유저 비밀글 보기/프로젝트 폴더*게시판 생성)</label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					  	  <ul class="list-unstyled">
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUE_WRITE" checked="checked">글 등록/삭제</label></div></li>
					  	  	<li>
							  <ul>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_NOTICE">글 등록/삭제 (공지사항)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_QNA" checked="checked">글 등록/삭제 (Q&amp;A)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_FAQ">글 등록/삭제 (FAQ)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_TECH">글 등록/삭제 (기술문서)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_OLDTECH">글 등록/삭제 (기술문서(예전))</label></div></li>
							  </ul>
					  	  	</li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUE_REPLY" checked="checked">본문 덧글 등록 (리플)</label></div></li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUE_REPLY_BOARD_QNA" checked="checked">본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
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
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_GLUEMASTER" checked="checked">메뉴생성/글 보기 - <strong>GlueMaster</strong></label></div>
					      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMASTER_ADMIN">어드민 권한 (유저 비밀글 보기/프로젝트 폴더*게시판 생성)</label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					  	  <ul class="list-unstyled">
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMASTER_WRITE" checked="checked">글 등록/삭제</label></div></li>
					  	  	<li>
					  	  		<ul>
					  	  		  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_NOTICE">글 등록/삭제 (공지사항)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_QNA" checked="checked">글 등록/삭제 (Q&amp;A)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_FAQ">글 등록/삭제 (FAQ)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_TECH">글 등록/삭제 (기술문서)</label></div></li>
					  	  		</ul>
					  	  	</li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMASTER_REPLY" checked="checked">본문 덧글 등록 (리플)</label></div></li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMASTER_REPLY_BOARD_QNA" checked="checked">본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
					  	  </ul>
					  </div>
				  </div>
			  </div>
			  </div>
			  <div class="col-xs-6">
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_GLUEMOBILE" checked="checked">메뉴생성/글 보기 - <strong>GlueMobile</strong></label></div>
					      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_ADMIN">어드민 권한 (유저 비밀글 보기/프로젝트 폴더*게시판 생성)</label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					  	  <ul class="list-unstyled">
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_WRITE" checked="checked">글 등록/삭제</label></div></li>
					  	  	<li>
					  	  		<ul>
					  	  		  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_NOTICE">글 등록/삭제 (공지사항)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_QNA" checked="checked">글 등록/삭제 (Q&amp;A)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_FAQ">글 등록/삭제 (FAQ)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_TECH">글 등록/삭제 (기술문서)</label></div></li>
					  	  		</ul>
					  	  	</li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_REPLY" checked="checked">본문 덧글 등록 (리플)</label></div></li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA" checked="checked">본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
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
						      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_UCUBE" checked="checked">메뉴생성/글 보기 - <strong>uCUBE</strong></label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_UCUBE_ADMIN">어드민 권한 (유저 비밀글 보기/프로젝트 폴더*게시판 생성)</label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						  	  <ul class="list-unstyled">
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_UCUBE_WRITE" checked="checked">글 등록/삭제</label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
							  	  		  <li><div class="checkbox"><label><input type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_NOTICE">글 등록/삭제 (공지사항)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_QNA" checked="checked">글 등록/삭제 (Q&amp;A)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_FAQ">글 등록/삭제 (FAQ)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_TECH">글 등록/삭제 (기술문서)</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_UCUBE_REPLY" checked="checked">본문 덧글 등록 (리플)</label></div></li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_UCUBE_REPLY_BOARD_QNA" checked="checked">본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
						  	  </ul>
						  </div>
					  </div>
				  </div>
			  </div>
		  	  <div class="col-xs-6">
				  <div class="panel panel-default">
					  <div class="panel-heading">
					      <h5 class="panel-title">
						      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_POSBEE" checked="checked">메뉴생성/글 보기 - <strong>PosBee</strong></label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_POSBEE_ADMIN">어드민 권한 (유저 비밀글 보기/프로젝트 폴더*게시판 생성)</label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						  	  <ul class="list-unstyled">
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_POSBEE_WRITE" checked="checked">글 등록/삭제</label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
							  	  		  <li><div class="checkbox"><label><input type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_NOTICE">글 등록/삭제 (공지사항)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_QNA" checked="checked">글 등록/삭제 (Q&amp;A)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_FAQ">글 등록/삭제 (FAQ)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_TECH">글 등록/삭제 (기술문서)</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_POSBEE_REPLY" checked="checked">본문 덧글 등록 (리플)</label></div></li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_POSBEE_REPLY_BOARD_QNA" checked="checked">본문에 대한 답글 작성 (새글-Q&amp;A)</label></div></li>
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
						      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_MANAGEMENT">메뉴생성 - <strong>고객관리</strong></label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
					  		  <ul class="list-unstyled">
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" id="MENU_MANAGEMENT_CHECK" name="SUB_MENU_MANAGEMENT_COMPLETE">서브메뉴/고객 정보 보기 - <strong>완료 계약건</strong></label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
						  	  	  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_MANAGEMENT_INPUT_USER">고객 등록/수정/삭제</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" id="MENU_MANAGEMENT_CHECK" name="SUB_MENU_MANAGEMENT_PROGRESS">서브메뉴/고객 정보 보기 - <strong>진행중 계약건</strong></label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
						  	  	  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_PROGRESS_INPUT_USER">가계약 등록/수정/삭제</label></div></li>
						  	  	  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_PROGRESS_COMMENT">Comment 등록</label></div></li>
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
						      <div class="checkbox"><label><input type="checkbox" value="true" id="MENU_SOLUTION_UPLOAD" name="MENU_SOLUTION_UPLOAD">메뉴생성 - <strong>솔루션 패키지 관리</strong></label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_GLUE">패키지 등록/삭제 (Glue)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_GLUEMASTER">패키지 등록/삭제 (GlueMaster)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE">패키지 등록/삭제 (GlueMobile)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_UCUBE">패키지 등록/삭제 (uCUBE)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_POSBEE">패키지 등록/삭제 (PosBee)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_ETC">패키지 등록/삭제 (기타파일)</label></div>
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
						      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_CUSTOMBOARD">메뉴생성/게시판 생성 - <strong>자료실</strong></label></div>
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
		<div class="col-xs-12 btn-group">
			<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.back();">취소</button>
	    	<button type="button" class="btn btn-primary btn-sm" onclick="javascript:confirmCustomUserForm();">유저 생성</button>
		</div>
		</div>
	  </div>
</form>
</body>
</html>