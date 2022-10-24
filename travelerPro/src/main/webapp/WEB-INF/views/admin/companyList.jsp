<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>traveler_manage</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp"/>

<style type="text/css">
.body-container {
	max-width: 1000px;
}

.basic {
	background-color: #F5EFE6;
}

.basic:hover{background-color:#D9D2CC;}

.title {
	border-bottom: 2px solid #B4CDE6;
	background: #B4CDE6;
}

.red {
	color: red;
	font-weight: bold;
	font-style: italic;
}

.blue {
	color: blue;
	font-weight: bold;
	font-style: italic;
}

.img {
	width: 20px;
	height: 20px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header_admin.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 업체정보 확인 </h3>
			</div>
			
			<div class="body-main">
				<table class="table table-hover board-list">
					<thead>
							<tr class="title">
								<th>사업자명</th>
								<th>업체명</th>
								<th>업체 전화번호</th>
								<th>사업자 번호</th>
								<th>상태</th>
								<th>상세 정보</th>
							</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td>${dto.userName}</td>
								<td>${dto.companyName}</td>
								<td>${dto.companyTel}</td>
        						<td>${dto.businessNum}</td>
        						<c:if test="${dto.approval==0}">
									<td class="red">대기</td>
								</c:if>
								<c:if test="${dto.approval==1}">
									<td class="blue">승인</td>
								</c:if>
        						<td><a href="${articleUrl}&companyNum=${dto.companyNum}" class="text-reset"><img src="../resources/images/right.png" alt="상세 정보 확인" class="img"></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 업체가 없습니다." : paging}
				</div>
				
			</div>
		</div>
	</div>

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">회원 상세정보</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
			<div>아이디 : ${dto.userId}</div>
        	<div>이름 : ${dto.userName}</div>
        	<div>이메일 : ${dto.email}</div>
        	<div>전화번호 : ${dto.tel}</div>
        	<div>생년월일 : ${dto.birth}</div>
      </div>
    </div>
  </div>
</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>