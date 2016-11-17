<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<%-- <script src="${contextPath }/dist/js/file.js"></script> --%>
<style type="text/css">
	td.left-list {
		width: 35%;
		text-align:center;
	}
</style>
<body>

	<c:if test="${empty packageList && solutionMode eq 'package' }">
		패키지가 존재 하지 않습니다.
	</c:if>

	<c:if test="${not empty packageList && packageList.size()>0 }">
		<c:forEach var="packageL" items="${packageList }">
			<div class="card-panel">
	      <h5>
      	  <c:if test="${packageL.FILE_CATEGORY != 'etc' }">
          ${packageL.FILE_CATEGORY }
          </c:if>
          ${packageL.PACKAGE_VERSION }
	      </h5>
				<div class="divider"></div>
		    <div class="section left-align">
					<table class="highlight">
						<tbody>
							<tr>
								<td class="left-list">패키지 버전</td>
								<td>${packageL.FILE_CATEGORY } ${packageL.PACKAGE_VERSION } (${packageL.r_CREATION_DATE })</td>
							</tr>
							<tr>
								<td class="left-list">설명</td>
								<td>${packageL.MAIN_CONTENT }</td>
							</tr>
							<tr>
								<td class="left-list">등록자</td>
								<td>${packageL.USER_NAME }</td>
							</tr>
							<tr>
								<td class="left-list">다운로드(패치)</td>
								<td>
									<form class="">
										<a class="waves-effect waves-light btn" onclick="javascript:fileDownload2('pakage','${packageL.OBJECT_ID }'); return false;"><i class="material-icons left">file_download</i>다운로드</a>
										<a class="waves-effect waves-light btn" onclick="javascript:deletePackage('package','${packageL.OBJECT_ID }','${mode }'); return false;"><i class="material-icons left">delete_forever</i>삭제</a>
										<input name="group${packageL.OBJECT_ID}" class="with-gap" onclick="<c:if test="${packageL.GUEST_OPEN=='N' }">javascript:openPackage('${packageL.OBJECT_ID }','${packageL.GUEST_OPEN }','${mode }'); return false;</c:if>"
											type="radio" id="test1_${packageL.OBJECT_ID}" <c:if test="${packageL.GUEST_OPEN=='Y' }">checked</c:if>/>
							      <label for="test1_${packageL.OBJECT_ID}">공개</label>
							      <input name="group${packageL.OBJECT_ID}" class="with-gap" onclick="<c:if test="${packageL.GUEST_OPEN=='Y' }">javascript:openPackage('${packageL.OBJECT_ID }','${packageL.GUEST_OPEN }','${mode }'); return false;</c:if>"
											type="radio" id="test2_${packageL.OBJECT_ID}" <c:if test="${packageL.GUEST_OPEN=='N' }">checked</c:if>/>
										<label for="test2_${packageL.OBJECT_ID}">비공개</label>
									</form>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="divider"></div>
					<c:if test="${not empty patchList && patchList.size()>0 }">
						<c:forEach var="patch" items="${patchList }" varStatus="status">
							<table class="highlight">
								<c:if test="${packageL.OBJECT_ID eq patch.P_OBJECT_ID }">
					        <tbody>
					          <tr>
					            <td class="left-list">패치 파일명</td>
					            <td>${patch.PACKAGE_FILE_NAME } (${patch.r_CREATION_DATE })</td>
					          </tr>
					          <tr>
					            <td class="left-list">설명</td>
					            <td>${patch.MAIN_CONTENT }</td>
					          </tr>
					          <tr>
					            <td class="left-list">다운로드(패치)</td>
					            <td>
												<a class="waves-effect waves-light btn" onclick="javascript:fileDownload2('patch','${patch.OBJECT_ID }'); return false;"><i class="material-icons left">file_download</i>다운로드</a>
												<a class="waves-effect waves-light btn" onclick="javascript:deletePatch('patch','${patch.OBJECT_ID }','${mode }'); return false;"><i class="material-icons left">delete_forever</i>삭제</a>
											</td>
					          </tr>
					        </tbody>
								</c:if>
				      </table>
							<!-- 쿼리에 오류가 있어 Glue FW3 호출시, 공백 데이터가 10번 정도 호출되어 선이 이상하게 짙어짐 -->
							<%-- <div class="divider"></div> --%>
						</c:forEach>
						<%-- <c:forEach var="patch" items="${patchList }" varStatus="status">
							<c:if test="${packageL.OBJECT_ID eq patch.P_OBJECT_ID }">
								<dl class="dl-horizontal">
								  <dt>패치 파일명</dt>
								  <dd>${patch.PACKAGE_FILE_NAME } (${patch.r_CREATION_DATE })</dd>
								  <dt>설명</dt>
								  <dd>${patch.MAIN_CONTENT }</dd>
								  <dt>다운로드(패치)</dt>
								  <dd>
								  	<button type="button" class="btn btn-success btn-xs" onclick="javascript:fileDownload2('patch','${patch.OBJECT_ID }'); return false;">
								  		<span class="glyphicon glyphicon-download-alt"></span> &nbsp;다운로드
								  	</button>
								  	<button type="button" class="btn btn-danger btn-xs" onclick="javascript:deletePatch('patch','${patch.OBJECT_ID }','${mode }'); return false;">
								  		<span class="glyphicon glyphicon-trash"></span> &nbsp;삭제
								  	</button>
								  </dd>
								</dl>
							</c:if>
						</c:forEach> --%>
					</c:if>
		    </div>
			</div>
		</c:forEach>
	</c:if>

	<div class="modal fade" id="companyInfoPop" tabindex="-1" role="dialog" aria-labelledby="#companyInfoModalLabel" aria-hidden="true"></div>
</body>
