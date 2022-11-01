<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TRAVELER</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 1500px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 40px;
}

.side {
	background: #E35D6A;
}

.side:hover {background: #ED5D6A;}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
function sendOk() {
	const f = document.qnaForm;
	str = f.subject.value.trim();
	    if(!str) {
	        alert("제목을 입력하세요. ");
	        f.subject.focus();
	        return false;
	    }

	
	str = f.content.value.trim();
		if(!str || str === "<p><br></p>") { // 아무것도 입력 안하면 "<p><br></p>" 만 출력
	        alert("내용을 입력하세요. "); 
	        f.content.focus();
	        return false;
	    }
		
	if(! confirm('등록하시겠습니까?')){
		return false;
	}
		

	f.action = "${pageContext.request.contextPath}/qna/${mode}_ok.do";
	f.submit();
}



</script>
</head>
<body class="pt-5">

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main class="pt-5">
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 새 문의 작성 </h3>
			</div>
			
			<div class="body-main">
				<form name="qnaForm" method="post">
					<div class="row mb-4">
						<label class="col-sm-2 col-form-label">카테고리</label>
						<div class="col-sm-10 userId-box">
							<div class="row">
								<div class="col-5 pe-1">
									<select name="categoryNum" id="categoryNum" class="form-select" required aria-label="select example">
										<c:forEach var="vo" items="${list}">
											<option value="${vo.categoryNum }" ${dto.categoryNum==vo.categoryNum ? "selected = 'selected'": ""}>${vo.categoryName }</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
				 
					<div class="row mb-4">
						<label class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
				            <input type="text" name="subject" class="form-control" value="${dto.subject}" placeholder="제목">
				        </div>
				    </div>
				    
				    <div class="row mb-4">
				        <label class="col-sm-2 col-form-label" for="userPwd2">내용</label>
				        <div class="col-sm-10 mb-4">
				            <textarea name="content" id="ir1" class="form-control" style="width: 100%; height: 300px;" placeholder="내용">${dto.content}</textarea>
				        </div>
				    </div>
				     
				    <div class="row mb-4">
				        <div class="text-center">
				            <button type="button" onclick="sendOk();" class="btn btn-danger text-white">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn side text-white">다시입력</button>
								<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/qna/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="questionNum" value="${dto.questionNum}"> 
									<input type="hidden" name="page" value="${page}">
								</c:if>
				        </div>
				    </div>
				</form>
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