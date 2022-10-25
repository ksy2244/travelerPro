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
	margin-top: 20px;
}

.basic:hover{background-color:#D9D2CC;}

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

.italic {
	font-style: italic;
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
				<h3> 상세 문의 </h3>
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
							<td align="left">
								<c:choose>
									<c:when test="${dto.categoryNum == 1}">
										<span class="box">카테고리</span><span class="italic"> 회원/개인정보 </span>
									</c:when>
									<c:when test="${dto.categoryNum == 2}">
										<span class="box">카테고리</span><span class="italic"> 쿠폰 </span>
									</c:when>
									<c:when test="${dto.categoryNum == 3}">
										<span class="box">카테고리</span><span class="italic"> 환불 </span>
									</c:when>
									<c:otherwise>
										<span class="box">카테고리</span><span class="italic"> 예약/결제 </span>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						
						<tr>
							<td align="right">
								<span class="box">아이디</span> ${dto.userId}&nbsp;&nbsp;|&nbsp;&nbsp;<span class="box">작성일</span> ${dto.reg_date}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="200" class="content">
								${dto.content}
							</td>
						</tr>

					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td>
							<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/answer/qnaList.do?${query}';">리스트</button>
						</td>
					</tr>
				</table>
				
				<div class="reply">
					<form name="replyForm" method="post">
						
						<table class="table table-borderless reply-form">
							<tr>
								<td>
									<div class="form-floating">
									  <textarea class="form-control" name="answer" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 150px"></textarea>
									  <label for="floatingTextarea2">Answer</label>
									</div>
								</td>
							</tr>
							<tr>
							   <td align='right'>
							        <button type='button' class='btn basic btnSendReply'>답변 등록</button>
							    </td>
							 </tr>
						</table>
					</form>
					
					<div id="listReply"></div>
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