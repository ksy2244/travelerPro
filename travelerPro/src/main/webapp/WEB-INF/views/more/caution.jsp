<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>admin</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp"/>

<style type="text/css">  
.menu{
	width: 400px;
	position:fixed;
	height: 100%;
	margin-left: 200px;
	margin-top: 60px;
	border-right: 1px solid #ccc;
}
.menu li {
	list-style: none;
}

.menu li a {
	height: 30px;
	display: block;
	font-size: 20px;
	padding: 30px;
	color: black;
	text-decoration: underline;
/* 	z-index: -999; */
}

.body-container {
	max-width: 1000px;
}

.title {
	font-size: 20px;
	font-weight: 600;
	margin-left: 100px;
	margin-top: 60px;
}

.line {
	border-top: 3px solid black;
	margin-top: 40px;
	margin-left: 42px;
	padding-top: 50px;
}

.content {
	padding-left: 55px;
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header_admin.jsp"/>
</header>
	
<main>
	<nav>
	<ul class="menu">
		<li><a href="${pageContext.request.contextPath}/more/policy.do?category=service">서비스 이용약관</a></li>
		<li><a href="${pageContext.request.contextPath}/more/policy.do?category=privacy">개인정보 처리방침</a></li>
		<li><a href="${pageContext.request.contextPath}/more/policy.do?category=e-commerce">전자금융거래 이용약관</a></li>
		<li><a href="${pageContext.request.contextPath}/more/policy.do?category=e-commerceCaution">전자금융거래 이용자 유의사항</a></li>
	</ul>
</nav>
<div class="body-container">	
	<div class="title">전자금융거래 이용자 유의사항</div>
	<br>
		<div class="line">
			<div class="content">
			이용자 유의사항
			<br>
			<br>
			「전자금융감독규정」 제 35조(이용자 유의사항 공지)에 따라, 아래와 같이 이용자 유의사항에 대하여 안내드립니다.
			• 비밀번호 유출위험 및 관리에 관한 사항
			• 비밀번호는 주민등록번호, 전화번호, 생년월일 등 다른사람이 쉽게 유추하기 쉬운 정보로 설정하지 마시고, 이용자 본인만 알 수 있는 비밀번호로 설정하여 주시기 바랍니다.
			• 비밀번호는 스마트폰, PC, 인터넷 등에 저장하지 마시고, 비밀번호가 다른 사람에게 노출되지 않도록 안전하게 관리하시기 바랍니다.
			• 비밀번호를 주기적으로 변경하시고 같은 비밀번호를 재사용하지 않도록 하시기 바랍니다.
			• 이용자보호 제도에 관한 사항
			• 야놀자는 전자금융거래약관에 따라 고객님과의 전자금융거래를 보호하고 있고, 이용자의 피해를 보상하기 위한 전자금융거래배상책임보험에 가입되어 있습니다.
			• 야놀자 이용자는 정보주체로서 다음과 같은 권리를 행사할 수 있습니다.
			• 개인정보의 제공 및 열람
			• 개인정보의 수집·이용에 대한 동의 철회 및 가입 해지
			• 이용자의 권리 행사는 다음 방법으로 요청할 수 있습니다.
			• 1:1 문의하기 (야놀자 > MY야놀자 > 카카오톡 1:1 문의)
			• 고객센터 (1644-1346, 운영시간 오전 9시 ~ 익일 오전 3시 운영)
			• 개인정보 침해로 인한 신고나 상담이 필요하신 경우, 아래 기관에 문의하시기 바랍니다.
			<br>
			<br>
			
			구분	기관명	연락처	사이트 주소
			<br>
			개인정보분쟁조정	개인정보분쟁조정위원회	1833-6972	www.kopico.go.kr
			개인정보 침해신고센터	한국인터넷진흥원	118	privacy.kisa.or.kr
			금융정보(개인신용)정보 침해신고	금융민원센터	1332	www.fcsc.kr
			사이버범죄수사단	대검찰청	1301	www.spo.go.kr
			사이버수사국	경찰청	182	ecrm.cyber.go.kr
			<br>
			<br>
			• 해킹 · 피싱 등 전자적 침해방지에 관한 사항
			• 해킹·피싱 등에 의한 개인정보 유출 및 훼손의 전자적 피해를 방지하고 안전한 금융거래를 위해서 바이러스 백신, 스파이웨어 제거 프로그램을 이용하고 최신 보안패치를 적용합니다.
			• 의심되는 이메일이나 게시판의 글을 열어보지 말고 첨부파일은 열람(클릭) 또는 저장하기 전에 백신으로 검사합니다.
			• 야놀자 직원을 사칭하여 고객 인적사항에 대한 문의시 반드시 직원 이름과 전화번호를 확인하여, 확인 후에도 정보사항이 노출 되지 않도록 주의 부탁 드립니다.
			</div>
		</div>
</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>