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
@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');
* {
	box-sizing: border-box;
}

.body-container {
	max-width: 1000px;
}

.box {
	margin-top: 60px;
	
	display: grid;
	
	/* 행열의 크기를 명시적으로 설정 */
	grid-template-rows: repeat(3,1fr); 
	grid-template-columns: repeat(4,1fr);
	grid-gap: 40px; /* 공백 주기 */
}

.item {
	border-radius: 7px;
	border: 1px solid #ccc;
	
	height: 250px;
	
	font-size: 15px;
}

.item1 {
	grid-column: 1/span 2; /* <start-line> / <end-line> */
	gird-row: 1/span 1;
}
.item2 {
	grid-column: 3/span 2;
	grid-row: 1/span 1; /* <start-line> / <end-line> */
}
.item3 {
	grid-column: 1/span 2;
	grid-row: 2/span 1; 
}

.item4 {
	grid-column: 3/span 2;
	grid-row: 2/span 1; 
}

.item5 {
	grid-column: 1/span 2;
	grid-row: 3/span 1; 
}

.item6 {
	grid-column: 3/span 2;
	grid-row: 3/span 1;  /* 1열부터 3칸 */
}

.more {
	width: 100%;
	height: 50px;
	background: #eee;
}

.font {
	margin-left: 35px;
	margin-top: 10px;
	position: absolute; 
	font-family: 맑은 고딕; 
	font-size: 19px; 
	font-weight: 400; 
	margin-right: 3px;
	color: #787878;
}

.left {
	margin-left: 0px;
	font-weight: bold;
	font-size: 19px; 
	
}

.start {
	font-weight: bold;
	font-size: 19px;
	margin-left: 30px;
}

.right {
	float: right;
	font-size: 19px; 
	margin-right: 30px;
	color: #787878;
}

.plus {
	font-weight: bold;
	font-size: 15px;
	color: #787878;
	float: right;
	margin-right: 30px;
	margin-top: 15px;
}

.plus:hover {
	text-decoration: underline;
}

.tr {
	margin-top: 10px;
	border-bottom: 1px solid #ccc;
	border-top: 1px solid #ccc;
	font-weight: bold;
	color: #787878;
	padding: 10px;
}

.content {
	margin-top: 20px;
	margin-left: 20px;
}

.red {
	color: red;
}

.blue {
	color: blue;
}
</style>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header_admin.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-main box">
					<div class="item item1">
						<div class="more"><span class="font">서비스 정보</span></div>
						<br>
						<span class="start">서비스</span><span class="right">TRAVLER</span>
						<br><br>
						<span class="start">사이트 주소</span><span class="right">travelerPro/main.do</span>
					</div>
					<div class="item item2">
						<div class="more"><span class="font">회원 정보 확인</span><span class="plus" onclick="location.href='${pageContext.request.contextPath}/admin/userList.do';">자세히 보기 ></span></div>
						<div class="content">
							<c:if test="${resultMember == 0}">
								신규 데이터가 없습니다.
							</c:if>
							<div class="blue">
								<c:if test="${resultMember != 0}">
									새로운 신규 데이터가 있습니다.
								</c:if>
							</div>
						</div>
					</div>
					<div class="item item3">
						<div class="more"><span class="font">업체 정보 확인</span><span class="plus" onclick="location.href='${pageContext.request.contextPath}/admin/companyList.do';">자세히 보기 ></span></div>
						<div class="content">
							<c:if test="${resultCompany == 0}">
								신규 데이터가 없습니다.
							</c:if>
							<div class="red">
								<c:if test="${resultCompany != 0}">
									승인되지 않은 신규 데이터가 있습니다.
								</c:if>
							</div>
						</div>
					</div>
					<div class="item item4">
						<div class="more"><span class="font">쿠폰 관리</span><span class="plus" onclick="location.href='${pageContext.request.contextPath}/coupon/list.do';">자세히 보기 ></span></div>
						<div class="content">
							<c:if test="${resultCoupon == 0}">
								신규 데이터가 없습니다.
							</c:if>
							<div class="red">
								<c:if test="${resultCoupon != 0}">
									유효기간이 만료된 데이터가 있습니다.
								</c:if>
							</div>
						</div>
					</div>
					<div class="item item5">
						<div class="more"><span class="font">공지 관리</span><span class="plus" onclick="location.href='${pageContext.request.contextPath}/notice/list.do';">자세히 보기 ></span></div>
						<div class="content">
							<c:if test="${resultNotice == 0}">
								신규 데이터가 없습니다.
							</c:if>
							<div class="blue">
								<c:if test="${resultNotice != 0}">
									새로운 신규 데이터가 있습니다.
								</c:if>
							</div>
						</div>
					</div>
					<div class="item item6">
						<div class="more"><span class="font">문의 관리</span><span class="plus" onclick="location.href='${pageContext.request.contextPath}/answer/qnaList.do';">자세히 보기 ></span></div>
						<div class="content">
							<c:if test="${resultCompany == 0}">
								신규 데이터가 없습니다.
							</c:if>
							<div class="red">
								<c:if test="${resultCompany != 0}">
									처리되지 않은 신규 데이터가 있습니다.
								</c:if>
							</div>
						</div>
					</div>
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