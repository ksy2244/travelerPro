<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	
		<c:forEach var="dto" items="${list}">
			<div class="body-main">
				<div class="accordion accordion-flush" id="accordionFlushExample${dto.faqNum}">
					  <div class="accordion-item">
					    <h2 class="accordion-header" id="flush-headingOne">
					      <button class="accordion-button collapsed" id="clickButton" data-categoryNum='${dto.categoryNum}' data-faqNum='${dto.faqNum}' type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
					       ${dto.subject}
					      </button>
					    </h2>
					    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
					      <div class="accordion-body">${dto.content}</div>
					    </div>
					  </div>
					</div>
				</div>
		</c:forEach>
		
		<c:forEach var="dto" items="${listAll}">
			<div class="body-main">
				<div class="accordion accordion-flush" id="accordionFlushExample${dto.faqNum}">
					  <div class="accordion-item">
					    <h2 class="accordion-header" id="flush-headingOne">
					      <button class="accordion-button collapsed" id="clickButton" type="button" data-categoryNum='${dto.categoryNum}' data-faqNum='${dto.faqNum}' data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
					       ${dto.subject} 
					      </button>
					    </h2>
					    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
					      <div class="accordion-body">${dto.content}</div>
					    </div>
					  </div>
					</div>
				</div>
		</c:forEach>
		
		