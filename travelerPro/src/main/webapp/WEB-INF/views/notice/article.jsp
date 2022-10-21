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
.basic {
	background-color: #F5EFE6;
}
.btn:hover{background-color:#D9D2CC;}
.bold {
	background-color: #3C2317;
}

.bold:hover{background-color:#804A30;}
.trbold {
	border-bottom: 2px solid #3C2317;
}
.write-form tr:first-child {
	border-top: 2px solid #3C2317; 
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/board2.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/notice.css" type="text/css">
<script type="text/javascript">
function deleteBoard() {
	if(confirm("게시글을 삭제하시겠습니까 ? ")) {
		let query = "noticeNum=${dto.noticeNum}&${query}";
		let url = "${pageContext.request.contextPath}/notice/delete.do?" + query;
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
				<h3> 공지사항 </h3>
			</div>
			
			<div class="body-main">
				
				<table class="table">
					<thead>
						<tr>
							<td colspan="2" align="center">
								${dto.subject}
							</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td align="right">
								${dto.reg_date}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="200">
								${dto.content}
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								파&nbsp;&nbsp;일 : 
								<c:if test="${not empty dto.saveFilename}">
									<a href="${pageContext.request.contextPath}/notice/download.do?noticeNum=${dto.noticeNum}">${dto.originalFilename}</a>
									(<fmt:formatNumber value="${dto.fileSize/1024}" pattern="#,##0.00"/> kb)
								</c:if>
							</td>
						</tr>

					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/notice/update.do?noticeNum=${dto.noticeNum}&page=${page}';">수정</button>
							<button type="button" class="btn basic" onclick="deleteBoard();">삭제</button>
						</td>
						
						<td class="text-end">
							<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/notice/list.do?${query}';">리스트</button>
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