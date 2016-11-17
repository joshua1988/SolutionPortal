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
</head>
<body>

	<div class="modal-content">
		<h5>비밀번호변경</h5>
		<form name="frm">
  		<c:if test="${mode == 0 }">
				<p>첫 로그인 시에는 비밀번호 변경이 필요 합니다.<br/>이후에 하고 싶으시면 상단의 비밀번호 변경 버튼을 누르세요.</p>
			</c:if>
			<p class="red-text">※ 숫자, 영문 혼합 8~12자리를 입력하세요.</p>
			<div class="row">
        <div class="input-field col s12">
          <input type="password" class="validate" id="abilitypassword">
          <label for="password">현재 비밀번호</label>
        </div>
      </div>
			<div class="row">
				<div class="input-field col s12">
					<input type="password" class="validate" id="newpassword">
					<label for="password">변경할 비밀번호</label>
				</div>
			</div>
			<div class="row">
				<div class="input-field col s12">
					<input type="password" class="validate" id="confirmpassword">
					<label for="password">비밀번호 확인입력</label>
				</div>
			</div>

			<input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus }" />
      <input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent }" />
			<input type="hidden" name="securedPassword" id="securedPassword" value="" />
		</form>
	</div>
	<div class="modal-footer">
		<%-- <c:if test="${mode == 1 }">
		<a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat" onclick="javascript:dismissModal();">취소</a>
		</c:if> --%>
		<a href="#!" class="modal-action modal-close waves-effect waves-light btn" onclick="javascript:fnCheckPassword();">변경</a>
	</div>

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
					alertPopup("비밀번호 변경 완료");
					$("#modal1").closeModal();
				}else{
					alertPopup("현재 비밀번호가 틀렸습니다.");
				}
			}
		});
	}

	// function dismissModal() {
	// 	$(".lean-overlay").remove();
	// 	$("#modal1").css("display", "none");
	// 	console.log("clicked");
	// }
	</script>
</body>
</html>
