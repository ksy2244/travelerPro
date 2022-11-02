<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약내용</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />
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
				
				<table class="table">
					
					
					<tbody>
						<tr>
							<td align="left">
								업체이름:${dto.companyName}
							</td>
						</tr>
						
						<tr>
							<td align="left">
								업체번호:${dto.companyNum}
							</td>
						</tr>
						
						
						<tr>
							<td align="left">
								이용자이름:${dto.realUserName}
							</td>
						</tr>
						<tr>
							<td align="left">
								회원아이디:${dto.realUserId}
							</td>
						</tr>
						<tr>
							<td align="left">
								이용자전화번호:${dto.realUserTel}
							</td>
						</tr>
						
						<tr>
							<td align="left">
								방이름 :${dto.roomName }
							</td>
						</tr>
						<tr>
							<td align="left">
								시작날짜:${dto.start_date}
							</td>
						</tr>
						<tr>
							<td align="left">
								종료날짜:${dto.end_date}
							</td>
						</tr>
						
						<tr>
							<td align="left">
								인원수:${dto.realheadCount} 
							</td>
						</tr>
						
						
						<tr>
							<td align="left">
								체크인시간:${dto.checkInTime}
							</td>
						</tr>
						<tr>
							<td align="left">
								체크아웃시간:${dto.checkOutTime}
							</td>
						</tr>
						<tr>
							<td align="left">
								결재금액:${dto.paymentPrice }
							</td>
						</tr>
						
						<tr>
							<td align="left">
								예약날짜:${dto.reservation_date}
							</td>
						</tr>
						
						

					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
							
						<td class="text-end">
							<button type="button" class="btn btn-primary"  onclick="location.href='${pageContext.request.contextPath}/ceo/reservation.do';">리스트</button>
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