<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<style type="text/css">
	span.badge {
		position: inherit;
		color: white;
		padding: 0 3px;
		font-size: 14px;
	}
	.btn {
		padding: 0 1rem;
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
<body>
	<!-- Custom Board -->
	<div class="card-panel">
		<c:if test="${ empty boardList || boardList == null }">&nbsp;&nbsp;게시물이 없습니다</c:if>

		<c:if test="${not empty boardList && boardList.size()>0 }">
			<table class="bordered responsive-table" style="font-size:14px;">
				<tr>
					<th class="center-align">No.</th>
					<th class="center-align">제목</th>
					<th class="center-align">작성자</th>
					<th class="center-align">시간</th>
					<th class="center-align" style="width:6%;">조회</th>
				</tr>

				<c:forEach items="${boardList }" var="list" varStatus="status">
				<tr style="height:0.1%">
					<td>${list.CONTENT_NO}</td>
					<td style="text-align:left">
						<a href="#" onclick="javascript:cViewPost('${list.BOARD_ID }','${list.CONTENT_NO }','${param.chartNum==null?1:param.chartNum }','${param.search }','${param.select }'); return false;">
							<c:if test="${list.CONTENT_SEQ!=1 }">
								<span class="badge grey darken-3">RE</span>
							</c:if>
							${list.TITLE }
							<c:if test="${sysDate ==  list.r_CREATION_DATE.substring(0,10)}">
								<span class="badge blue darken-3">new</span>
							</c:if>
							<c:if test="${list.REPLY_COUNT > 0 }">
								<b class="black-text">[${list.REPLY_COUNT }]</b>
							</c:if>
						</a>
					</td>
					<td>${list.USER_NAME }</td>
					<td>${list.r_CREATION_DATE.substring(0,19) }</td>
					<td>${list.CLICKS }</td> <!-- 조회수 뒷단에서 가져오지 못함 (원래 로직에 구현 안되어있음) -->
				</tr>
			</c:forEach>
		</table>
	</c:if>
	</div>

	<!-- board page & search -->
  <div class="row">
  	<div class="col s12">
  		<div class="col s4 left-align">
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
      <div class="col s8">
        <div style="display: flex; justify-content: flex-end;">
          <select id="select" name="select">
            <option selected="selected" value="0">제목</option>
            <option value="2">제목+본문</option>
          </select>
          <input type="text" id="text" name="text" style="width:30%; margin-left:5px;" placeholder="Search" onkeydown="javascript:if(event.keyCode == 13){searchList('${folder}','${subCategory }');}">
          <label for="text"></label>
          <a class="waves-effect waves-light btn left-align" style="margin-top: 5px; margin-left:5px; font-size: 14px;" onclick="javascript:cSearchList('${boardId }'); return false;"><i class="material-icons left">search</i>검색</a>
          <a class="waves-effect waves-light btn left-align" style="margin-top: 5px; margin-left:5px; font-size: 14px;" onclick="javascript:getCustomWritingForm('${boardId }'); return false;"><i class="material-icons left">create</i>글쓰기</a>
        </div>
      </div>
    </div>
  </div>

	<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2-jquery.min.js"></script>
</body>
