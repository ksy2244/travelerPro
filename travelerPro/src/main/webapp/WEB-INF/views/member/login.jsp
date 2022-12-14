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
body {
	height: 100vh;
	width: 100%;
	background-image: url('${pageContext.request.contextPath}/resources/images/background4.png');
	background-size: cover;
	background-repeat: repeat-x;
}

.body-container {
	max-width: 800px;
}

.login {
	background: white;
	border-radius: 3px;
}
</style>

<script type="text/javascript">
function sendLogin() {
    const f = document.loginForm;
	let str;
	
	str = f.userId.value;
    if(!str) {
        f.userId.focus();
        return;
    }

    str = f.userPwd.value;
    if(!str) {
        f.userPwd.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/login_ok.do";
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
			<br><br>
	        <div class="row">
	            <div class="col-md-6 offset-md-3">
	                <div class="border mt-5 p-4 login">
	                    <form name="loginForm" action="" method="post" class="row g-3">
	                        <h3 class="text-center"><i class="bi bi-lock"></i> 회원 로그인</h3>
	                        <div class="col-12">
	                            <label class="mb-1">아이디</label>
	                            <input type="text" name="userId" class="form-control" placeholder="아이디">
	                        </div>
	                        <div class="col-12">
	                            <label class="mb-1">패스워드</label>
	                            <input type="password" name="userPwd" class="form-control" placeholder="패스워드">
	                        </div>
	                        <div class="col-12">
	                            <div class="form-check">
	                                <input class="form-check-input" type="checkbox" id="rememberMe">
	                                <label class="form-check-label" for="rememberMe"> 아이디 저장</label>
	                            </div>
	                        </div>
	                        <div class="col-12">
	                            <button type="button" class="btn float-end btn-danger text-white" onclick="sendLogin();">&nbsp;Login&nbsp;<i class="bi bi-check2"></i></button>
	                        </div>
	                    </form>
	                    <hr class="mt-4">
	                    <div class="col-12">
	                        <p class="text-center mb-0">
	                        	<a href="#" class="text-decoration-none me-2">아이디 찾기</a>
	                        	<a href="#" class="text-decoration-none me-2">패스워드 찾기</a>
	                        	<a href="${pageContext.request.contextPath}/member/member.do" class="text-decoration-none">회원가입</a>
	                        </p>
	                        <p class="form-control-plaintext mt-3 text-center text-danger">${message}</p>
	                    </div>
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