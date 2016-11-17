function loginOK(){
	if(document.getElementById("text").value.replace(/\s/g, "")==""){
		alert("ID를 입력하세요.");
		$("#text").focus();
		return false;
	}
	if(document.getElementById("password").value.replace(/\s/g, "")==""){
		alert("PW를 입력하세요.");
		$("#password").focus();
		return false;
	}

	var form = document.frm;
	// console.log(form);
	form.submit();
}

function guestLogin(){
	var form = document.frm2;
	// console.log(form);
	form.submit();
}
