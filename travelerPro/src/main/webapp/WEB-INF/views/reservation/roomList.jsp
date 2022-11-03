<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/datePicker.css">
		<div class="row">
		
			<c:forEach var="room" items="${roomList}" varStatus="status">
				<div class="mb-3 ms-2 box" style="max-width: 100rem;">

					<img src="${pageContext.request.contextPath}/uploads/room/${room.imageFileName}"
						class="card-img-top roomDetail" alt="...">

					<div class="card-body">
						<p class="eachRoomName">${room.roomName}</p>
						<br>
						<p class="headCount">기준 ${room.headCount}인 / 최대 ${room.headCount}인</p>
						<p class="headCount clear">금연객실</p>
						<br><br>
						<div class="eachRoomMoney">
							<span style="color: red; font-size: 18px;">${room.discountRate}% &nbsp;</span>${room.roomPrice}원 ~
						</div>

						<form action="reservation.do" method="get">
							<input type="hidden" value="${companyNum}" name="companyNum">
							<input type="hidden" value="${room.roomNum}" name="roomNum">
							<input type="hidden" value="${start_date}" name=start_date>
							<input type="hidden" value="${end_date}" name="end_date">
							<button class="btn btn-danger roomChoice" type="submit">객실
								선택하기</button>
						</form>
					</div>
				</div>

			</c:forEach>
		</div>
