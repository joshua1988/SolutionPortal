<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

<!-- 부트스트랩 -->
<link href="${contextPath }/dist/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="${contextPath }/dist/bootstrap/css/bootstrap.css" rel="stylesheet">
<title></title>
</head>
<body>
<div class="jumbotron">
  <div class="container">
    <h1>로그인 실패!</h1>
    <p>아이디 및 패스워드 정보가 일치하지 않습니다.</p>
    <p><a class="btn btn-primary btn-lg" href="${contextPath }/index">Login</a></p>
  </div>
</div>

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> -->
<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2-jquery.min.js"></script>
<!-- 모든 합쳐진 플러그인을 포함하거나 (아래) 필요한 각각의 파일들을 포함하세요 -->
<script src="${contextPath }/dist/bootstrap/js/bootstrap.min.js"></script>
<!-- Respond.js 으로 IE8 에서 반응형 기능을 활성화하세요 (https://github.com/scottjehl/Respond) -->
<!-- <script src="js/respond.js"></script> -->
</body>
</html>