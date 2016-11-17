<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<title>자료실</title>
</head>
<body>
	<div class="well" style="margin: 0 auto 10px; background-color: white;">
		<strong>자료실 관리 - <small>생성/수정/삭제</small></strong> &nbsp; (일반유져는 볼 수 없습니다.)
		<button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#createBoardModal">자료실 생성</button>
	</div>

	<div class="well" style="background-color: white;">
	      <div id="myTabContent" class="tab-content">
	        <div class="tab-pane fade in active" id="fileList">
	          <c:if test="${empty customBoardList || customBoardList==null }">목록이 없습니다.</c:if>
		    	<c:if test="${not empty customBoardList && customBoardList.size()>0 }">
		    	   <c:forEach items="${customBoardList }" var="list" varStatus="status">
		    	   
		    	   	<div class="well" style="margin: 0 auto 10px;">
		    	   		<div class="row">
			    	   		<div class="col-xs-1">
						    	<button type="button" class="btn btn-warning btn-sm" onclick="javascript:deleteCustomBoard('${list.BOARD_ID}'); return false;"><strong>삭제</strong></button>		    	   		
			    	   		</div>
			    	   		<div class="col-xs-3">
			    	   			<p><strong>${list.BOARD_NAME }</strong></p>
			    	   		</div>
			    	   		<div class="col-xs-8">
								<div class="input-group input-group-sm">
							      <span class="input-group-btn">
							        <button class="btn btn-default" type="button" onclick="javascript:renameCustomBoard('${list.BOARD_ID}', '${status.index }'); return false;"><strong>이름수정</strong></button>
							      </span>
							      <input type="text" class="form-control" id="inputName${status.index }">
							    </div>
			    	   		</div>
		    	   		</div>
					</div>
				   </c:forEach>
		    	</c:if>
	        </div>
	      </div>			
	</div>

	<!-- createBoardModal -->
	<div class="modal fade" id="createBoardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	        <h4 class="modal-title"><strong>게시판 생성</strong></h4>
	      </div>
	      
	      <div class="modal-body">
			<form class="form-horizontal" role="form" action="${contextPath }/createCustomBoard" name="createCustomBoard" method="post">
			  <div class="form-group">
			    <label class="col-xs-3 control-label">게시판 명</label>
			    <div class="col-xs-9">
					<input type="text" class="form-control" name="boardName" id="boardName" placeholder="게시판 명">
			    </div>
			  </div>
			</form>	        
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="javascript:createBoardC();">생성</button>
	      </div>
	      
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->		
</body>
</html>