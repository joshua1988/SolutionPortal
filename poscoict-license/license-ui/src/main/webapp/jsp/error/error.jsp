<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<link rel="stylesheet" href="${contextPath }/dist/bootstrap/css/bootstrap.css">
<title>POSCO ICT 솔루션 포탈</title>

<!-- Favicon -->
<link rel="shortcut icon" href="favicon.ico">
<link rel="apple-touch-icon" sizes="57x57" href="${contextPath}/dist/images/favicon/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="${contextPath}/dist/images/favicon/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="${contextPath}/dist/images/favicon/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="${contextPath}/dist/images/favicon/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="${contextPath}/dist/images/favicon/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="${contextPath}/dist/images/favicon/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="${contextPath}/dist/images/favicon/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="${contextPath}/dist/images/favicon/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="${contextPath}/dist/images/favicon/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="${contextPath}/dist/images/favicon/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="${contextPath}/dist/images/favicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="${contextPath}/dist/images/favicon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="${contextPath}/dist/images/favicon/favicon-16x16.png">

</head>
<body>
<div class="jumbotron">
  <div class="container">
    <h1>Error!</h1>
    <p>${message}</p>
<%--     <p><a class="btn btn-primary btn-lg" href="${contextPath }/index">Login</a></p> --%>
  </div>
</div>

<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2-jquery.min.js"></script>
<script src="${contextPath }/dist/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
