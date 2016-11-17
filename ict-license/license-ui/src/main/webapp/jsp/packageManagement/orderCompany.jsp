<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">
.form-group {
	margin-bottom: 0;
}
.form-group label{
	font-size: 12px;
}
</style>
<title>Insert title here</title>
</head>
<body>
		<div class="well" style="margin: 0 auto 10px; background-color: white;">
			<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#addOrderCompanyModal"><b>수주사 추가</b></button>
		</div>

		<div class="well" style="background-color: white;">
			<c:if test="${not empty orderCompanyList && orderCompanyList.size()>0 }">	
				<c:forEach var="list" items="${orderCompanyList }">
					<div class="panel panel-default">
					    <div class="panel-heading">
					      <h4 class="panel-title">
					      	  <div class="btn-group">
					      	  <button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#companyInfoPop" onclick="javascript:orderCompanyInfo('${list.USER_NO }'); return false;">수정</button>
					      	  <button type="button" class="btn btn-default btn-xs" data-toggle="modal" data-target="#companyInfoPop" onclick="javascript:initializationPassword('${list.USER_NO }'); return false;">비번초기화</button>
					          </div>
					      </h4>
					    </div>
					    <div id="collapseOne" class="panel-collapse collapse in">
						  
						  <div class="panel-body table-responsive">
							
							<table class="table">
								<thead>
									<tr>
										<th><span style="color: black;">수주사명</span></th>
										<th><span style="color: black;">ID</span></th>
										<th><span style="color: black;">담당자</span></th>
										<th><span style="color: black;">전화번호</span></th>
										<th><span style="color: black;">휴대번호</span></th>
										<th><span style="color: black;">이메일</span></th>
									</tr>
								</thead>
								<tbody>
								<tr>
									<td>${list.COMPANY_NAME }</td>
									<td>${list.USER_NO }</td>
									<td>${list.MANAGER_NAME }</td>
									<td>${list.MANAGER_OFFICE_PHON==''?'없음':list.MANAGER_OFFICE_PHON }</td>
									<td>${list.MANAGER_CEL_PHON==''?'없음':list.MANAGER_CEL_PHON }</td>
									<td>${list.MANAGER_EMAIL==''?'없음':list.MANAGER_EMAIL }</td>
								</tr>
								</tbody>
							</table>
							
						  </div>
					    </div>
					</div>
				</c:forEach>
			</c:if>
	
	<!-- addOrderCompany Modal -->
	<div class="modal fade" id="addOrderCompanyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	        <h4 class="modal-title"><strong>수주사 추가</strong></h4>
	      </div>
	      <div class="modal-body">
			<form class="form-horizontal" role="form" action="${contextPath }/addOrderCompany" method="post" name="addOrderCompany">
				<div class="form-group has-error">
				  <label class="control-label" for="USER_NO">* 아이디</label>
				  <input type="text" class="form-control" id="USER_NO" name="USER_NO">
				</div>
				<div class="form-group has-error">
				  <label class="control-label" for="USER_NAME">* 수주사명</label>
				  <input type="text" class="form-control" id="USER_NAME" name="USER_NAME">
				</div>
				<div class="form-group has-success">
				  <label class="control-label" for="MANAGER_NAME">담당자</label>
				  <input type="text" class="form-control" id="MANAGER_NAME" name="MANAGER_NAME">
				</div>
				<div class="form-group has-success">
				  <label class="control-label" for="USER_ADDRESS">회사주소</label>
				  <input type="text" class="form-control" id="USER_ADDRESS" name="USER_ADDRESS">
				</div>
				<div class="form-group has-success">
				  <label class="control-label" for="MANAGER_OFFICE_PHON">전화번호</label>
				  <input type="text" class="form-control" id="MANAGER_OFFICE_PHON" name="MANAGER_OFFICE_PHON">
				</div>
				<div class="form-group has-success">
				  <label class="control-label" for="MANAGER_CEL_PHON">휴대번호</label>
				  <input type="text" class="form-control" id="MANAGER_CEL_PHON" name="MANAGER_CEL_PHON">
				</div>
				<div class="form-group has-success">
				  <label class="control-label" for="MANAGER_EMAIL">이메일</label>
				  <input type="text" class="form-control" id="MANAGER_EMAIL" name="MANAGER_EMAIL">
				</div>
			</form>	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" onclick="javascript:addOrderCompanyFormCheck(); return false;">추가</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->		
</div>

<div class="modal fade" id="companyInfoPop" tabindex="-1" role="dialog" aria-labelledby="#companyInfoModalLabel" aria-hidden="true"></div>
<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2.js"></script>
</body>
</html>