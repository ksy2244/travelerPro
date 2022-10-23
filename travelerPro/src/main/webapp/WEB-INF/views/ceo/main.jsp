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
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
	
<main>
	<div class="container mt-3">
		<div class="body-container">	
			<div class="body-title">
				<h3><i class="bi bi-house"></i> 업체 리스트 </h3>
			</div>
			<div class="body-main">
		        <div class="row board-list-header">
		            <div class="col-auto me-auto">
		            	${dataCount}개(${page}/${total_page} 페이지)
		            </div>
		            <div class="col-auto">&nbsp;</div>
		        </div>				
				
				<table class="table table-hover board-list">
					<thead class="table-light">
						<tr>
							<th class="companyNum">번호</th>
							<th class="companyName">업체명</th>
							<th class ="companyTel">업체 전화번호</th>
							<th class="addr1">주소</th>
							<th class="approval">관리자 승인 여부</th>
							<th class="roomgo">객실등록</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status"> 
							<tr>
								<td> ${dto.companyNum}</td>
								<td class="left">
									<a href="${articleUrl}&companyNum=${dto.companyNum}" class="text-reset">${dto.companyName}</a>
								</td>
								<td>${dto.companyTel}</td>
								<td>${dto.addr}</td>
								<td>${dto.approval == 0 ? "대기중" : "승인완료" }</td>
								<%-- <c:if test="${dto.approval ==1}"> --%>
								<td><button class="submit" onclick="location.href='${pageContext.request.contextPath}/room/list.do?companyNum=${dto.companyNum}'">객실등록</button></td>
								<%-- </c:if> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>

				<div class="row board-list-footer">
					<div class="col">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/ceo/main.do';">새로고침</button>
					</div>
					<div class="col text-end">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/ceo/recognition.do';">업체등록하러가기</button>
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
</html>