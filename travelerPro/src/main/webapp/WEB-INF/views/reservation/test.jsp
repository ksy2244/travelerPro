<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login.do";
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}


//댓글별 답글 리스트
function listReplyAnswer(answer) {
	//let url = "${pageContext.request.contextPath}/bbs/listReplyAnswer.do";
	let query = "answer=" + answer;
	let selector = "#listReplyAnswer" + answer;
	
	const fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 댓글별 답글 개수
function countReviewAnswer(answer) {
	let url = "${pageContext.request.contextPath}/bbs/countReviewAnswer.do";
	let query = "answer=" + answer;
	
	const fn = function(data){
		let count = data.count;
		let selector = "#answerCount"+answer;
		$(selector).html(count);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnReviewAnswerLayout", function(){
		const $trReplyAnswer = $(this).closest("tr").next();
		// const $trReplyAnswer = $(this).parent().parent().next();
		// const $answerList = $trReplyAnswer.children().children().eq(0);
		
		let isVisible = $trReviewAnswer.is(':visible');
		let ReviewNum = $(this).attr("data-ReviewNum");
			
		if(isVisible) {
			$trReviewAnswer.hide();
		} else {
			$trReviewAnswer.show();
            
			// 답글 리스트
			listReviewAnswer(replyNum);
			
			// 답글 개수
			countReviewAnswer(replyNum);
		}
	});
	
});

</script>

</head>
<body>
	<table class="table table-borderless">
		<tr>
			<td width="50%"><c:choose>
					<c:when test="${sessionScope.member.userId==dto.userId}">
						<button type="button" class="btn btn-light"
							onclick="location.href='${pageContext.request.contextPath}/bbs/update.do?num=${dto.num}&page=${page}';">수정</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-light" disabled="disabled">수정</button>
					</c:otherwise>
				</c:choose> <c:choose>
					<c:when
						test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
						<button type="button" class="btn btn-light"
							onclick="deleteBoard();">삭제</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
					</c:otherwise>
				</c:choose></td>
			<td class="text-end">
				<button type="button" class="btn btn-light"
					onclick="location.href='${pageContext.request.contextPath}/bbs/list.do?${query}';">리스트</button>
			</td>
		</tr>
	</table>

	<div class="reply">
		<form name="replyForm" method="post">
			<div class='form-header'>
				<span class="bold">댓글</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의
					게시를 삼가해 주세요.</span>
			</div>

			<table class="table table-borderless reply-form">
				<tr>
					<td><textarea class='form-control' name="content"></textarea>
					</td>
				</tr>
				<tr>
					<td align='right'>
						<button type='button' class='btn btn-light btnSendReply'>댓글
							등록</button>
					</td>
				</tr>
			</table>
		</form>

		<div id="listReply"></div>
	</div>



</body>
</html>