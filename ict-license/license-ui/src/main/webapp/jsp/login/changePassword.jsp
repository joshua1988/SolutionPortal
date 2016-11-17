<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<script type="text/javascript" src="${contextPath }/dist/rsa/jsbn.js"></script>
<script type="text/javascript" src="${contextPath }/dist/rsa/rsa.js"></script>
<script type="text/javascript" src="${contextPath }/dist/rsa/prng4.js"></script>
<script type="text/javascript" src="${contextPath }/dist/rsa/rng.js"></script>

<title>비밀번호 변경</title>
<script type="text/javascript"> 
function fnCheckPassword(){
	var pattern = /^[a-zA-Z0-9_]{8,12}$/; 

	var abilitypassword = $("#abilitypassword").val().replace(/\s/g, "");
	var newpassword = $("#newpassword").val().replace(/\s/g, "");
	var confirmpassword = $("#confirmpassword").val().replace(/\s/g, ""); 

	if(newpassword.replace(/\s/g, "") != confirmpassword.replace(/\s/g, "")){
		alertPopup("새로운 비밀번호가 맞지 않습니다.");
		return false;
	}

	if(!pattern.test(newpassword)){
		alertPopup('비밀번호는 숫자와 영문자 조합으로 8~12자리를 사용해야 합니다.');
		return false;
	}

    var chk_num = newpassword.search(/[0-9]/g);
    var chk_eng = newpassword.search(/[a-z]/ig);

    if(chk_num < 0 || chk_eng < 0){ 
    	alertPopup('비밀번호는 숫자와 영문자를 혼용하여야 합니다.'); 
        return false;
    }  
    
    var no = "${USER_NO}";
    if(newpassword.search(no)>-1)
    {
    	alertPopup('ID가 포함된 비밀번호는 사용하실 수 없습니다.'); 
         return false;
     }
    
	var password = $("#abilitypassword").val().replace(/\s/g, "");;
	
    try {
        var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
        var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
        var rsa = new RSAKey();
        rsa.setPublic(rsaPublicKeyModulus, rsaPublicKeyExponent);
        abilitypassword = rsa.encrypt(password);
        newpassword = rsa.encrypt(newpassword);
    } catch(err) {
        alert(err);
    }

	var url = "changePassword";
	jQuery.ajax({
		type:"POST",
		url:url,
		data:{oriPass: abilitypassword, newPass: newpassword },
		success: function(data){
			if(data == 'success'){
				$("#passwordPop").modal("hide");
				alertPopup("비밀번호 변경 완료");
			}else{
				alertPopup("현재 비밀번호가 틀렸습니다.");
			}
		}
	});
} 
</script>
</head>
<body>    
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title"><p class="text-muted"><strong>비밀번호변경</strong></p></h4>
      </div>
      <div class="modal-body">
		<form name="frm">   
      		<c:if test="${mode == 0 }">    
			<p class="text-danger">비밀번호 변경이 필요 합니다.</p>
			</c:if>
			<br>
			<p class="text-info">숫자, 영문 혼합 8~12자리를 입력하세요.</p><br>          
			<span class="label label-default">현재 비밀번호</span>&nbsp;&nbsp;<input type="password" class="form-control" id="abilitypassword"><br>
			<span class="label label-warning">변경 비밀번호</span>&nbsp;&nbsp;<input type="password" class="form-control" id="newpassword"><br>
			<span class="label label-warning">비밀번호 확인</span>&nbsp;&nbsp;<input type="password" class="form-control" id="confirmpassword"><br>
			
			<input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus }" />
	        <input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent }" /> 
			<input type="hidden" name="securedPassword" id="securedPassword" value="" />
		</form>
      </div>
      <div class="modal-footer">
      	<c:if test="${mode == 1 }">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        </c:if>
        <button type="button" class="btn btn-primary" onclick="javascript:fnCheckPassword();">변경</button>
      </div>
    </div>
  </div>
</body>
</html>