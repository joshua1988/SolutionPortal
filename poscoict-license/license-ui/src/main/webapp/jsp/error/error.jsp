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
<title>Insert title here</title>
</head>
<body>
<div class="jumbotron">
  <div class="container">
    <h1>Error!</h1>
    <p>${message}</p>
<%--     <p><a class="btn btn-primary btn-lg" href="${contextPath }/index">Login</a></p> --%>
  </div>
</div>

<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>     -->
<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2-jquery.min.js"></script>
<script src="${contextPath }/dist/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>