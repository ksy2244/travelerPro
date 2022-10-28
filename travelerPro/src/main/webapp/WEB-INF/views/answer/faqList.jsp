<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	
<div class="body-main">
	<div class="accordion accordion-flush" id="accordionFlush${categoryNum}">
		<c:forEach var="dto" items="${list}" varStatus="status">
			<div class="accordion-item">
				<h2 class="accordion-header" id="flush-heading-${categoryNum}-${status.index}">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse-${categoryNum}-${status.index}" aria-expanded="false" aria-controls="flush-collapse-${categoryNum}-${status.index}"
							data-categoryNum='${dto.categoryNum}' data-faqNum='${dto.faqNum}'>
					   ${dto.subject}
					</button>
				</h2>
				<div id="flush-collapse-${categoryNum}-${status.index}" class="accordion-collapse collapse" aria-labelledby="flush-heading-${categoryNum}-${status.index}" data-bs-parent="#accordionFlush${categoryNum}">
					<div class="accordion-body">
						<div class="accordion-body">${dto.content}</div>
						<div class="row board-list-footer">
							<div class="col">
								<button type="button" class="btn plus" onclick="location.href='${pageContext.request.contextPath}/answer/faqDelete.do?faqNum=${dto.faqNum}';">삭제</button>
							</div>
							<div class="col text-end">
								<button type="button" class="btn plus" onclick="location.href='${pageContext.request.contextPath}/answer/faqUpdate.do?faqNum=${dto.faqNum}';">수정</button>
							</div>
						</div>
					</div>
				</div>
			</div>		
		</c:forEach>
	</div>
</div>

		
		