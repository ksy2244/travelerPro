<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>traveler_manage</title>
<jsp:include page="/WEB-INF/views/admin_layout/staticHeader.jsp"/>

<style type="text/css">
@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');
* {
	box-sizing: border-box;
}

.body-container {
	max-width: 1000px;
}

.box {
	width: 1000px; height: 800px;
	margin: 50px;
	
	display: grid;
	
	/* 행열의 크기를 명시적으로 설정 */
	grid-template-rows: repeat(4,1fr); 
	grid-template-columns: repeat(3,1fr);
	grid-gap: 40px; /* 공백 주기 */
	
	
	
}

.item {
	border-radius: 7px;
	
	/* 텍스트를 수직 가운데 보내려고 flex 사용 */
	display: flex;
	align-items: center;
	justify-content: center;
	font-family: 'GmarketSans';
	font-size: 30px;
	font-weight: bold;
	color: white;
}

.item1 {background: #3FB8AF;}
.item1:hover {background: #2B807A;}
.item2 {background: #7FC7AF;}
.item2:hover {background: #5F9482;}
.item3 {background: #DAD8A7;}
.item3:hover {background: #DAC8A7;}
.item4 {background: #FF9E9D;}
.item4:hover {background: #EB9E9D;}
.item5 {background: #FF3D7F;}
.item5:hover {background: #E13D7F;}
.item6 {background: #9fc3ea;}
.item6:hover {background: #9FAFE0;}

.item1 {
	grid-column: 1/4; /* <start-line> / <end-line> */
}
.item2 {
	grid-row: 2/4; /* <start-line> / <end-line> */
}
.item3 {
	grid-column: 2/span 2; /* 2열부터 2칸 */
}
.item6 {
	grid-column: 1/span 3; /* 1열부터 3칸 */
}


</style>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin_layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			
			<div class="body-main box">
					<div class="item item1" onclick="location.href='${pageContext.request.contextPath}/notice/list.do';">공지 관리</div>
					<div class="item item2" onclick="location.href='${pageContext.request.contextPath}/coupon/list.do';">쿠폰 관리</div>
					<div class="item item3" onclick="location.href='${pageContext.request.contextPath}/admin/userList.do';">회원정보 확인</div>
					<div class="item item4"></div>
					<div class="item item5"></div>
					<div class="item item6" onclick="location.href='${pageContext.request.contextPath}/admin/companyList.do';">업체정보 확인 </div>
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/admin_layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin_layout/staticFooter.jsp"/>
</body>
</html>