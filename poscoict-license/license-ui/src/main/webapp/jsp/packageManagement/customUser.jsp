<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<body>

	<div class="card-panel">
		<a class="waves-effect waves-light btn" onclick="javascript:page('addCustomUserForm'); return false;"><b><i class="material-icons left">file_upload</i>커스텀 유져 생성</b></a>
	</div>

	<div class="card-panel">
		<c:if test="${empty list && list.size()<1 }">
			<label style="font-size: 13px; color: gray;">정보가 존재 하지 않습니다.</label>
		</c:if>
		<c:if test="${not empty list && list.size()>0 }">
			<c:forEach var="list" items="${list }">
				<div class="card-panel">
			    <div class="card-header">
	      	  <div class="btn-group">
		      	  <button type="button" class="btn btn-info btn-xs" onclick="javascript:getCustomUserInfo('${list.USER_NO }'); return false;">보기/수정</button>
		      	  <button type="button" class="btn btn-default btn-xs" onclick="javascript:initializationPassword('${list.USER_NO }'); return false;">비번초기화</button>
	          </div>
			    </div>
			    <div id="collapseOne" class="panel-collapse collapse in">
					  <div class="card-content">
							<table>
								<thead>
									<tr>
										<th><span style="color: black;">유저명</span></th>
										<th><span style="color: black;">ID</span></th>
										<th><span style="color: black;">담당자</span></th>
										<th><span style="color: black;">전화번호</span></th>
										<th><span style="color: black;">휴대번호</span></th>
										<th><span style="color: black;">이메일</span></th>
									</tr>
								</thead>
								<tbody>
								<tr>
									<td>${list.USER_NAME }</td>
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
	</div>

</body>
