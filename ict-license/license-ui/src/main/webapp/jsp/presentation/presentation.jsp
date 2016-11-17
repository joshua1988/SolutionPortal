<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<title>Insert title here</title>
</head>
<body data-spy="scroll">
        <div class="col-xs-9" style="padding-top: 20px;">
            <div id="uCUBE" class="row">
			 	<div class="well">
			 	<h2><strong>u-CUBE</strong></h2>
			 	u-CUBE는 기업 내 또는 기업간 다양한 시스템을 어플리케이션 또는 서비스 레벨에서 유기적으로 연동하여 복잡한 IT 시스템을 신속하고 유연하게 통합하는 EAI 솔루션 입니다.
			 	</div>
              <hr>
			</div>
              
            <div class="row">  
            <h4 id="uCUBE-1"><span class="text-primary">u-CUBE - 특징</span></h4>
			 	<ul><ins class="text-danger">신뢰성 및 안정성 보장</ins>
				  <li>신뢰성 있는 데이터 전달 보장</li>
				  <li>장애 사전감지 및 재연결 시도</li>
				  <li>데이터 전송 오류 실시간 감지/통보</li>
				</ul>
			 	<ul><ins class="text-danger">개발생산성 향상 및 사용자 편의성</ins>
				  <li>인터페이스 전문 표준화</li>
				  <li>어플리케이션 로직과 인터페이스의 분리</li>
				  <li>글로벌 지원 및 다양한 프로토콜 지원</li>
				  <li>다양한 시스템의 통합정보를 위한 저장소관리</li>
				</ul>
			 	<ul><ins class="text-danger">신속성 및 확장성 보장</ins>
				  <li>재사용 가능한 어댑터로 신속한 시스템 통합</li>
				  <li>제조현장의 다양한 공정시스템과 호환성 보장</li>
				  <li>벤더와 독립적 IT 통합 인프라 제공</li>
				  <li>표준화된 어플리케이션 연동 환경 제공</li>
				</ul>
			 	<ul><ins class="text-danger">품질 인증 및 수상내역</ins>
				  <li>'07.10 : Good Software 인증획득 (TTA)</li>
				  <li>'08.02 : 신소프트웨어 대상 정보통신부 장관상</li>
				  <li>'12.11 : 대한민국 소프트웨어 기술대상 우수상</li>
				</ul>
              <hr>
			 </div>
            
            <div class="row">  
            <h4 id="uCUBE-2"><span class="text-primary">u-CUBE - 구성</span></h4>
			 <p align="center">
			 	<img src="${contextPath }/jsp/presentation/img/ucube-1.png" class="img-responsive">
			 </p>
              <hr>
			</div> 
              
            <div class="row">  
            <h4 id="uCUBE-3"><span class="text-primary">u-CUBE - 주요기능</span></h4>
			 	<div class="table-responsive">
				  <table class="table table-bordered">
				    <thead>
				    	<tr>
				    		<th>구분</th>
				    		<th>주요기능</th>
				    		<th>설명</th>
				    	</tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td rowspan="2"><strong>Management</strong></td>
				    		<td>Monitor</td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>중앙 집중의 서비스 상태 실시간 모니터링</li>
								  <li>서비스 장애 실시간 감지 및 자동통보기능(SMS, 통합운영관리 연계 등)</li>
								</ul>
				    		</td>
				    	</tr>	
				    	<tr>
				    		<td>Analyzer</td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>데이터 발생 및 흐름 추적 및 분석</li>
								</ul>
				    		</td>
				    	</tr>	
				    	<tr>
				    		<td rowspan="5"><strong>Mediation</strong></td>
				    		<td>Service</td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>비동기 통신지원- Queue(1:1)/Topic(1:N) 방식지원
								  	<br>※ 동기식은 별도 어댑터로 서비스
								  </li>
								</ul>
				    		</td>
				    	</tr>	
				    	<tr>
				    		<td>Transmission</td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>Message, File, DB type transmission (Size에 따른 분할 전송)</li>
								  <li>Transaction Control 지원</li>
								</ul>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>Transformation</td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>Rule 기반 Data Mapping 및 변환기능 (XML, Flat file 등)</li>
								</ul>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>Global Support</td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>다양한 character-set 변환지원 (UTF-8, EUC-KR, EUC-CN, KSC-5601 등)</li>
								</ul>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>순차처리지원</td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>서비스간 정보처리 순서 제어 (HTTP)</li>
								</ul>
				    		</td>
				    	</tr>  
				    	<tr>
				    		<td colspan="2"><strong>Integration</strong></td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>다양한 OS 환경지원 (HP-UX, AIX, Solaris, Windows, Linux, VMS 등)</li>
								  <li>저사양의 Legacy 시스템 경량화 모듈제공</li>
								  <li>다양한 개발언어 지원 ( Java, C/C++, VB, .NET 등)</li>
								  <li>Package를 지원하는 Adapter 제공 (Oracle ERP, SAP 등)</li>
								  <li>IBM, Fiorano MQ와 연동 / B2Bi 지원</li>
								</ul>
				    		</td>
				    	</tr>  	
				    	<tr>
				    		<td colspan="2"><strong>Security</strong></td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>SSL 기반의 인증 및 암 · 복호화 가능</li>
								</ul>
				    		</td>
				    	</tr> 
				    	<tr>
				    		<td colspan="2"><strong>High Availability</strong></td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>다양한 서버 및 서버 이중화 구성 지원
								  	<br>- 장애시점 데이터 자동복구 및 로그관리
								  </li>
								</ul>
				    		</td>
				    	</tr> 
				    </tbody>
				  </table>
				</div>
              <hr> 
			</div> 
              
            <div class="row">  
            <h4 id="uCUBE-4"><span class="text-primary">u-CUBE - 도입효과</span></h4>
			 	<div class="alert alert-warning">시스템 가용성과 안정성 보장</div>
			 	<div class="alert alert-warning">추가 I/F 신속성 및 확장성 향상</div>
			 	<div class="alert alert-warning">중앙집중적 관리로 효율성 확보</div>
			 	<div class="alert alert-warning">운영 및 개발 시간단축</div>
              <hr>
			</div>
              
            <div class="row">  
            <h4 id="uCUBE-5"><span class="text-primary">u-CUBE - 구축사례</span></h4>
			 <p>
			 	<strong>국내:</strong> POSCO 및 패밀리사(포스코에너지, 엔투비, 포스코엔지니어링, 포스하이메탈, SNNC 등), 한국타이어, 공군C41, 코리아e플랫폼, KT커머스 등 
			 	<br><strong>해외:</strong> POSCO 베트남, 멕시코, 말레이시아, 중국, 인도네시아, 인도 등
			 </p>
              <hr>                                        
			</div> 
            
            <br>  
            <div id="GlueFramework" class="row">  
			 	<div class="well">
			 	<h2><strong>Glue Framework</strong></h2>
			 	소프트웨어 발전과 함께 매우 빠른 속도로 복잡성이 증가하고 있는 환경에서 일정 수준의 균일
				한 품질을 가진 애플리케이션을 적절한 납기에 개발하기 위해서는 표준화된 프레임웍이 필요합
				니다. Glue Framework은 프로그램 재사용에 특화된 표준화된 Framework로 대규모 기업 어플
				리케이션의 아키텍처를 표준화하여 플랫폼과 벤더에 종속되지 않고 쉽고 빠르게 설계/개발이 가능합니다.
				</div>
			 <p align="center">
				<img src="${contextPath }/jsp/presentation/img/GlueFramework-0.png" class="img-responsive">
			 </p>
              <hr>  
			</div>
              
            <div class="row">  
            <h4 id="GlueFramework-1"><span class="text-primary">Glue Framework - 특징</span></h4>
			 	<ul><ins class="text-danger">개발 편리성 제공</ins>
				  <li>비즈니스 로직을 프로세스화하여 개발 집중력 향상</li>
				  <li>설계명세서 자동화 기능 제공</li>
				  <li>Reusable Component를 변경없이 재사용</li>
				</ul>
				<ul><ins class="text-danger">표준 기반의 독립성 보장</ins>
				  <li>표준 아키텍처 및 오픈 소스 채택</li>
				  <li>벤더 (WAS 및 Framework) 어댑터 적용 가능</li>
				  <li>UI / Non-UI 동시 처리 가능</li>
				</ul>
				<ul><ins class="text-danger">검증된 Framework</ins>
				  <li>다수 프로젝트 수행을 통해 안정성 검증</li>
				  <li>검증된 Reusable component 사용</li>
				</ul>
				<ul><ins class="text-danger">4 Tier 기반 Layered 아키텍쳐</ins>
				  <li>화면 개발과 비즈니스 로직 개발 분리</li>
				  <li>데이터와 비즈니스 로직 개발 분리</li>
				  <li>타 시스템 I/F 처리 기능 제공</li>
				</ul>
              <br>
              <hr> 
			</div> 
              
            <div class="row">  
            <h4 id="GlueFramework-2"><span class="text-primary">Glue Framework - 구성</span></h4>
			 <p align="center">
			 	<img src="${contextPath }/jsp/presentation/img/GlueFramework-1.png" class="img-responsive">
			 </p>
			  <br>
              <hr> 
			</div> 
              
            <div class="row">  
            <h4 id="GlueFramework-3"><span class="text-primary">Glue Framework - 주요기능</span></h4>
			 	<div class="table-responsive">
				  <table class="table table-bordered">
				    <thead>
				    	<tr>
				    		<th colspan="2">구분</th>
				    		<th>내용</th>
				    	</tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td rowspan="2"><strong>Presentation</strong></td>
				    		<td>User InterFace</td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>최종사용자에게 필요한 정보를 제공하는 Web화면</li>
								  <li>GUI용 Reusable Component 기능 제공</li>
								</ul>
				    		</td>
				    	</tr>
				 		<tr>
				    		<td>Wrapper</td>
				    		<td>화면간 처리 흐름을 담당하고, Business Controller를 호출하는 기능</td>
				    	</tr>
				    	<tr>
				    		<td rowspan="2"><strong>Business</strong></td>
				    		<td>Biz Controller</td>
				    		<td>Business Logic Flow를 담당</td>
				    	</tr>
				 		<tr>
				    		<td>Activity</td>
				    		<td>Business Logic을 구성하는 단위</td>
				    	</tr>
				    	<tr>
				    		<td><strong>Model</strong></td>
				    		<td>DAO (Data Access Object)</td>
				    		<td>비즈니스의 정보를 변경하기 위한 Database Data 변경 기능</td>
				    	</tr>
				    	<tr>
				    		<td colspan="2"><strong>Integration</strong></td>
				    		<td>
				    			<ul style="margin: 0; padding-left: 10px;">
								  <li>타 System, Service간 Interface 제공, Message 송수신(u-CUBE)</li>
								  <li>사용자와 화면 및 메뉴 관리(Glue Security 별도), Job Scheduler</li>
								</ul>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td rowspan="4"><strong>Technical</strong></td>
				    		<td>DTO (Data Transfer Object)</td>
				    		<td>모든 Layer의 Data에 대한 표준 I/F 및 Access 방법 제공</td>
				    	</tr>
				    	<tr>
				    		<td>Logging &amp; Messaging</td>
				    		<td>Logging, Exception, Messaging, Memory Cache 등</td>
				    	</tr>
				    	<tr>
				    		<td>Master Data</td>
				    		<td>각종 업무에서 공통으로 사용되는 업무기준, 코드, 항목 (Data Dictionary)을 표준화한 데이터를 관리 (Glue Master 적용 시)</td>
				    	</tr>
				    	<tr>
				    		<td>개발 편의기능</td>
				    		<td>Activity Diagram 작성, Service XML Generator, 개발환경 구성 Wizard IDE툴 기반의 Plug-in (Eclipse)</td>
				    	</tr>				    	
				    </tbody>
				  </table>
				</div>
			  <br>	
              <hr> 
			</div> 
              
            <div class="row">  
            <h4 id="GlueFramework-4"><span class="text-primary">Glue Framework - 도입효과</span></h4>
			 	<ul><ins class="text-danger">개발 비용 절감</ins>
				  <li>경쟁 Framework 대비 낮은 도입 비용</li>
				  <li>개발 투자 인력 시간 축소에 따른 비용 절감</li>
				</ul>
				<ul><ins class="text-danger">개발 기간 단축</ins>
				  <li>단순한 I/F 및 개발 방법 제공</li>
				  <li>비즈니스 중심으로 설계 단순화</li>
				</ul>
				<ul><ins class="text-danger">프로젝트 품질 향상</ins>
				  <li>Framework 적용으로 프로젝트 품질 향상</li>
				  <li>합리적 비용으로 시스템 구축 가능</li>
				</ul>
				<ul><ins class="text-danger">다양한 솔루션 개발 및 응용가능</ins>
				  <li>어플리케이션 재활용 가능</li>
				  <li>다양한 비즈니스 솔루션 제공으로 경쟁력 강화</li>
				</ul>
				<br>
              <hr> 
			 </div>
              
            <div class="row">  
            <h4 id="GlueFramework-5"><span class="text-primary">Glue Framework - 적용사례</span></h4>
			 <p>
			 	POSCO 및 패밀리사, 현대하이스코, 유니온 스틸, 동부제철, 고려제강, 아모레퍼시픽, 국민연금 등 다수
			 </p>
			 <br>
              <hr>  
			</div>
			
			<div class="row">  
			<h4 id="GlueFramework-6"><span class="text-primary">Glue 제품군 아키텍쳐</span></h4>
				<br>
			 <p align="center">
			 	<img src="${contextPath }/jsp/presentation/img/GLUE-1.png" class="img-responsive">
			 </p>
			 <br>
              <hr>
            </div>
              
            <div class="row">    
            <h4 id="GlueFramework-7"><span class="text-primary">각 Glue 제품 역할</span></h4>
            	<br>
			 <p align="center">
			 	<img src="${contextPath }/jsp/presentation/img/GLUE-2.png" class="img-responsive">
			 </p>
			 <br>
              <hr>
             </div>  
                 
            <div id="GlueMaster" class="row">     
			 	<div class="well">
			 	<h2><strong>Glue Master</strong></h2>
			 	Glue Master는 표준용어, 항목, 코드에 대한 데이타를 체계적으로 관리할 수 있도록 지원하고 
			 	비즈니스 규칙과 계산식을 사전등록하여 어플리케이션 개발을 원활하게 지원하는 데이타 통합관리 솔루션입니다.
			 	</div>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/GlueMaster-0.png" class="img-responsive">
				 </p>
			  	 <br>	 
              	 <hr> 
			 </div>
              
            <div class="row">  
            <h4 id="GlueMaster-1"><span class="text-primary">Glue Master - 특징</span></h4>
			 	<ul><ins class="text-danger">표준 용어 및 항목 관리</ins>
				  <li>유사 의미(동의어) 등 다양한 지원</li>
				  <li>DB설계 결과를 표준항목과 Cross Check 가능</li>
				  <li>표준용어 및 항목 데이터 생성, 변경관리 체계화</li>
				</ul>
				<ul><ins class="text-danger">코드 관리의 체계화</ins>
				  <li>마스터/트랜잭션/카테고리 개념 적용</li>
				  <li>코드 상태, 유형, 조직 등 다양한 코드 검색</li>
				  <li>코드 생성, 변경 관리 체계화</li>
				</ul>
				<ul><ins class="text-danger">업무 Rule 기반 관리</ins>
				  <li>업무 기준별 (일반, 판단) 사전 등록 및 활용 가능</li>
				  <li>다양한 계산 수식 사전 등록 및 활용 가능</li>
				</ul>
				<ul><ins class="text-danger">다양한 편의기능 제공</ins>
				  <li>엑셀 import/export 기능 지원</li>
				  <li>I/F 전문 및 포맷 관리, 메시지 출력 지원</li>
				  <li>Glue Master API를 통한 애플리케이션 연동</li>
				</ul>
				<br>
              <hr>
			 </div>
              
            <div class="row">  
            <h4 id="GlueMaster-2"><span class="text-primary">Glue Master - 구성</span></h4>
			 <p align="center">
   				<img src="${contextPath }/jsp/presentation/img/GlueMaster-1.png" class="img-responsive">
			 </p>
			 <br>
              <hr>
			</div> 
              
            <div class="row">  
            <h4 id="GlueMaster-3"><span class="text-primary">Glue Master - 주요기능</span></h4>
			 	<div class="table-responsive">
			 	<table class="table table-bordered">
				    <thead>
				    	<tr>
				    		<th colspan="2">구 분</th>
				    		<th style="width: 70%;">내 용</th>
				    	</tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td rowspan="2"><strong>용어관리</strong></td>
				    		<td>표준용어</td>
				    		<td>표준용어 목록, 영문 FullName 검색, 표준용어 검색, 동의어 포함 검색, 표준 용어 목록 Excel 출력, 
				    			여러 국가의 언어로 용어설명을 추가하여 관리가 가능
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>표준용어 신청/조회</td>
				    		<td>표준용어 검색,신규 표준용어 신청 등록,등록요청 표준용어 확정 및 반려</td>
				    	</tr>
				    	<tr>
				    		<td rowspan="3"><strong>표준항목관리</strong></td>
				    		<td>표준항목</td>
				    		<td>표준항목 목록, 표준항목 검색, 표준ID 검색, 시스템/부문별 표준항목 검색, 동의어 포함 검색, 
				    			표준항목 Excel 출력, 표준항목 상세조회, 연결코드 검색
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>표준항목 신청 /조회</td>
				    		<td>신규 표준항목 신청 및 처리결과 목록, 표준항목 신청 등록, 등록요청 표준항목 확정 및 반려</td>
				    	</tr>
				    	<tr>
				    		<td>표준항목 생성</td>
				    		<td>신규 표준항목 등록시 필요한 영문 ID 도우미</td>
				    	</tr>
				    	<tr>
				    		<td rowspan="2"><strong>코드관리</strong></td>
				    		<td>마스터 코드</td>
				    		<td>마스터 코드 목록, 상태별 조회, 코드유형(단순,조합,범위)별 조회, 코드/부분/담당/ID별 검색, 
				    			코드목록 Excel 출력, 코드목록 Excel 등록, 신규코드 등록, 등록코드 수정 (카테고리 등록, 값 등록, 
				    			카테고리 Excel 등록, 카테고리 Excel 출력) , Code 테스트, 코드값 내용조회, 코드값 Excel 출력, 
				    			마스타 코드 내용조회, 마스타코드 내용 Excel 출력, 카테고리별 코드내용 검색, JOC 동기화
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>트랜잭션 코드</td>
				    		<td>트랜잭션 코드 목록, 상태별 트랜잭션 목록, 코드/부분/담당/ID별 검색, 목록Excel 출력, Code 테스트, 
				    			마스타 코드 내용조회, 마스타코드 내용 Excel 출력, 카테고리별 코드내용 검색
				    		</td>
				    	</tr>
				    	<tr>
				    		<td colspan="2"><strong>업무기준관리</strong></td>
				    		<td>업무 기준 목록, 상태별 조회, 기준구분별(일반/판단) 조회, 기준명 조회, 일반기준/조건판단 기준상세조회, 
				    			업무기준등록(조건,판단), JOC 동기화, 업무기준 수정(조건,판단), 목록 Excel 출력, 레이아웃 조회, 변경이력 조회, 
				    			일반 기준 테스트, 레이아웃 Excel 출력
				    		</td>
				    	</tr>
				    	<tr>
				    		<td colspan="2"><strong>계산수식관리</strong></td>
				    		<td>계산수식 목록, 상태별 조회, 구분(단순/판단)별 조회, 계산식명 조회, 계산식 상세내용조회, 
				    			계산식 테스트, 계산식 변경이력, 계산식 등록, 계산식 수정
				    		</td>
				    	</tr>
				    	<tr>
				    		<td colspan="2"><strong>인터페이스 전문관리</strong></td>
				    		<td>인터페이스 전문 목록, 송수신 체인별 전문 목록 조회, 전문ID 조회, 전문 내용 수정, 전문삭제, 포멧삭제</td>
				    	</tr>
				    	<tr>
				    		<td colspan="2"><strong>화면출력 메시지 관리</strong></td>
				    		<td>화면 출력 메시지 목록, 메시지 등록, 메시지 수정, 메시지 목록 Excel 등록, 메시지 목록 Excel 출력,구분별(고정형/가변형) 메시지 조회</td>
				    	</tr>
				    	<tr>
				    		<td colspan="2"><strong>Glue Master API</strong></td>
				    		<td>Glue Master 에 등록 및 관리되는 정보를 응용 App에서 적용하기 위한 API 사용법</td>
				    	</tr>
				    </tbody>
				 </table>
				 </div>
			 <br>
              <hr>
			</div>
              
            <div class="row">  
            <h4 id="GlueMaster-4"><span class="text-primary">Glue Master - 도입효과</span></h4>
			 	<ul><ins class="text-danger">업무 기준관리로 업무처리 신속성 향상</ins>
				  <li>업무 담당자와 IT 담당자 간 의사소통 편리</li>
				  <li>신속한 현업 요구사항 대응</li>
				</ul>
				<ul><ins class="text-danger">데이터 통합 관리를 통한 중복 감소</ins>
				  <li>표준 용어, 항목, 코드를 체계적으로 관리</li>
				  <li>정보 통합 및 신규 업무확장 용이</li>
				</ul>
				<ul><ins class="text-danger">프로그램 변경률 감소</ins>
				  <li>표준화에 따른 프로그램 변경 최소화</li>
				  <li>프로그램 로직의 단순화</li>
				</ul>
				<ul><ins class="text-danger">시스템 유지보수의 편리성 증가</ins>
				  <li>업무 상호 간 I/F 변환 작업 편리</li>
				  <li>업무 변경에 따른 시스템 유지보수의 간편화</li>
				</ul>
				<br>
              <hr>
			</div> 
              
            <div class="row">  
            <h4 id="GlueMaster-5"><span class="text-primary">Glue Master - 구축사례</span></h4>
			 <p>
			 	포스코 및 패밀리사 (포스코 켐텍, 포스코 강판 등), 현대하이스코, 동부제철,
				고려제강, 유니온스틸 등
			 </p>
			 <br>
              <hr>
			</div> 
			
			
			
			<div id="GlueMobile" class="row">     
			 	<div class="well">
			 	<h2><strong>Glue Mobile</strong></h2>
			 	모바일 기반 비즈니스의 지속적인 증가와 다양한 모바일 앱 개발에 대응하기 위한 모바일 앱 개발에 필요한 
			 	기반환경 및 공통모듈을 미리 구현한 기반솔루션으로 모바일 웹앱과 하이브리드앱 개발 시에 개발생산성 향상과 
			 	품질 확보를 위한 프레임워크로 활용한다.
			 	</div>
			  	<br>	 
              	<hr> 
			</div>
			
			<div class="row">  
            <h4 id="GlueMobile-1"><span class="text-primary">Glue Mobile - 특징</span></h4>
			 	<ul><ins class="text-danger">개방형 표준준수</ins>
				  <li>공개SW기반의 범용화된 기술</li>
				  <li>특정사업자에 대한 종속성 배제</li>
				  <li>표준기반 상호 운영성보장</li>
				</ul>
				<ul><ins class="text-danger">재사용성 향상</ins>
				  <li>프레임워크 기반 재사용증대</li>
				  <li>모듈화 기반 품질향상</li>
				  <li>지속적인 자산화</li>
				</ul>
				<ul><ins class="text-danger">다양한 플랫폼지원</ins>
				  <li>One Source Multi Use</li>
				  <li>디바이스 별 웹 API 제공</li>
				  <li>개발 원가절감 기여</li>
				</ul>
				<ul><ins class="text-danger">사용편의성/확장성</ins>
				  <li>통합개발환경지원</li>
				  <li>웹 프레임워크와 동일패턴 개발</li>
				  <li>모바일 통합솔루션확장</li>
				</ul>
				<br>
				
				<em>※ 수상 내역 : 『2014대한민국소프트웨어기술대상』 우수상</em>
				<br>
              <hr>
			</div>
			 
			<div class="row">  
            	<h4 id="GlueMobile-2"><span class="text-primary">Glue Mobile - 구성</span></h4>
				<p align="center">
   					<img src="${contextPath }/jsp/presentation/img/GlueMobile-0.png" class="img-responsive">
			 	</p>
			    <br>
                <hr>
			</div>  
			
			<div class="row">  
            <h4 id="GlueMobile-3"><span class="text-primary">Glue Mobile - 주요기능</span></h4>
			 	<div class="table-responsive">
			 	<table class="table table-bordered">
				    <thead>
				    	<tr>
				    		<th colspan="2">구 분</th>
				    		<th style="width: 50%;">설 명</th>
				    	</tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td rowspan="6" style="vertical-align: middle;"><strong>모바일UI 컴포넌트</strong></td>
				    		<td>UI Widgets</td>
				    		<td>사용자 인터페이스를 위한 컴포넌트</td>
				    	</tr>
				    	<tr>
				    		<td>Graph Library</td>
				    		<td>선, 바, 파이 차트그래프</td>
				    	</tr>
				    	<tr>
				    		<td>Databox</td>
				    		<td>날짜/시간 선택</td>
				    	</tr>
				    	<tr>
				    		<td>Validation</td>
				    		<td>입력 유형성 점검</td>
				    	</tr>
				    	<tr>
				    		<td>Datagrid</td>
				    		<td>그리드(테이블)</td>
				    	</tr>
				    	<tr>
				    		<td>Code Template</td>
				    		<td>코드 템플릿</td>
				    	</tr>
				    	<tr>
				    		<td rowspan="12" style="vertical-align: middle;"><strong>모바일 장치 접근/제어 API</strong></td>
				    		<td>Accelerator</td>
				    		<td>가속도조회/중지</td>
				    	</tr>
				    	<tr>
				    		<td>GPS</td>
				    		<td>위치정보조회</td>
				    	</tr>
				    	<tr>
				    		<td>Vibrator</td>
				    		<td>진동 알림</td>
				    	</tr>
				    	<tr>
				    		<td>Camera</td>
				    		<td>사진촬영</td>
				    	</tr>
				    	<tr>
				    		<td>Contacts</td>
				    		<td>연락처 조회</td>
				    	</tr>
				    	<tr>
				    		<td>Media</td>
				    		<td>Media조회/재생</td>
				    	</tr>
				    	<tr>
				    		<td>FileReaderWriter</td>
				    		<td>파일정보조회</td>
				    	</tr>
				    	<tr>
				    		<td>Network Info</td>
				    		<td>네트워크조회</td>
				    	</tr>
				    	<tr>
				    		<td>Device Info</td>
				    		<td>메타정보조회</td>
				    	</tr>
				    	<tr>
				    		<td>Push Connect</td>
				    		<td>모바일 푸쉬 서버연계</td>
				    	</tr>
				    	<tr>
				    		<td>QR/Bar Code</td>
				    		<td>QR/Bar 코드인식 및 생성</td>
				    	</tr>
				    	<tr>
				    		<td>NFC</td>
				    		<td>NFC 읽기/쓰기 기능</td>
				    	</tr>
				    	<tr>
				    		<td rowspan="8" style="vertical-align: middle;"><strong>통합개발도구</strong></td>
				    		<td>프로젝트생성</td>
				    		<td>모바일 프로젝트 Wizard</td>
				    	</tr>
				    	<tr>
				    		<td>팔레트</td>
				    		<td>UI 컴포넌트의 도구내 통합</td>
				    	</tr>
				    	<tr>
				    		<td>디자이너</td>
				    		<td>UI 화면 및 비즈니스 로직구현</td>
				    	</tr>
				    	<tr>
				    		<td>설계</td>
				    		<td>DB 설계 연계</td>
				    	</tr>
				    	<tr>
				    		<td>테스트</td>
				    		<td>테스트 도구</td>
				    	</tr>
				    	<tr>
				    		<td>에뮬레이터</td>
				    		<td>모바일 앱 직관적인 확인</td>
				    	</tr>
				    	<tr>
				    		<td>소스관리</td>
				    		<td>모바일 앱의 소스버전관리</td>
				    	</tr>
				    	<tr>
				    		<td>빌드관리</td>
				    		<td>모바일 Native OS 별 빌드</td>
				    	</tr>
				    </tbody>
				 </table>
				 </div>
			 <br>
              <hr>
			</div>
			
		    <div class="row">  
            <h4 id="GlueMobile-4"><span class="text-primary">Glue Mobile - 도입효과</span></h4>
			 	<div class="alert alert-warning">사용자 친화적인 앱 개발</div>
			 	<div class="alert alert-warning">개발생산성 향상 및 품질 확보</div>
			 	<div class="alert alert-warning">서비스 유지보수 용이</div>
			 	<div class="alert alert-warning">전사 모바일 시스템 TCO 점감</div>
              <hr>
			</div>
			
			<div class="row">  
            <h4 id="GlueMobile-5"><span class="text-primary">Glue Mobile - 구축사례</span></h4>
			 <p>
			 	POSCO 안전방재 작업현장 위험인식 모바일 서비스 시범 적용
			 </p>
			 <br>
              <hr>
			</div>  
              
            <div id="PosBee" class="row">  
			 	<div class="well">
			 	<h2><strong>PosBee (미들웨어 솔루션)</strong></h2>
			 	머신-To-머신 간의 인터페이스를 위해서 RFID 시스템, 센서 및 어플리케이션 프로그램 등 다양한 이 기종간의 연결을
				위해서 발생하는 대량의 raw 데이터를 수집, 가공하여 응용서비스에게 전달하는 미들웨어 소프트웨어
				</div>
              <hr>
			</div> 
              
            <div class="row">   
            <h4 id="PosBee-1"><span class="text-primary">PosBee - 특징</span></h4>
			 	<ul><ins class="text-danger">유연성/ 이식성/ 호환성 보장</ins>
				  <li>EPC 글로벌 표준준수 (EPC Tag, ALE 등)</li>
				  <li>XML 기반의 정보 모델 제공으로 확장이 용이</li>
				  <li>자바기반 솔루션으로 벤더에 종속적이지 않음</li>
				</ul>
				<ul><ins class="text-danger">통합 사용자 관리 도구</ins>
				  <li>센서, RFID리더, 프린터 등 상태 모니터링</li>
				  <li>PosBee Server 상태 및 로그 정보</li>
				  <li>다양한 장치 시뮬레이터 제공</li>
				</ul>
				<ul><ins class="text-danger">경량화 솔루션</ins>
				  <li>낮은 시스템 사양에서 구동 (No WAS, DB)</li>
				  <li>표준화된 다양한 장치 어댑터 확보</li>
				</ul>
				<ul><ins class="text-danger">워크 플로우 기반 모델링</ins>
				  <li>워크 픞로우 기반의 태스크 정의</li>
				  <li>컴포넌트 기반 비즈니스 모델링</li>
				</ul>
				<br>
              <hr>
			</div> 
              
            <div class="row">  
            <h4 id="PosBee-2"><span class="text-primary">PosBee - 구성</span></h4>
			 <p>
			 	디바이스 연동을 Reader 인터페이스와 내부 신호처리를 위한 기준컴포넌트(어댑터, 필터, 리포터)와 응용
				서비스 바인딩을 위한 ALE 서비스로 구성
			 </p>
			 <p align="center">
				<img src="${contextPath }/jsp/presentation/img/posbee-1.png" class="img-responsive">
			 </p>
			 <br>
              <hr>
			</div> 
              
            <div class="row">   
            <h4 id="PosBee-3"><span class="text-primary">PosBee - 주요기능</span></h4>
			 <p align="center">
			 	<img src="${contextPath }/jsp/presentation/img/posbee-2.png" class="img-responsive">
			 </p>
			 <br>
              <hr>
			</div> 
              
            <div class="row">   
            <h4 id="PosBee-4"><span class="text-primary">PosBee - 도입효과</span></h4>
			 	<div class="alert alert-warning">
			 		<strong>시스템 구축비용 최적화:</strong> 다양한 디바이스 연계를 경험을 바탕으로 다량의 어댑터 DB가 확보되어 있어 시스템 구축 기간이 단축
			 		<br><strong>타 솔루션대비 1/3 구축 비용절감</strong>
			 	</div>
			 	<div class="alert alert-warning">
			 		<strong>시스템 확장용이:</strong> 디바이스 인터페이스가 Pluggable 구조로 되어 있어 신규 장비의 추가를 통한 시스템의 확장이 용이
			 		<br><strong>시스템 확장 시 복잡도가 1/2 축소</strong>
			 	</div>
			 	<div class="alert alert-warning">
			 		<strong>안정적인 유지보수:</strong> 디바이스 인터페이스에 대한 표준화된 기준을 통해 시스템이 관리되어 현장에서 발생하는 여러 형태의 이슈에 빠른 대응이 가능
			 		<br><strong>유지보수 운영 인력절감</strong>
			 	</div>
			 	<div class="alert alert-warning">
			 		<strong>디바이스 통합관리:</strong> 현장에서 사용되는 모든 디바이스를 통합 운영 관리하여 현장 데이터의 실시간 모니터링이 가능
			 		<br><strong>실시간 설비계획 및 공정스케줄링 가능</strong>
			 	</div>
			 	<br>
              <hr>
			</div> 
              
            <div class="row">   
            <h4 id="PosBee-5"><span class="text-primary">PosBee - 구축사례</span></h4>
			 <p>
			 	포스코 포항/광양 및 해외제철소의 출입보안, 무인계량 등에 적용되어 있으며, 후판 물류관리를 위한 유통사업 영역으로 확대
			 </p>
			 <p align="center">
			 	<img src="${contextPath }/jsp/presentation/img/posbee-3.png" class="img-responsive">
			 </p>
              <hr>
			</div> 
			
			<div id="SmartECM" class="row">     
				 	<div class="well">
				 	<h2><strong>SmartECM</strong></h2>
					SmartECM은 문서중앙화를 통해 개인문서를 회사 자산화하고 문서활용과 문서보안을 강화하여 일하는 
					방식을 개선시키는 혁신적인 기업형 ECM 솔루션입니다.
				 	</div>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/GlueMaster-0.png" class="img-responsive">
				 </p>
				 <br>
              <hr> 
			 </div>
			 
			<div class="row">     
            <h4 id="SmartECM-1"><span class="text-primary">SmartECM - 특징</span></h4>
				 <p>
					SmartECM은 국내 최초 문서중앙화 솔루션으로서 포스코 및 패밀리사에 안정적인 구축과 
					운영서비스를 제공하고 있으며 문서중앙화의 핵심 노하우가 반영되어 슬림화시킨 기업형 ECM 솔루션으로 진화하고 있습니다.
				 </p>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/smartecm-1.png" class="img-responsive">
				 </p>
				 <br>
              <hr> 
			</div>
			 
			<div class="row">     
            <h4 id="SmartECM-2"><span class="text-primary">SmartECM - 구성</span></h4>
				 <p>
					문서중앙화 및 문서 라이프 사이클을 관리할 수 있도록 최적의 시스템 구성체계를 제공합니다.
				 </p>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/smartecm-2.png" class="img-responsive">
				 </p>
				 <br>
              <hr> 
			</div>

			<div class="row">     
            <h4 id="SmartECM-3"><span class="text-primary">SmartECM - 주요기능</span></h4>
				 <p>
					SmatECM은 문서생성/등록, 문서활용, 문서폐기, 관리자 기능을 제공하고 있습니다.
				 </p>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/smartecm-3.png" class="img-responsive">
				 </p>
				 <br>
              <hr> 
			</div>
			
			<div class="row">     
            <h4 id="SmartECM-4"><span class="text-primary">SmartECM - 도입효과</span></h4>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/smartecm-4.png" class="img-responsive">
				 </p>
				 <br>
              <hr> 
			</div>			
			
			<div class="row">     
            <h4 id="SmartECM-5"><span class="text-primary">SmartECM - 구축사례</span></h4>
				 <p>
				 	포스코 및 패밀리 사, 고려제강, 공군2전대 등
				 </p>
				 <br>
              <hr> 
			</div>	
			
			<div id="POWIS" class="row">     
				 	<div class="well">
				 	<h2><strong>POWIS 업무정보시스템</strong></h2>
					POWIS는 신속한 업무공유 및 커뮤니케이션 툴의 장점을 극대화하여 보고를 간소화하고
					의사결정을 신속하게 하며, Smart Work를 지향하는 업무혁신 솔루션입니다.
				 	</div>
				 	<br>
              <hr> 
			 </div>
			 
			<div class="row">     
            <h4 id="POWIS-1"><span class="text-primary">POWIS - 특징</span></h4>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/powis-1.png" class="img-responsive">
				 </p>
				 <br>
              <hr> 
			</div>
			
			<div class="row">     
            <h4 id="POWIS-2"><span class="text-primary">POWIS - 구성</span></h4>
            	 <p>
            	 	회의 보고체계를 통해 보고문서 공유 및 신속한 의사결정을 할 수 있도록 최적의 시스템을 제공합니다.
            	 </p>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/powis-2.png" class="img-responsive">
				 </p>
				 <br>
              <hr> 
			</div>			
			
			<div class="row">     
            <h4 id="POWIS-3"><span class="text-primary">POWIS - 주요기능</span></h4>
            	 <p>
            	 	POWIS는 보고문서 등록/조회, 상위자 보고, 권한 위임, 관리자 기능을 제공하고 있습니다.
            	 </p>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/powis-3.png" class="img-responsive">
				 </p>
				 <br>
              <hr> 
			</div>	
			
			<div class="row">     
            <h4 id="POWIS-4"><span class="text-primary">POWIS - 도입효과</span></h4>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/powis-4.png" class="img-responsive">
				 </p>
				 <br>
              <hr> 
			</div>
			
			<div class="row">     
            <h4 id="POWIS-5"><span class="text-primary">POWIS - 구축사례</span></h4>
            	 <p>
            	 	포스코 및 패밀리사, 대우조선해양
            	 </p>
            	 <br>
              <hr> 
			</div>

			<div id="ERP" class="row">     
				 	<div class="well">
					 	<h2><strong>SMB ERP솔루션</strong></h2>
						<p class="text-info">중소기업 특성에 최적화된 ERP 솔루션</p>
						포스코의 글로벌 비즈니스 노하우로 다양한 업종의 ERP구축경험을 바탕으로 중소기업에 
						최적화된 ERP 구축 및 책임운영서비스를 제공해 드립니다. 
				 	</div>
			 		<label class="text-success">포스코ICT의 SMB ERP를 도입하면 이렇게 달라집니다.</label><br>
					<strong>기업경영의 효율성과 신속성이 증가합니다.</strong><br>
					- IFRS 연결결산체제 구축 및 판매 주문 등 업무 Lead Time단축으로 
					신속한 경영체계 구축 
					<ul><ins class="text-danger">예) SMB ERP 도입 후</ins>
					  <li>판매생산계획 수립 :1개월 → 즉시</li>
					  <li>월 결산: 3~4일 → 1일</li>
					  <li>원가계산 3~4일 → 2시간 이내</li>
					</ul>
					<label class="text-success">다양한 시스템과 연계된 차별화된 ERP 패키지</label><br>
					<p align="left">
				 		<img src="${contextPath }/jsp/presentation/img/erp-0.png" class="img-responsive">
				 	</p><br>
				 	<label class="text-success">포스코 ICT만의 구축방법론으로 구축합니다.</label><br>
				 	포스코 ICT ERP방법론은 5단계(Phase)로 구성되고, 각 단계마다 품질관리 및 프로젝트
   					관리가 포함되어 있으며, 어떻게 작업(Task)를 수행해야 되는지에 대한 가이드 및 템플릿을
   					제공합니다.<br><br>
   					<label class="text-success">포스코 ICT라서 가능합니다.</label><br>
   					 - 포스코 및 대외 유수기관의 적용을 통해 오랜 신뢰성과 높은 생산성 확보<br>
					 - 컨설팅, 구축, ITO까지 Total Service  가능<br>
					 - 국내 본사와 해외법인간의 Global 구축 및 운영 노하우 제공<br>
					 - PDA 등을 통한 Mobility 기능 제공<br>
					<br>
              <hr> 
			 </div>
			 
			<div class="row">     
            <h4 id="ERP-1"><span class="text-primary">SMB ERP - 개요</span></h4>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/erp-1-1.png" class="img-responsive">
				 </p>
				 <p>
				 	포스코의 글로벌 가공/물류 비즈니스 노하우와 다양한 업종의 ERP 구축경험을 바탕으로 
					기업별 특성에 최적화된 프로세스 컨설팅에서부터 구축 및 운영 서비스를 제공해 드립니다
				 </p>
				 <br>
				 <p align="center">
				 	<strong>시스템 구성업무</strong>
				 	<img src="${contextPath }/jsp/presentation/img/erp-1-2.png" class="img-responsive">
				 </p>
				 <br>
				 <p align="center">
				 	<strong>시스템 메뉴구성</strong>
				 	<img src="${contextPath }/jsp/presentation/img/erp-1-3.png" class="img-responsive">
				 </p>
              <hr> 
			</div>
			
			<div class="row">     
            <h4 id="ERP-2"><span class="text-primary">SMB ERP - 특징</span></h4>
            	 <p>
            	 	하나. 국내외 생산 유통되는 모든 철강제품의 품명, 규격약호, 이론중량 계산공식, 
      				단위중량 계산, 제품표현 방법을 탑재하여 즉시 적용이 가능
            	 </p>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/erp-2-1.png" class="img-responsive">
				 </p><br>
				 <p>
            	 	둘. 매출 이익율 분석을 통한 전략적 경영지원하며,  거래처별 매입, 매출, 채권/채무 
    				잔액을 직관적으로 표현
            	 </p>
            	 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/erp-2-2.png" class="img-responsive">
				 </p><br>
            	 <p>
            	 	셋. 분산된 창고의 입출고를 PDA로 처리, 어느 곳 에서나 실시간 재고 파악
            	 </p>
            	 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/erp-2-3.png" class="img-responsive">
				 </p>
              <hr> 
			</div>
			
			<div class="row">     
            <h4 id="ERP-3"><span class="text-primary">SMB ERP - 가동현황</span></h4>
            	 <p>
            	 	SMB ERP 가동 현황 : 가공센터(14개국, 30개법인), 판매법인(일본:1개사)
            	 </p>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/erp-3.png" class="img-responsive">
				 </p>
              <hr> 
			</div>
			
			
			<div id="i9" class="row">     
			 	<div class="well">
			 	<h2><strong>설비관리시스템 i9</strong></h2>
			 	POSCO 설비관리 노하우가 축적되어 있는 설비관리시스템, i9 <br>
			 	POSCO가 세계 TOP5 조강 생산량을 달성할 수 있었던 것은 방대한 설비를 항상 최상의 상태로 유지해왔기 때문입니다.
			 	<br>
			 	설비관리시스템 i9은 공장에 설치된 제조설비가 최적의 성능을 발휘하도록 작업 절차, 수행 시간, 필요 자재, 
			 	소요 인력 등을 미리 표준화 하여 기준정보를 정립하고, 작업계획과 일정관리를 통해 설비 보전 효율성을 높이는 솔루션입니다.
			 	</div>
				 <p align="center">
				 	<img src="${contextPath }/jsp/presentation/img/i9-0.png" class="img-responsive">
				 </p>
			  	 <br>	 
              	 <hr> 
			</div>
			
			<div class="row">  
            <h4 id="i9-1"><span class="text-primary">i9 - 특징 및 도입효과</span></h4>
			 	<ul><ins class="text-danger">예방 정비 프로세스</ins>
				  <li>예방 정비 프로세스 구축을 통해 고장발생 감소로 생산량 증대</li>
				  <li>주기적인 점검관리를 통해 대형사고 예방</li>
				</ul>
				<ul><ins class="text-danger">정비 비용 절감</ins>
				  <li>정비작업계획과 직결된 자재조달로 과잉재고, 악성재고 등 감소</li>
				  <li>고장으로 발생하는 수선비 절감</li>
				</ul>
				<ul><ins class="text-danger">이력분석을 통한 합리적 설비 관리</ins>
				  <li>외부 용역 업체의 불필요한 투입 인력 관리</li>
				  <li>계속적인 고장이나 과도한 수리비용이 지출되는 설비교체판단 가능</li>
				</ul>
				<ul><ins class="text-danger">시스템 편의성</ins>
				  <li>전사시스템(구매,자재,AP,결재,도면,인사 등) 과의 시스템 연계로 업무 편의 제공</li>
				  <li>Web 기반 셀프서비스를 통해 정보입력, 작업계획, 작업실적 등을 간편하게 처리함으로 사무 업무 감소</li>
				</ul>
				<br>
              <hr>
			</div>
			
			<div class="row">  
            <h4 id="i9-2"><span class="text-primary">i9 - 구성</span></h4>
			 <p align="center">
   				<img src="${contextPath }/jsp/presentation/img/i9-1.png" class="img-responsive">
			 </p>
			 <br>
              <hr>
			</div> 
			
			<div class="row">  
            <h4 id="i9-3"><span class="text-primary">i9 - 주요기능</span></h4>
			 	<div class="table-responsive">
			 	<table class="table table-bordered">
				    <thead>
				    	<tr>
				    		<th style="width: 15%;">기 능</th>
				    		<th style="width: 60%;">설 명</th>
				    		<th style="width: 25%;">상세기능</th>
				    	</tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td style="vertical-align: middle;"><strong>마스터관리</strong></td>
				    		<td>설비분류 및 사양점보, 점검기준, 수리기준, 외주사정보, 점검유형정보 등을 마스터정보로 관리하는 기능</td>
				    		<td>외주사관리, 설비기준코드, 설비사양관리, 점검표준항목, 점검유형항목관리, 점검기준, 수리기준</td>
				    	</tr>
				    	<tr>
				    		<td style="vertical-align: middle;"><strong>점검관리</strong></td>
				    		<td>점검기준에 의한 작업계획 생성 및 작업 일정조정에 의해 계획을 수립하고 계획된 점검 일정에 따라 실시된 작업 결과에 대하여 이상 발생으로 판단 시 수리 작업 계획 등록하는 기능</td>
				    		<td>점검계획, 점검실적, 점검Trend</td>
				    	</tr>
				    	<tr>
				    		<td style="vertical-align: middle;"><strong>수리관리</strong></td>
				    		<td>수리기준에 의한 작업계획 생성 및 작업 일정조정에 의해 계획을 수립하고, 수리 업무 단계별 연계 시스템과의 인터페이스 처리로 결제(EP), 재고(INV), 구매(PO), 비용(AP) 관련 업무를 수행하는 기능</td>
				    		<td>수리계획, 수리지시, 수리실적, 서비스입고, 작업품질평가, 수선비정산, 수리현황</td>
				    	</tr>
				    	<tr>
				    		<td style="vertical-align: middle;"><strong>고장관리</strong></td>
				    		<td>조업작업 시 발생할 수 있는 돌발 상황이나 점검작업 시 확인하지 못해서 발생할 수 있는 고장 현상을 접수하고 점검하여 고장으로 판단 시 수리 작업 계획 등록하는 기능</td>
				    		<td>고장신고, 고장접수, 고장실적</td>
				    	</tr>
				    	<tr>
				    		<td style="vertical-align: middle;"><strong>이력관리</strong></td>
				    		<td>설비별 점검/수리/고장 이력을 조회하고, 자재이력을 조회하는 기능</td>
				    		<td>설비이력, 자재수불이력, 자재예약현황</td>
				    	</tr>
				    	<tr>
				    		<td style="vertical-align: middle;"><strong>계측기관리</strong></td>
				    		<td>계측기 등록부터 폐기까지의 Life Cycle을 유지할 수 있도록 기준정보를 관리하고, 교정 계획 및 실적을 관리하는 기능</td>
				    		<td>계측기등록, 교정계획/실적,계측기폐기</td>
				    	</tr>
				    	<tr>
				    		<td style="vertical-align: middle;"><strong>지표분석</strong></td>
				    		<td>설비 실적정보를 이용한 지표 분석 정보를 제공하는 기능</td>
				    		<td>계획정비율 등 총 8종</td>
				    	</tr>
				    	<tr>
				    		<td style="vertical-align: middle;"><strong>모바일점검</strong></td>
				    		<td>RFID태그를 이용해 자동으로 설비를 인지하고 설비 점검 실적을 등록할 수 있는 기능</td>
				    		<td>모바일 점검실적</td>
				    	</tr>
				    </tbody>
				 </table>
				 </div>
			 <br>
              <hr>
			</div> 
			
			<div class="row">  
            <h4 id="i9-4"><span class="text-primary">i9 - 구축사례</span></h4>
			 	<ul><ins class="text-danger">국내</ins>
				  <li>SNNC1기 (2008)</li>
				  <li>포스하이메탈 (2010)</li>
				  <li>피엠씨텍 (2014)</li>
				  <li>SNNC2기 (2014)</li>
				  <li>그린가스텍 (2014)</li>
				  <li>피앤알 (2015)</li>
				</ul>
				<ul><ins class="text-danger">해외</ins>
				  <li>POSCOSS-VINA (포스코특수강 베트남) (2014)</li>
				</ul>
				<br>
              <hr>
			</div>
			
			
			
			<div id="ManagementSystem" class="row">     
			 	<div class="well">
			 	<h2><strong>법무 및 인장관리시스템</strong></h2>
			 	법률자문, 인장날인, 송무관리 등을 통해서 법무업무의 표준화와 법률적 리스크를 예방하기 위한 시스템입니다.
			 	</div>
			  	<br>	 
              	<hr> 
			</div>
			
			<div class="row">  
            <h4 id="ManagementSystem-1"><span class="text-primary">법무 및 인장관리시스템 - 시스템 개요</span></h4>
			 <p align="center">
   				<img src="${contextPath }/jsp/presentation/img/ManagementSystem-0.png" class="img-responsive">
			 </p>
			 <br>
              <hr>
			</div> 
			
			<div class="row">  
            <h4 id="ManagementSystem-2"><span class="text-primary">법무 및 인장관리시스템 - 구성</span></h4>
			 <p align="center">
   				<img src="${contextPath }/jsp/presentation/img/ManagementSystem-1.png" class="img-responsive">
			 </p>
			 <br>
              <hr>
			</div> 
			
			<div class="row">  
            <h4 id="ManagementSystem-3"><span class="text-primary">법무 및 인장관리시스템 - 주요기능</span></h4>
			 	<div class="table-responsive">
			 	<table class="table table-bordered">
				    <thead>
				    	<tr>
				    		<th>구 분</th>
				    		<th>기 능</th>
				    		<th style="width: 70%;">주요기능</th>
				    	</tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td rowspan="4"><strong>법인제증명발급</strong></td>
				    		<td>발급신청</td>
				    		<td>필요한 법인제증명 서류의 발급 신청하는 기능</td>
				    	</tr>
				    	<tr>
				    		<td>발급프로세스</td>
				    		<td>발급신청 업무프로세스 시원<br>
								발급신청 → 부서리더 승인 → 법무부서 확인 → 발급<br>
								각 승인 단계의 반려에 대한 재신청 기능 지원
							</td>
				    	</tr>
				    	<tr>
				    		<td>발급제한설정</td>
				    		<td>미확보 제증명 서류를 일시적으로 발급 신청하지 못하게 제한하는 기능</td>
				    	</tr>
				    	<tr>
				    		<td>진행 알림</td>
				    		<td>발급프로세스의 각 단계별 결과 알림 메일 발송 기능</td>
				    	</tr>
				    	<tr>
				    		<td rowspan="2"><strong>송무관리</strong></td>
				    		<td>송무정보 등록</td>
				    		<td>개별적인 소송 정보를 등록하는 기능</td>
				    	</tr>
				    	<tr>
				    		<td>송무정보 조회</td>
				    		<td>등록된 송무정보를 조회하는 기능<br>
								※법무그룹원과 현업 담당자만 가능항
							</td>
				    	</tr>
				    	<tr>
				    		<td rowspan="3"><strong>법률정보</strong></td>
				    		<td>분류관리</td>
				    		<td>법률정보 하위의 분류별 게시판을 등록/수정/삭제하는 기능</td>
				    	</tr>
				    	<tr>
				    		<td>법률정보 등록</td>
				    		<td>각 게시판별 게시물을 등록하는 기능</td>
				    	</tr>
				    	<tr>
				    		<td>법률정보 조회</td>
				    		<td>각 게시판 내의 게시물을 조회하는 기능</td>
				    	</tr>
				    	<tr>
				    		<td>공통</td>
				    		<td>목록 조회/저장</td>
				    		<td>각 목록 현재 로그인 사용자가 접근할 수 있는 자료만을 표시함<br>
								각 목록은 엑셀 형태로 저장하는 기능을 공통적으로 지원함
							</td>
				    	</tr>
				    </tbody>
				 </table>
				 </div>
			 <br>
              <hr>
			</div>
			
			<div class="row">  
            <h4 id="ManagementSystem-4"><span class="text-primary">법무 및 인장관리시스템 - 업무처리 절차</span></h4>
			 <p align="center">
   				<img src="${contextPath }/jsp/presentation/img/ManagementSystem-2.png" class="img-responsive">
			 </p>
			 <br>
              <hr>
			</div> 
			
			<div class="row">  
            <h4 id="ManagementSystem-5"><span class="text-primary">법무 및 인장관리시스템 - 구축사례</span></h4>
			 <p>
			 	포스코 및 패밀리사
			 </p>
			 <br>
              <hr>
			</div> 
			
			  
			<br><br><br><br><br><br>  
        </div>
        
        <div class="col-xs-3" id="myScrollspy">
        	<div class="bs-sidebar" data-spy="affix">
            <ul class="nav bs-sidenav">
		      <li class="active">
		      	<a href="#uCUBE">u-CUBE</a>
		      	<ul class="nav">
		      		<li><a href="#uCUBE-1">특징</a></li>
		      		<li><a href="#uCUBE-2">구성</a></li>
		      		<li><a href="#uCUBE-3">주요기능</a></li>
		      		<li><a href="#uCUBE-4">도입효과</a></li>
		      		<li><a href="#uCUBE-5">구축사례</a></li>
		      	</ul>
		      </li>
		      <li>
		      	<a href="#GlueFramework">Glue Framework</a>
		      	<ul class="nav">
		      		<li><a href="#GlueFramework-1">특징</a></li>
		      		<li><a href="#GlueFramework-2">구성</a></li>
		      		<li><a href="#GlueFramework-3">주요기능</a></li>
		      		<li><a href="#GlueFramework-4">도입효과</a></li>
		      		<li><a href="#GlueFramework-5">적용사례</a></li>
		      		<li><a href="#GlueFramework-6">Glue 제품군 아키텍쳐</a></li>
		      		<li><a href="#GlueFramework-7">각 Glue 제품 역할</a></li>
		      	</ul>
		      </li>
		      <li>
		      	<a href="#GlueMaster">Glue Master</a>
		      	<ul class="nav">
		      		<li><a href="#GlueMaster-1">특징</a></li>
		      		<li><a href="#GlueMaster-2">구성</a></li>
		      		<li><a href="#GlueMaster-3">주요기능</a></li>
		      		<li><a href="#GlueMaster-4">도입효과</a></li>
		      		<li><a href="#GlueMaster-5">구축사례</a></li>
		      	</ul>
		      </li>
		      <li>
		      	<a href="#GlueMobile">Glue Mobile</a>
		      	<ul class="nav">
		      		<li><a href="#GlueMobile-1">특징</a></li>
		      		<li><a href="#GlueMobile-2">구성</a></li>
		      		<li><a href="#GlueMobile-3">주요기능</a></li>
		      		<li><a href="#GlueMobile-4">도입효과</a></li>
		      		<li><a href="#GlueMobile-5">구축사례</a></li>
		      	</ul>
		      </li>
		      <li>
		      	<a href="#PosBee">PosBee</a>
		      	<ul class="nav">
		      		<li><a href="#PosBee-1">특징</a></li>
		      		<li><a href="#PosBee-2">구성</a></li>
		      		<li><a href="#PosBee-3">주요기능</a></li>
		      		<li><a href="#PosBee-4">도입효과</a></li>
		      		<li><a href="#PosBee-5">구축사례</a></li>
		      	</ul>
		      </li>
		      <li>
		      	<a href="#SmartECM">SmartECM</a>
		      	<ul class="nav">
		      		<li><a href="#SmartECM-1">특징</a></li>
		      		<li><a href="#SmartECM-2">구성</a></li>
		      		<li><a href="#SmartECM-3">주요기능</a></li>
		      		<li><a href="#SmartECM-4">도입효과</a></li>
		      		<li><a href="#SmartECM-5">구축사례</a></li>
		      	</ul>
		      </li>
		      <li>
		      	<a href="#POWIS">POWIS</a>
		      	<ul class="nav">
		      		<li><a href="#POWIS-1">특징</a></li>
		      		<li><a href="#POWIS-2">구성</a></li>
		      		<li><a href="#POWIS-3">주요기능</a></li>
		      		<li><a href="#POWIS-4">도입효과</a></li>
		      		<li><a href="#POWIS-5">구축사례</a></li>
		      	</ul>
		      </li>
		      <li>
		      	<a href="#ERP">SMB ERP솔루션</a>
		      	<ul class="nav">
		      		<li><a href="#ERP-1">개요</a></li>
		      		<li><a href="#ERP-2">특징</a></li>
		      		<li><a href="#ERP-3">가동현황</a></li>
		      	</ul>
		      </li>
		      <li>
		      	<a href="#i9">설비관리시스템 i9</a>
		      	<ul class="nav">
		      		<li><a href="#i9-1">특징 및 도입효과</a></li>
		      		<li><a href="#i9-2">구성</a></li>
		      		<li><a href="#i9-3">주요기능</a></li>
		      		<li><a href="#i9-4">구축사례</a></li>
		      	</ul>
		      </li>
		      <li>
		      	<a href="#ManagementSystem">법무 및 인장관리시스템</a>
		      	<ul class="nav">
		      		<li><a href="#ManagementSystem-1">시스템 개요</a></li>
		      		<li><a href="#ManagementSystem-2">구성</a></li>
		      		<li><a href="#ManagementSystem-3">주요기능</a></li>
		      		<li><a href="#ManagementSystem-4">업무처리 절차</a></li>
		      		<li><a href="#ManagementSystem-5">구축사례</a></li>
		      	</ul>
		      </li>
		    </ul>
		    </div>
        </div>
</body>
</html>