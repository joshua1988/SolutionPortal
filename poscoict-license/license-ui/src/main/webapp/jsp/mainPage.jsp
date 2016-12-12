<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="${contextPath}/dist/materialize/css/materialize.min.css"  media="screen,projection"/>
<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

<!-- jquery-ui css -->
<link rel="stylesheet" href="${contextPath }/dist/modal/jquery.remodal.css">
<link rel="stylesheet" href="${contextPath }/dist/css/docs.css">
<style type="text/css">
.top { position:fixed;right:5%;bottom:10%; z-index:999; display:none; }
.top IMG {
	width: 30px; height: 30px;
	zoom: 1;
    filter: alpha(opacity=50);
    opacity: 0.5;
}

/* fixed footer*/
body {
  display: flex;
  min-height: 100vh;
  flex-direction: column;
}
main {
  flex: 1 0 auto;
	font-size: 14px;
}
footer.page-footer {
	margin-top: 0;
}
/*container*/
.container {
	width: 90%;
	max-width: 1600px;
	/*margin: 0 5%;*/
}
.row {
	margin-bottom: 0;
}
@media only screen and (min-width: 993px) {
  .container {
    width: 90%;
  }
	.brand-logo {
		margin-left:0.75em;
	}
}
/*table layout*/
td {
	padding: 5px 5px;
}
/*tree collection padding*/
.collection .collection-item {
	padding: 10px 30px;
}
/*side nav icon alignment*/
.side-nav a {
	display: flex;
}
/*mobile 비공개 button*/
@media (max-width:600px) {
	header, nav, nav .button-collapse i {
		height:40px;
		line-height: 40px;
	}
	[type="checkbox"]+label {
		padding-left: 1.8rem;
		font-size: 0.8rem;
	}
	#unopened {
		width:32% !important;
		padding-left:5px !important;
	}
}
/*mobile button*/
@media (max-width:736px) {
	.btn {
		padding : 0 1.5rem;
	}
	.btnSection {
		text-align: center;
	}
	.btnGroup {
		float: none !important;
	}
	.viewInfo {
		text-align: center;
		padding: 0;
	}
	.replyInfo {
		padding: 0;
	}
	/*mobile UI*/
	.container {
		width: 100%;
	}
	.card-panel {
		padding: 0;
	}
	/*layout optimization based on mobile width*/
	.card .card-title {
		font-size:20px;
		font-weight:600 !important;
	}
	.card .card-content {
		padding:10px;
	}
	/*side nav divider*/
	.side-nav .divider {
		margin: 0;
	}
}
@media (min-width:800px) {
	.btnGroup {
		padding-top:5px;
	}
	.viewInfo {
		padding:5px;
	}
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
  <div class="top"><a href="#"><label style="font-size: 12px; color: gray;">맨위</label><img src="${contextPath }/dist/img/arrow_top.gif" alt="맨위"/></a></div>
	<header>
		<nav class="blue darken-1">
	    <div class="nav-wrapper">
	      <a href="#!" class="brand-logo" onclick="javascript:boardList('notice','NOTICE'); return false;">Solution Portal</a>
				<a href="#" data-activates="sidebar" class="button-collapse"><i class="material-icons">menu</i></a>
	      <ul class="right hide-on-med-and-down">
					<security:authorize ifAnyGranted="ROLE_U,ROLE_S,ROLE_D, ROLE_C">
		        <li>
							<a href="#" onclick="javascript:passPop('1'); return false;">
								<i class="material-icons left">lock</i>
								비밀번호 변경
							</a>
						</li>
					</security:authorize>
					<li><a href="logout"><i class="material-icons left">input</i>로그아웃</a></li>
	      </ul>
				<ul class="side-nav" id="sidebar">
					<li><a href="logout"><i class="material-icons">input</i>로그아웃</a></li>
					${sessionScope.userNavMenu}
	      </ul>
	    </div>
	  </nav>
	</header>

	<main>
		<div class="row container">
			<div class="container">
				<div class="col l3 m4 s12 hide-on-small-only" id="tree">
					<ul class="collapsible" data-collapsible="accordion">
						${sessionScope.userMenu}
				  </ul>
				</div>
				<div class="col l9 m8 s12">
					<jsp:include page="${sPage }"></jsp:include>
				</div>
			</div>
	  </div>
	</main>
	<footer class="page-footer blue darken-1" style="padding:18px 0;">
		<div class="container center-align white-text">
			ⓒ2014 POSCO ICT, All Rights Reserved.
		</div>
  </footer>

	<%-- 비번 변경 팝업 --%>
	<!-- Modal Trigger -->
	<a id="modalTest" class="waves-effect waves-light btn modal-trigger" href="#modal1" style="display:none;">Modal</a>
	<!-- Modal Structure -->
	<div id="modal1" class="modal">
	</div>

	<div class="remodal" data-remodal-id="modal" data-remodal-options="hashTracking: false"></div>

<%-- Materialize CSS --%>
<script src="${contextPath }/dist/jquery/jquery.min.js"></script>
<script src="${contextPath }/dist/materialize/js/materialize.min.js"></script>
<%-- etc libraries --%>
<script src="${contextPath }/dist/js/common.js"></script>
<script src="${contextPath }/dist/js/board.js"></script>
<script src="${contextPath }/dist/js/file.js"></script>
<script async src="${contextPath }/dist/js/morgue2.js"></script>
<script async src="${contextPath }/dist/js/licenseManagement.js"></script>
<script async src="${contextPath }/dist/js/customUser.js"></script>
<script async src="${contextPath }/dist/modal/jquery.remodal.js"></script>
<script src="${contextPath }/dist/js/tree.js"></script>
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

  $(window).scroll(function(){
    if($(window).scrollTop()>100) $('.top').fadeIn('slow'); // 100 픽셀을 초과하여 스크롤 된 다음 표시
    else $('.top').fadeOut('slow'); // 100 픽셀 이하인 경우 숨김
  });
  $('.top a').click(function () {
    $('html, body').animate({ scrollTop:0 }, 'slow');
    return false;
  });

});

	var treeKey = sessionStorage.getItem("treeKey");
	var navActiveKey = sessionStorage.getItem("navActiveKey");
	var activeKey = sessionStorage.getItem("treeActiveKey");

	$(document).ready(function(){
		$(".button-collapse").sideNav();
		$('select').material_select();
		$('.modal-trigger').leanModal();
    $('.datepicker').pickadate({
      selectMonths: true, // Creates a dropdown to control month
      selectYears: 15, // Creates a dropdown of 15 years to control year
			format: 'yyyy-mm-dd',
			monthsFull: [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthsShort: [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			weekdaysFull: [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],
			weekdaysShort: [ '일', '월', '화', '수', '목', '금', '토' ]
			// 날짜 선택시 종료
			// onSet: function( arg ){
			// 	if ( 'select' in arg ){
			// 		this.close();
			// 	}
			// }
    });

		// date picker format
		// var $input = $('.datepicker').pickadate();
		// var picker = $input.pickadate('picker');
		// picker.set('select', '2016-04-20', { format: 'yyyy-mm-dd' });

    // Materialize.updateTextFields();
		// $('ul.tabs').tabs();

		treeActive();
		navTreeActive();
		treeActiveValidation();

	});
</script>
</body>
</html>
