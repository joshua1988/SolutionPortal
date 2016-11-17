function createBoardC(){
	var f = document.createCustomBoard;
	if(f.boardName.value.replace(/\s/g, "")=="") {
		alertPopup("게시판 명을 입력해 주세요.");
		return false;
	}
	
	f.submit();
}

function deleteCustomBoard(id){
	var inst = confirmPopup("게시판을 삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");     
		form.setAttribute("method","post");  
		form.setAttribute("action","deleteCustomBoard");
		var param1 = createEl("boardId", id);
		
		document.body.appendChild(form); 
		form.appendChild(param1);
		form.submit(); 
	});
}

function renameCustomBoard(id,ind){
	var temp = $("#inputName"+ind).val();
	if(temp.replace(/\s/g, "")=="") {
		alertPopup("수정 할 이름을 입력해 주세요.");
		return false;
	}
	
	var inst = confirmPopup("게시판명을 수정 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");     
		form.setAttribute("method","post");  
		form.setAttribute("action","renameCustomBoard");
		var param1 = createEl("boardId", id);
		var param2 = createEl("boardName", temp);
		document.body.appendChild(form); 
		form.appendChild(param1);
		form.appendChild(param2);
		form.submit(); 
	});
}

function getCustomBoardList(id){
	saveLocalStoragy(id);
	
	var form = document.createElement("form");     
	form.setAttribute("action","customBoard");
	form.setAttribute("method","POST");      
	var child1 = createEl("boardId", id);
	document.body.appendChild(form); 
	form.appendChild(child1);                         
	form.submit();
}

function getReplyCustomBoard(boardId, no, sear, sel, chart){
//	$("#replyBoardForm").load("replyCustomBoardForm?boardId="+boardId+"&contentNo="+no+"&search="+sear+"&select="+sel+"&chartNum="+chart);
	var url="replyCustomBoardForm";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{boardId:boardId, contentNo:no, search:sear, select:sel, chartNum:chart},
		success: function(data){
			$("#replyBoardForm").append(data);
			$(".replyBoardButton").css("display","none");
		}
	});
}

function cInsertReply(boardId, contentNo){
	var content = document.getElementById("replyText").value.replace(/\s/g, "");

	if(checkBytes(content) > 1000){
		alertPopup("글자 수가 1000byte를 넘었습니다.");
		return false;
	}
	if(content == ""){
		alertPopup("덧글을 작성 해주세요.");
		return false;
	}
	content = document.getElementById("replyText").value;

	var url = "cInsertReply";
    $.post(url, 
            {boardId:boardId, 
    		 contentNo:contentNo, 
             mainContent:encodeURIComponent(content)},
            function(data){
            	// 내용 비우기
                $('#replyText').val(''); 
                // 입력이 완료가 됐으므로 다시 리스트 불러오기
                cCmtList(contentNo, boardId);
                alertPopup("덧글이 등록 되었습니다.");
            });
}

function cDeleteReply(boardId, reContentNo, contentNo){
	var url = "cDeleteReply";
	var inst = confirmPopup("삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		$.post(url, 
			{boardId:boardId, reContentNo:reContentNo, contentNo:contentNo},
			function(data){
				cCmtList(contentNo, boardId);
			});
		$.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')].close();
	});
}

function cCmtList(no, boardId) {
	var url = "cReplyList";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{contentNo:no, boardId:boardId},
		success: function(data){
			$("#reply").empty();
			$("#reply").append(data);
		}
	});
}

function cModifyBoard(){
	var form = document.insertCModifyBoard;     
	form.setAttribute("method","post");                    
	form.setAttribute("action","cModifyBoard");
	var title = document.getElementById("modify_title").value.replace(/\s/g, "");
	
	oEditors.getById["modify_content"].exec("UPDATE_CONTENTS_FIELD", [ ]);
	var content = document.getElementById("modify_content").value.replace(/\s/g, "");
	if(content == ""){
		alertPopup("본문을 작성해 주세요.");
		$(".modify_content").focus();
		return;
	}
	if(title == "" || content == ""){
		alertPopup("제목 및 본문을 작성해 주세요.");
		return;
	}
	form.submit();
}

function getCustomWritingForm(id){
	var form = document.createElement("form");     
	form.setAttribute("method","post");                    
	form.setAttribute("action","customWriting");
	document.body.appendChild(form);
	var param1 = createEl("boardId", id);
	form.appendChild(param1);
	form.submit(); 
}

function cViewPost(id, no, chartNum, search, select){
	var form = document.createElement("form");     
	form.setAttribute("method","post");                    
	form.setAttribute("action","cViewPost");
	document.body.appendChild(form);
	var param1 = createEl("boardId", id);
	var param2 = createEl("contentNo", no);
	var param3 = createEl("chartNum", chartNum);
	
	if(search != null || search != ""){
		var param4 = createEl("search", search);
		var param5 = createEl("select", select);
		form.appendChild(param4);
		form.appendChild(param5);
	}
	
	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);

	form.submit();
}

function cDeleteBoard(id, no, sear, sel, chart){
	var inst = confirmPopup("게시물을 삭제 하시겠습니까?");
	inst.open();
	$('.remodal-confirm').on('click', function () {
		var form = document.createElement("form");     
		form.setAttribute("method","post");                    
		form.setAttribute("action","cDeleteBoard");
		document.body.appendChild(form);      
		
		var param1 = createEl("boardId", id);
		var param2 = createEl("contentNo", no);
		var param3 = createEl("chartNum",chart);
		form.appendChild(param1);
		form.appendChild(param2);
		form.appendChild(param3);   
		
		if(sear != null || sear != ""){
			var param4 = createEl("search", sear);
			var param5 = createEl("select", sel);
			form.appendChild(param4);
			form.appendChild(param5);
		}

		form.submit(); 
	});
}

function cModifyForm(id, no, chart, sear, sel){
	var form = document.createElement("form");     
	form.setAttribute("method","post");                    
	form.setAttribute("action","cModifyBoardForm");
	
	document.body.appendChild(form);
	
	var param1 = createEl("boardId", id);
	var param2 = createEl("contentNo", no);
	var param3 = createEl("search", sear);
	var param4 = createEl("select", sel);
	var param5 = createEl("chartNum", chart);
	
	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);
	form.appendChild(param4);
	form.appendChild(param5);
	
	form.submit(); 
}

function customWriteSubmit(){
	var title = document.getElementById("WRITE_TITLE").value.replace(/\s/g, "");
	if(title == ""){
		alertPopup("제목을 작성해 주세요.");
		$(".WRITE_TITLE").focus();
		return;
	}
	oEditors.getById["WRITE_MAIN_CONTENT"].exec("UPDATE_CONTENTS_FIELD", [ ]);
	var content = document.getElementById("WRITE_MAIN_CONTENT").value.replace(/\s/g, "");
	if(content == "" || content == "<br>"){
		alertPopup("본문을 작성해 주세요.");
		$(".WRITE_MAIN_CONTENT").focus();
		return;
	}
	
	document.customW.submit();
}

//네비게이터 페이지 숫자 선택시 처리
function cMovePage(chart, id, sear, sel){
	var form = document.createElement("form");     
	form.setAttribute("method","post");  
	form.setAttribute("action","customBoard");
	
	document.body.appendChild(form);
	var param1 = createEl("chartNum", chart);
	var param2 = createEl("boardId", id);
	
	if(sear != null){
		var param3 = createEl("search", sear);
		var param4 = createEl("select", sel);
		form.appendChild(param3);
		form.appendChild(param4);
	}

	form.appendChild(param1);
	form.appendChild(param2);
	form.submit();  
}

//네비게이터 10페이지씩 이동, 맨처음, 맨끝 이동
function cJumpPage(id, mode, totalPage, sear, sel){
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
	
	var form = document.createElement("form");     
	form.setAttribute("method","post");  
	form.setAttribute("action","customBoard");
	
	document.body.appendChild(form);
	var param1 = createEl("chartNum", chart);
	var param2 = createEl("boardId", id);
	
	if(sear != null){
		var param3 = createEl("search", sear);
		var param4 = createEl("select", sel);
		form.appendChild(param3);
		form.appendChild(param4);
	}
	
	form.appendChild(param1);
	form.appendChild(param2);
	form.submit();
}

function cSearchList(id){
	var temp = document.getElementById("text").value.replace(/\s/g, "");
	
	if(temp == "" || temp.length <= 1){
		alertPopup("두 글자 이상 입력해 주세요");
		return;
	}
	
	var form = document.createElement("form");     
	form.setAttribute("method","post");                    
	form.setAttribute("action","customBoard");
	
	document.body.appendChild(form);
	var choose = document.getElementById("select").value;
	var text = document.getElementById("text").value;
	
	var category = createEl("boardId", id);
	var search = createEl("search", text);
	var select = createEl("select", choose);
	form.appendChild(category);
	form.appendChild(search);
	form.appendChild(select);
	form.submit(); 
}

function cSearchList1(id){
	var temp = document.getElementById("text1").value.replace(/\s/g, "");
	
	if(temp == "" || temp.length <= 1){
		alertPopup("두 글자 이상 입력해 주세요");
		return;
	}
	
	var form = document.createElement("form");     
	form.setAttribute("method","post");                    
	form.setAttribute("action","customBoard");
	
	document.body.appendChild(form);
	var choose = document.getElementById("select1").value;
	var text = document.getElementById("text1").value;
	
	var category = createEl("boardId", id);
	var search = createEl("search1", text);
	var select = createEl("select1", choose);
	form.appendChild(category);
	form.appendChild(search);
	form.appendChild(select);
	form.submit(); 
}

function projectManagement(id, localId){
	saveLocalStoragy(localId);
	
	var form = document.createElement("form");     
	form.setAttribute("method","post");  
	form.setAttribute("action","boardManagement");
	document.body.appendChild(form);
	var param1 = createEl("solution", id);
	form.appendChild(param1);
	form.submit(); 
}

function createProjectFun(mode, id){
	$("#projectFolderContent").empty();
	var mo='';
	if(mode=='F') mo='폴더 생성';
	if(mode=='B') mo='게시판 생성';
	if(mode=='EF') mo='폴더명 변경';
	if(mode=='DF') mo='폴더 삭제';
	if(mode=='EB') mo='게시판명 변경';
	if(mode=='DB') mo='게시판 삭제';
	var temp = ''
			  +'<div class="modal-header">'
			  +'<h4 class="modal-title"><p class="text-muted"><strong>'+mo+'</strong></p></h4>'
			  +'</div><div class="modal-body">'
			  +'<form name="creatProject" class="form-horizontal" role="form">'
			  +'<div class="form-group"><label class="col-xs-3 control-label">'+mo+'</label>'
			  +'<div class="col-xs-9">';
			  if(mode!='DF' && mode!='DB') temp+='<input type="text" class="form-control" name="projectName" id="projectName" placeholder="'+mo+'">';
			  if(mode=='DF') temp+='<div class="alert alert-danger">폴더 삭제시 하위폴더 및 게시판을 이용 할 수 없습니다.</div>';
			  if(mode=='DB') temp+='<div class="alert alert-danger">게시판이 제거됩니다.</div>';
			  temp+='</div></div>';
			  temp+='</form></div><div class="modal-footer">';
			  temp+='<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>';
			  temp+='<button type="button" class="btn btn-primary" onclick="javascript:createProjectSubmit(\''+mode+'\',\''+id+'\')">'+mo+'</button></div>';
	
	
	$("#projectFolderContent").append(temp);
}

function createProjectSubmit(mode, id) {
	if(mode=='F' && document.getElementById("projectName").value.replace(/\s/g, "")==''){
		alertPopup("폴더명을 입력하세요.");
		return false;
	}
	if(mode=='B' && document.getElementById("projectName").value.replace(/\s/g, "")==''){
		alertPopup("게시판명을 입력하세요.");
		return false;
	}
	if(mode=='EF' && document.getElementById("projectName").value.replace(/\s/g, "")==''){
		alertPopup("폴더명을 입력하세요.");
		return false;
	}
	if(mode=='EB' && document.getElementById("projectName").value.replace(/\s/g, "")==''){
		alertPopup("게시판명을 입력하세요.");
		return false;
	}
	
	var form = document.createElement("form");     
	form.setAttribute("method","post");  
	form.setAttribute("action","projectFolders");
	document.body.appendChild(form);
	
	var param1 = createEl("mode", mode);
	var param2 = createEl("upperId", id);
	var param3 = createEl("solution", $("#solution").val());
	var param4 = createEl("projectName", $("#projectName").val());
	form.appendChild(param1);
	form.appendChild(param2);
	form.appendChild(param3);
	form.appendChild(param4);
	form.submit(); 
	
}