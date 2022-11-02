<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>traveler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/travelerStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/travelerStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script>
	var IMP = window.IMP;
	IMP.init("imp31814638");

	var today = new Date();
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes(); // 분
	var seconds = today.getSeconds(); // 초
	var milliseconds = today.getMilliseconds();
	var makeMerchantUid = hours + minutes + seconds + milliseconds;

	function requestPay() {
		const f = document.reservationForm;
		let str;

		str = f.realUserName.value;
		if (!/^[가-힣]{2,5}$/.test(str)) {
			alert("이름을 다시 입력하세요. ");
			f.realUserName.focus();
			return;
		}

		str = f.realUserTel.value;
		if (!/^[0-9]{3}-[0-9]{3,4}-[0-9]{4}/.test(str)) {
			alert("전화번호를 입력하세요. ");
			f.realUserTel.focus();
			return;
		}
		
		//결제 
		let paymentPrice = $("form[name=reservationForm] input[name=paymentPrice]").val();
		
		alert(paymentPrice);
		
		let subject = "${dto.companyName}(${dto.roomName})";
		paymentPrice = 100;
		IMP.request_pay({
			pg : 'html5_inicis.INIpayTest',
			pay_method : 'card',
			merchant_uid : "IMP" + makeMerchantUid,
			name : subject, //클라이언트에게 보여주는 상품 이름 
			amount : paymentPrice, // 결제 금액 
			//buyer_email : 'Iamport@chai.finance', // 구매자 이메일 
			buyer_name : f.realUserName.value, // 구매자 이름 
			buyer_tel : f.realUserTel.value, // 구매자 전화번호 
			//buyer_addr : '서울특별시 강남구 삼성동', // 구매자 주소
			buyer_postcode : '123-456' //구매자 우편번호 
		},
		function(rsp) { // callback
			if (rsp.success) {
				console.log(rsp);
				f.action = "${pageContext.request.contextPath}/reservation/reservation_ok.do";
				f.submit();
			} else {
				console.log(rsp);
				alert("결제가 실패했습니다");
				}
		});	

	}
	
	$(function(){
		$(".btnCoupon").click(function(){
			let s = $("form[name=reservationForm] input[name=couponNum]").val();

			let couponNum = $(this).closest("div").find("input[name=couponNum]").val();
			let couponPrice = $(this).closest("div").find("input[name=couponPrice]").val();
			let paymentPrice = ${paymentPrice};
			
			
			if(s==couponNum){
		
				$("form[name=reservationForm] input[name=paymentPrice]").val(paymentPrice);
				
				$("form[name=reservationForm] input[name=couponNum]").val("0");

				$(".spanPaymentPrice").html("");
				
			}else{
				paymentPrice = paymentPrice -couponPrice;
				
				$("form[name=reservationForm] input[name=paymentPrice]").val(paymentPrice);
				
				$("form[name=reservationForm] input[name=couponNum]").val(couponNum);

				$(".spanPaymentPrice").html("(쿠폰 적용가 " + paymentPrice +")");
			}
			
			
			
			
			
		});
	});
	
</script>


</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>


	<main>

		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>${title}</h3>
				</div>

				<div class="alert" role="alert" style="background: #E4FBFF">
					객실 예매를 위한 정보를 입력해주세요.</div>
				<div class="shadowBox">
					<div class="shadowBoxContent" style="padding: 40px">
						<h4>
							<i class="fa-solid fa-hotel"></i>&nbsp;
							${dto.companyName}&nbsp;${dto.roomName}
						</h4>
						<p class="card-text">
						<p class="address" style="font-size: 20px;">
							<i class="fa-solid fa-location-dot">&nbsp;</i>주소 ${dto.addr} 기준
							${dto.addrDetail}인
						</p>
						<p>${dto.roomInfo}</p>
						<p>체크인 ${start_date}&nbsp;${dto.checkInTime}&nbsp;|&nbsp;체크아웃
							${end_date}&nbsp;${dto.checkOutTime}</p>
						<p>기준 ${dto.headCount}인 ${dto.headCount}인 가격
							${dto.roomPrice}원&nbsp;할인율 ${dto.discountRate}%</p>
						<p>
							<i class="fa-solid fa-money-check"></i>&nbsp;지불
							금액&nbsp;${paymentPrice}원 <span class ="spanPaymentPrice"></span>
						</p>

					</div>

				</div>
				<br>


				<!-- 쿠폰 -->
				<div class="row">
					<c:forEach var="coupon" items="${list}" varStatus="status">
						<div class="col-md-3 col-lg-5 p-2 item">
							<div class="card-group" style="width: 1500px; margin: auto;">

								<div class="card-body">
								
								<h4 class="card-title">내가 사용할 수 있는 쿠폰 리스트</h4>
									<h4 class="card-title">쿠폰 이름${coupon.couponNum} </h4>
									<h4 class="card-title">쿠폰 이름${coupon.couponName}</h4>
									<h4 class="card-title">할인율${coupon.couponRate}</h4>
									<h4 class="card-titl">${coupon.start_date}~${coupon.end_date}</h4>
									<h4 class="card-title">${coupon.start_date}~${coupon.end_date}</h4>
									<h4 class="card-title">${paymentPrice * coupon.couponRate /100}원 할인</h4>
						 		
						 		<div class="couponForm"> 
									<input type="hidden" value="${paymentPrice * coupon.couponRate /100}" name="couponPrice">
									<input type="hidden" value="${coupon.couponNum}" name="couponNum"> 
								
								<button class="dateBtn btn btn-danger btnCoupon"  type="button"> 쿠폰 적용하기 </button>
										
									</div>
								</div>
							</div>

						</div>
					</c:forEach>
				</div>


				<div class="body-main">
					<form name="reservationForm" method="post">
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="realUserName">이용자
								이름</label>
							<div class="col-sm-10 userId-box">
								<div class="row">
									<div class="col-5 pe-1">
										<input type="text" name="realUserName" id="realUserName"
											class="form-control" placeholder="체크인시 필요한 이름입니다.">
									</div>
								</div>

								<small class="form-control-plaintext help-block">이름은
									2~5자 이내이며, 한글만 가능합니다. </small>

							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="realUserTel">이용자
								전화번호</label>
							<div class="col-sm-10">
								<input type="text" name="realUserTel" id="realUserTel"
									class="form-control" placeholder="체크인시 필요한 전화번호입니다.">
							</div>
						</div>


						<div>
							<input type="hidden" value="${dto.roomNum}" name="roomNum">
							<%-- 	<input type="hidden" value="${start_date}" name="start_date">
							<input type="hidden" value="${end_date}" name="end_date"> --%>
							<input type="hidden" value="${dto.headCount}" name="headCount">
							<input type="hidden" value="${dto.roomPrice}" name="totalPrice">
							<input type="hidden" value="${paymentPrice}" name="paymentPrice">
							<input type="hidden" value="${dto.checkInTime}"
								name="checkInTime"> <input type="hidden"
								value="${dto.checkOutTime}" name="checkOutTime"> <input
								type="hidden" value="${dto.discountRate}" name="discountRate">
							<input type="hidden" value="${dto.companyNum}" name="companyNum">
							<input type="hidden" value="${dto.checkInTime}"
								name="checkInTime"> <input type="hidden"
								value="${dto.checkOutTime}" name="checkOutTime"> <input
								type="hidden" value="${start_date}" name="start_date"
								class="styleInput"> <input type="hidden"
								value="${end_date}" name="end_date" class="styleInput">
							
							<input type ="hidden" name ="couponNum" value ="0">
							<input type="hidden" value="0" name="couponPrice" >								
							<button type="button" name="sendButton"
								class="dateBtn btn btn-danger" onclick="requestPay();">예약</button>
						</div>
					</form>

				</div>
			</div>
		</div>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</html>