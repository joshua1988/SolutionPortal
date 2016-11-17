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
<!-- <div class="row"> -->
		<div class="well" style="margin: 0 auto 10px; background-color: white;">
			<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#packageUploadModal"><b>패키지 등록</b></button>
			<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#patchUploadModal"><b>패치 등록</b></button>
		</div>

		<div class="well" style="background-color: white;">
		      <div id="myTabContent" class="tab-content">
		        <div class="tab-pane fade in active" id="fileList">
	          
		        </div>
		      </div>			
		</div>
	
	<!-- packageUpload Modal -->
	<div class="modal fade" id="packageUploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	        <h4 class="modal-title"><strong>패키지 등록</strong></h4>
	      </div>
	      
	      <div class="modal-body">
			<form class="form-horizontal" role="form" action="${contextPath }/packageUpload" name="packageUpload" enctype="multipart/form-data" method="post">
			  <div class="form-group">
			    <label class="col-xs-3 control-label">패키지 구분</label>
			    <div class="col-xs-9">
			      	<select class="input-sm" name="folderCategory" id="folderCategory" onchange="javascript:optionCheck(this.form);" style="width: 100%;">
			      		<option value="0" selected="selected">선 택</option>
						<c:if test="${not empty folder }">
						<option value="${folder }">${folder }</option>
						</c:if>
					</select>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="packageVersion" class="col-xs-3 control-label">패키지 버젼</label>
			    <div class="col-xs-9">
			      <input type="text" class="form-control" name="packageVersion" id="packageVersion" placeholder="패키지 버젼">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="packageFile" class="col-xs-3 control-label">패키지 파일</label>
			    <div class="col-xs-9">
			      <input type="file" class="form-control" id="packageFile" name="file">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="packageInfo" class="col-xs-3 control-label">부가 설명</label>
			    <div class="col-xs-9">
			      <textarea rows="3" class="form-control" name="comment" id="packageInfo" style="resize: none;"></textarea>
			    </div>
			  </div>
			  <input type="hidden" name="solutionMode" value="package">
			  <input type="hidden" name="mode" value="${mode }">
			</form>	        
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="javascript:packageUp(); return false;">
	        	<span class="glyphicon glyphicon-open"></span> &nbsp;upload
	        </button>
	      </div>
	      
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<!-- patchUpload Modal -->
	<div class="modal fade" id="patchUploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	        <h4 class="modal-title"><strong>패치 등록</strong></h4>
	      </div>
	      <div class="modal-body">
			<form class="form-horizontal" role="form" action="${contextPath }/patchUpload" enctype="multipart/form-data" method="post" name="patchUpload">
			  <div class="form-group">
			    <label class="col-xs-3 control-label">패키지 구분</label>
			    <div class="col-xs-9">
			      	<select class="input-sm" name="folderCategory" id="folderCategory" onchange="javascript:getVersionInfo(this.form);" style="width: 100%;">
						<option value="0" selected="selected">선 택</option>
						<c:if test="${not empty folder }">
						<c:if test="${folder != 'etc' }">
						<option value="${folder }">${folder }</option>
						</c:if>
						</c:if>
					</select>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="packageVersion" class="col-xs-3 control-label">패키지 버젼</label>
			    <div class="col-xs-9">
			      	<select class="input-sm addOption" name="packageVersion" id="packageVersion" style="width: 100%;">
						<option value="0" selected="selected">선 택</option>
					</select>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="packageFile" class="col-xs-3 control-label">패키지 파일</label>
			    <div class="col-xs-9">
			      <input type="file" class="form-control" id="packageFile" name="file">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="packageInfo" class="col-xs-3 control-label">부가 설명</label>
			    <div class="col-xs-9">
			      <textarea rows="3" class="form-control" name="comment" id="packageInfo" style="resize: none;"></textarea>
			    </div>
			  </div>
			  <input type="hidden" name="solutionMode" value="patch">
			  <input type="hidden" name="mode" value="${mode }">
			</form>	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="javascript:patchUp(); return false;">upload</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->		
<!-- </div> -->

<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2.js"></script>
<script type="text/javascript">
$(function(){
	patchList("${mode}");	
});
</script>
</body>
</html>