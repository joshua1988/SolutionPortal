<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">

</style>
<body>

	<div class="card-panel">
		<a class="waves-effect waves-light btn modal-trigger" href="#addOrderCompanyModal"><b><i class="material-icons left">add_circle</i>수주사 추가</b></a>
	</div>

	<c:if test="${not empty orderCompanyList && orderCompanyList.size()>0 }">
		<c:forEach var="list" items="${orderCompanyList }">
			<div class="card-panel">
				<div class="card-header">
					<a class="waves-effect waves-light btn modal-trigger" href="#companyInfoPop" onclick="javascript:orderCompanyInfo('${list.USER_NO }'); return false;"><b>수정</b></a>
					<a class="waves-effect waves-light btn modal-trigger" href="#companyInfoPop" onclick="javascript:initializationPassword('${list.USER_NO }'); return false;"><b>비번초기화</b></a>
				</div>
				<div class="card-content">
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
			</div>
		</c:forEach>
	</c:if>

	<!-- addOrderCompany Modal -->
	<div id="addOrderCompanyModal" class="modal">
    <div class="modal-content">
      <h4>수주사 추가</h4>
			<div class="row">
				<form class="col s12" role="form" action="${contextPath }/addOrderCompany" name="addOrderCompany" method="post">
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
				</form>
			</div>
    </div>
    <div class="modal-footer">
      <a href="#" class="modal-action modal-close waves-effect waves-green btn-flat"><i class="material-icons left">close</i>취소</a>
			<a href="#" class="modal-action waves-effect waves-green btn-flat" onclick="javascript:addOrderCompanyFormCheck(); return false;"><i class="material-icons left">add</i>추가</a>
    </div>
  </div>

	<div id="" class="modal">
	</div>

	<div class="modal" id="companyInfoPop" aria-labelledby="#companyInfoModalLabel"></div>
	<%-- <script src="${contextPath }/dist/jquery/jquery.min.js"></script>
	<script src="${contextPath }/dist/materialize/js/materialize.min.js"></script>
	<script type="text/javascript">
		Materialize.updateTextFields();
	</script> --%>
</body>
