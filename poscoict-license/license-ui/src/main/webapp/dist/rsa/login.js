function validateEncryptedForm() {
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    if (!username || !password) {
        alert("ID/비밀번호를 입력해주세요.");
        return false;
    }

    try {
        var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
        var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
        submitEncryptedForm(username,password, rsaPublicKeyModulus, rsaPublicKeyExponent);
    } catch(err) {
        alert(err);
    }
    return false;
}

function submitEncryptedForm(username, password, rsaPublicKeyModulus, rsaPpublicKeyExponent) {
    var rsa = new RSAKey();
    rsa.setPublic(rsaPublicKeyModulus, rsaPpublicKeyExponent);

    // 사용자ID와 비밀번호를 RSA로 암호화한다.
    var securedUsername = rsa.encrypt(username);
    var securedPassword = rsa.encrypt(password);

    // POST 로그인 폼에 값을 설정하고 발행(submit) 한다.
    var securedLoginForm = document.getElementById("securedLoginForm");
    securedLoginForm.securedUsername.value = securedUsername;
    securedLoginForm.securedPassword.value = securedPassword;
    securedLoginForm.submit();
}