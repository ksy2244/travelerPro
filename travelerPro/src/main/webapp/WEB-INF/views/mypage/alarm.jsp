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

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.body-container {
	max-width: 1500px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 40px;
}

#table {
	width: 30%;
	height: 140px;
	float: left;
	margin-left: 20px;
	margin-right: 20px;
	margin-top: 25px;
	border: 1px solid #eee;
}

.block {
	display: block;
	border-bottom: none;
}

.basic {
	background-color: #6C757D;
}

.basic:hover {
	background-color: #7689A5;
}

.form tr:first-child {
	border-top: 2px solid #3C2317;
}

.trbold {
	border-bottom: 1px solid #3C2317;
}

.box {
	border: 2px solid #eee;
	height: 60px;
	width: 130px;
	border-right: 7px solid black;
	border-radius: 5px;
}

.text {
	padding-top: 35px;
}

.text_color {
	color: #787878;
}

#searchDate {
	color: red;
}

.detail {
	font-weight: bold;
	font-size: 12px;
	height: 47px;
}

.top {
	margin-top: 10px;
}

.checkbox_container {

	height: 30px;
	line-height: 30px;
	margin-top: 8px;
	margin-bottom: 8px;
	padding-left: 40px;
	cursor: pointer;
	display: block;
	position: relative;
	user-select: none;
}

.checkbox_container .checkbox_mark {
	width: 30px;
	height: 30px;
	top: 0;
	left: 0;
	position: absolute;
	background-color: #eeeeee;
	border-radius: 4px;
}

.checkbox_container:hover input ~ .checkbox_mark {
	background-color: #cccccc;
}

.checkbox_container input:checked ~ .checkbox_mark {
	background-color: #1DDBDE;
}

.checkbox_container input {
	position: absolute;
	width: 0;
	height: 0;
	opacity: 0;
}

.checkbox_container .checkbox_mark:after {
	display: none;
	content: "";
	position: relative;
}

.checkbox_container input:checked ~ .checkbox_mark:after {
	display: block;
}

.checkbox_container .checkbox_mark:after {
	width: 4px;
	height: 10px;
	top: 7px;
	left: 12px;
	border-style: solid;
	border-color: white;
	border-width: 0 3px 3px 0;
	transform: rotate(45deg);
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">
</head>
<body class="pt-5">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="pt-5">
		<div class="container">
			<div class="body-container">
				
				<div class="body-title">
					<h3>알림</h3>
				</div>
				<div class="body-main">
				<label class="checkbox_container"> 마케팅 알림 수신 동의(선택) <input
					type="checkbox" checked="checked"> <span
					class="checkbox_mark"></span>
					
				</label>
				<p>할인쿠폰, 특가 상품, 이벤트 등 다양한 혜택 소식을 가장 먼저 보내드려요.</p>
				
				<label class="checkbox_container"> 푸시알림 <input
					type="checkbox" checked="checked"> <span
					class="checkbox_mark"></span>
				</label> <label class="checkbox_container"> 이메일 <input
					type="checkbox"> <span class="checkbox_mark"></span>
				</label> <label class="checkbox_container"> SMS <input
					type="checkbox"> <span class="checkbox_mark"></span>
				</label>

				</div>
			</div>
		</div>

		<div class="text-center mb-2 p-2">
		
		<button type="button" class="btn btn-primary btnDialog3">변경</button>
		
			<div class="modal fade" id="myDialogModal3" tabindex="-1" 
		aria-labelledby="myDialogModalLabel3" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h6 class="modal-title" id="myDialogModalLabel3">마케팅 알림 수신정보가 수정되었습니다.</h6>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<p>• 일시 : </p>
        		<p>• 수신거절 : </p>
        		<p>• 수신동의 : </p>
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
</body>

<script type="text/javascript">
$(function(){
	$(".btnClose").click(function(){
		$("#myDialogModal2").modal("hide");
	});
});

$(function(){
	$(".btnDialog3").click(function(){
		$("#myDialogModal3").modal("show");
	});
});

$(function(){
	$(".btnDialog4").click(function(){
		$("#myDialogModal4").modal("show");
	});
});


</script>
</html>
