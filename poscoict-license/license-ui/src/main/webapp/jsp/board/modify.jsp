<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<body>

	<form role="form" name="insertModifyBoard" enctype="multipart/form-data">
		<div class="card">
			<div class="card-content">
				<span class="right">
					<a class="waves-effect waves-light btn" onclick="javascript:modifyBoard();">수정</a>
					<a class="waves-effect waves-light btn" onclick="javascript:history.back();">취소</a>
				</span>
				<span class="card-title">게시글 수정</span>

				<div class="section" style="display:flex; align-items:center; padding: 0.5erm 0;">
					<input type="text" class="modify_title" name="modify_title" id="modify_title" value="${board.TITLE }">
					<span id="unopened" style="width:12%; padding-left:10px;">
						<input type="checkbox" id="modify_openFlag" name="modify_openFlag" <c:if test="${board.OPEN_FLAG eq 'N' }">checked</c:if>/>
      			<label for="modify_openFlag">비공개</label>
					</span>
					<%-- <span  style="width:25%;">
						<input type="checkbox" id="modify_openFlag" name="modify_openFlag" <c:if test="${board.OPEN_FLAG eq 'N' }">checked</c:if>/>
      			<label for="modify_openFlag">비공개</label>
					</span> --%>
				</div>

				<div class="section" style="padding:0 0;">
					<textarea class="form-control" rows="20" id="modify_content" name="modify_content" class="modify_content" style="width: 100%;"></textarea>
				</div>

				<div class="section">
					<label for="boardAttach" class="control-label" style="font-size: 13px;">첨부파일 추가</label>
					<input type="file" class="form-control input-sm" name="boardAttach" id="boardAttach" multiple="multiple">

					<%-- 기존 첨부파일 삭제 여부 --%>
					<c:if test="${not empty attachInfo }">
						<c:forEach var="attach" items="${attachInfo }" varStatus="status">
							<div class="checkbox">
								<input type="checkbox" name="deleteFile" id="${status.index+1 }" value="${attach.OBJECT_ID }"/>
  							<label for="${status.index+1 }">삭제 : 첨부파일 ${status.index+1 } - ${attach.ATTACH_FILE_NAME }(${attach.ATTACH_FILE_SIZE }byte)</label>
							</div>
						</c:forEach>
					</c:if>

					<%-- <input type="hidden" name="folder" value="${folder }">
					<input type="hidden" name="subCategory" value="${subCategory }"> --%>
				</div>

				<input type="hidden" name="content_no" value="${board.CONTENT_NO }">
				<input type="hidden" name="folder" value="${folder }">
				<input type="hidden" name="chartNum" value="${chartNum }">
				<input type="hidden" name="select" value="${select }">
				<input type="hidden" name="search" value="${search }">
				<input type="hidden" name="subCategory" value="${board.SUBCATEGORY }">
			</div>
		</div>
	</form>

	<script type="text/javascript" charset="utf-8" src="${contextPath }/dist/se2/js/HuskyEZCreator.js"></script>
	<script src='${contextPath }/dist/multifile/jquery.js' type="text/javascript"></script>
	<script src='${contextPath }/dist/multifile/jquery.form.js' type="text/javascript"></script>
	<script src='${contextPath }/dist/multifile/jquery.MetaData.js' type="text/javascript"></script>
	<script src='${contextPath }/dist/multifile/jquery.MultiFile.js' type="text/javascript"></script>
	<script type="text/javascript">
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "modify_content",
		    sSkinURI: "${contextPath}/dist/se2/SmartEditor2Skin.html",
		    fCreator: "createSEditor2",
		    fOnAppLoad : function(){
				var paramCn = '${board.MAIN_CONTENT }';
				paramCn = replaceAll(paramCn,"</br>","\n");
		        oEditors.getById["modify_content"].exec("PASTE_HTML",[paramCn]);
		    }
		});

		$('#boardAttach').MultiFile({
			max: 10,
			STRING: {
				remove: '<span class="glyphicon glyphicon-trash"></span>'
			}
		});

		function replaceAll(sValue, param1, param2) {
		    return sValue.split(param1).join(param2);
		}
	</script>
</body>
