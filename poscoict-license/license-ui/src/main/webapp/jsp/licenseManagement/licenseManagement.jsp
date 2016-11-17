<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">
	.btn {
		padding: 0 1rem;
		margin: 0 0.2rem;
	}
	span.badge {
		position: inherit;
		color: white;
		/*padding: 0 3px;*/
		/*font-size: 14px;*/
	}
	.select-wrapper input.select-dropdown {
		margin: 0 0.2rem;
	}
</style>
<body>
	<div class="card-panel">
		<div style="display:flex;">
			<c:if test="${userPermission.isFUNCTION_MANAGEMENT_INPUT_USER() }">
				<a class="waves-effect waves-light btn" onclick="javascript:page('newContract');">신규
					<i class="material-icons left">person_add</i>
				</a>
			</c:if>
			<security:authorize ifAnyGranted="ROLE_D,ROLE_S,ROLE_C">
				<a class="waves-effect waves-light btn" onclick="javascript:generateExcel(); return false;">엑셀
					<i class="material-icons left">file_download</i>
				</a>
			</security:authorize>
			<select class="input-sm" id="managementSelect" name="managementSelect">
				<option selected="selected" value="0">회사명</option>
				<option value="1">계약번호</option>
				<security:authorize ifAnyGranted="ROLE_D">
				<option value="2">수주사</option>
				</security:authorize>
			</select>
			<input type="text" style="width: 30%;" onkeydown="javascript:if(event.keyCode == 13){searchCompany();}" id="managementText" name="managementText" placeholder="Search">
			<a class="waves-effect waves-light btn" onclick="javascript:searchCompany();" type="submit">검색
				<i class="material-icons left">search</i>
			</a>
		</div>
		<div class="card-content">
			<c:if test="${not empty list }">
				<c:forEach var="list" items="${list }" varStatus="status">
					<div class="section" style="padding:0.5rem 0;">
						<a href="#" class="list-group-item col-xs-12" onclick="javascript:getInfomation('${list.USER_NO }');" style="color:black;">
							<p>
							<h5><strong>${list.USER_NAME } (${list.PROJECT_NAME })</strong></h5>
								<c:if test="${list.PRODUCT_SETUP_DATE!=null }">
									<span class="badge blue">설치: ${list.PRODUCT_SETUP_DATE==null?'설치안됨':list.PRODUCT_SETUP_DATE }</span>
								</c:if>
								<c:if test="${list.PRODUCT_SETUP_DATE==null }">
									<span class="badge red">설치안됨</span>
								</c:if>
								<strong>계약번호: </strong>${list.USER_NO } / <strong>계약일자: </strong>${list.USER_START_DATE }
								<%-- <span class="badge black">계약번호:</span> ${list.USER_NO } /
								<span class="badge black">계약일자:</span> ${list.USER_START_DATE } --%>
							</p>
						</a>
					</div>
					<div class="divider">
					</div>
				</c:forEach>
			</c:if>
		</div>
	</div>
</body>
