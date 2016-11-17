<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<style type="text/css">
  /*nth yet*/

	.flex > * {
		margin: 0 10px;
	}

  .select-wrapper {
    width: 18%;
    margin-left: auto;
  }

  td, th {
    text-align: center;
  }

  span.badge {
    position: inherit;
    color: white;
    padding: 0 3px;
    font-size: 14px;
  }

  @media (max-width:736px) {
    #pageDiv {
      text-align: center;
    }
  }
</style>
<fmt:formatDate var="sysDate" value="<%=new Date() %>" pattern="yyyy/MM/dd"/>
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
<!-- board -->
  <div class="card-panel">
    <c:if test="${empty boardList || boardList == null }">
      <div class="alert alert-success">게시물이 없습니다.</div>
    </c:if>

    <div class="card-content">
    <c:if test="${not empty boardList }">
      <%-- <table class="bordered responsive-table" style="font-size:14px;"> --%>
        <table class="bordered highlight" style="font-size:14px;">
          <tr>
            <th>No.</th>
            <th>제목</th>
            <th>작성자</th>
            <th>시간</th>
            <th style="width:6%;" class="hide-on-small-only">조회</th>
          </tr>
          <c:forEach items="${boardList }" var="list" varStatus="status">
          <tr style="height:0.1%">
            <td>${list.CONTENT_NO}</td>
            <td style="text-align:left">
              <c:if test="${subCategory eq 'NOTICE'}">
                <security:authorize ifAnyGranted="ROLE_D">
                  <c:if test="${list.OD eq 'A' && list.FOLDER_ID eq 'important' }">
                    <a href="#" onclick="javascript:cancelImpo('${list.FOLDER_ID }','${list.CONTENT_NO }');">
                      <span class="glyphicon glyphicon-arrow-down" style="color: red;"></span>
                      (Glyphicon Red arrow down)
                    </a>
                  </c:if>
                  <c:if test="${list.OD eq 'B'}">
                    <a href="#" class="list-group-item text-center col-xs-1 impo" onclick="javascript:setImpo('${list.FOLDER_ID }','${list.CONTENT_NO }');">
                      <span class="glyphicon glyphicon-arrow-up"></span>
                      (Glyphicon Red arrow up)
                    </a>
                  </c:if>
                </security:authorize>
              </c:if>

              <!-- to fix notice link -->
              <c:set var="realFolderId" value="${folder}"/>
              <c:if test="${list.FOLDER_ID eq 'important'}">
                <c:set var="realFolderId" value="notice"/>
              </c:if>
              <!-- folder : ${folder} , list.folder_id : ${list.FOLDER_ID} , realFolderId : ${realFolderId} ,  list.OD : ${list.OD }   , subcate :  ${subCategory}  -->
              <a href="#" class="
                <c:if test="${list.FOLDER_ID eq 'important' && list.OD eq 'A' }">

                </c:if>
                <c:if test="${subCategory eq 'NOTICE' }">
                  <security:authorize ifAnyGranted="ROLE_D"></security:authorize>
                </c:if>"
                onclick="javascript:viewPost( '${realFolderId}','${list.CONTENT_NO }',
                  '${param.chartNum==null?1:param.chartNum }','${param.search }','${param.select }','${subCategory }'); return false;">
                <c:if test="${list.FOLDER_ID eq 'important' && list.OD eq 'A' }">
                  <span class="badge red">필독</span>
                </c:if>
                <c:if test="${list.OPEN_FLAG eq 'N' }">
                  <span class="badge yellow darken-3">비공개</span>
                </c:if>
                <c:if test="${sysDate ==  list.r_CREATION_DATE.substring(0,10)}">
                  <span class="badge blue darken-3">new</span>
                </c:if>
                <c:if test="${list.CONTENT_SEQ!=1 }">
                  <span class="badge grey darken-3"><i class="tiny material-icons">subdirectory_arrow_right</i></span>
                </c:if>
                <!-- 제목 -->
                ${list.TITLE }
                <c:if test="${list.REPLY_COUNT > 0 }">
                  <b class="black-text">[${list.REPLY_COUNT }]</b>
                </c:if>
              </a>
            </td>
            <td>${list.USER_NAME }</td>
            <td>${list.r_CREATION_DATE.substring(2,16) }</td>
            <td class="hide-on-small-only">${list.CLICKS }</td>
          </tr>
          </c:forEach>
        </table>
    </c:if>
    </div>
  </div>

  <a href="text.excel"></a>

  <!-- board page & search -->
  <div class="row">
  	<div class="col s12">
  		<div id="pageDiv" class="col l4 m5 s12 left-align">
  			<ul class="pagination" style="margin-top: 5px;">
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
  		</div>
      <div class="col l8 m7 s12">
        <div style="display: flex;">
          <select id="select" name="select">
            <option selected="selected" value="0">제목</option>
            <option value="1">작성자</option>
            <option value="2">제목+본문</option>
          </select>
          <input type="text" id="text" name="text" style="width:30%; margin-left:5px;" placeholder="Search" onkeydown="javascript:if(event.keyCode == 13){searchList('${folder}','${subCategory }');}">
          <label for="text"></label>
          <a class="waves-effect waves-light btn" style="margin-top: 5px; margin-left:5px;"
            onclick="javascript:searchList('${folder}','${subCategory }'); return false;"><i class="material-icons">search</i></a>
          <a class="waves-effect waves-light btn" style="margin-top: 5px; margin-left:5px;"
            onclick="javascript:getWritingForm('${folder}','${subCategory }')"><i class="material-icons">create</i></a>
        </div>
      </div>
    </div>
  </div>
  <script src="${contextPath }/dist/jquery/jquery.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
    	$('select').material_select();
    });
  </script>
