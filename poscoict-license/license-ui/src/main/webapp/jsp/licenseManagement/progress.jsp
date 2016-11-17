<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%
	HashMap ct = new HashMap();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="ct" value="<%= ct %>" />
<c:if test="${not empty counting }">
	<c:forEach var="list" items="${counting }">
		<c:set target="${ct }" property="${list.ORDER_STATUS }" value="${list.CT }" />
	</c:forEach>
</c:if>
<style type="text/css">
	.select-wrapper {
		width: 15rem !important;
	}
	span.badge {
		color: white;
	}
</style>
<body>

	<%-- <div style="display:flex;">
		<c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
			<a class="waves-effect waves-light btn" onclick="javascript:page('progressContract');" style="margin-right:1.2rem;">추가<i class="material-icons left">add</i></a>
		</c:if>

		<select class="input-sm" id="progressSelect" name="progressSelect">
			<option selected="selected" value="0">회사명</option>
			<option value="1">프로젝트명</option>
			<security:authorize ifAnyGranted="ROLE_D">
			<option value="2">수주사</option>
			</security:authorize>
		</select>
		<input type="text" onkeydown="javascript:if(event.keyCode == 13){searchProgressCompany();}" style="width: 30%;" id="progressText" name="progressText" >
		<a class="waves-effect waves-light btn" onclick="javascript:searchProgressCompany();">검색<i class="material-icons left">search</i></a>
	</div> --%>

	<div class="" style="display:inline-flex; align-items:baseline;">
		<c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
			<a class="waves-effect waves-light btn" onclick="javascript:page('progressContract');" style="width:8rem; margin-right:1.2rem;">추가</a>
		</c:if>
			<select class="input-sm" id="progressSelect" name="progressSelect">
				<option selected="selected" value="0">회사명</option>
				<option value="1">프로젝트명</option>
				<security:authorize ifAnyGranted="ROLE_D">
				<option value="2">수주사</option>
				</security:authorize>
			</select>
			<input type="text" onkeydown="javascript:if(event.keyCode == 13){searchProgressCompany();}" class="input-sm" id="progressText" name="progressText" placeholder="Search">
			<a class="waves-effect waves-light btn" onclick="javascript:searchProgressCompany();" style="width:8rem;">검색</a>
	</div>
	<div class="divider"></div>
		<h5>진행중인 계약 관리</h5>
			<div class="collection">
		    <a href="#!" onclick="javascript:getSubCategoryList('0');"
					class="collection-item <c:if test="${subCategory=='0' || subCategory==null }">active</c:if>">전체
					<span class="badge grey">${ct.P+ct.C+ct.R+ct.G+ct.F }</span></a>
		    <a href="#!" onclick="javascript:getSubCategoryList('1');"
					class="collection-item <c:if test="${subCategory=='1' }">active</c:if>">진행중
					<span class="badge grey">${ct.P==null?0:ct.P }</span></a>
		    <a href="#!" onclick="javascript:getSubCategoryList('2');"
					class="collection-item <c:if test="${subCategory=='2' }">active</c:if>">등록요청
					<span class="badge grey">${ct.C==null?0:ct.C }</span></a>
		    <a href="#!" onclick="javascript:getSubCategoryList('3');"
					class="collection-item <c:if test="${subCategory=='3' }">active</c:if>">반려
					<span class="badge grey">${ct.C==null?0:ct.R }</span></a>
				<a href="#!" onclick="javascript:getSubCategoryList('4');"
					class="collection-item <c:if test="${subCategory=='4' }">active</c:if>">삭제/완료
					<span class="badge grey">${ct.G+ct.F }</span></a>
		  </div>
			<div class="">
				<c:if test="${empty list }">
					<p class="text-muted">정보가 없습니다.</p>
				</c:if>
				<c:if test="${not empty list }">
					<ul class="list-group">
						<c:forEach var="list" items="${list }" varStatus="status">
						<a href="#" class="list-group-item" onclick="javascript:getProgressInfomation('${list.OBJECT_ID }');">
							<p style="font-size: 13px; color:black;">
								<c:if test="${list.ORDER_STATUS=='P' }">
									<span class="badge blue darken-1 left" style="position:inherit; margin-right:0.5rem;">진행중</span>
								</c:if>
								<c:if test="${list.ORDER_STATUS=='C' }">
									<span class="badge blue darken-1 left" style="position:inherit; margin-right:0.5rem;">등록요청중</span>
								</c:if>
								<c:if test="${list.ORDER_STATUS=='R' }">
									<span class="badge red darken-1 left" style="position:inherit; margin-right:0.5rem;">반려</span>
								</c:if>
								<c:if test="${list.ORDER_STATUS=='G' }">
									<span class="badge red darken-1 left" style="position:inherit; margin-right:0.5rem;">삭제</span>
								</c:if>
								<c:if test="${list.ORDER_STATUS=='F' }">
									<span class="badge blue darken-1 left" style="position:inherit; margin-right:0.5rem;">등록완료</span>
								</c:if>
								회사명: ${list.USER_NAME } <label style="color: #C0CFCB;">|</label>
								프로젝트명: ${list.PROJECT_NAME } <label style="color: #C0CFCB;">|</label> 등록일: ${list.r_CREATION_DATE }
							</p>
						</a>
						</c:forEach>
					</ul>
				</c:if>
			</div>

		<%-- <div class="row">
				<ul class="nav nav-pills visible-xs">
					<li class="<c:if test="${subCategory=='0' || subCategory==null }">disabled</c:if>">
						<a href="#fileList" data-toggle="tab" onclick="javascript:getSubCategoryList('0');">전체
						</a>
					</li>
					<li class="<c:if test="${subCategory=='1' }">disabled</c:if>">
						<a href="#" data-toggle="tab" onclick="javascript:getSubCategoryList('1');">진행중
						</a>
					</li>
					<li class="<c:if test="${subCategory=='2' }">disabled</c:if>">
						<a href="#" data-toggle="tab" onclick="javascript:getSubCategoryList('2');">등록요청
						</a>
					</li>
					<li class="<c:if test="${subCategory=='3' }">disabled</c:if>">
						<a href="#" data-toggle="tab" onclick="javascript:getSubCategoryList('3');">반려
						</a>
					</li>
					<li class="<c:if test="${subCategory=='4' }">disabled</c:if>">
						<a href="#" data-toggle="tab" onclick="javascript:getSubCategoryList('4');">삭제/완료
						</a>
					</li>
				</ul>

			  <ul id="myTab" class="nav nav-tabs hidden-xs">
					<li class="<c:if test="${subCategory=='0' || subCategory==null }">active</c:if>">
						<a href="#fileList" data-toggle="tab" onclick="javascript:getSubCategoryList('0');" style="font-weight: bold;">전체
							<span class="badge">${ct.P+ct.C+ct.R+ct.G+ct.F }</span>
						</a>
					</li>
					<li class="<c:if test="${subCategory=='1' }">active</c:if>">
						<a href="#" data-toggle="tab" onclick="javascript:getSubCategoryList('1');" style="font-weight: bold;">진행중
							<span class="badge">${ct.P==null?0:ct.P }</span>
						</a>
					</li>
					<li class="<c:if test="${subCategory=='2' }">active</c:if>">
						<a href="#" data-toggle="tab" onclick="javascript:getSubCategoryList('2');" style="font-weight: bold;">등록요청
							<span class="badge">${ct.C==null?0:ct.C }</span>
						</a>
					</li>
					<li class="<c:if test="${subCategory=='3' }">active</c:if>">
						<a href="#" data-toggle="tab" onclick="javascript:getSubCategoryList('3');" style="font-weight: bold;">반려
							<span class="badge">${ct.R==null?0:ct.R }</span>
						</a>
					</li>
					<li class="<c:if test="${subCategory=='4' }">active</c:if>">
						<a href="#" data-toggle="tab" onclick="javascript:getSubCategoryList('4');" style="font-weight: bold;">삭제/완료
							<span class="badge">${ct.G+ct.F }</span>
						</a>
					</li>
			  </ul>

			  <div id="myTabContent" class="tab-content">
				<div class="tab-pane fade in active" id="userList">
						<c:if test="${empty list }">
							<br>
							<p class="text-muted">정보가 없습니다.</p>
						</c:if>
						<c:if test="${not empty list }">
							<ul class="list-group">
							<c:forEach var="list" items="${list }" varStatus="status">
							  	<a href="#" class="list-group-item" onclick="javascript:getProgressInfomation('${list.OBJECT_ID }');">
					  					<p style="font-size: 13px;">
								    		<c:if test="${list.ORDER_STATUS=='P' }">
											<button type="button" class="btn btn-primary btn-xs">진행중</button>
											</c:if>
											<c:if test="${list.ORDER_STATUS=='C' }">
											<button type="button" class="btn btn-danger btn-xs">등록요청중</button>
											</c:if>
											<c:if test="${list.ORDER_STATUS=='R' }">
											<button type="button" class="btn btn-warning btn-xs">반려</button>
											</c:if>
											<c:if test="${list.ORDER_STATUS=='G' }">
											<button type="button" class="btn btn-default btn-xs">삭제</button>
											</c:if>
											<c:if test="${list.ORDER_STATUS=='F' }">
											<button type="button" class="btn btn-success btn-xs">등록완료</button>
											</c:if>
											회사명: ${list.USER_NAME } <label style="color: #C0CFCB;">|</label>
											프로젝트명: ${list.PROJECT_NAME } <label style="color: #C0CFCB;">|</label> 등록일: ${list.r_CREATION_DATE }
										</p>
							    </a>
							</c:forEach>
							</ul>
						</c:if>
				</div>
			  </div>
		</div> --%>


	<%-- <script src="${contextPath }/dist/jquery/jquery.min.js"></script> --%>
	<script type="text/javascript">
		// $(document).ready(function () {
		// 	$('ul.tabs').tabs();
		// 	console.log("tab initialized");
		// });
	</script>
</body>
