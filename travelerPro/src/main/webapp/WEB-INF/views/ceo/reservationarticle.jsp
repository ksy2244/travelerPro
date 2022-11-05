<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CEO</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title3.png" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />
<style type="text/css">
.body-container {
	max-width: 1500px;
}




.body-title {
	margin-top: 20px;
	margin-bottom: 50px;
}


#basic {
	background-color: #6C757D;
}

#basic:hover{background-color:#7689A5;}

.title {
	border-bottom: 2px solid #ced4da;
	background: #ced4da;
}

.page {
	margin-bottom: 20px;
}

#point {
	background-color: #FF5E00;
}

#point:hover{background-color:#FF9000;}

.red {
	color: red;
}

.blue {
	color: blue;
}

.gray {
	color: #787878;
}

.png {
	width: 20px;
	height: 20px;
}

#basic {
	background-color: #6C757D;
}

#basic:hover{background-color:#7689A5;}
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 예약번호:${dto.reservationNum} </h3>
			</div>
			
			<div class="body-main">
				
				<table class="table table-hover board-list">
					<thead>
						<tr class="title">
							<th class="inquiryNum" >예약상세정보</th>
							
						</tr>
					</thead>
					
					
					<tbody>
						<tr>
							<td align="left" >
								업체이름 : ${dto.companyName}
								
							</td>
						</tr>
						
						<tr>
							<td align="left">
								업체번호 : ${dto.companyNum}
								
							</td>
						</tr>
						
						
						<tr>
							<td align="left">
								이용자 이름 : ${dto.realUserName}
								
							</td>
						</tr>
						<tr>
							<td align="left">
								회원 아이디 : ${dto.userId}
								
							</td>
						</tr>
						<tr>
							<td align="left">
								이용자 전화번호 : ${dto.realUserTel}
								
							</td>
						</tr>
						
						<tr>
							<td align="left">
								방이름 : ${dto.roomName }
								
								
							</td>
						</tr>
						<tr>
							<td align="left">
								시작 날짜 : ${dto.start_date}
								
								
							</td>
						</tr>
						<tr>
							<td align="left">
								종료 날짜 : ${dto.end_date}
								
								
							</td>
						</tr>
						
						<tr>
							<td align="left">
								인원수 : ${dto.realHeadCount} 
								
								
							</td>
						</tr>
						
						
						<tr>
							<td align="left">
								체크인 시간 : ${dto.checkInTime}
								
								
							</td>
						</tr>
						<tr>
							<td align="left">
								체크아웃 시간 : ${dto.checkOutTime}
								
								
							</td>
						</tr>
						<tr>
							<td align="left">
								결재금액 : ${dto.paymentPrice }
								
								
							</td>
						</tr>
						
						<tr>
							<td align="left">
								예약 날짜 : ${dto.reservation_date}
								
								
							</td>
						</tr>
						
						

					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
							
						<td class="text-end">
							<button type="button" class="btn text-white" id="basic"  onclick="location.href='${pageContext.request.contextPath}/ceo/reservation.do';">리스트</button>
						</td>
					</tr>
				</table>
				
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>