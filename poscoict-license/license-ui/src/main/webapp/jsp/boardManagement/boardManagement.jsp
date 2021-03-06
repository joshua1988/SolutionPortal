<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">
  .dropdown-content {
    width: 150px !important;
  }
</style>
<body>
	<div class="card-panel">
		<div style="display:flex; align-items:center;">
			<h5>게시판 관리</h5>
			<a class="waves-effect waves-light btn modal-trigger" style="margin: 0 0.5em; padding: 0 5px;" href="#board_admin"
				onclick="javascript:createProjectFun('B','root')"><i class="material-icons left">developer_board</i>게시판 생성</a>
		</div>
		<div class="card-content" style="margin: 1em 1em;">
			<c:if test="${empty projectFolders || projectFolders==null }">목록이 없습니다.</c:if>
			<c:if test="${not empty projectFolders && projectFolders!=null }">
				${projectFolders}
			</c:if>
		</div>
		<input type="hidden" id="solution" value="${solution }">
	</div>

	<%-- <h6 class="header">폴더 사용 예시</h6>
	<div class="card horizontal">
		<div class="card-image">
			<img src="${contextPath }/dist/images/folder_structure.png" alt="폴더구조 설명">
		</div>
		<div class="card-stacked">
			<div class="card-content">
				<p>폴더는 총 3depth까지 생성 가능하며 각 폴더에 게시판을 생성 할 수 있습니다.<br>
				이 페이지에서 만들어진 폴더 및 게시판은 현재 각 솔루션 관리자만 볼 수 있습니다.</p>
			</div>
		</div>
	</div> --%>

	<!-- Modal Structure -->
	<div id="board_admin" class="modal">
		<div id="projectFolderContent">

		</div>
	</div>

</body>
