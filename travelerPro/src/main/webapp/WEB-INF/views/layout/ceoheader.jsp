<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ceopage.css" type="text/css">


<nav class="navbar navbar-expand-lg justify-content-end" style=" background: #BDBDBD; border: 20px solid #BDBDBD; z-index: 1; box-shadow: 5px 5px 5px 5px gray">
  <div class="container-fluid">
    <a class="navbar-brand text-white" href="${pageContext.request.contextPath}/ceo/main.do" style="font-family: 'GmarketSans'; font-size: 30px; text-decoration: none;"><i class="bi bi-github">사장님 페이지</i></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent" style="margin-right: 350px;">
      <ul class="navbar-nav mb-2 mb-lg-0">
        <c:if test="${empty sessionScope.member}">
        	<li class="nav-item">
          		<a class="nav-link fw-semibold text-white" href="javascript:dialogLogin();" title="로그인"
          		 style="font-family: 'GmarketSans'; font-size: 25px; margin-top: 6px; margin-right: 20px;">로그인</a>
        	</li>
        	<li class="nav-item">
          		<a class="nav-link fw-semibold text-white" href="${pageContext.request.contextPath}/member/member.do" title="회원가입"
          		 style="font-family: 'GmarketSans'; font-size: 25px; margin-top: 6px; margin-right: 20px;">회원가입</a>
        	</li>
        	<li class="nav-item fw-semibold text-white">
          		<a class="nav-link fw-semibold text-white" href="${pageContext.request.contextPath}/main/main.do" title="메인화면"
          		 style="font-family: 'GmarketSans'; font-size: 25px; margin-top: 6px; margin-right: 20px;">메인화면가기</a>
        	</li>
      	</c:if>
      	<c:if test="${not empty sessionScope.member}">
      		<li class="nav-item fw-semibold text-white">
          		<a class="nav-link fw-semibold text-white" href="${pageContext.request.contextPath}/member/logout.do" title="로그아웃" 
          		 style="font-family: 'GmarketSans'; font-size: 25px; margin-top: 6px; margin-right: 20px;">로그아웃</a>
        	</li>
      		<li class="nav-item fw-semibold text-white">
          		<a class="nav-link fw-semibold text-white" href="#" title="마이페이지"
          		 style="font-family: 'GmarketSans'; font-size: 25px; margin-top: 6px; margin-right: 20px;">마이페이지</a>
        	</li>
      	</c:if>
      	</ul>
    </div>
  </div>
</nav>
<nav>
	<ul class="menu">
		<li><a href="${pageContext.request.contextPath}/ceo/recognition.do">업체승인받기</a></li>
		<li><a href="${pageContext.request.contextPath}/ceo/main.do">업체리스트</a></li>
		<li><a href="${pageContext.request.contextPath}/ceo/paylist.do">매출리스트</a></li>
		<li><a href="${pageContext.request.contextPath}/ceo/reservation.do">예약정보리스트</a></li>
		<li><a href="${pageContext.request.contextPath}/ceo/room.do">객실등록</a></li>
	</ul>
</nav>


	<!-- Login Modal -->
	<script type="text/javascript">
	function dialogLogin() {
	    $("form[name=modelLoginForm] input[name=userId]").val("");
	    $("form[name=modelLoginForm] input[name=userPwd]").val("");
	    
		$("#loginModal").modal("show");	
		
	    $("form[name=modelLoginForm] input[name=userId]").focus();
	}

	function sendModelLogin() {
	    var f = document.modelLoginForm;
		var str;
		
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
	<div class="modal fade" id="loginModal" tabindex="-1"
			data-bs-backdrop="static" data-bs-keyboard="false" 
			aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="loginViewerModalLabel">로그인</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
	                <div class="p-3">
	                    <form name="modelLoginForm" action="" method="post" class="row g-3">
	                    	<div class="mt-0">
	                    		 <p class="form-control-plaintext">계정으로 로그인 하세요</p>
	                    	</div>
	                        <div class="mt-0">
	                            <input type="text" name="userId" class="form-control" placeholder="아이디">
	                        </div>
	                        <div>
	                            <input type="password" name="userPwd" class="form-control" placeholder="패스워드">
	                        </div>
	                        <div>
	                            <div class="form-check">
	                                <input class="form-check-input" type="checkbox" id="rememberMeModel">
	                                <label class="form-check-label" for="rememberMeModel"> 아이디 저장</label>
	                            </div>
	                        </div>
	                        <div>
	                            <button type="button" class="btn w-100" onclick="sendModelLogin();" style="background: #EDEEF7">Login</button>
	                        </div>
	                        <div>
	                    		 <p class="form-control-plaintext text-center">
	                    		 	<a href="#" class="text-decoration-none me-2">패스워드를 잊으셨나요 ?</a>
	                    		 </p>
	                    	</div>
	                    </form>
	                    <hr class="mt-3">
	                    <div>
	                        <p class="form-control-plaintext mb-0">
	                        	아직 회원이 아니세요 ?
	                        	<a href="${pageContext.request.contextPath}/member/member.do" class="text-decoration-none">회원가입</a>
	                        </p>
	                    </div>
	                </div>
				</div>
			</div>
		</div>
	</div>