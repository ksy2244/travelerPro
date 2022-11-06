<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class='review-info'>
	<span class='review-count mb-5'>리뷰 ${reviewCount}개</span>
</div>

<table class='table table-borderless review-list'>
	<c:forEach var="vo" items="${listReview}">
		<tr class='list-header mt-5'>
			<td class="ps-3 pt-5">
				<c:choose>
					<c:when test="${vo.starRate == 5 || vo.starRate == 4}">
						<div class="color"><i class="fa-regular fa-face-smile-beam fa-5x"></i></div> 
					</c:when>
					<c:when test="${vo.starRate == 3}">
						<div class="color"><i class="fa-regular fa-face-meh fa-5x"></i></div>
					</c:when>
					<c:otherwise>
						<div class="color"><i class="fa-regular fa-face-frown fa-5x"></i></div>
					</c:otherwise>
				</c:choose>	
			</td>
			<td width='50%' class="ps-3 pt-5">
				<span class='bold nickName'>${vo.nickName}</span>
			</td>
			<td width='50%' align='right' class="pt-3">
				<span class="registerDate">${vo.reg_date}&nbsp;&nbsp;|&nbsp;&nbsp;</span> 
				
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
		<tr class='list-header content'>
			<td colspan='4' valign='top' class="pt-5 pb-5 ps-3">${vo.content}</td>
		</tr>

	</c:forEach>
</table>

<div class="page-navigation">
	${paging}
</div>		


	