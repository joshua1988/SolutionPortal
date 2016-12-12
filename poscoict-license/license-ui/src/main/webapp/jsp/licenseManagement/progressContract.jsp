<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<body>
	<form class="form-horizontal" role="form" name="addProgressContract" action="${contextPath }/addProgressContract" method="post">

		<div class="card-panel">
			<div class="card-header" style="padding-bottom:1rem;">
				<span class="right">
					<a class="waves-effect waves-light btn" onclick="javascript:addProgressUser();"><i class="material-icons left">add_circle</i>등록</a>
					<a class="waves-effect waves-light btn" onclick="javascript:history.back();"><i class="material-icons left">backspace</i>취소</a>
				</span>
				<h5>고객 정보</h5>
					상태: <span style="color: #8B8BCC;">진행중</span>
			</div>
			<div class="card-content">
				<div class="panel-body" id="addContract">
					<%-- <c:if test="${not empty user }"> --%>
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">business</i>
								<input id="USER_NAME" name="USER_NAME" type="text" class="validate" >
								<label for="USER_NAME">회사명</label>
							</div>
							<div class="input-field col s6">
								<i class="material-icons prefix">content_paste</i>
								<input id="PROJECT_NAME" name="PROJECT_NAME" type="text" class="validate" >
								<label for="PROJECT_NAME">프로젝트명</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s12">
								<i class="material-icons prefix">place</i>
								<input id="USER_ADDRESS" name="USER_ADDRESS" type="text" class="validate" >
								<label for="USER_ADDRESS">회사주소</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">account_circle</i>
								<input id="MANAGER_NAME" name="MANAGER_NAME" type="text" class="validate" >
								<label for="MANAGER_NAME">담당자</label>
							</div>
							<div class="input-field col s6">
								<i class="material-icons prefix">phone</i>
								<input id="MANAGER_OFFICE_PHON" name="MANAGER_OFFICE_PHON" type="text" class="validate" >
								<label for="MANAGER_OFFICE_PHON">전화번호</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">phone_iphone</i>
								<input id="MANAGER_CEL_PHON" name="MANAGER_CEL_PHON" type="text" class="validate" >
								<label for="MANAGER_CEL_PHON">휴대번호</label>
							</div>
							<div class="input-field col s6">
								<i class="material-icons prefix">email</i>
								<input id="MANAGER_EMAIL" name="MANAGER_EMAIL" type="email" class="validate" >
								<label for="MANAGER_EMAIL" data-error="이메일 형식을 준수하세요" data-success="올바른 이메일입니다">이메일</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s6">
								<i class="material-icons prefix">today</i>
                <input type="date" class="datepicker" id="startDatepicker2" name="USER_START_DATE">
                <label for="startDatepicker2">계약일자</label>
							</div>
							<div class="input-field col s6">
								<select class="browser-default" name="PRODUCT_FILE_ID" id="PRODUCT_FILE_NAME">
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
				</div>
			</div>
		</div>

		<div class="card-panel" style="margin-top:1rem;">
			<div class="card-content">
				<div>
						<div class="input-field" style="display:flex;">
		          <i class="material-icons prefix">comment</i>
		          <input id="COMMENT" name="COMMENT" type="text" class="validate">
		          <label for="COMMENT">Comment</label>
		        </div>
				</div>
			</div>
		</div>
		
	</form>
</body>
