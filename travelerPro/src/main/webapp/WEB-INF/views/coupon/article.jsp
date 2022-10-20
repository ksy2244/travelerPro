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
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/board2.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/coupon.css" type="text/css">
<script type="text/javascript">
function deleteBoard() {
	if(confirm("쿠폰을 삭제하시겠습니까 ? ")) {
		let query = "couponNum=${dto.couponNum}&page="+${page};
		let url = "${pageContext.request.contextPath}/coupon/delete.do?page="+${page};
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
								${dto.couponRate}, ${dto.couponPrice}
							</td>
						</tr>
						

					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<button type="button" class="btn" id="btn" onclick="location.href='${pageContext.request.contextPath}/coupon/update.do?couponNum=${dto.couponNum}&page=${page}';">수정</button>
							<button type="button" class="btn" id="btn" onclick="deleteBoard();">삭제</button>
						</td>
						
						<td class="text-end">
							<button type="button" class="btn" id="btn" onclick="location.href='${pageContext.request.contextPath}/coupon/list.do?page=${page}';">리스트</button>
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