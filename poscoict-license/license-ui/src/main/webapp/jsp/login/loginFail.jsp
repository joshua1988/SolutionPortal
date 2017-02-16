<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
  <!--Import Google Icon Font-->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <!--Import materialize.css-->
  <link type="text/css" rel="stylesheet" href="${contextPath}/dist/materialize/css/materialize.min.css"  media="screen,projection"/>
  <title>POSCO ICT 솔루션 포탈</title>
  <!--Let browser know website is optimized for mobile-->
</head>
<body>

  <div class="container">
    <h4 class="truncate">로그인 실패!</h4>
    <p>
      아이디 및 패스워드 정보가 일치하지 않습니다. <br/>
      패스워드가 기억나지 않으면 담당자에게 연락바랍니다.
    </p>
    <a class="waves-effect waves-light btn blue darken-1" href="${contextPath }/index">로그인 페이지로</a>
    <a class="waves-effect waves-light btn blue darken-1 hide-on-med-and-down" href="mailto:fairies@poscoict.com"><i class="material-icons left">email</i>담당자</a>
    <a class="waves-effect waves-light btn blue darken-1 hide-on-large-only" href="tel:+0317233286"><i class="material-icons left">call</i>담당자</a>

  </div>

  <%-- Materialize CSS --%>
  <script src="${contextPath }/dist/jquery/jquery.min.js"></script>
  <script src="${contextPath }/dist/materialize/js/materialize.min.js"></script>
</body>
</html>
