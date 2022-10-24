<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--  한번 돌때마다 댓글별 답글 개수만큼 나옴 -->
<c:forEach var="vo" items="${listAnswer}">
	<div class='answer-article'>
		<div class='answer-article-header'>
			<div class='answer-left'>└</div>
			<div class='answer-right'>
				<div style='float: left;'><span class='bold'>${vo.userName}</span></div>
				<div style='float: right;'>
					<span>${vo.reg_date}</span> |
					
					<c:choose>
				
						<c:when test="${vo.userId==sessionScope.member.userId || sessionScope.member.userId=='admin'}">
						<span class='deleteReplyAnswer' data-replyNum='${vo.replyNum}' data-answer='${vo.answer}'>삭제</span>
						</c:when>
						<c:otherwise>
							<span class="notifyReply">신고</span>
						</c:otherwise>
					</c:choose>
					
				</div>
			</div>
		</div>
		<div class='answer-article-body'>
			${vo.content}
		</div>
	</div>
</c:forEach>