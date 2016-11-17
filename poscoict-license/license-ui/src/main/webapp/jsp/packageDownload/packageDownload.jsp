<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<style type="text/css">
	td.left-list {
		width: 35%;
		text-align:center;
	}
</style>
<body>
<!-- <div class="row"> -->
<c:if test="${empty map }">
	<label>패키지가 존재 하지 않습니다.</label>
</c:if>
	<c:if test="${not empty map.product && map.product.size()>0 }">
    <c:forEach var="packageL" items="${map.product }">
			<c:if test="${packageL.FILE_CATEGORY != 'etc' }">
				<div class="card-panel">
					<div class="card-content">
						<h5>
		          ${packageL.FILE_CATEGORY }
		          ${packageL.PACKAGE_VERSION }
			      </h5>
						<div class="section">
							<table class="highlight">
								<tbody>
									<tr>
										<td class="left-list">패키지 버전</td>
										<td>${packageL.FILE_CATEGORY } ${packageL.PACKAGE_VERSION }</td>
									</tr>
									<tr>
										<td class="left-list">설명</td>
										<td>${packageL.MAIN_CONTENT }</td>
									</tr>
									<tr>
										<td class="left-list">다운로드(패키지)</td>
										<td>
											<a class="waves-effect waves-light btn" onclick="javascript:fileDownload('pakage','${packageL.OBJECT_ID }')"><i class="material-icons left">file_download</i>다운로드</a>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="divider"></div>
							<c:forEach var="temp" items="${map }">
								<c:if test="${temp.key == packageL.OBJECT_ID }">
									<c:forEach var="patch" items="${temp.value }">
										<table class="highlight">
							        <tbody>
							          <tr>
							            <td class="left-list">버전</td>
							            <td>${patch.MAIN_CONTENT }</td>
							          </tr>
												<tr>
							            <td class="left-list">파일명</td>
							            <td>${patch.PACKAGE_FILE_NAME }</td>
							          </tr>
							          <tr>
													<td class="left-list">다운로드(패키지)</td>
							            <td>
														<a class="waves-effect waves-light btn" onclick="javascript:fileDownload('patch','${patch.OBJECT_ID }')"><i class="material-icons left">file_download</i>다운로드</a>
													</td>
							          </tr>
							        </tbody>
							      </table>
										<div class="divider"></div>
									</c:forEach>
								</c:if>
							</c:forEach>
				    </div>
					</div>
				</div>
			</c:if>
		</c:forEach>
	</c:if>

	<c:if test="${not empty map.product && map.product.size()>0 }">
		<div class="card-panel">
      <h5>기타파일</h5>
	    <div class="section left-align">
		  	<c:forEach var="list" items="${map.product }">
		  		<c:if test="${list.FILE_CATEGORY eq 'etc' }">
						<table class="highlight">
							<tbody>
								<tr>
									<td class="left-list">버전</td>
									<td>${list.MAIN_CONTENT }</td>
								</tr>
								<tr>
									<td class="left-list">파일명</td>
									<td>${list.PACKAGE_VERSION }</td>
								</tr>
								<tr>
									<td class="left-list">다운로드</td>
									<td>
										<a class="waves-effect waves-light btn" onclick="javascript:fileDownload('pakage','${list.OBJECT_ID }')"><i class="material-icons left">file_download</i>다운로드</a>
									</td>
								</tr>
							</tbody>
						</table>
		  		</c:if>
				</c:forEach>
			</div>
	  </div>
	</c:if>
</body>
