function passPop(mode){
	$("#popInfo").remove();
	$("#passwordPop").append('<div id="popInfo"></div>');
	var url = "passwordPop";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{mode: mode },
		success: function(data){
			$("#popInfo").append(data);
		}
	});
}

function passCheck(){
	var url = "passCheck";
	jQuery.ajax({
		type:"POST",
		url:url,
		success: function(data){
			if(data=='fail'){
				$("#passwordPop").modal("show");
				passPop('0');
			}
		}
	});		
}

function sessionExpire(pass){
	var temp='<h1>알림</h1><p>세션이 만료 되었습니다. 다시 로그인 해주십시요.</p><br><div><a class="btn btn-primary btn-lg" href="'+pass+'/index">로그인</a></div>';
	$(".remodal").empty();
	$(".remodal").append(temp);
	
	var inst = $.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')];
	inst.open();
}

function alertPopup(text){
	var temp='<h1>알림</h1><p>'+text+'</p><br>'
    +'<button class="remodal-cancel" onclick="javascript:$.remodal.lookup[$(\'[data-remodal-id=modal]\').data(\'remodal\')].close();">확인</button>'
    +'</div>';
	$(".remodal").empty();
	$(".remodal").append(temp);
	
	var inst = $.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')];
	inst.open();
}

function confirmPopup(text){	
	var temp='<h1>알림</h1><p>'+text+'</p><br>'
	+'<button class="remodal-cancel" onclick="javascript:$.remodal.lookup[$(\'[data-remodal-id=modal]\').data(\'remodal\')].close();">Cancel</button>'
	+'<button class="remodal-confirm btn btn-success">OK</button>'
    +'</div>';
	$(".remodal").empty();
	$(".remodal").append(temp);
    
	var inst = $.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')];
	return inst;
}

function createEl(name, value){
	var input_id = document.createElement("input");  
	input_id.setAttribute("type", "hidden");                  
	input_id.setAttribute("name", name);                        
	input_id.setAttribute("value", value);
	
	return input_id;
}

function page(pa){
	saveLocalStoragy(pa);
	
	var form = document.createElement("form");     
	form.setAttribute("action",pa);
	form.setAttribute("method","POST");                    
	document.body.appendChild(form);                         

	form.submit();
}

function saveLocalStoragy(id){
	if(id=="addCustomUserForm") id="customUser";
	if(id=="newContract") id="management";
	if(id=="progressContract") id="progress";
	
	var myJstree = JSON.parse(localStorage.getItem("myJstree"));
	var temp = '';
	Object.getOwnPropertyNames(myJstree).forEach(function (el) {
		if(myJstree[el].hasOwnProperty("core")){
	    	temp = myJstree[el].core.open;
		}
	});
	var state	= {"state":{"core":{"open":temp,"scroll":{"left":0,"top":0},"selected":[id]}},"ttl":false,"sec":new Date().getTime()+1000};
	localStorage.setItem("myJstree", JSON.stringify(state));
	
	$('#myJstree').jstree().restore_state();
}