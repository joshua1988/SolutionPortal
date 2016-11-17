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
ul {
	list-style: none;
  	margin-left: -15px;
}
ul li {
	line-height: 30px;
}
</style>
<title>자료실</title>
</head>
<body>
	<div class="well" style="margin: 0 auto 10px; background-color: white;">
		<strong>게시판 관리 - <small>생성/수정/삭제</small></strong>
		<button type="button" onclick="javascript:createProjectFun('F','root')" class="btn btn-default btn-sm" data-toggle="modal" data-target="#projectFolderModal">루트폴더 생성</button>
		<button type="button" onclick="javascript:createProjectFun('B','root')" class="btn btn-default btn-sm" data-toggle="modal" data-target="#projectFolderModal">게시판 생성</button>
	</div>

	<div class="well" style="background-color: white;">
	      <div id="myTabContent" class="tab-content">
	        <div class="tab-pane fade in active" id="fileList">
	            <c:if test="${empty projectFolders || projectFolders==null }">목록이 없습니다.</c:if>
		    	<c:if test="${not empty projectFolders && projectFolders!=null }">
		    	   <div id="asdf">
		    	       ${projectFolders }
		    	   </div>
		    	</c:if>
	        </div>
	      </div>			
	</div>
	
	<input type="hidden" id="solution" value="${solution }">
	
	<div class="row" style="font-size: 12px;">
			<div class="col-xs-12"><p class="text-muted">&nbsp;&nbsp;<span class="glyphicon glyphicon-paperclip"></span> 사용 예</p></div>
			<div class="col-xs-3">
				<div class="well">
				<ul>
					<li><span class="glyphicon glyphicon-asterisk"></span>&nbsp;&nbsp;관리</li>
					<li><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;폴더1
						<ul>
							<li><span class="glyphicon glyphicon-folder-open" style="color: gray;"></span>&nbsp;&nbsp;폴더2
								<ul>
									<li><span class="glyphicon glyphicon-folder-open" style="color: silver;"></span>&nbsp;&nbsp;폴더3
										<ul>
											<li><span class="glyphicon glyphicon-list"></span>&nbsp;&nbsp;게시판1</li>
										</ul>
									</li>
								</ul>
							</li>
						</ul>
						<ul>
							<li><span class="glyphicon glyphicon-list"></span>&nbsp;&nbsp;게시판2</li>
						</ul>
					</li>
					<li><span class="glyphicon glyphicon-list"></span>&nbsp;&nbsp;게시판3</li>
				</ul>
				</div>
			</div>
			<div class="col-xs-9 alert alert-success">
				폴더는 총 3depth까지 생성 가능하며<br><br>
				각 폴더에 게시판을 생성 할 수 있습니다.<br><br>
				이 페이지에서 만들어진 폴더 및 게시판은<br><br>
				현재 각 솔루션 관리자만 볼 수 있습니다.
			</div>
	</div>
	
	<div class="modal fade" id="projectFolderModal" tabindex="-1" role="dialog" aria-labelledby="projectFolderModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content" id="projectFolderContent">
			</div>
		</div>
	</div>
</body>
</html>