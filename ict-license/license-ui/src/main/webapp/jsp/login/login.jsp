<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=0.7">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<link rel="stylesheet" href="${contextPath }/dist/bootstrap/css/bootstrap.css">
<style type="text/css">
.row{
	margin-top: 10%;
 	background-image: url('${contextPath }/dist/img/bg.gif'); 
 	background-repeat: repeat-x; 
}
.container{
	padding-top: 60px;
	padding-bottom: 60px;
}
</style>
<title>라이선스 관리 포탈</title>
</head>
<body>
<div class="row">
	<div class="container">
		<div class="media">
		  <a class="pull-left" href="#">
		    <img class="media-object" src="${contextPath }/dist/img/glueimg01.png" alt="..." style="padding-top: 20px;">
		  </a>
		  <div class="media-body input-group-sm col-lg-3">
		    <h4 class="media-heading"><label style="font-size: 13px; color: white;">라이선스 관리 포탈</label></h4>
		    <form class="form-signin" name="frm" method="post" action="securityLogin">
	   		<input type="text" class="form-control" id="text" name="text" placeholder="ID" autofocus>
			<input type="password" class="form-control" id="password" name="password" placeholder="PASSWORD">
			<button class="btn btn-sm btn-info btn-block" onclick="javascript:loginOK();" type="button">로그인</button>
			</form>
			<form class="form-signin" name="frm2" method="post" action="securityLogin">
			<input type="hidden" name="text" value="guest">
			<input type="hidden" name="password" value="guest">
			<button class="btn btn-sm btn-warning btn-block" onclick="javascript:guestLogin();" type="button">게스트 로그인</button>
			</form>
		  </div>
		</div>
	</div>		
</div>

<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>     -->
<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2-jquery.min.js"></script>
<script src="${contextPath }/dist/bootstrap/js/bootstrap.min.js"></script>
<script src="${contextPath }/dist/js/signin.js"></script>
<script type="text/javascript">
$(function(){
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