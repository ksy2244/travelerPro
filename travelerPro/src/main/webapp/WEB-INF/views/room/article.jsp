<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />
<script type="text/javascript">
function deleteroom() {
	if(confirm("객실을 삭제 하시 겠습니까 ? ")) {
		let query = "companyNum=${companyNum}&roomNum=${dto.roomNum}&${query}";
		let url = "${pageContext.request.contextPath}/room/delete.do?" + query;
	    location.href = url;
	    
	}
}

</script>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 객실 </h3>
			</div>
			
			<div class="body-main">
				
				<table class="table">
					<thead>
						<tr>
							<td colspan="2" align="center">
								${dto.roomName}
							</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							
							<td colspan="2" style="border-bottom: none;">
							
								<div class="row row-cols-6 img-box">
								이미지:
									<c:forEach var="vo" items="${listFile}">
										<div class="col p-1">
											<img src="${pageContext.request.contextPath}/uploads/room/${vo.imageFilename}"
												class="img-thumbnail w-100 h-100" style="max-height: 130px;"
												onclick="imageViewer('${pageContext.request.contextPath}/uploads/room/${vo.imageFilename}');">
										</div>
									</c:forEach>
								</div>
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="200">
								${dto.roomInfo}
							</td>
						</tr>
						<tr>
							<td align="left">
								가&nbsp;&nbsp;격 : ${dto.price}
							</td>
						</tr>
						<tr>
							<td align="left">
								할&nbsp;&nbsp;인&nbsp;&nbsp;률 : ${dto.discountRate}
							</td>
						</tr>
						<tr>
							<td align="left">
								인&nbsp;&nbsp;원&nbsp;&nbsp;수 : ${dto.headCount}
							</td>
						</tr>
						
						

					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<button type="button" class="btn btn-primary"  onclick="location.href='${pageContext.request.contextPath}/room/update.do?roomNum=${dto.roomNum}&page=${page}&companyNum=${companyNum}';">수정</button>
							<button type="button" class="btn btn-primary"  onclick="deleteroom();">삭제</button>
						</td>
						
						<td class="text-end">
							<button type="button" class="btn btn-primary"  onclick="location.href='${pageContext.request.contextPath}/room/list.do?companyNum=${companyNum}';">리스트</button>
						</td>
					</tr>
				</table>
				
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