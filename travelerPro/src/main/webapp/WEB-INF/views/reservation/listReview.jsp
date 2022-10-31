<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class='review-info'>
	<span class='review-count'>댓글 ${reviewCount}개</span>
	<span>[목록, ${pageNo}/${total_page} 페이지]</span>
</div>

<table class='table table-borderless reply-list'>
	<c:forEach var="vo" items="${listReview}">
		<tr class='list-header'>
			<td width='50%'>
				<span class='bold'>${vo.nickName}</span>
			</td>
			<td width='50%' align='right'>
				<span>${vo.reg_date}</span> | 평점 "${vo.starRate}"
				
				<c:choose>
			
					<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">
						<span class='deleteReview' data-reviewNum='${vo.reviewNum}' data-pageNo='${pageNo}'>삭제</span>
					</c:when>
					<c:otherwise>
						<span class='notifyReview'>신고</span>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan='2' valign='top'>${vo.content}</td>
		</tr>

	</c:forEach>
</table>

<div class="page-navigation">
	${paging}
</div>		


	