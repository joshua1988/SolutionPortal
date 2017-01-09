<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">
.btn-flat i {
	vertical-align: bottom;
}
</style>
<body>
<div class="card-panel">
	<div class="section">
		<a class="waves-effect waves-light btn modal-trigger" href="#packageUploadModal"><b><i class="material-icons left">file_upload</i>패키지 등록</b></a>
		<a class="waves-effect waves-light btn modal-trigger" href="#patchUploadModal"><b><i class="material-icons left">file_upload</i>패치 등록</b></a>
	</div>

	<!-- Package List -->
  <div id="myTabContent">
    <div id="fileList">

    </div>
  </div>

	<!-- packageUpload Modal -->
  <div id="packageUploadModal" class="modal">
    <div class="modal-content">
      <h4>패키지 등록</h4>
			<div class="row">
				<form class="col s12" role="form" action="${contextPath }/packageUpload" name="packageUpload" enctype="multipart/form-data" method="post">
					<div class="row">
						<div class="input-field col s3">
							<select name="folderCategory" id="folderCategory" onchange="javascript:optionCheck(this.form);">
								<option value="0" selected="selected">패키지 구분</option>
								<c:if test="${not empty folder }">
									<option value="${folder }">${folder }</option>
								</c:if>
							</select>
						</div>
						<div class="input-field col s9">
							<input type="text" name="packageVersion" id="packageVersion" placeholder="패키지 버젼" class="validate">
						</div>
					</div>
					<div class="row">
						<div class="input-field col s3">
							패키지 파일
						</div>
						<div class="input-field col s9">
							<input type="file" id="packageFile" name="file">
						</div>
					</div>
					<div class="row">
						<div class="input-field col s3">
							부가 설명
						</div>
						<div class="input-field col s9">
							<textarea rows="3" name="comment" id="packageInfo"></textarea>
						</div>
					</div>
					<input type="hidden" name="solutionMode" value="package">
					<input type="hidden" name="mode" value="${mode }">
				</form>
			</div>
    </div>
    <div class="modal-footer">
      <a href="#" class="modal-action modal-close waves-effect waves-green btn-flat"><i class="material-icons left">close</i>닫기</a>
			<a href="#" class="modal-action waves-effect waves-green btn-flat" onclick="javascript:packageUp(); return false;"><i class="material-icons left">file_upload</i>업로드</a>
    </div>
  </div>

	<!-- patchUpload Modal -->
	<div id="patchUploadModal" class="modal">
    <div class="modal-content">
      <h4>패치 등록</h4>
			<div class="row">
				<form class="col s12" action="${contextPath }/patchUpload" name="patchUpload" enctype="multipart/form-data" method="post">
					<div class="row">
						<div class="input-field col s3">
							<select name="folderCategory" id="folderCategory" onchange="javascript:getVersionInfo(this.form);">
								<option value="0" selected="selected">패키지 구분</option>
								<c:if test="${not empty folder }">
									<option value="${folder }">${folder }</option>
								</c:if>
							</select>
						</div>
						<div class="input-field col s9 selectBox">
							<%-- <input type="text" class="" name="packageVersion" id="packageVersion" placeholder="패키지 버젼" class="validate"> --%>
								<%-- <label for="packageVersion"></label> --%>
								<select class="addOption" name="packageVersion" id="packageVersion">
									<option value="999" selected="selected">패키지 버젼</option>
								</select>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s3">
							패키지 파일
						</div>
						<div class="input-field col s9">
							<input type="file" id="packageFile" name="file">
						</div>
					</div>
					<div class="row">
						<div class="input-field col s3">
							부가 설명
						</div>
						<div class="input-field col s9">
							<textarea rows="3" name="comment" id="packageInfo"></textarea>
						</div>
					</div>
					<input type="hidden" name="solutionMode" value="patch">
					<input type="hidden" name="mode" value="${mode}">
				</form>
			</div>
    </div>
    <div class="modal-footer">
      <a href="#" class="modal-action modal-close waves-effect waves-green btn-flat"><i class="material-icons left">close</i>닫기</a>
			<a href="#" class="modal-action waves-effect waves-green btn-flat" onclick="javascript:patchUp(); return false;"><i class="material-icons left">file_upload</i>업로드</a>
    </div>
  </div>
</div>

<script src="${contextPath }/dist/jquery/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	patchList("${mode}");
});
</script>
</body>
