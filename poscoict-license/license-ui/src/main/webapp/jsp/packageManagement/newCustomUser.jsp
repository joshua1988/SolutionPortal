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
   	  <div class="panel-heading"><strong>Ŀ���� ���� ����</strong></div>
   	  <div class="panel-body" id="addContract">
   	  	  <div class="form-group has-error">
			  <label class="control-label" for="USER_NO">* ���̵�</label>
			  <input type="text" class="form-control input-sm" id="USER_NO" name="USER_NO">
		  </div>
		  <div class="form-group has-error">
			  <label class="control-label" for="USER_NAME">* �г���</label>
			  <input type="text" class="form-control input-sm" id="USER_NAME" name="USER_NAME">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_NAME">�����</label>
			  <input type="text" class="form-control input-sm" id="MANAGER_NAME" name="MANAGER_NAME">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="USER_ADDRESS">ȸ���ּ�</label>
			  <input type="text" class="form-control input-sm" id="USER_ADDRESS" name="USER_ADDRESS">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_OFFICE_PHON">��ȭ��ȣ</label>
			  <input type="text" class="form-control input-sm" id="MANAGER_OFFICE_PHON" name="MANAGER_OFFICE_PHON">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_CEL_PHON">�޴��ȣ</label>
			  <input type="text" class="form-control input-sm" id="MANAGER_CEL_PHON" name="MANAGER_CEL_PHON">
		  </div>
		  <div class="form-group has-success">
			  <label class="control-label" for="MANAGER_EMAIL">�̸���</label>
			  <input type="text" class="form-control input-sm" id="MANAGER_EMAIL" name="MANAGER_EMAIL">
		  </div>
		  
		  <hr>
		  <strong>- ���� ����</strong>
		  <div class="row">
		  <div class="col-xs-12">
		  	<div class="col-xs-6">
		  	  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_NOTICE" id="MENU_NOTICE" checked="checked" onclick="javascript:noticeCheckbox(); return false;">�޴�����/�� ���� - <strong>����</strong></label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_NOTICE_WRITE">�� ���/����</label></div>
					  </div>
				  </div>
			  </div>
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_PRESENTATION" checked="checked">�޴����� - <strong>��ǰ�Ұ�</strong></label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					      <label style="font-size: 12px; color: gray;">��ǰ�Ұ� �޴��Դϴ�.</label>
					  </div>
				  </div>
			  </div>
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_GUEST_PACKAGE_DOWNLOAD" checked="checked">�޴�����/�ٿ�ε�(Guest) - <strong>������ �ַ�� ��Ű��</strong></label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					      <label style="font-size: 12px; color: gray;">������ �ַ���� �ٿ� ���� �� �ֽ��ϴ�.</label>
					  </div>
				  </div>
			  </div>
		  	</div>
			<div class="col-xs-6">
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_GLUE" checked="checked">�޴�����/�� ���� - <strong>Glue</strong></label></div>
					      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUE_ADMIN">���� ���� (���� ��б� ����/������Ʈ ����*�Խ��� ����)</label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					  	  <ul class="list-unstyled">
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUE_WRITE" checked="checked">�� ���/����</label></div></li>
					  	  	<li>
							  <ul>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_NOTICE">�� ���/���� (��������)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_QNA" checked="checked">�� ���/���� (Q&amp;A)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_FAQ">�� ���/���� (FAQ)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_TECH">�� ���/���� (�������)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUE_CHECK" name="FUNCTION_GLUE_WRITE_OLDTECH">�� ���/���� (�������(����))</label></div></li>
							  </ul>
					  	  	</li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUE_REPLY" checked="checked">���� ���� ��� (����)</label></div></li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUE_REPLY_BOARD_QNA" checked="checked">������ ���� ��� �ۼ� (����-Q&amp;A)</label></div></li>
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
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_GLUEMASTER" checked="checked">�޴�����/�� ���� - <strong>GlueMaster</strong></label></div>
					      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMASTER_ADMIN">���� ���� (���� ��б� ����/������Ʈ ����*�Խ��� ����)</label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					  	  <ul class="list-unstyled">
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMASTER_WRITE" checked="checked">�� ���/����</label></div></li>
					  	  	<li>
					  	  		<ul>
					  	  		  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_NOTICE">�� ���/���� (��������)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_QNA" checked="checked">�� ���/���� (Q&amp;A)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_FAQ">�� ���/���� (FAQ)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMASTER_CHECK" name="FUNCTION_GLUEMASTER_WRITE_TECH">�� ���/���� (�������)</label></div></li>
					  	  		</ul>
					  	  	</li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMASTER_REPLY" checked="checked">���� ���� ��� (����)</label></div></li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMASTER_REPLY_BOARD_QNA" checked="checked">������ ���� ��� �ۼ� (����-Q&amp;A)</label></div></li>
					  	  </ul>
					  </div>
				  </div>
			  </div>
			  </div>
			  <div class="col-xs-6">
			  <div class="panel panel-default">
				  <div class="panel-heading">
				      <h5 class="panel-title">
					      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_GLUEMOBILE" checked="checked">�޴�����/�� ���� - <strong>GlueMobile</strong></label></div>
					      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_ADMIN">���� ���� (���� ��б� ����/������Ʈ ����*�Խ��� ����)</label></div>
				      </h5>
				  </div>
				  <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="panel-body">
					  	  <ul class="list-unstyled">
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_WRITE" checked="checked">�� ���/����</label></div></li>
					  	  	<li>
					  	  		<ul>
					  	  		  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_NOTICE">�� ���/���� (��������)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_QNA" checked="checked">�� ���/���� (Q&amp;A)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_FAQ">�� ���/���� (FAQ)</label></div></li>
								  <li><div class="checkbox"><label><input type="checkbox" value="true" id="GLUEMOBILE_CHECK" name="FUNCTION_GLUEMOBILE_WRITE_TECH">�� ���/���� (�������)</label></div></li>
					  	  		</ul>
					  	  	</li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_REPLY" checked="checked">���� ���� ��� (����)</label></div></li>
					  	  	<li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA" checked="checked">������ ���� ��� �ۼ� (����-Q&amp;A)</label></div></li>
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
						      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_UCUBE" checked="checked">�޴�����/�� ���� - <strong>uCUBE</strong></label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_UCUBE_ADMIN">���� ���� (���� ��б� ����/������Ʈ ����*�Խ��� ����)</label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						  	  <ul class="list-unstyled">
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_UCUBE_WRITE" checked="checked">�� ���/����</label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
							  	  		  <li><div class="checkbox"><label><input type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_NOTICE">�� ���/���� (��������)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_QNA" checked="checked">�� ���/���� (Q&amp;A)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_FAQ">�� ���/���� (FAQ)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="UCUBE_CHECK" name="FUNCTION_UCUBE_WRITE_TECH">�� ���/���� (�������)</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_UCUBE_REPLY" checked="checked">���� ���� ��� (����)</label></div></li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_UCUBE_REPLY_BOARD_QNA" checked="checked">������ ���� ��� �ۼ� (����-Q&amp;A)</label></div></li>
						  	  </ul>
						  </div>
					  </div>
				  </div>
			  </div>
		  	  <div class="col-xs-6">
				  <div class="panel panel-default">
					  <div class="panel-heading">
					      <h5 class="panel-title">
						      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_POSBEE" checked="checked">�޴�����/�� ���� - <strong>PosBee</strong></label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_POSBEE_ADMIN">���� ���� (���� ��б� ����/������Ʈ ����*�Խ��� ����)</label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						  	  <ul class="list-unstyled">
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_POSBEE_WRITE" checked="checked">�� ���/����</label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
							  	  		  <li><div class="checkbox"><label><input type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_NOTICE">�� ���/���� (��������)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_QNA" checked="checked">�� ���/���� (Q&amp;A)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_FAQ">�� ���/���� (FAQ)</label></div></li>
										  <li><div class="checkbox"><label><input type="checkbox" value="true" id="POSBEE_CHECK" name="FUNCTION_POSBEE_WRITE_TECH">�� ���/���� (�������)</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_POSBEE_REPLY" checked="checked">���� ���� ��� (����)</label></div></li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_POSBEE_REPLY_BOARD_QNA" checked="checked">������ ���� ��� �ۼ� (����-Q&amp;A)</label></div></li>
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
						      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_MANAGEMENT">�޴����� - <strong>������</strong></label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
					  		  <ul class="list-unstyled">
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" id="MENU_MANAGEMENT_CHECK" name="SUB_MENU_MANAGEMENT_COMPLETE">����޴�/�� ���� ���� - <strong>�Ϸ� ����</strong></label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
						  	  	  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_MANAGEMENT_INPUT_USER">�� ���/����/����</label></div></li>
						  	  	  	  </ul>
						  	  	  </li>
						  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" id="MENU_MANAGEMENT_CHECK" name="SUB_MENU_MANAGEMENT_PROGRESS">����޴�/�� ���� ���� - <strong>������ ����</strong></label></div></li>
						  	  	  <li>
						  	  	  	  <ul>
						  	  	  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_PROGRESS_INPUT_USER">����� ���/����/����</label></div></li>
						  	  	  	  	  <li><div class="checkbox"><label><input type="checkbox" value="true" name="FUNCTION_PROGRESS_COMMENT">Comment ���</label></div></li>
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
						      <div class="checkbox"><label><input type="checkbox" value="true" id="MENU_SOLUTION_UPLOAD" name="MENU_SOLUTION_UPLOAD">�޴����� - <strong>�ַ�� ��Ű�� ����</strong></label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_GLUE">��Ű�� ���/���� (Glue)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_GLUEMASTER">��Ű�� ���/���� (GlueMaster)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE">��Ű�� ���/���� (GlueMobile)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_UCUBE">��Ű�� ���/���� (uCUBE)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_POSBEE">��Ű�� ���/���� (PosBee)</label></div>
						      <div class="checkbox"><label><input type="checkbox" value="true" id="SOLUTION_CHECK" name="FUNCTION_SOLUTION_UPLOAD_ETC">��Ű�� ���/���� (��Ÿ����)</label></div>
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
						      <div class="checkbox"><label><input type="checkbox" value="true" name="MENU_CUSTOMBOARD">�޴�����/�Խ��� ���� - <strong>�ڷ��</strong></label></div>
					      </h5>
					  </div>
					  <div id="collapseOne" class="panel-collapse collapse in">
						  <div class="panel-body">
						      <label style="font-size: 12px; color: gray;">�Խ��� ���� �� �ڷḦ ��� �� �� �ִ� �޴� �Դϴ�.</label>
						  </div>
				 	  </div>
				  </div>
			  </div>
		  	</div>
		  </div>
		
		<br>  
		<div class="col-xs-12 btn-group">
			<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.back();">���</button>
	    	<button type="button" class="btn btn-primary btn-sm" onclick="javascript:confirmCustomUserForm();">���� ����</button>
		</div>
		</div>
	  </div>
</form>
</body>
</html>