<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TRAVELER</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title2.png" />
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
	max-width: 1500px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 40px;
}

.shadowBox {
	margin-left: 100px;
}

.font {
	font-size: 19px;
	font-weight: 600;
}

.box {
	background: #eee;
	border-radius: 3px;
	border: 5px solid #eee;
	font-size: 18px;
	text-align: center;
	color: #5D5D5D;
}

.day {
	font-size: 17px;
}

.head {
	font-size: 17px;
	font-weight: bold;
	color: gray;
}

.basic {
	font-size: 17px;
	margin-top: 20px;
}

.rate {
	font-size: 30px;
	font-weight: bold;
	text-align: right;
	padding-right: 200px;
	padding-top: 50px;
	width: 1100px;
	color: red;
}

.rate2 {
	font-size: 15px;
	font-weight: bold;
	text-align: right;
	width: 1100px;
	padding-right: 250px;
}

.price {
	color: black;
}

.line {
	text-decoration: line-through;
	font-size: 25px;
	color: #787878;
}

.realPrice {
	font-size: 30px;
	font-weight: bold;
	text-align: right;
	padding-right: 160px;
	width: 1100px;
}

.realPrice2 {
	font-size: 28px;
	font-weight: bold;
	text-align: right;
}

.result {
	padding-left: 18px;
}

.gray {
	padding-left: 0px;
}

.card {
	font-size: 15px;
	font-weight: 400;
	text-align: center;
}

.go {
	width: 800px;
	margin-left: 80px;
}

.coupon {
	border: 1px solid #eee;
	border-radius: 7px;
	font-size: 18px;
	color: #787878;
	width: 220px;
	height: 130px;
	padding: 10px;
	margin-right: 10px;
}

.coupon-body {
	float: left;
}

.name {
	font-weight: bold;
	font-size: 17px;
	color: black;
}

.couponPrice {
	font-size: 16px;
}

.couponDay {
	font-size: 13px;
}

.margin {
	font-size: 22px; 
	margin-left: 430px;
	font-weight: bold;
	text-align: right;
}

.black {
	color: black;
	font-size: 28px;
}

#realPayment {
	font-weight: bold;
	color:red;
	font-size: 30px;
}

.label {
	font-weight: bold;
	font-size: 20px;
}

input[type=checkbox] {
	zoom: 1.5;
}

.form-check {
	margin-left: 20px;
}

.smallLabel {
	margin-right: 100px;
}

.room { 
	font-size: 19px;
}

.gray {
	color: #787878;
	font-size: 17px;
}

.btnCoupon {
	margin-left: 55px;
	margin-top: 20px;
}

.red {
	color: red;
	font-size: 15px;
}

.both {
	clear: both;
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
	var hours = today.getHours(); // ???
	var minutes = today.getMinutes(); // ???
	var seconds = today.getSeconds(); // ???
	var milliseconds = today.getMilliseconds();
	var makeMerchantUid = hours + minutes + seconds + milliseconds;

	function requestPay() {
		const f = document.reservationForm;
		let str;

		str = f.realUserName.value;
		if (!/^[???-???]{2,5}$/.test(str)) {
			alert("????????? ?????? ???????????????. ");
			f.realUserName.focus();
			return;
		}

		str = f.realUserTel.value;
		if (!/^[0-9]{3}-[0-9]{3,4}-[0-9]{4}/.test(str)) {
			alert("??????????????? ???????????????. ");
			f.realUserTel.focus();
			return;
		}
		
		//?????? 
		let paymentPrice = $("form[name=reservationForm] input[name=paymentPrice]").val();
		
		
		
		let subject = "${dto.companyName}(${dto.roomName})";
		paymentPrice = 100; // ????????? ??? ???.
		IMP.request_pay({
			pg : 'html5_inicis.INIpayTest',
			pay_method : 'card',
			merchant_uid : "IMP" + makeMerchantUid,
			name : subject, //????????????????????? ???????????? ?????? ?????? 
			amount : paymentPrice, // ?????? ?????? 
			//buyer_email : 'Iamport@chai.finance', // ????????? ????????? 
			buyer_name : f.realUserName.value, // ????????? ?????? 
			buyer_tel : f.realUserTel.value, // ????????? ???????????? 
			//buyer_addr : '??????????????? ????????? ?????????', // ????????? ??????
			buyer_postcode : '123-456' //????????? ???????????? 
		},
		function(rsp) { // callback
			if (rsp.success) {
				console.log(rsp);
				f.action = "${pageContext.request.contextPath}/reservation/reservation_ok.do";
				f.submit();
			} else {
				console.log(rsp);
				alert("????????? ??????????????????");
				}
		});	

	}
	
	$(function(){
		$(".btnCoupon").click(function(){
			let s = $("form[name=reservationForm] input[name=couponNum]").val();

			let couponNum = $(this).closest("div").find("input[name=couponNum]").val();
			let couponRate = $(this).closest("div").find("input[name=couponRate]").val();
			let couponPrice = $(this).closest("div").find("input[name=couponPrice]").val();
			
			let paymentPrice = ${paymentPrice * gap};
			
			let gap = ${paymentPrice};
			
			
			if(s==couponNum){
		
				$("form[name=reservationForm] input[name=paymentPrice]").val(paymentPrice);
				
				$("form[name=reservationForm] input[name=couponNum]").val("0");

				$(".spanPaymentPrice").html("");
				
			}else if(couponRate == 0){
				paymentPrice = paymentPrice - couponPrice;
				
				
				$("form[name=reservationForm] input[name=paymentPrice]").val(paymentPrice);
				
				$("form[name=reservationForm] input[name=couponNum]").val(couponNum);

				$(".spanPaymentPrice").html(paymentPrice+"???");
				
			} else if(couponPrice == 0){
				couponRate = (100-couponRate)/100;
				paymentPrice = paymentPrice * couponRate;
				
				$("form[name=reservationForm] input[name=paymentPrice]").val(paymentPrice);
				
				$("form[name=reservationForm] input[name=couponNum]").val(couponNum);

				$(".spanPaymentPrice").html(paymentPrice+"???");
				
			}
			
			
			
			
			
		});
	});
	
	
	
</script>


</head>
<body class="pt-5">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>


	<main class="pt-5">
		<div class="container">
			<div class="body-container">
				<br><br><br>
				<span class="pb-5">				
					<img src="${pageContext.request.contextPath}/uploads/room/${dto.imageFileName}" style="width: 1100px; margin-left: 105px;">
				</span>
				<div class="shadowBox" style="width: 1100px; height: 1200px;">  
					<div class="shadowBoxContent" style="padding: 40px">
						<h4 class="name">${dto.roomName}</h4>
						<br> 
						<hr style="width: 950px; color: #787878;">
						<br>
						
						<p class="card-text">
						<p class="address" style="font-size: 20px; width: 1000px;">
							<i class="fa-solid fa-location-dot">&nbsp;</i> ${dto.addr} ??????
							${dto.addrDetail}
						</p>
						<br>
						<p class="font pb-3">??????</p>
							<div style="width: 1250px;">
								<span class="box">??????</span>&nbsp;<span class="head">?????? ${dto.headCount}???</span>&nbsp;&nbsp;|&nbsp;&nbsp;
								<span class="box">?????????</span>&nbsp;&nbsp;<span class="day">${start_date}&nbsp;${dto.checkInTime}&nbsp;&nbsp;|&nbsp;&nbsp;
								</span><span class="box">????????????</span>&nbsp;&nbsp;<span class="day">${end_date}&nbsp;${dto.checkOutTime}&nbsp;</span>
							</div>
						<div class="basic">????????????</div>
						<c:if test="${dto.discountRate != 0 }">
							<div class="rate">${dto.discountRate}%&nbsp;&nbsp;<span class="price line" id="liveAlertPlaceholder">${dto.roomPrice}???</span></div>
							<div class="realPrice">${paymentPrice}???
								<span>
								  <a class="btn gray" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
								    <i class="fa-solid fa-circle-exclamation"></i>
								  </a>
								</span>
							    <div class="collapse" id="collapseExample">
									  <div class="card card-body">
									    * 1??? ?????? ???????????????.<br>
									    * ????????? ?????? ?????? ???????????? ????????? ??? ????????????.
									  </div>
								</div>
							</div>
						</c:if>
						
						<c:if test="${dto.discountRate == 0 }">
							<div class="realPrice">${paymentPrice}???
								<span>
								  <a class="btn gray" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
								    <i class="fa-solid fa-circle-exclamation"></i>
								  </a>
								</span>
			    
							    <div class="collapse" id="collapseExample">
									  <div class="card card-body">
									    * 1??? ?????? ???????????????.<br>
									    * ????????? ?????? ?????? ???????????? ????????? ??? ????????????.
									  </div>
								</div>
							</div>
						</c:if>				
						<br>
						<hr style="width: 950px; color: #787878;">
						<br>
						
						<p class="font pb-3">????????????</p>
						<div class="basic" style="width: 1250px;">${dto.roomInfo}</div>
						<br>
						<hr style="width: 950px; color: #787878;">
						<br>
						
						<p class="font pb-3">????????????</p>
						<div class="basic" style="width: 900px;">${dto.notice}</div>
						<br><br><br>
						<div class="pt-5"><button class="btn btn-danger btn-lg go" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">????????????</button></div>
					</div>
				</div>
			<br>


		<!-- ?????? ?????? -->			
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">????????????</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      	  <div>
		      	  	<br>
		      	  		<div class="font">?????? ??????</div>
		      	  		<br>
		      	  		<div class="name mb-2">${dto.companyName}</div>
		      	  		<div class="room">${dto.roomName}</div>
		      	  		<div class="gray">${start_date}&nbsp;&nbsp;~&nbsp;&nbsp;${end_date}</div>
		      	  		<div class="gray">????????? ${dto.checkInTime}&nbsp;&nbsp;|&nbsp;&nbsp;???????????? ${dto.checkOutTime}</div>
		      	  		<br>
		      	  		<div class="red">?????? ??? ?????? ??????</div>
		      	  		<br><hr><br>
		      	  		
		      	  		<h4 class="font pb-3">?????? ??????????????? ??????</h4>
							<c:forEach var="coupon" items="${list}" varStatus="status">
								<div>
									<div class="coupon-body ms-4">
										<div class="coupon">
											<div class="name" align="center">${coupon.couponName}</div>
											<c:if test="${coupon.couponPrice == 0 }">
												<div align="center" class="couponPrice">????????? ${coupon.couponRate}%</div>
											</c:if>
											<c:if test="${coupon.couponRate == 0 }">
												<div align="center" class="couponPrice">???????????? ${coupon.couponPrice}???</div>
											</c:if>
											<div class="couponDay mt-3" align="center">${coupon.start_date}~${coupon.end_date}</div>
									 	</div>
									 		
									 	<div class="couponForm"> 
											<input type="hidden" value="${coupon.couponRate}" name="couponRate">
											<input type="hidden" value="${coupon.couponPrice}" name="couponPrice">
											<input type="hidden" value="${coupon.couponNum}" name="couponNum"> 								
											<button class="btn btn-danger btnCoupon btn-sm"  type="button"> ?????? ???????????? </button>
											<div class="mb-4"></div>
										</div>
									</div>
								</div>
						</c:forEach>
					</div>
				<div class="both"></div>	
				<br><hr>		
		        <form name="reservationForm" method="post">
		       	<br>
		          <div class="mb-4">
		  			<div class="font">????????? ??????</div>
		            <label for="recipient-name" class="col-form-label basic">????????? ??????</label>
		            <input type="text" class="form-control" name="realUserName" id="realUserName" placeholder="????????? ??? ????????? ???????????????.">
		            <small class="form-control-plaintext help-block">????????? 2~5??? ????????????, ????????? ???????????????. </small>
		          </div>
		          <div class="mb-3">
		            <label for="recipient-name" class="col-form-label basic" >????????? ????????????</label>
		            <input type="text" class="form-control" name="realUserTel" id="realUserTel" placeholder="????????? ??? ????????? ?????????????????????.">
		          </div>
		          <br><hr><br>
		          
		          <div class="font">?????? ??? ?????? ??????</div>
		          <br>
		          <span class="basic mb-3">??? ?????? ??????</span><span class="margin result">${gap}??? <span class="realPrice2">${paymentPrice*gap}???</span></span>   
				  <br><br>				
		          <span class="basic mb-3">?????? ?????? ?????? ??????</span><span class ="spanPaymentPrice margin" id="realPayment"></span>
		          <br><br><hr><div class="mb-4"></div>	
		          	<div class="form-check">
						 <input type="checkbox" id="agree" name="agree"
											class="form-check-input"
											checked="checked"
											onchange="form.sendButton.disabled = !checked">
						 <label class="form-check-label label" for="flexCheckDefault">
						    ?????? ?????? ??????
						 </label>
						 <br>
						 <label class="form-check-label smallLabel" for="flexCheckDefault">
						    ????????????, ?????? ??? ?????? ????????? ???????????? ?????? ?????? ????????? ????????? ?????????.
						 </label>
					</div>
					
					<div class="mb-4"></div>				
		          	<div>
						<input type="hidden" value="${dto.roomNum}" name="roomNum">
						<%-- 	<input type="hidden" value="${start_date}" name="start_date">
						<input type="hidden" value="${end_date}" name="end_date"> --%>
						<input type="hidden" value="${dto.headCount}" name="headCount">
						<input type="hidden" value="${dto.roomPrice}" name="totalPrice">
						<input type="hidden" value="${paymentPrice*gap}" name="paymentPrice">
						<input type="hidden" value="${dto.checkInTime}" name="checkInTime"> 
						<input type="hidden" value="${dto.checkOutTime}" name="checkOutTime"> 
						<input type="hidden" value="${dto.discountRate}" name="discountRate">
						<input type="hidden" value="${dto.companyNum}" name="companyNum">
						<input type="hidden" value="${dto.checkInTime}" name="checkInTime"> 
						<input type="hidden" value="${dto.checkOutTime}" name="checkOutTime"> 
						<input type="hidden" value="${start_date}" name="start_date" class="styleInput"> 
						<input type="hidden" value="${end_date}" name="end_date" class="styleInput">
						<input type ="hidden" name ="couponNum" value ="0">
						<input type="hidden" value="0" name="couponPrice" >								
					</div>
			         <div class="modal-footer">
				      	<button type="button" name="sendButton" class="btn btn-danger" onclick="requestPay();">??????</button>
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">??????</button>
			      	</div>
		        </form>   
		      </div>
		    </div>
		  </div>
		</div>

	</div>
</div>
</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</html>