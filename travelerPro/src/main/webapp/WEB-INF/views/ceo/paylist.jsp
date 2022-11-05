<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CEO</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
th{font-size:19px;} 
 
td{ padding: 15px;
font-size: 16px; 
}
.body-container {
	max-width: 1500px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 50px;
}

#basic {
	background-color: #6C757D;
}

#basic:hover{background-color:#7689A5;}

.page {
	margin-bottom: 20px;
}

.title {
	border-bottom: 2px solid #ced4da;
	background: #ced4da;
}

#point {
	background-color: #FF5E00;
}

#point:hover{background-color:#FF9000;}

</style>

<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
	
<main>
	<div class="container mt-3">
		<div class="body-container">	
				
			<div class="body-title">
				<h3> 매출 리스트 </h3>
			</div>
			
			<div class="body-main">
		        <div class="row board-list-header">	        	
		           <div><h3 align="center">총 매출: ${sales} 원</h3></div>
		            <div class="col-auto me-auto">
		            	${dataCount}개 (${page}/${total_page} 페이지)
		            </div>
		        </div>				
				
				<table class="table table-hover board-list">
					<thead>
						<tr class="title">
							<th class ="companyName">업체명</th>
							<th class="paymentPrice">업체별 매출액</th>
							
						</tr>
					</thead>
					
					<tbody>
						 <c:forEach var="dto" items="${saleslist}" varStatus="status"> 
							<tr>
								<td>${dto.companyName}</td>
								<td>${dto.paymentPrice} 원</td>
								
							</tr>
						< </c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 업체가 없습니다." : paging}
				</div>

				<div class="row board-list-footer">
					
					
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