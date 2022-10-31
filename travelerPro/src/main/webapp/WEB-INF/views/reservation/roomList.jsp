<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/datePicker.css">
		<div class="row">
		
			<c:forEach var="room" items="${roomList}" varStatus="status">
				<div class="card border-secondary mb-3" style="max-width: 100rem;">

					<img
						src="${pageContext.request.contextPath}/resources/images/mainImg/busan.png"
						class="card-img-top" alt="...">

					<div class="card-body">
						<p class="eachRoomName">${room.roomName}</p>
						<p class="eachRoomInfo">${room.roomInfo}</p>

						<p class="headCount">기준 ${room.headCount}인 /
							${room.headCount}최대 ${room.headCount}인</p>
						<p class="eachRoomMoney">
							<span style="color: purple">${room.discountRate}% &nbsp;</span>${room.roomPrice}원
						</p>

						<form action="reservation.do" method="get">
							<input type="hidden" value="${companyNum}" name="companyNum">
							<input type="hidden" value="${room.roomNum}" name="roomNum">
							<input type="hidden" value="${start_date}" name=start_date>
							<input type="hidden" value="${end_date}" name="end_date">
							<button class="dateBtn btn btn-danger" type="submit">객실
								선택</button>
						</form>
					</div>
				</div>

			</c:forEach>
		</div>
