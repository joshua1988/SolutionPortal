<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=0.7"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<!-- 부트스트랩 -->
<link href="${contextPath }/dist/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="${contextPath }/dist/bootstrap/css/bootstrap.css" rel="stylesheet">
<!-- jquery-ui css -->
<link rel="stylesheet" href="${contextPath }/dist/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${contextPath }/dist/modal/jquery.remodal.css">
<link rel="stylesheet" href="${contextPath }/dist/css/docs.css">
<link rel="stylesheet" href="${contextPath }/dist/jstree/themes/default/style.min.css" />
<link rel="stylesheet" href="${contextPath }/dist/bootstrap/css/non-reponsive.css" />
<style type="text/css">
.top { position:fixed;right:5%;bottom:15%; z-index:999; display:none; }
.top IMG {
	width: 30px; height: 30px;
	zoom: 1;
    filter: alpha(opacity=50);
    opacity: 0.5;
}
#treemenu {
	font-size: 12px;
	padding-right: 0;
    padding-left: 0;
}
</style>
<c:choose>
	<c:when test="${empty param.page && empty page }">
		<c:set var="sPage" value="board/boardList.jsp"/>
	</c:when>
	<c:when test="${not empty param.page || not empty page}">
		<c:set var="sPage" value="${param.page==null?page:param.page }.jsp"/>
	</c:when>
</c:choose>
<title>라이선스 관리 포털</title>
</head>
<body>
<%
	if( session.getAttribute("jstree") != null ){
%>
<script type="text/javascript">
 		localStorage.setItem('myJstree','{"state":{"core":{"open":[],"scroll":{"left":0,"top":0},"selected":["notice"]}},"ttl":false,"sec":'+new Date().getTime()+'}');
</script>
<%
	session.removeAttribute("jstree");
 	}
%>
	  <div class="top"><a href="#"><label style="font-size: 12px; color: gray;">맨위</label><img src="${contextPath }/dist/img/arrow_top.gif" alt="맨위"/></a></div>
     <!-- Fixed navbar -->
      <header class="navbar navbar-inverse" style="z-index: 100;">
      	  <div class="container">
	          <div class="navbar-header">
	            <a class="navbar-brand" href="#" onclick="javascript:boardList('notice','NOTICE'); return false;" style="color: white;">LICENSE MANAGEMENT</a>
	            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
	              <span class="icon-bar"></span>
	              <span class="icon-bar"></span>
	              <span class="icon-bar"></span>
	            </button>
	          </div>
	          <div class="collapse navbar-collapse">
	            <div class="navbar-form navbar-right">
		            <security:authorize ifAnyGranted="ROLE_U,ROLE_S,ROLE_D, ROLE_C">
		            <div class="form-group">
		              	<button type="button" class="btn btn-info" onclick="javascript:passPop('1'); return false;" data-toggle="modal" data-target="#passwordPop">
				  			<span class="glyphicon glyphicon-cog"></span> 비밀번호 변경
						</button>
		            </div>
		            </security:authorize>
		            <form class="form-group" action="logout">
		                <button type="submit" class="btn btn-primary">
				  			<span class="glyphicon glyphicon-off"></span> 로그아웃
						</button>
		            </form>
	            </div>
	          </div>
          </div>
      </header>

      <article>
        <div class="container">
	      	<div id="treemenu" class="col-xs-2" style="padding-bottom: 70px;">
	      		<div class="panel panel-default" style="overflow-x: scroll;">
				    <div class="panel-heading">
			            <label><strong>CATEGORY</strong></label>
				    </div>
				    <div class="panel-body">
					    <div id="myJstree">
					    	${sessionScope.userMenu }
						</div>
				    </div>
				</div>
	      	</div>
	      	<div class="col-xs-10" style="padding-bottom: 70px;">
				<jsp:include page="${sPage }"></jsp:include>
	      	</div>
      	</div>
	  </article>

      <footer class="navbar navbar-default navbar-fixed-bottom" role="navigation">
      	  <div class="container">
            <p class="text-muted credit pager" style="font-size: 12px;">
            	ⓒ2014 POSCO ICT, All Rights Reserved. <a href="mailto:help@solutionpot.co.kr">help@solutionpot.co.kr</a> |
            	Fabulous icons from <a href="http://glyphicons.com" target="_blank">Glyphicons</a>
            </p>
          </div>
      </footer>

	<div class="modal fade" id="passwordPop" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel" aria-hidden="true" data-backdrop="static"></div>

	<div class="remodal" data-remodal-id="modal" data-remodal-options="hashTracking: false"></div>

 <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> -->
<script src="${contextPath }/dist/jquery-ui/jquery-1.10.2-jquery.min.js"></script>
<!-- 모든 합쳐진 플러그인을 포함하거나 (아래) 필요한 각각의 파일들을 포함하세요 -->
<script src="${contextPath }/dist/bootstrap/js/bootstrap.min.js"></script>
<!-- Respond.js 으로 IE8 에서 반응형 기능을 활성화하세요 (https://github.com/scottjehl/Respond) -->
<!-- <script src="js/respond.js"></script> -->
<%-- <script src="${contextPath }/dist/jquery-ui/jquery-1.10.2.js"></script> --%>
<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
<script src="${contextPath }/dist/jquery-ui/jquery-ui.js"></script>
<script src="${contextPath }/dist/js/common.js"></script>
<script src="${contextPath }/dist/js/board.js"></script>
<script src="${contextPath }/dist/js/file.js"></script>
<script src="${contextPath }/dist/js/morgue2.js"></script>
<script src="${contextPath }/dist/js/licenseManagement.js"></script>
<script src="${contextPath }/dist/js/customUser.js"></script>
<script src="${contextPath }/dist/modal/jquery.remodal.js"></script>
<script src="${contextPath }/dist/jstree/jstree.js"></script>
<script type="text/javascript">
$(function() {
    $.ajaxSetup({
        beforeSend: function(xhr) {
         xhr.setRequestHeader("AJAX", true);
     },
     error: function(xhr, status, err) {
         if (xhr.status == 403) {
        	 sessionExpire("${contextPath }");
         } else {
        	 alertPopup("예외가 발생했습니다. 관리자에게 문의하세요.");
         }
     }
	});

	if("${changePassword}"){
		passCheck();
	}

	$( "#startDatepicker" ).datepicker();
	$( "#startDatepicker" ).change(function() {
		$( "#startDatepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	});

	$( "#setUpDatepicker" ).datepicker();
	$( "#setUpDatepicker" ).change(function() {
		$( "#setUpDatepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	});

	$( "#startDatepicker2" ).datepicker();
	$( "#startDatepicker2" ).change(function() {
		$( "#startDatepicker2" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	});

    $(window).scroll(function(){
        if($(window).scrollTop()>100) $('.top').fadeIn('slow'); // 100 픽셀을 초과하여 스크롤 된 다음 표시
        else $('.top').fadeOut('slow'); // 100 픽셀 이하인 경우 숨김
      });
      $('.top a').click(function () {
        $('html, body').animate({ scrollTop:0 }, 'slow');
        return false;
    });

    $('#myJstree').jstree({
    	"state" : { "key" : "myJstree" },
    	"plugins" : [ "themes", "state", "wholerow" ] });
});
</script>
</body>
</html>
