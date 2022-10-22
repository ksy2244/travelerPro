<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>notice</title>
<jsp:include page="/WEB-INF/views/admin_layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
#table {
	width: 380px;
	height: 150px;
	float: left;
	margin-left: 10px;
	margin-right: 10px;
	box-shadow: 3px 3px #ccc;
}
.coupon {
	display: block;
	border-bottom: none;
}
.basic {
	background-color: #F5EFE6;
}
.form tr:first-child {
	border-top: 2px solid #3C2317; 
}
.btn:hover{background-color:#D9D2CC;}
.bold {
	background-color: #3C2317;
}
.bold:hover{background-color:#804A30;}
.trbold {
	border-bottom: 1px solid #3C2317;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/board2.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/coupon.css" type="text/css">
<script type="text/javascript">
function deleteCoupon() {
	if(confirm("쿠폰을 삭제하시겠습니까 ? ")) {
		let query = "${query}&couponNum=${dto.couponNum}";
		let url = "${pageContext.request.contextPath}/coupon/delete.do?" + query;
	    location.href = url;
	}
}

</script>


</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin_layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 쿠폰 상세정보 </h3>
			</div>
			
			<div class="body-main">			
				<table class="table">
					<thead>
						<tr>
							<td colspan="2" align="center">
								${dto.couponName}
							</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td align="right">
								사용기간 : ${dto.start_date} ~ ${dto.end_date}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="200">
								${dto.content}
							</td>
						</tr>
						
						<tr>
							<td align="left">
								<c:if test="${dto.couponRate==0}">
									할인금액 : ${dto.couponPrice}원
								</c:if>
								<c:if test="${dto.couponPrice==0}">
									할인율 : ${dto.couponRate}%
								</c:if>
							</td>
						</tr>
						

					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<button type="button" class="btn basic"onclick="location.href='${pageContext.request.contextPath}/coupon/update.do?page=${page}&couponNum=${dto.couponNum}';">수정</button>
							<button type="button" class="btn basic"onclick="deleteCoupon();">삭제</button>
						</td>
						
						<td class="text-end">
							<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/coupon/list.do?${query}';">리스트</button>
						</td>
					</tr>
				</table>
				
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/admin_layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin_layout/staticFooter.jsp"/>
</body>
</html>