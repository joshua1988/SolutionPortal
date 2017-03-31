<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<script type="text/javascript">
// function addProduct() {
// 	var no = $(".contract1").length;
// 	$("#plus").append(
// 		'<div class="well well-sm contract1">'+
// 		'<div class="form-group"><label class="control-label">제품구분</label>'+
// 		'<c:if test="${not empty file }"><select class="form-control input-sm" name="PRODUCT_FILE_ID['+no+']"><c:forEach var="file" items="${file }"><c:if test="${file.FILE_CATEGORY != \'etc\' }"><option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option></c:if></c:forEach></select></c:if>'+
// 		'</div><div class="form-group"><label class="control-label">제품키</label>'+
// 		'<input class="form-control input-sm license'+no+'" type="text" name="LICENSE_KEY['+no+']"></div>'+
// 		'<div class="form-group"><label class="control-label">수량</label>'+
// 		'<select class="form-control input-sm" name="LICENSE_QUANTITY" id="LICENSE_QUANTITY['+no+']"><c:forEach begin="1" end="100" step="1" varStatus="status">'+
// 		'<option value="${status.index }">${status.index }</option></c:forEach></select></div>'+
// 		'<div class="form-group"><label class="control-label">라이센스파일 :: <input type="checkbox" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'">'+
// 		'<small style="color: gray;">라이센스 파일이 필요 없을 시 체크</small></label>'+
// 		'<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'">'+
// 		'<input type="file" class="form-control input-sm file'+no+'" name="file['+no+']"></div>'+
// 		'</div>'
// 	);
// }



// function fileCheck(no){
// 	var ischecked = $(".fileCheck"+no).is(":checked");
// 	if(ischecked){
// 		$(".file"+no).attr("disabled","disabled");
// 		$(".fileCheckVal"+no).val("true");
// 	}else{
// 		$(".file"+no).removeAttr("disabled");
// 		$(".fileCheckVal"+no).val("false");
// 	}
// }
</script>
<style type="text/css">
@media (min-width:800px) {
	.btnGroup {
		padding-top:5px;
	}
}
</style>
<body>
	<form class="form-horizontal" role="form" name="addContract" action="${contextPath }/addContract" method="post" enctype="multipart/form-data">
		<div class="card-panel">
			<div class="card-header">
				<span class="right">
					<a class="waves-effect waves-light btn" onclick="javascript:addUser();">등록
						<i class="material-icons left">add_circle</i>
					</a>
					<a class="waves-effect waves-light btn" onclick="javascript:history.back();">취소
						<i class="material-icons left">clear</i>
					</a>
				</span>
				<h5>고객정보</h5>
			</div>
			<div class="card-content">
				<div class="panel-body" id="addContract">
					<div class="row">
		        <div class="input-field col s6">
							<i class="material-icons prefix">filter_7</i>
							<input id="USER_NO" name="USER_NO" type="text" class="validate" required>
		          <label for="USER_NO">계약번호</label>
		        </div>
		        <div class="input-field col s6">
							<i class="material-icons prefix">business</i>
		          <input id="USER_NAME" name="USER_NAME" type="text" class="validate" required>
		          <label for="USER_NAME">회사명</label>
		        </div>
		      </div>
		      <div class="row">
		        <div class="input-field col s12">
							<i class="material-icons prefix">place</i>
		          <input id="USER_ADDRESS" name="USER_ADDRESS" type="text" class="validate">
		          <label for="USER_ADDRESS">회사주소</label>
		        </div>
		      </div>
		      <div class="row">
		        <div class="input-field col s4">
							<i class="material-icons prefix">content_paste</i>
		          <input id="PROJECT_NAME" name="PROJECT_NAME" type="text" class="validate">
		          <label for="PROJECT_NAME">프로젝트명</label>
		        </div>
						<div class="input-field col s4">
							<i class="material-icons prefix">account_circle</i>
							<input id="MANAGER_NAME" name="MANAGER_NAME"  type="text" class="validate">
							<label for="MANAGER_NAME">담당자</label>
						</div>
						<div class="input-field col s4">
							<i class="material-icons prefix">phone</i>
							<input id="MANAGER_OFFICE_PHON" name="MANAGER_OFFICE_PHON" type="text" class="validate">
							<label for="MANAGER_OFFICE_PHON">전화번호</label>
						</div>
		      </div>
					<div class="row">
		        <div class="input-field col s4">
							<i class="material-icons prefix">phone_iphone</i>
		          <input id="MANAGER_CEL_PHON" name="MANAGER_CEL_PHON" type="text" class="validate">
		          <label for="MANAGER_CEL_PHON">휴대번호</label>
		        </div>
						<div class="input-field col s4">
							<i class="material-icons prefix">email</i>
							<input id="MANAGER_EMAIL" name="MANAGER_EMAIL" type="email" class="validate">
							<label for="MANAGER_EMAIL" data-error="이메일 형식을 준수하세요" data-success="올바른 이메일입니다">이메일</label>
						</div>
						<div class="input-field col s4">
							<%-- <label>수주사</label> --%>
				    	<c:if test="${not empty company }">
				      	<select id="ORDER_COMPANY_CODE" name="ORDER_COMPANY_CODE">
									<option disabled selected value="">수주사 선택</option>
				      		<c:forEach var="company" items="${company }">
							  		<option value="${company.COMPANY_CODE }">${company.COMPANY_NAME }</option>
						  		</c:forEach>
								</select>
							</c:if>
						</div>
		      </div>
		      <div class="row">
		        <div class="input-field col s6">
							<i class="material-icons prefix">event_note</i>
							<%-- <input type="text" id="startDatepicker" class="form-control" placeholder="계약일자" name="USER_START_DATE"> --%>
              <input type="date" class="datepicker" id="startDatepicker" name="USER_START_DATE">
              <label for="startDatepicker">계약일자</label>
		        </div>
						<div class="input-field col s6">
							<i class="material-icons prefix">event_note</i>
							<%-- <input type="text" id="setUpDatepicker" class="form-control" placeholder="제품설치일자" name="PRODUCT_SETUP_DATE"> --%>
							<input type="date" class="datepicker" id="setUpDatepicker" name="PRODUCT_SETUP_DATE">
							<label for="setUpDatepicker">제품설치일자</label>
						</div>
		      </div>
			  </div>
			</div>
		</div>

		<div class="card-panel">
			<div class="card-header">
				<h5>기타파일 선택</h5>
			</div>
			<div class="card-content">
				<c:if test="${not empty file }">
					<c:forEach var="list" items="${file }">
						<c:if test="${list.FILE_CATEGORY eq 'etc' }">
							<div class="">
								<input type="checkbox" id="${list.OBJECT_ID }" value="${list.OBJECT_ID }" name="etcFile" />
								<label class="black-text" for="${list.OBJECT_ID }">
									<i class="material-icons" style="vertical-align:top;">attachment</i>
									<%-- ${list.FILE_CATEGORY } --%>
									<strong>${list.PACKAGE_VERSION }</strong> ${list.MAIN_CONTENT }
								</label>
							</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
		</div>

		<div class="card-panel">
			<div class="card-header">
				<span class="right">
					<a class="waves-effect waves-light btn" onclick="javascript:addProduct(); return false;"><i class="material-icons left">add</i>추가</a>
					<a class="waves-effect waves-light btn" onclick="javascript:newRomoveProduct(); return false;"><i class="material-icons left">remove</i>제거</a>
				</span>
				<h5>제품등록</h5>
			</div>
			<div class="card-content" id="plus">
				<a class="waves-effect waves-light btn modal-trigger" href="#productRegisterModal"><i class="material-icons left">add</i>추가</a>
				<%-- <div class="row contract1">
					<div class="col s6">
						제품구분
						<c:if test="${not empty file }">
							<select class="" name="PRODUCT_FILE_ID['+no+']">
								<c:forEach var="file" items="${file }">
									<c:if test="${file.FILE_CATEGORY != etc }">
										<option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option>
									</c:if>
								</c:forEach>
							</select>
						</c:if>
					</div>
					<div class="col s6">
						제품키
						<input type="text" value="license'+no+'" name="LICENSE_KEY['+no+']">
					</div>
				</div>
				<div class="row">
					<div class="col s6">
						수량
						<select id="selectedNum" name="LICENSE_QUANTITY">
							<c:forEach begin="1" end="10" step="1" varStatus="status">
								<option value="${status.index }">${status.index }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col s6">
						라이센스 파일
						<input type="checkbox" class="filled-in" id="filledIn" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'" checked="checked"/>
						<label for="filledIn">Filled in</label>
						<input type="file" class="file'+no+'" name="file['+no+']">
						<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'">
					</div>
				</div> --%>
			</div>
		</div>

		<!-- Modal Structure -->
	 	<%-- <div id="productRegisterModal" class="modal modal-fixed-footer">
			<div class="modal-content">
				<h5>제품등록</h5>
				<tbody>
			 		<tr>
			 			<td>제품구분</td>
						<td id="productFileId">
							<c:if test="${not empty file }">
								<select class="" id="PRODUCT_FILE_ID" name="PRODUCT_FILE_ID['+no+']">
								<select class="" id="PRODUCT_FILE_ID">
									<c:forEach var="file" items="${file }">
										<c:if test="${file.FILE_CATEGORY != etc }">
											<option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option>
										</c:if>
									</c:forEach>
								</select>
							</c:if>
						</td>
			 		</tr>
					<tr>
						<td>제품키</td>
						<td>
							<input type="text" id="LICENSE_KEY" value="license'+no+'" name="LICENSE_KEY['+no+']">
							<input class="license" type="text" id="LICENSE_KEY" value="">
						</td>
					</tr>
					<tr>
						<td>수량</td>
						<td id="quantity">
							<select id="selectedNum" name="LICENSE_QUANTITY">
								<c:forEach begin="1" end="10" step="1" varStatus="status">
									<option value="${status.index }">${status.index }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>라이센스 파일</td>
						<td>
							<input type="checkbox" class="filled-in" id="filledIn" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'" checked="checked"/>
							<label for="filledIn">Filled in</label>
							<input type="file" class="file'+no+'" name="file['+no+']">
							<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'">
						</td>
					</tr>
			 	</tbody>
			</div>
			<div class="modal-footer">
				<a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat" onclick="javascript:addProductToList();">등록</a>
				<a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">취소</a>
			</div>
	 	</div> --%>

		<script type="text/javascript">
			function addProductToList() {
				var PRODUCT_FILE_ID = $("#PRODUCT_FILE_ID :selected").text();
				var LICENSE_KEY = $("#LICENSE_KEY").val();
				var LICENSE_QUANTITY = $("#selectedNum :selected").text();

				// addProduct(PRODUCT_FILE_ID, LICENSE_KEY, LICENSE_QUANTITY);
				$("#select1").material_select();
				$("#select2").material_select();
			}

			function addProduct() {
				var no = $(".contract1").length;

				// <div class="row contract1">
				// 	<div class="col s6">
				// 		제품구분
				// 			<select class="" name="PRODUCT_FILE_ID['+no+']">
				// 				<option value=""></option>
				// 			</select>
				// 	</div>
				// 	<div class="col s6">
				// 		제품키
				// 		<input type="text" value="" name="LICENSE_KEY['+no+']">
				// 	</div>
				// </div>
				// <div class="row">
				// 	<div class="col s6">
				// 		수량
				// 		<select id="selectedNum" name="LICENSE_QUANTITY">
				// 			<option value=""></option>
				// 		</select>
				// 	</div>
				// 	<div class="col s6">
				// 		라이센스 파일
				// 		<input type="checkbox" class="filled-in" id="filledIn" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'" checked="checked"/>
				// 		<label for="filledIn">Filled in</label>
				// 		<input type="file" class="file'+no+'" name="file['+no+']">
				// 		<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'">
				// 	</div>
				// </div>

				$("#plus").append(
					'<div class="contract1" style="margin:15px 15px;">'+
					'<div class="row">'+
						'<div class="col s6">'+
							'제품구분'+
							'<c:if test="${not empty file }">'+
								'<select class="" name="PRODUCT_FILE_ID['+no+']">'+
									'<c:forEach var="file" items="${file }">'+
										'<c:if test="${file.FILE_CATEGORY != etc }">'+
											'<option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option>'+
										'</c:if>'+
									'</c:forEach>'+
								'</select>'+
							'</c:if>'+
						'</div>'+
						'<div class="col s6">'+
							'제품키'+
							'<input type="text" class="license'+no+'" value="license'+no+'" name="LICENSE_KEY['+no+']">'+
						'</div>'+
					'</div>'+
					'<div class="row">'+
						'<div class="col s6">'+
							'수량'+
							'<select id="selectedNum" name="LICENSE_QUANTITY">'+
								'<c:forEach begin="1" end="10" step="1" varStatus="status">'+
									'<option value="${status.index }">${status.index }</option>'+
								'</c:forEach>'+
							'</select>'+
						'</div>'+
						'<div class="col s6">'+
							'라이센스 파일'+
							'<input type="checkbox" class="filled-in" id="filledIn" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'" checked="checked"/>'+
							'<label for="filledIn">라이센스 없을 시 체크</label>'+
							'<input type="file" class="file'+no+'" name="file['+no+']">'+
							'<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'">'+
						'</div>'+
					'</div>'+
					'</div>'


					// '<div class="row contract1">'+
					// 	'<div class="col s6">'+
					// 		'제품구분'+
					// 			'<select id="select1" class="" name="PRODUCT_FILE_ID['+no+']">'+
					// 				'<option value="'+PRODUCT_FILE_ID+'">'+PRODUCT_FILE_ID+'</option>'+
					// 			'</select>'+
					// 	'</div>'+
					// 	'<div class="col s6">'+
					// 		'제품키'+
					// 		'<input type="text" value="'+LICENSE_KEY+'" name="LICENSE_KEY['+no+']">'+
					// 	'</div>'+
					// '</div>'+
					// '<div class="row">'+
					// 	'<div class="col s6">'+
					// 		'수량'+
					// 		'<select id="select1" name="LICENSE_QUANTITY">'+
					// 			'<option value="'+LICENSE_QUANTITY+'">'+LICENSE_QUANTITY+'</option>'+
					// 		'</select>'+
					// 	'</div>'+
					// 	'<div class="col s6">'+
					// 		'라이센스 파일'+
					// 		'<input type="checkbox" class="filled-in" id="filledIn" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'" checked="checked"/>'+
					// 		'<label for="filledIn">Filled in</label>'+
					// 		'<input type="file" class="file'+no+'" name="file['+no+']">'+
					// 		'<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'">'+
					// 	'</div>'+
					// '</div>'



					// '<div class="well well-sm contract1">'+
					// '<div class="form-group"><label class="control-label">제품구분</label>'+
					// '<c:if test="${not empty file }"><select class="form-control input-sm" name="PRODUCT_FILE_ID['+no+']"><c:forEach var="file" items="${file }"><c:if test="${file.FILE_CATEGORY != \'etc\' }"><option value="${file.OBJECT_ID }">${file.FILE_CATEGORY } ${file.PACKAGE_VERSION }</option></c:if></c:forEach></select></c:if>'+
					// '</div><div class="form-group"><label class="control-label">제품키</label>'+
					// '<input class="form-control input-sm license'+no+'" type="text" name="LICENSE_KEY['+no+']"></div>'+
					// '<div class="form-group"><label class="control-label">수량</label>'+
					// '<select class="form-control input-sm" name="LICENSE_QUANTITY" id="LICENSE_QUANTITY['+no+']"><c:forEach begin="1" end="100" step="1" varStatus="status">'+
					// '<option value="${status.index }">${status.index }</option></c:forEach></select></div>'+
					// '<div class="form-group"><label class="control-label">라이센스파일 :: <input type="checkbox" onclick="javascript:fileCheck('+no+');" class="fileCheck'+no+'">'+
					// '<small style="color: gray;">라이센스 파일이 필요 없을 시 체크</small></label>'+
					// '<input type="hidden" name="CHECKBOX['+no+']" value="false" class="fileCheckVal'+no+'">'+
					// '<input type="file" class="form-control input-sm file'+no+'" name="file['+no+']"></div>'+
					// '</div>'
				);

				$("select").material_select();
			}
		</script>

	</form>
</body>
