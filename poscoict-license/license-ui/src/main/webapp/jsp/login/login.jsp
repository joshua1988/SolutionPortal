<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

	<!--Import Google Icon Font-->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <!--Import materialize.css-->
  <link type="text/css" rel="stylesheet" href="${contextPath}/dist/materialize/css/materialize.min.css"  media="screen,projection"/>
  <!--Let browser know website is optimized for mobile-->
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>

	<%-- Android Chrome --%>
	<meta name="mobile-web-app-capable" content="yes">
	<link rel="icon" sizes="192x192" href="${contextPath}/dist/images/icons/chrome-touch-icon.png">

	<%-- PWA meta --%>
	<link rel="manifest" href="${contextPath}/manifest.json">

	<%-- Safari --%>
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-title" content="SolPot(Dev)">
	<link rel="apple-touch-icon" href="${contextPath}/dist/images/icons/apple-touch-icon.png">
	<link rel="apple-touch-startup-image" href="${contextPath}/dist/images/icons/apple-touch-icon.png">
	<link rel="apple-touch-icon-precomposed" href="${contextPath}/dist/images/icons/apple-touch-icon.png">

	<%-- <link rel="shortcut icon" sizes="192x192" href="${contextPath}/dist/images/icons/chrome-touch-icon.png">
	<link rel="shortcut icon" sizes="128x128" href="icon-128x128.png">
	<link rel="apple-touch-icon" sizes="128x128" href="${contextPath}/dist/images/icons/apple-touch-icon.png">
	<link rel="apple-touch-icon-precomposed" sizes="128x128" href="icon-128x128.png"> --%>
	<style>
    body {
      display: flex;
      min-height: 100vh;
      flex-direction: column;
    }

    main {
      flex: 1 0 auto;
			align-items: center;
    }

    body {
      background: #fff;
    }

    .input-field input[type=date]:focus + label,
    .input-field input[type=text]:focus + label,
    .input-field input[type=email]:focus + label,
    .input-field input[type=password]:focus + label {
      color: #e91e63;
    }

    .input-field input[type=date]:focus,
    .input-field input[type=text]:focus,
    .input-field input[type=email]:focus,
    .input-field input[type=password]:focus {
      border-bottom: 2px solid #e91e63;
      box-shadow: none;
    }
  </style>
	<title>라이선스 관리 포탈</title>
</head>
<body>
	<div class="section"></div>
	  <main>
	    <center>
				<div class="section hide-on-small-only"></div>
				<img class="responsive-img" style="width: 250px;" src="${contextPath}/dist/img/mainLogo.gif" />
	      <div class="section hide-on-small-only"></div>

	      <h5 class="blue-text text-darken-1">Welcome to Solution Portal</h5>
	      <div class="section hide-on-small-only"></div>

	      <div class="container">
	        <div class="z-depth-1 grey lighten-4 row hoverable" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">

	          <form class="col s12 form-signin" name="frm" method="post" action="securityLogin">
	            <div class='row'>
	              <div class='col s12'>
	              </div>
	            </div>

	            <div class='row'>
	              <div class='input-field col s12' style="text-align: left;">
	                <input class='validate' type='text' name='text' id='text' autofocus/>
	                <label for='text'>ID를 입력하세요</label>
	              </div>
	            </div>

	            <div class='row text-center'>
	              <div class='input-field col s12 text-left' style="text-align: left;">
	                <input class='validate' type='password' name='password' id='password'/>
	                <label for='password'>비밀번호를 입력하세요</label>
	              </div>
	              <label style='float: right;'>
									<a class='pink-text text-darken-1' href='#!'><b>비밀번호 잊으셨나요?</b></a>
								</label>
	            </div>

	            <br />
	            <center>
	              <div class='row'>
	                <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect blue darken-1' name="action" onclick="javascript:loginOK();">
										Login</button><br><br><br>
									<%-- <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect indigo' name="action" onclick="javascript:guestLogin();">
										Guest</button> --%>
	              </div>
	            </center>
	          </form>
						<div class='row'>
							<div class="col s12">
								<button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect blue darken-1' name="action" onclick="javascript:guestLogin();">
									Guest</button>
							</div>
						</div>
						<form class="form-signin" name="frm2" method="post" action="securityLogin" hidden>
							<input type="hidden" name="text" value="guest">
							<input type="hidden" name="password" value="guest">
						</form>
	        </div>
	      </div>
				<%-- <a id="pushBtn" class="waves-effect waves-light btn"><i id="pushIcon" class="material-icons left">notifications_active</i>알림 설정</a> --%>
				<label for="pushAlert">게시판 & 답글 알림 설정</label>
				<div class="switch" id="pushAlert">
			    <label>
			      Off
			      <input id="pushSwitch" type="checkbox">
			      <span class="lever"></span>
			      On
			    </label>
			  </div>
				<div id="pushStatus" style="margin-top:5px;"></div>
	      <%-- <a href="#!">Help Desk</a> --%>
	    </center>
	  </main>
	<script type="text/javascript">
	    sessionStorage.clear();
			sessionStorage.setItem("treeActiveKey", "notice");
			sessionStorage.setItem("navActiveKey", "Navnotice");
	</script>
  <script async src="${contextPath }/main.js" data-service-worker="${contextPath }/sw.js"></script>
	<script src="${contextPath }/dist/jquery/jquery.min.js"></script>
	<script src="${contextPath }/dist/materialize/js/materialize.min.js"></script>
	<script async src="${contextPath }/dist/js/signin.js"></script>
	<script type="text/javascript">
	$(function(){
		/* $('body').bind('touchmove', function(ev) { ev.preventDefault(); }); */
		$(".text").focus();
		$("input").keydown(function(e){
			if(e.keyCode == 13) {
				loginOK();
			}
		});
	});
	</script>
</body>
</html>
