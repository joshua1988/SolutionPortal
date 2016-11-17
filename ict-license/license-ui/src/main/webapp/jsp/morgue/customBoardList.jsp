<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>        
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<style type="text/css">
.impo {
	border: 0; 
	border-top: 1px solid #dddddd;
}
a.impo:hover {
	background-color: white;
}
.impo:first-child {
	border-top: 0;
}
.list-group-item.noticeImpo,
.list-group-item.noticeImpo:focus {
  z-index: 2;
  background-color: #e7e7e7;
  border-color: #e7e7e7;
}
.list-group-item.noticeImpo:hover {
  background-color: #DBDBDB;
  border-color: #DBDBDB;
}
</style>
<fmt:formatDate var="sysDate" value="<%=new Date() %>" pattern="yyyy-MM-dd"/>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:choose>
	<c:when test="${empty param.chartNum}">
		<c:set var="startChartNum" value="1"/>
	</c:when>
	<c:otherwise>
		<c:set var="temp" value="${param.chartNum mod 5 }"/>
		<c:if test="${temp == 0 }">
			<c:set var="startChartNum" value="${param.chartNum-4 }" />
		</c:if>
		<c:if test="${temp == 1 }">
			<c:set var="startChartNum" value="${param.chartNum }" />
		</c:if>
		<c:if test="${temp > 1 }">
			<c:set var="startChartNum" value="${param.chartNum - temp +1 }"/>
		</c:if>	
		<c:remove var="temp"/>
	</c:otherwise>
</c:choose>
<title>게시판</title>
</head>
<body>	
<!-- 		<div class="row">	 -->
<div>
	<div><label style="color: gray;">&nbsp; 자료실 &gt; ${boardName }</label></div>
		<div class="row">
			<div class="col-xs-12 ">
				<div class="col-xs-6 text-right"></div>
			<!--<ul class="pagination" style="margin-top: 5px;">
				<c:if test="${startChartNum >= 6 }">
  					<li onclick="javascript:jumpPage('${folder }','prev','${totalPage }','${search==null?null:search }','${select==null?null:select }','${subCategory }')">
  						<a href="#">«</a>
  					</li>
  				</c:if>
  				<c:forEach begin='${startChartNum }' end='${startChartNum+4>=totalPage?totalPage:startChartNum+4 }' step="1" varStatus="status">
  					<li class="<c:if test="${status.index eq chartNum }">active</c:if>">
  						<a href="#" onclick="javascript:movePage('${status.index }','${folder }','${search==null?null:search }','${select==null?null:select }','${subCategory }')" class="listNo chart${status.index }">${status.index }</a>
  					</li>
  				</c:forEach>
  				<c:if test="${totalPage > startChartNum+4 }">
  					<li onclick="javascript:jumpPage('${folder }','next','${totalPage }','${search==null?null:search }','${select==null?null:select }','${subCategory }')">
  						<a href="#">»</a>
  					</li>
  				</c:if>
			</ul>
		</div> -->
		<!--<div class="col-xs-6 text-right">  
		    <div class="navbar-form" role="search" style="border: 0;">
			    <select class="input-sm1" id="select1" name="select1">
				  <option selected="selected" value="0">제목</option>
				  <option value="1">작성자</option>
				  <option value="2">제목+본문</option>
				</select>

				<input type="text" id="text1" name="text1" class="input-sm1" placeholder="Search" onkeydown="javascript:if(event.keyCode == 13){searchList('${folder}','${subCategory }');}">
				<div class="btn-group">
				<button type="button" class="btn btn-default btn-sm" onclick="javascript:cSearchList1('${boardId }'); return false;">검색</button>
				<button type="button" class="btn btn-info btn-sm" onclick="javascript:getCustomWritingForm('${boardId }'); return false;">글쓰기</button>
				</div>
		    </div>-->
	    </div>
	</div>
</div>
			<div class="list-group">
				<c:if test="${ empty boardList || boardList == null }">&nbsp;&nbsp;게시물이 없습니다</c:if>
				
				<c:if test="${not empty boardList && boardList.size()>0 }">
				<table class="table" width="100%"></div>
		<tr>
		 <th>No.</th>
		 <th>제목</th>
		 <th>작성자</th>
		 <th>시간</th>
		 <th>조회</th>
		</tr>
				<c:forEach items="${boardList }" var="list" varStatus="status">
		<tr>
		   <td width="40px">
		     <font class="text-muted">${list.CONTENT_NO}</font>
		   </td>
		   <td style="text-align:left">
		   
				  <a href="#" class="list-group-item" onclick="javascript:cViewPost('${list.BOARD_ID }','${list.CONTENT_NO }','${param.chartNum==null?1:param.chartNum }','${param.search }','${param.select }'); return false;">
					  <p style="line-height: 1; font-size: 15px;">
					<c:if test="${list.CONTENT_SEQ!=1 }">					
					 <font class="text-primary"><b>└</b></font><span class="label label-default">RE</span>
				</c:if><!-- 제목 -->		
				 ${list.TITLE } 
				<c:if test="${sysDate ==  list.r_CREATION_DATE.substring(0,10)}">
					<span class="label label-info">new</span>
				</c:if>		
						<c:if test="${list.REPLY_COUNT > 0 }">
				<!-- span class="badge pull-right" style="background-color: #725EE0">${list.REPLY_COUNT }</span -->
						<font class="text-primary"><b>[${list.REPLY_COUNT }]</b></font>
						</c:if>	
						
					  </p>
				 </a>
					  
		    </td>
			<td width="20px"><small>${list.USER_NAME }</small></td>
			<td width="150px">			
			 <small>${list.r_CREATION_DATE.substring(0,19) }</small>
			</td>
			<td width="30px">					
			 <small>${list.CLICKS }</small>
		    </td>
		</tr>
			
				</c:forEach>
		</table>
		</c:if>	
</div>				
<!-- 		</div> -->
		<!-- 		<div class="row"> -->
			<div class="row">
				<div class="col-xs-6 text-right">
					<ul class="pagination" style="margin-top: 5px;">
						<c:if test="${startChartNum >= 6 }">
		  					<li onclick="javascript:cJumpPage('${boardId }','prev','${totalPage }','${search==null?null:search }','${select==null?null:select }')">
		  						<a href="#">«</a>
		  					</li>
		  				</c:if>
		  				<c:forEach begin='${startChartNum }' end='${startChartNum+4>=totalPage?totalPage:startChartNum+4 }' step="1" varStatus="status">
		  					<li class="<c:if test="${status.index eq chartNum }">active</c:if>">
		  						<a href="#" onclick="javascript:cMovePage('${status.index }','${boardId }','${search==null?null:search }','${select==null?null:select }')" class="listNo chart${status.index }">${status.index }</a>
		  					</li>
		  				</c:forEach>
		  				<c:if test="${totalPage > startChartNum+4 }">
		  					<li onclick="javascript:cJumpPage('${boardId }','next','${totalPage }','${search==null?null:search }','${select==null?null:select }')">
		  						<a href="#">»</a>
		  					</li>
		  				</c:if>
					</ul>
				</div>
				<div class="col-xs-6 text-right">  
				    <div class="navbar-form" role="search" style="border: 0; margin-left: -40px;">
					    <select class="input-sm" id="select" name="select">
						  <option selected="selected" value="0">제목</option>
						  <option value="2">제목+본문</option>
						</select>
		
						<input type="text" id="text" name="text" class="input-sm" placeholder="Search" onkeydown="javascript:if(event.keyCode == 13){cSearchList('${boardId }');}">
						<div class="btn-group">
						<button type="button" class="btn btn-default btn-sm" onclick="javascript:cSearchList('${boardId }'); return false;">검색</button>
						<button type="button" class="btn btn-info btn-sm" onclick="javascript:getCustomWritingForm('${boardId }'); return false;">글쓰기</button>
						</div>
				    </div>
			    </div>
			</div>
<!-- 		</div> -->
		
		

<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2-jquery.min.js"></script>
<!-- 		</div> -->
</body>
</html>