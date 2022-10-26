﻿<%@ page contentType="text/html; charset=UTF-8" %>
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
				<h3> 회원정보 확인 </h3>
			</div>
			
			<div class="body-main">
				<table class="table table-hover board-list">
					<thead>
							<tr class="title">
								<th>아이디</th>
								<th>닉네임</th>
								<th>가입일</th>
								<th>생년월일</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>구분</th>
								
							</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td>${dto.userId}</td>
								<td>${dto.nickName}</td>
								<td>${dto.reg_date}</td>
        						<td>${dto.birth}</td>
        						<td>${dto.tel}</td>
								<td>${dto.email}</td>
								<c:if test="${dto.roll==0}">
									<td>일반 회원 <i class="fa-regular fa-user"></i></td>
								</c:if>
								<c:if test="${dto.roll==1}">
									<td>업체 회원 <i class="fa-solid fa-house-user"></i></td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 회원이 없습니다." : paging}
				</div>
				
			</div>
		</div>
	</div>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>