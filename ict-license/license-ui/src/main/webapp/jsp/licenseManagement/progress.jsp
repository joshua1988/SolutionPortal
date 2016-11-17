<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%
	HashMap ct = new HashMap();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">
.form-group{margin-bottom: 2px;}
</style>
<c:set var="ct" value="<%= ct %>" />
<c:if test="${not empty counting }">
<c:forEach var="list" items="${counting }">
	<c:set target="${ct }" property="${list.ORDER_STATUS }" value="${list.CT }" />
</c:forEach>
</c:if>
<title>Insert title here</title>
</head>
<body>
<!-- <div class="container"> -->
	<div class="well" style="background-color: white; border: 0;">
		<div class="row">
			<c:if test="${userPermission.isFUNCTION_PROGRESS_INPUT_USER() }">
			<button type="button" class="btn btn-success btn-sm" onclick="javascript:page('progressContract');">추가</button>
			</c:if>
		    <select class="input-sm" id="progressSelect" name="progressSelect">
			  <option selected="selected" value="0">회사명</option>
			  <option value="1">프로젝트명</option>
			  <security:authorize ifAnyGranted="ROLE_D">
			  <option value="2">수주사</option>
			  </security:authorize>
			</select>
			<input type="text" onkeydown="javascript:if(event.keyCode == 13){searchProgressCompany();}" class="input-sm" id="progressText" name="progressText" placeholder="Search">
			<button type="button" class="btn btn-info btn-sm" onclick="javascript:searchProgressCompany();">검색</button>
		</div>
		
		<hr>
		
		<div class="row">
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
		</div>
	</div>
<!-- </div>	 -->
</body>
</html>