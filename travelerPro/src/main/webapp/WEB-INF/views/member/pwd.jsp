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
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title2.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width:800px;
}
</style>

<script type="text/javascript">
function sendOk() {
	const f = document.pwdForm;

	let str = f.userPwd.value;
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.userPwd.focus();
		return;
	}

	f.action = "${pageContext.request.contextPath}/member/pwd_ok.do";
	f.submit();
}
</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="pt-5">
	<div class="container">
		<div class="body-container">	

	        <div class="row justify-content-md-center">
	            <div class="col-md-7">
	                <div class="border mt-5 p-4">
	                    <form name="pwdForm" method="post" class="row g-3">
	                        <h3 class="text-center fw-bold">비밀번호 재확인</h3>
	                        
			                <div class="d-grid">
								<p class="form-control-plaintext text-center">정보 보호를 위해 비밀번호를 다시 한 번 입력해주세요.</p>
			                </div>
	                        
	                        <div class="d-grid">
	                            <input type="text" name="userId" class="form-control form-control-lg" placeholder="아이디"
	                            		value="${sessionScope.member.userId}" 
	                            		readonly="readonly">
	                        </div>
	                        <div class="d-grid">
	                            <input type="password" name="userPwd" class="form-control form-control-lg" placeholder="비밀번호">
	                        </div>
	                        <div class="d-grid">
	                            <button type="button" class="btn btn-lg" onclick="sendOk();" style="background: #EDEEF7">확인 <i class="bi bi-check2"></i> </button>
	                            <input type="hidden" name="mode" value="${mode}">
	                        </div>
	                    </form>
	                </div>

	                <div class="d-grid">
						<p class="form-control-plaintext text-center">${message}</p>
	                </div>

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