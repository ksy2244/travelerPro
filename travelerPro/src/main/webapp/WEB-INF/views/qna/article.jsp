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
			let query = "num=${dto.num}&${query}";
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
	let query = "num=${dto.num}&pageNo="+page;
	let selector = "#listReply";
	
	const fn = function (data) {
		$(selector).html(data); 
	};
	ajaxFun(url, "get", query, "html", fn);
}



// 리플 등록
$(function () {
	$(".btnSendReply").click(function () {
		let num = "${dto.num}";
		const $tb = $(this).closest("table");
		let content = $tb.find("textarea").val().trim();
		if( ! content ){
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content); // 반드시 인코딩해야함
		
		let url = "${pageContext.request.contextPath}/qna/insertReply.do";
		let query = "num="+num+"&content="+content+"&answer=0"; 
		
		const fn = function(data){
			$tb.find("textarea").val("");
			if(data.state==="true"){
				listPage(1);
				
			} else {
				alert("댓글 등록이 실패 했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json",fn);
	});
	
});

// 댓글 삭제 - 답글도 지워지게 하면 됨
$(function () {
	$("body").on("click", ".deleteReply", function () {
		if(! confirm('게시글을 삭제하시겠습니까 ? ')) {
			return false;
		}
		
		let replyNum = $(this).attr("data-replyNum");
		let page = $(this).attr("data-pageNo");
		
		let url= "${pageContext.request.contextPath}/qna/deleteReply.do";
		let query = "replyNum="+replyNum;
		
		const fn = function (data) {
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	});
});
	
// 댓글별 답글 리스트 
function listReplyAnswer(answer) {
	let url = "${pageContext.request.contextPath}/qna/listReplyAnswer.do";
	let query = "answer="+answer;
	let selector = "#listReplyAnswer" + answer;
	
	const fn = function (data) {
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 댓글별 답글 개수
function countReplyAnswer(answer) {
	let url = "${pageContext.request.contextPath}/qna/countReplyAnswer.do"; // 서블릿의 countReplyAnswer 주소로 
	let query = "answer="+answer;
	
	const fn = function (data) {
		let count = data.count;
		let selector = "#answerCount"+answer;
		$(selector).html(count);
	};
	
	ajaxFun(url, "post", query, "json", fn);
	
}

//댓글별 답글 등록 버튼
$(function () {
	$("body").on("click", ".btnSendReplyAnswer", function () {
		let num = "${dto.num}";
		let replyNum = $(this).attr("data-replyNum");
		const $td = $(this).closest("td"); // td로 textarea 찾기위한 함수
		
		let content = $td.find("textarea").val().trim();
		if(! content){
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		let url = "${pageContext.request.contextPath}/sbbs/insertReply.do";
		let query = "num="+num+"&content="+content+"&answer="+replyNum;
		
		const fn = function (data) {
			$td.find("textarea").val("");
			
			let state = data.state;

			if(state === "true"){
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	});
});


// 답글 버튼 (댓글별 답글 등록 폼 및 답글 리스트)
$(function () {
	$("body").on("click", ".btnReplyAnswerLayout", function () { 
		// => listReply.jsp 바디에서 38번줄 클래스 이름 (.btnReplyAnswerLayout 객체)찾아서 click 이벤트 등록
		// $("body") 또는 $("document") 사용 가능 
		const $tr = $(this).closest("tr").next(); 
		// .btnReplyAnswerLayout의 가장가까운 tr을 찾음
		
		let isVisible = $tr.is(":visible");
		let replyNum = $(this).attr("data-replyNum");
		
		if(isVisible){
			$tr.hide(); // listReply.jsp의 36번줄 tr
		} else {
			$tr.show();
			
			// 답글 리스트
			listReplyAnswer(replyNum);
			
			
			// 답글 개수
			countReplyAnswer(replyNum);
			
			
		}
		
	});
});


// 댓글별 답글 삭제
$(function () {
	
});

</script>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" >
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

						<tbody>
							<tr>
								<td width="50%">이름 : ${dto.userName}</td>
								<td align="right">${dto.reg_date}</td>
							</tr>

							<tr>
								<td colspan="2" valign="top" height="200">${dto.content}</td>
							</tr>
							<!-- 
							<tr>
								<td colspan="2">파&nbsp;&nbsp;일 : <c:if
										test="${not empty dto.saveFilename}">
										<a
											href="${pageContext.request.contextPath}/qna/download.do?num=${dto.num}">${dto.originalFilename}</a>
									(<fmt:formatNumber value="${dto.fileSize/1024}"
											pattern="#,##0.00" /> kb)
								</c:if>
								</td>
							</tr>
 							-->
 							
							<tr>
								<td colspan="2">이전글 : <c:if test="${not empty preReadDto}">
										<a
											href="${pageContext.request.contextPath}/qna/article.do?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
									</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="2">다음글 : <c:if test="${not empty nextReadDto}">
										<a
											href="${pageContext.request.contextPath}/qna/article.do?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>

					<table class="table table-borderless">
						<tr>
							<td width="50%"><c:choose>
									<c:when test="${sessionScope.member.userId==dto.userId}">
										<button type="button" class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/qna/update.do?num=${dto.num}&page=${page}';">수정</button>
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

					<div class="reply">
						<form name="replyForm" method="post">
							<div class='form-header'>
								<span class="bold">답변</span>
							</div>

							<table class="table table-borderless reply-form">
								<tr>
									<td><textarea class='form-control' name="content"></textarea>
									</td>
								</tr>
								<tr>
									<td align='right'>
										<button type='button' class='btn btn-light btnSendReply'>질문
											등록</button>
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
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>