<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CEOMain</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/ceo.js"></script>
<script type="text/javascript">
function companyOk() {
	const f = document.companyForm;
	
		
	f.action = "${pageContext.request.contextPath}/ceo/recognition_ok.do"; 
	f.submit();
	
}
</script>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
	
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3><i class="bi bi-person-square"></i> 업체승인하기 </h3>
			</div>
			
		    <div class="alert alert-info" role="alert">
		        <i class="bi bi-person-check-fill"></i> 업체승인을 위해 정보를 입려해주세요
		    </div>
			
			<div class="body-main">
				
				<form name="companyForm" method="post">
					<div class="row mb-3">
						<label class="col-sm-2  col-form-label" for="companyName">업체명</label>
						<div class="col-sm-10 userId-box">
							<div class="row">
								<div class="col-5 pe-1">
									${dto.companyName}
								</div>
							</div>
						</div>
					</div>
					<div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="companyNum">사업자번호</label>
				        <div class="col-sm-10 row">
							<div class="col-sm-3 pe-2">
								${dto.businessNum}
<%-- 							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 px-1">
								<input type="text" name="companyNum2" id="companyNum2" class="form-control" value="${dto.tel2}" maxlength="2">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 ps-1">
								<input type="text" name="companyNum3" id="companyNum3" class="form-control" value="${dto.tel3}" maxlength="5">
							</div> --%>
				        </div>
				    </div>
				    </div>
				    

				 
				    <div class="row mb-3">
				        <label class="col-sm-2 pt-1 col-form-label" for="userId">아이디</label>
				        <div class="col-sm-10">
				        	${dto.userId}
				        </div>
				    </div>
				 
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="amenities">지역명</label>
				        <div class="col-sm-10">
				           ${dto.regionNum == 1 ? "강원도":"다른지역" }
				        </div>
				    </div>

				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="checkinTime">체크인시간</label>
				        <div class="col-sm-10 row">
							<div class="col-3 pe-0">
								${dto.checkinTime}
							</div>
						</div>
					</div>
					<div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="checkoutTime">체크아웃시간</label>
				        <div class="col-sm-10 row">
							<div class="col-3 pe-0">
								${dto.checkoutTime}
							</div>
						</div>
					</div>
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="tel1">전화번호</label>
				        <div class="col-sm-10 row">
							<div class="col-sm-3 pe-2">
								${dto.companyTel}
				        	</div>
				    	</div>
				    </div>
				
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="zip">우편번호</label>
				        <div class="col-sm-5">
				       		<div class="input-group">
								${dto.zip}
				           	</div>
						</div>
				    </div>
			
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="addr1">주소</label>
				        <div class="col-sm-10">
				       		<div>
				           		${dto.addr}
				           	</div>
				       		<div style="margin-top: 5px;">
				       			${dto.addrDetail}
							</div>
						</div>
				    </div>
					<div class="mt-10 mb-5">
					  <label for="exampleFormControlTextarea1" class="form-label">업체정보</label>
					  <textarea class="form-control" name="companyInfo" id="companyInfo" rows="3">${dto.companyInfo}</textarea>
					</div>
					<div class="mb-5">
					  <label for="exampleFormControlTextarea1" class="form-label">서비스(편의시설)</label>
					  <textarea class="form-control" name="amenities" id="amenities" rows="3">${dto.amenities}</textarea>
					</div>
					<div class="mb-5">
					  <label for="exampleFormControlTextarea1" class="form-label">안내</label>
					  <textarea class="form-control" name="guide" id="guide" rows="3">${dto.guide}</textarea>
					</div>
					<div class="mb-5">
					  <label for="exampleFormControlTextarea1" class="form-label">예약공지</label>
					  <textarea class="form-control" name="notice" id="notice" rows="3">${dto.notice}</textarea>
					</div>

				    <div class="row mb-3">
				        <div class="text-center">
				            <button type="button" name="sendButton" class="btn btn-primary" onclick="companyOk();"> <i class="bi bi-check2"></i>수정하기</button>
							<input type="hidden" name="userIdValid" id="userIdValid" value="false">
				        </div>
				    </div>
				
				    <div class="row">
						<p class="form-control-plaintext text-center">${message}</p>
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