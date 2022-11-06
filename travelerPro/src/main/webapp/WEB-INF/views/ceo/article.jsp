<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CEO</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title3.png" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
.img-box img {
	cursor: pointer;

}

#basic {
	background-color: #6C757D;
}

#basic:hover{background-color:#7689A5;}

</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/ceo.js"></script>
<script type="text/javascript">
function deleteCeo() {
     if(confirm("해당업체를 삭제 하시겠습니까 ? ")) {
	    let query = "companyNum=${dto.companyNum}&page=${page}";
	    let url = "${pageContext.request.contextPath}/ceo/delete.do?" + query;
    	location.href = url;
     }
}

function imageViewer(src) {
	const $model = $("#myDialogModal .modal-body");
	let s="<img src='"+src+"' class='img-thumbnail w-100 h-100'>";
	$model.html(s);
	
	$("#myDialogModal").modal("show");
}
</script>
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
				<h3> 업체 상세 정보 </h3>
			</div>
			
		    <div class="alert alert-info" role="alert">
		         업체 상세 정보입니다.
		    </div>
			
			<div class="body-main">
				
				<form name="companyForm" method="post">
					<div class="row mb-3">
						<label class="col-sm-2  col-form-label" for="companyName">업체명</label>
						<div class="col-sm-10">
							<div class="col-sm-10">
								${dto.companyName}
							</div>
						</div>
					</div>
					<div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="companyNum">사업자번호</label>
				        <div class="col-sm-10">
							<div class="col-sm-10">
								${dto.businessNum}
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
				           ${dto.regionName}
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
				        <div class="col-sm-10 row">
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
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="images">이미지</label>
				        <div class="col-sm-2 row img-box">
							<c:forEach var="vo" items="${listFile}">
								<div class="col p-1">
									<img src="${pageContext.request.contextPath}/uploads/ceo/${vo.imageFilename}"
										class="img-thumbnail w-100 h-100" style="max-height: 130px;"
										onclick="imageViewer('${pageContext.request.contextPath}/uploads/ceo/${vo.imageFilename}');">
								</div>
							</c:forEach>
						</div>
				    </div>
				    
					<div class="mt-10 mb-5">
					  <label for="exampleFormControlTextarea1" class="form-label">업체정보</label>
					  <textarea class="form-control" name="companyInfo" id="companyInfo" rows="3">${dto.companyInfo}</textarea>
					</div>
					<div class="mb-5">
					  <label for="exampleFormControlTextarea1" class="form-label">서비스(편의시설)</label>
					  <br>
					  
					  <c:set var="serviceList" value="${dto.amenities}"></c:set>
							<c:forEach var="service" items="${serviceList}">
									<c:choose>
										<c:when test="${service == 1}">와이파이&nbsp;/ </c:when>
										<c:when test="${service == 2}">애견동반&nbsp;/ </c:when>
										<c:when test="${service == 3}">개별 바베큐&nbsp;/ </c:when>
										<c:when test="${service == 4}">수영장&nbsp;/ </c:when>
										<c:when test="${service == 5}">주차 가능&nbsp;/ </c:when>
										<c:when test="${service == 6}">상비약&nbsp;/ </c:when>
										<c:when test="${service == 7}">기본 양념&nbsp;/ </c:when>
										<c:when test="${service == 8}">매점&편의점&nbsp;/ </c:when>
										<c:when test="${service == 9}">조식 운영&nbsp;/ </c:when>
										<c:when test="${service == 10}">운동장&nbsp;/ </c:when> 
										<c:otherwise><p>기타</p></c:otherwise> 
										
							</c:choose>
							</c:forEach>
						
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
						<%-- 	<c:choose> --%>
								<%-- <c:when test="${sessionScope.member.userId==dto.userId}"> --%>
									<button type="button" class="btn text-white" id="basic"  onclick="location.href='${pageContext.request.contextPath}/ceo/update.do?companyNum=${dto.companyNum}&page=${page}';">수정</button>
<%-- 								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-primary" disabled="disabled">수정</button>
								</c:otherwise>
							</c:choose>
					    	
							<c:choose> --%>
					    		<%-- <c:when test="${sessionScope.member.userId==dto.userId}"> --%>
					    			<button type="button" class="btn text-white" id="basic" onclick="deleteCeo();">삭제</button>
<%-- 					    		</c:when>
					    		<c:otherwise>
					    			<button type="button" class="btn btn-primary" disabled="disabled">삭제</button>
					    		</c:otherwise>
					    	</c:choose> --%>
				        </div>
				    </div>
				</form>
			</div>
		</div>
	</div>	
</main>

<!-- Modal -->
<div class="modal fade" id="myDialogModal" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">이미지 뷰어</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        
			</div>
		</div>
	</div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />

</body>
</html>