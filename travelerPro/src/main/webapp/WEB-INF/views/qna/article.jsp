<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TRAVELER</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.body-container {
	max-width: 1500px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 40px;
}

.box {
	background: #eee;
	border-radius: 3px;
	border: 5px solid #eee;
	font-size: 13px;
	text-align: center;
	color: #5D5D5D;
}

.content {
	border-bottom: none;
}

.blue {
	color: navy;
	margin-left: 40px;
}

.question {
	color: #B4CDE6;
	font-size: 70px;
	font-weight: 500;
	padding: 0px;
	margin-left: 40px;
}

.subject {
	font-size: 25px;
	margin-left: 25px;
}

.content {
	margin-top: 20px;
	margin-left: 40px;
	margin-right: 40px;
	height: 250px;
}

.id {
	margin-left: 40px;
	margin-top: 20px;
	font-size: 15px;
	margin-bottom: 30px;
}

.date {
	color: #787878;
}

.answer {
	margin-left: 40px;
	font-size: 50px;
	color: #628E90;
	font-weight: 500;
}

.margin {
	margin-left: 40px;
	margin-bottom: 30px;
}

.reply-list {
	border: 1px solid #ccc;
	border-radius: 15px;
	padding: 20px;
}

.write {
	margin-top: 30px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
	<c:if test="${sessionScope.member.userId==dto.userId }">
	function deleteBoard() {
		if (confirm("문의글을 삭제하시겠습니까 ? ")) {
			let query = "questionNum=${dto.questionNum}&${query}";
			let url = "${pageContext.request.contextPath}/qna/delete.do?"
					+ query;
			location.href = url;
		}
	}
	</c:if>
</script>


</head>
<body class="pt-5">

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<main class="pt-5">
	<div class="container">
		<div class="body-container">	
			<button type="button" class="btn text-white pb-5" onclick="location.href='${pageContext.request.contextPath}/qna/list.do?${query}';"><img src="${pageContext.request.contextPath}/resources/images/left2.png" style="width: 18px;"></button>

				<div class="body-main reply-list">
					<table class="table">
						<tbody>
							<tr class="title">
							<td colspan="2" align="left">
								<span class="question">Q</span> <span class="subject">${dto.subject}</span>
								<div class="content">${dto.content}</div>
								<c:choose>
									<c:when test="${dto.categoryNum == 1}">
										<span class="blue"><i class="fa-solid fa-bars"></i> 회원/개인정보 </span>
									</c:when>
									<c:when test="${dto.categoryNum == 2}">
										<span class="blue"><i class="fa-solid fa-bars"></i> 쿠폰 </span>
									</c:when>
									<c:when test="${dto.categoryNum == 3}">
										<span class="blue"><i class="fa-solid fa-bars"></i> 환불 </span>
									</c:when>
									<c:otherwise>
										<span class="blue"><i class="fa-solid fa-bars"></i> 예약/결제 </span>
									</c:otherwise>
								</c:choose>
								<div class="id"><span class="date">${dto.reg_date}</span></div>
								<div class="text-end pb-3"><button type="button" class="btn btn-danger text-white " onclick="deleteBoard();">삭제</button></div>
							</td>
						</tr>
						</tbody>
					</table>
					
					<div class="reply">
						<div id="listReply">
							<table class='table table-borderless'>
								<tr>
									<td width="100%">
										<div class='answer'>A</div>
										<div class='content'>${vo.content}</div>
										<div class='date margin'>${vo.reg_date}</div>
									</td>
								</tr>
							</table>			
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