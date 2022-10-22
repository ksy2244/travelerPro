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
<jsp:include page="/WEB-INF/views/admin_layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 1000px;
}

.basic {
	background-color: #F5EFE6;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">
<script type="text/javascript">
function deleteNotice() {
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
				<h3> 업체 상세정보 </h3>
			</div>
			
			<div class="body-main">
				
				<table class="table">
					<thead>
						<tr>
							<td colspan="2" align="center">
								${dto.companyName}
							</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td align="right">
								전화번호 : ${dto.companyTel} | 사업자명 : ${dto.userName}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="100">
								${dto.companyInfo}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="100">
								${dto.amenities}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="100">
								${dto.guide}
							</td>
						</tr>
						
						<tr>
							<td align="left">
								체크인•아웃 시간 : ${dto.checkInTime} / ${dto.checkOutTime}
							</td>
						</tr>
						
						<tr>
							<td align="left">
								주소 : ${dto.addr} | ${dto.addrDetail}
							</td>
						</tr>
						

					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/';">수정</button>
							<button type="button" class="btn basic" onclick="deleteNotice();">삭제</button>
						</td>
						
						<td class="text-end">
							<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/admin/companyList.do?${query}';">리스트</button>
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