<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>qna</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">

<script type="text/javascript">
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	function deleteBoard() {
		if (confirm("문의글을 삭제 하시 겠습니까 ? ")) {
			let query = "questionNum=${dto.questionNum}&${query}";
			let url = "${pageContext.request.contextPath}/qna/delete.do?"
					+ query;
			location.href = url;
		}
	}
	</c:if>
</script>

<script type="text/javascript">
	function login() {
		location.href = "${pageContext.request.contextPath}/member/login.do";

	}

	function ajaxFun(url, method, query, dataType, fn) {
		$.ajax({
			type : method,
			url : url,
			data : query, // 없으면 null값 써도됨
			dataType : dataType, // dataType 을 생략하면 텍스트 타입이 됨
			success : function(data) { // 성공하면 (data) 를 fn(data);에 출력
				fn(data);
			},
			beforeSend : function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			},
			error:function(jqXHR) { // 서버통신에 문제가 잇을때 에러 사용 
				if(jqXHR.status === 403){ 
					login();
					return false;
				} else if(jqXHR.status === 400){ 
					alert("요청 처리가 실패 했습니다.");
					return false;
				}
				
				console.log(jqXHR.responseText);
			}
		});
	}
	

$(function () {
	listPage(1);
});

function listPage(page) { 
	let url = "${pageContext.request.contextPath}/qna/listReply.do";
	let query = "questionNum=${dto.questionNum}&pageNo="+page;
	let selector = "#listReply";
	
	const fn = function (data) {
		$(selector).html(data); 
	};
	ajaxFun(url, "get", query, "html", fn);
}


</script>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>
						<i class="bi bi-book-half"></i> 1:1문의
					</h3>
				</div>

				<div class="body-main">

					<table class="table">
						<thead>
							<tr>
								<td colspan="2" align="center">${dto.subject}</td>
							</tr>
						</thead>
							<thead>
							<tr >
							<c:if test ="${dto.categoryNum == 1}">
									<td colspan="2">문의사항 : 회원/개인정보</td>
								</c:if>
								<c:if test ="${dto.categoryNum == 2}">
									<td colspan="2">문의사항 : 쿠폰</td>
								</c:if>
								<c:if test ="${dto.categoryNum == 3}">
									<td colspan="2">문의사항 : 환불</td>
								</c:if>
								<c:if test ="${dto.categoryNum == 4}">
									<td colspan="2">문의사항 : 예약/결제</td>
								</c:if>
								</tr>
								</thead>
						<tbody>
							<tr>
								<td width="50%">작성자 : ${dto.userId}</td>
								<td align="right">${dto.reg_date}</td>
								
							</tr>
							
							<tr>
								<td colspan="2" valign="top" height="200">${dto.content}</td>
							</tr>
							
 							
						</tbody>
					</table>

					<table class="table table-borderless">
						<tr>
							<td width="50%"><c:choose>
									<c:when test="${sessionScope.member.userId==dto.userId}">
										<button type="button" class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/qna/update.do?questionNum=${dto.questionNum}&page=${page}';">수정</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light"
											disabled="disabled">수정</button>
									</c:otherwise>
								</c:choose> <c:choose>
									<c:when
										test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
										<button type="button" class="btn btn-light"
											onclick="deleteBoard();">삭제</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light"
											disabled="disabled">삭제</button>
									</c:otherwise>
								</c:choose></td>
							<td class="text-end">
								<button type="button" class="btn btn-light"
									onclick="location.href='${pageContext.request.contextPath}/qna/list.do?${query}';">리스트</button>
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