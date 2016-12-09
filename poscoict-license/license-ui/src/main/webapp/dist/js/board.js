function testdd(){
	boardList($("#ddd").val());
}

//네비게이터 페이지 숫자 선택시 처리
function movePage(num, folder, sear, sel, cate){
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","board");

	document.body.appendChild(form);
	var param1 = createEl("chartNum", num);
	var param2 = createEl("folder", folder);
	var param3 = createEl("subCategory",cate);

	if(sear != null){
		var param4 = createEl("search", sear);
		var param5 = createEl("select", sel);
		form.appendChild(param4);
		form.appendChild(param5);
	}

	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);
	form.submit();
}

//네비게이터 10페이지씩 이동, 맨처음, 맨끝 이동
function jumpPage(folder, mode, totalPage, sear, sel, subCate){
	var chart;
	if(mode == 'next'){
		chart = $(".listNo:last").text();
		chart = Number(chart)+1;
	}else if(mode == 'prev'){
		chart = $(".listNo:first").text();
		if(chart != 1){
			chart = Number(chart)-5;
		}
	}else if(mode == 'first'){
		chart = $(".listNo:first").text();
		if(chart != 1){
			chart = 1;
		}
	}else if(mode == 'last'){
		chart = totalPage;
	}else{
		return false;
	}

	var form = createFormPost();
	document.body.appendChild(form);
	var param1 = createEl("chartNum", chart);
	var param2 = createEl("folder", folder);
	var param3 = createEl("subCategory",subCate);

	if(sear != null){
		var param4 = createEl("search", sear);
		var param5 = createEl("select", sel);
		form.appendChild(param4);
		form.appendChild(param5);
	}

	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);
	form.submit();
}

function attachFileDown(id){
	var form = document.createElement("form");
	document.body.appendChild(form);
	form.setAttribute("method","post");
	form.setAttribute("action","attachFileDown");

	var objectId = createEl("objectId", id);
	form.appendChild(objectId);
	form.submit();
}

//게시물 보기
function viewPost(folder, connum, num, sear, sel, subCate){
	var url = "permissionCheck";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{category: folder, contentNo: connum},
		success: function(data){
			if(data=='permission'){
				alertPopup("게시물 보기 권한이 없습니다.");
			}else if(data=='fail'){
				var inst = permissionCheckPopup(folder, connum, num, sear, sel, subCate);
				inst.open();
			}else if(data=='success'){
				getBoardInfo(folder, connum, num, sear, sel, subCate);
			}else if(data=='secret'){
				alertPopup("비밀글로 설정된 게시물입니다.");
			}
		}
	});
}



function replyBoardOnNewPage (folder, contentNo, chartNum) {
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","replyBoardOnNewPage");
	document.body.appendChild(form);

	var param1 = createEl("folder", folder);
	var param2 = createEl("contentNo", contentNo);
	var param3 = createEl("chartNum", chartNum);

	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);

	form.submit();
}



function permissionCheckPopup(folder, connum, num, sear, sel, subCate){
	var temp2=
			'<div class="well">'+
			'<div class="input-group input-group-sm has-warning" style="magin-left: 10%; magin-right: 10%;">'+
			'<span class="input-group-addon">임시ID</span>'+
			'<input type="text" class="form-control" id="guestID" name="guestID" placeholder="guest ID">'+
			'</div><br>'+
			'<div class="input-group input-group-sm has-warning" style="magin-left: 10%; magin-right: 10%;">'+
			'<span class="input-group-addon">임시PW</span>'+
			'<input type="password" class="form-control" id="guestPW" name="guestPW" placeholder="guest PW">'+
			'</div><br>'+
			'<button class="remodal-cancel" onclick="javascript:$.remodal.lookup[$(\'[data-remodal-id=modal]\').data(\'remodal\')].close();">Cancel</button>'+
		    '<button type="button" class="remodal-confirm" onclick="javascript:guestPermissionCheck(\''+folder+'\',\''+connum+'\',\''+num+'\',\''+sear+'\',\''+sel+'\',\''+subCate+'\'); return false;">check</button>'+
			'</div>';

	$(".remodal").empty();
	$(".remodal").append(temp2);

	var inst = $.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')];
	return inst;
}

function guestPermissionCheck(folder, connum, num, sear, sel, subCate){
	var url = "guestPermissionCheck";
	var guestID = document.getElementById("guestID").value.replace(/\s/g, "");
	var guestPW = document.getElementById("guestPW").value.replace(/\s/g, "");
	if(guestID==""||guestPW==""){
		alertPopup("ID 및 PW를 입력해주세요.");
		return false;
	}
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{category: folder, contentNo: connum, guestID: guestID, guestPW: guestPW},
		success: function(data){
			if(data=='N'){
				alertPopup("임시아이디 또는 패스워드가 일치 하지 않습니다.");
			}else{
				$.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close();
				getBoardInfo(folder, connum, num, sear, sel, subCate);
			}
		}
	});
}

function guestModifyForm(folder, connum, num, sear, sel, subCate){
	var url = "guestPermissionCheck";
	var guestID = document.getElementById("guestID").value.replace(/\s/g, "");
	var guestPW = document.getElementById("guestPW").value.replace(/\s/g, "");

	if(guestID==""||guestPW==""){
		// alertPopup("ID 및 PW를 입력해주세요.");
		alert("ID 및 PW를 입력해주세요.");
		// return false;
	} else {
		jQuery.ajax({
			type:"POST",
			url:url,
			data:{category: folder, contentNo: connum, guestID: guestID, guestPW: guestPW},
			success: function(data){
				if(data=='N'){
					console.log("modify data : ",data);
					alert("임시아이디 또는 패스워드가 일치 하지 않습니다.");
					// return false;
				} else{
					modifyForm(folder, connum, num, sear, sel, subCate);
				}
			}
		});
	}

}

function getBoardInfo(folder, connum, num, sear, sel, subCate){
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","viewPost");
	document.body.appendChild(form);
//	var param1 = createEl("oriFolderId", oriId);
	var param2 = createEl("folder", folder);
	var param3 = createEl("contentNo", connum);
	var param4 = createEl("chartNum", num);
	var param5 = createEl("subCategory", subCate);

	if(sear != null || sear != ""){
		var param6 = createEl("search", sear);
		var param7 = createEl("select", sel);
		form.appendChild(param6);
		form.appendChild(param7);
	}

//	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);
	form.appendChild(param4);
	form.appendChild(param5);

	form.submit();
}



function permissionCheckFormOff(){
	$("#passwordPop").fadeOut();
	e.preventDefault();
	$("#passwordPop").remove();
}

function cmtList(no, folder) {
	var url = "replyList";

	// contentType: false,
	// processData: false,
	// dataType: "xml/html/script/json",
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{contentNo:no, folder:folder},
		success: function(data){
			// console.log("before data : ", data);
			// var data = new FormData(data);
			// console.log("after data : ", data);
			$("#reply").empty();
			$("#reply").append(data);
		}
	});
}

function insertReply(folder, contentNo, subCategory){
	var content = document.getElementById("replyText").value.replace(/\s/g, "");
//	var guestReplyId = $("#guest").val();
//	console.log("guestReplyId : "+guestReplyId);

	if(checkBytes(content) > 1000){
		alertPopup("글자 수가 1000byte를 넘었습니다.");
		return false;
	}
	if(content == ""){
		alertPopup("덧글을 작성 해주세요.");
		return false;
	}
	content = document.getElementById("replyText").value;
	var url = "insertReply";
    $.post(url, {
									folder:folder,
			    		 		contentNo:contentNo,
									subCategory:subCategory,
			           	mainContent:encodeURIComponent(content)
			           	//	게스트 이름 변경후 댓글
//									guestReplyId: guestReplyId
								}, function(data){
	            		// 내용 비우기
	                $('#replyText').val('');
	                // 입력이 완료가 됐으므로 다시 리스트 불러오기
	                cmtList(contentNo, folder);
	                alertPopup("덧글이 등록 되었습니다.");
		            });
}

function deleteReply(folder, reContentNo, contentNo){
	var url = "deleteReply";
	var inst = confirmPopup("삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		$.post(url, {
				folder:folder,
				reContentNo:reContentNo,
				contentNo:contentNo
			},
			function(data){
				cmtList(contentNo, folder);
			});
		$.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close();
	});
}

function checkBytes(expression){
 var VLength=0;
 var temp = expression;
 var EscTemp;
 if(temp!="" & temp !=null)
 {
  for(var i=0;i<temp.length;i++)
  {
   if (temp.charAt(i)!=escape(temp.charAt(i)))
   {
    EscTemp=escape(temp.charAt(i));
    if (EscTemp.length>=6)
     VLength+=3;
    else
     VLength+=1;
   }
   else
    VLength+=1;
  }
 }
 return VLength;
}

//게시물 목록 가져오기
function boardList(list){
	saveLocalStoragy(localId);

	var form = createFormPost();
	document.body.appendChild(form);
	var input_id = createEl("category",list);
	form.appendChild(input_id);

	form.submit();
}

//카테고리 별 게시물 목록 가져오기
function boardList(folder, subCate, localId){
	// Logo 클릭시 트리 초기화
	sessionStorage.clear();
	if (folder == "notice") {
		sessionStorage.setItem("treeActiveKey", "notice");
		sessionStorage.setItem("navActiveKey", "Navnotice");
		console.log("folder is notice");
	}

	var form = createFormPost();
	document.body.appendChild(form);
	//input
	var input_id = createEl("folder",folder);
	var subCategory = createEl("subCategory",subCate);

	form.appendChild(input_id);
	form.appendChild(subCategory);

	form.submit();
}

function createFormPost(){
	var form = document.createElement("form");
	form.setAttribute("method","POST");
	form.setAttribute("action","board");
	return form;
}

function createEl(name, value){
	var input_id = document.createElement("input");
	input_id.setAttribute("type", "hidden");
	input_id.setAttribute("name", name);
	input_id.setAttribute("value", value);

	return input_id;
}

//게시물 삭제
function deleteBoard(folder, contNo, sear, sel, num, subcate){
	var inst = confirmPopup("게시물을 삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		deleteAction(folder, contNo, sear, sel, num, subcate);
	});
}

function modifyForm(folder, no, chart, sear, sel, subCate){
	// disable button

	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","modifyBoardForm");

	document.body.appendChild(form);

//	var param1 = createEl("oriFolderId", oriId);
	var param2 = createEl("contentNo", no);
	var param3 = createEl("folder", folder);
	var param4 = createEl("search", sear);
	var param5 = createEl("select", sel);
	var param6 = createEl("subCategory", subCate);
	var param7 = createEl("chartNum", chart);

//	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);
	form.appendChild(param4);
	form.appendChild(param5);
	form.appendChild(param6);
	form.appendChild(param7);

	form.submit();
}

function deleteAction(folder, contNo, sear, sel, num, subcate){
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","deleteBoard");
	document.body.appendChild(form);
	//input
	var param1 = createEl("subCategory", subcate);
	var param2 = createEl("folder", folder);
	var param3 = createEl("contentNo", contNo);
	var param4 = createEl("chartNum",num);
	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);
	form.appendChild(param4);

	if(sear != null || sear != ""){
		var param5 = createEl("search", sear);
		var param6 = createEl("select", sel);
		form.appendChild(param5);
		form.appendChild(param6);
	}
	form.submit();
}

function adminDeleteBoard(folder, contNo, sear, sel, num, subcate){
	var inst = confirmPopup("관리자 권한:강제로 게시물을 삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
					guestDeleteAction(folder, contNo, sear, sel, num, subcate);
	});
}

function guestDeleteBoard(folder, contNo, sear, sel, num, subcate){
	var inst = confirmPopup("게시물을 삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		guestDeleteConfirmPopup(folder, contNo, sear, sel, num, subcate);

		// if(guestID==""||guestPW==""){
		// 	guestDeleteConfirmPopup("ID 및 PW를 입력해주세요.");
		// 	return false;
		// }
		//
		// jQuery.ajax({
		// 	type:"POST",
		// 	url:url,
		// 	data:{category: folder, contentNo: contNo, guestID: guestID, guestPW: guestPW},
		// 	success: function(data){
		// 		if(data=='N'){
		// 			alertPopup("임시아이디 또는 패스워드가 일치 하지 않습니다.");
		// 			return false;
		// 		}else{
		// 			guestDeleteAction(folder, contNo, sear, sel, num, subcate);
		// 		}
		// 	}
		// });
	});
//	if(confirm("삭제 하시겠습니까?")==true)
//		guestDeleteAction(category, contNo, sear, sel, num);
}

function guestDeleteRequest (folder, contNo, sear, sel, num, subcate) {
	// body...
	var url = "guestPermissionCheck";
	var guestID = document.getElementById("guestID").value.replace(/\s/g, "");
	var guestPW = document.getElementById("guestPW").value.replace(/\s/g, "");

	console.log("guestID : "+guestID);
	console.log("guestPW : "+guestPW);

	console.log("folder, contNo, sear, sel, num, subcate : ", folder, contNo, sear, sel, num, subcate);

	if(guestID==""||guestPW==""){
		alert("ID 및 PW를 입력해주세요.");
	} else {
		jQuery.ajax({
			type:"POST",
			url:url,
			data:{category: folder, contentNo: contNo, guestID: guestID, guestPW: guestPW},
			success: function(data){
				if(data=='N'){
					alert("임시아이디 또는 패스워드가 일치 하지 않습니다.");
					return false;
				}else{
					guestDeleteAction(folder, contNo, sear, sel, num, subcate);
				}
			}
		});
	}
}

function guestDeleteAction(folder, contNo, sear, sel, num, subcate){
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","deleteBoard");
	document.body.appendChild(form);
	//input
	var param1 = createEl("subCategory", subcate);
	var param2 = createEl("folder", folder);
	var param3 = createEl("contentNo", contNo);
	var param4 = createEl("chartNum",num);
	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);
	form.appendChild(param4);

	if(sear != null || sear != ""){
		var param5 = createEl("search", sear);
		var param6 = createEl("select", sel);
		form.appendChild(param5);
		form.appendChild(param6);
	}

	// console.log(obj);
	form.submit();
}

//게시판 검색기능
function searchList(men, cate){
	var temp = document.getElementById("text").value.replace(/\s/g, "");

	if(temp == "" || temp.length <= 1){
		alertPopup("두 글자 이상 입력해 주세요");
		return;
	}

	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","board");

	document.body.appendChild(form);
	var choose = document.getElementById("select").value;
	var text = document.getElementById("text").value;

	var category = createEl("folder", men);
	var search = createEl("search", text);
	var select = createEl("select", choose);
	var subCategory = createEl("subCategory",cate);
	form.appendChild(category);
	form.appendChild(search);
	form.appendChild(select);
	form.appendChild(subCategory);
	form.submit();
}

//글쓰기 폼
function getWritingForm(folder, subCategory){
	var url="boardPermissionCheck";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{folder: folder, subCategory: subCategory},
		success: function(data){
			if(data=='fail'){
				alertPopup("글쓰기 권한이 없습니다.");
			}else{
				var form = document.createElement("form");
				form.setAttribute("method","post");
				form.setAttribute("action","writing");
				document.body.appendChild(form);
				var param1 = createEl("folder", folder);
				var param2 = createEl("subCategory", subCategory);
				form.appendChild(param1);
				form.appendChild(param2);
				form.submit();
			}
		}
	});
}

function guestWriteSubmit(){
	if(document.getElementById("guestID").value.replace(/\s/g, "")=="" || document.getElementById("guestPW").value.replace(/\s/g, "")==""){
		alertPopup("임시 아이디와 패스워드를 입력해 주세요.");
		return;
	}

	writeSubmit2();
}

function writeSubmit2(){
	var title = document.getElementById("WRITE_TITLE").value.replace(/\s/g, "");
//	var subCategory = document.getElementById("subCategory").value;
	if(title == ""){
		alertPopup("제목을 작성해 주세요.");
		$(".WRITE_TITLE").focus();
		return;
	}
//	if(subCategory == 'notice' && category != 'notice'){
//		alertPopup("소분류를 선택해 주세요.");
//		return;
//	}
	oEditors.getById["WRITE_MAIN_CONTENT"].exec("UPDATE_CONTENTS_FIELD", [ ]);
	var content = document.getElementById("WRITE_MAIN_CONTENT").value.replace(/\s/g, "");
	if(content == "" || content == "<br>"){
		alertPopup("본문을 작성해 주세요.");
		$(".WRITE_MAIN_CONTENT").focus();
		return;
	}

	document.write_frm.submit();
}

function modifyBoard(){
	var form = document.insertModifyBoard;
	form.setAttribute("method","post");
	form.setAttribute("action","modifyBoard");
	var title = document.getElementById("modify_title").value.replace(/\s/g, "");

	oEditors.getById["modify_content"].exec("UPDATE_CONTENTS_FIELD", [ ]);
	var content = document.getElementById("modify_content").value.replace(/\s/g, "");
	if(content == ""){
		alert("본문을 작성해 주세요.");
		$(".modify_content").focus();
		return;
	}
	if(title == "" || content == ""){
		alert("제목 및 본문을 작성해 주세요.");
		return;
	}
	form.submit();
}

// 답글달기 페이지 로딩
function getReplyBoard(folder, contentNo, search, select, chartNum){
	var url="replyBoardForm";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{folder:folder, contentNo:contentNo, search:search, select:select, chartNum:chartNum},
		success: function(data){
			$(".card-content").empty();
			$(".card-content").append(data);
			$("#getReplyBoardBtn").css("display","none");
		},
		error: function(err) {
			console.log("error : ", err);
		}
	});
}

function replyBoard(){
	var form = document.insertReplyBoard;
	form.setAttribute("method","post");
	form.setAttribute("action","replyBoard");
	console.log(" form guestID : ", form.getAttribute("guestID"));
	console.log(" form guestPW : ", form.getAttribute("guestPW"));

	// console.log(" guestIDD : ", $("#guestIDD").val());
	// console.log(" guestPWW : ", $("#guestPWW").val());
	// form.setAttribute("guestID", $("#guestIDD").val());
	// form.setAttribute("guestPW", $("#guestPWW").val());
	// var child1 = createEl("guestID", $("#guestID").val());
	// var child2 = createEl("guestPW", $("#guestPW").val());
	// form.appendChild(child1);
	// form.appendChild(child2);

	var title = document.getElementById("reply_title").value.replace(/\s/g, "");
	oEditors.getById["reply_content"].exec("UPDATE_CONTENTS_FIELD", [ ]);
	var content = document.getElementById("reply_content").value.replace(/\s/g, "");

	if(title == "" || content == "<p>&nbsp;</p>"){
		alertPopup("제목 및 본문을 작성해 주세요.");
		return;
	} else {
		// console.log(" submitted form : ", form);
		form.submit();
	}
	// console.log("@ reply content : ", content);
	// console.log("@ reply title : ", title);
}

function cancelImpo(mode, no){
	var inst = confirmPopup("중요공지를 내리겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		form.setAttribute("method","post");
		form.setAttribute("action","noticeMode");
		var child1 = createEl("mode", mode);
		var child2 = createEl("contentNo", no);

		document.body.appendChild(form);
		form.appendChild(child1);
		form.appendChild(child2);
		form.submit();
	});
}

function setImpo(mode, no){
	if(mode == "important"){
		alertPopup("이미 중요공지로 설정 되어 있습니다.");
		return false;
	}
	var inst = confirmPopup("중요공지로 올리겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");
		form.setAttribute("method","post");
		form.setAttribute("action","noticeMode");
		var child1 = createEl("mode", mode);
		var child2 = createEl("contentNo", no);

		document.body.appendChild(form);
		form.appendChild(child1);
		form.appendChild(child2);
		form.submit();
	});
}
