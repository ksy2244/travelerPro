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
	IMP.init("인증키");

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
		let paymentPrice = "${paymentPrice}";
		let subject = "${dto.companyName}(${dto.roomName})";
		alert(paymentPrice);
		paymentPrice = 100;
        IMP.request_pay({
            pg : 'html5_inicis.INIpayTest',
            pay_method : 'card',
            merchant_uid: "IMP"+makeMerchantUid, 
            name : subject, //클라이언트에게 보여주는 상품 이름 
            amount : paymentPrice, // 결제 금액 
           	//buyer_email : 'Iamport@chai.finance', // 구매자 이메일 
            buyer_name :  ${realUserName}, // 구매자 이름 
            buyer_tel : ${realUserTel}, // 구매자 전화번호 
            //buyer_addr : '서울특별시 강남구 삼성동', // 구매자 주소
            buyer_postcode : '123-456' //구매자 우편번호 
        }, function (rsp) { // callback
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
				<div class="card border-secondary mb-3" style="max-width: 100rem;">
					<div class="card-header">
						<h5>
							<i class="fa-solid fa-hotel"></i>&nbsp; ${dto.companyName}&nbsp;
						</h5>
					</div>
					<div class="card-body text-secondary">
						<h5 class="card-title">객실 타입 ${dto.roomName}</h5>
						<p class="card-text">
						<p>${dto.roomInfo}</p>
						<p>체크인 ${start_date}&nbsp;${checkInTime}&nbsp;|&nbsp;체크아웃
							${end_date}&nbsp;${checkOutTime} 가격 ${dto.roomPrice}</p>
						<p>할인율 ${dto.discountRate} 기준 ${dto.headCount}인 최대
							${dto.headCount}인</p>
						<p>주소 ${addr} 기준 ${dto.addrDetail}인 최대 ${dto.headCount}인</p>
					</div>

				</div>
				<br>



				<div class="card border-secondary mb-3" style="max-width: 100rem;">
					<div class="card-header">
						<h5>
							<i class="fa-solid fa-hotel"></i>&nbsp;결제 수단&nbsp;
						</h5>
					</div>
					<div class="card-body text-secondary">
						<h5 class="card-title">카카오 페이</h5>
						<p class="card-text">
					</div>
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
							<input type="hidden" value="${start_date}" name="start_date">
							<input type="hidden" value="${end_date}" name="end_date">
							<input type="hidden" value="${dto.headCount}" name="headCount">
							<input type="hidden" value="${dto.roomPrice}" name="roomPrice">
							<input type="hidden" value="${paymentPrice}" name="paymentPrice">
							<input type="hidden" value="${dto.checkInTime}"
								name="checkInTime"> <input type="hidden"
								value="${dto.checkOutTime}" name="checkOutTime"> <input
								type="hidden" value="${dto.discountRate}" name="discountRate">
							<input type="hidden" value="${dto.companyNum}" name="companyNum">
							<input type="hidden" value="${dto.checkInTime}"
								name="checkInTime"> <input type="hidden"
								value="${dto.checkOutTime}" name="checkOutTime">


							<button type="button" name="sendButton" class="btn"
								onclick="requestPay();">결제</button>
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
</body>
</html>





