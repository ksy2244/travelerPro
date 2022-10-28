<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
@import url('https://webfontworld.github.io/hallym/Hallym.css');
.navContainer {
	display: grid;
	line-height: 1.0;
	margin-left: 20px;
	float: right;
}
</style>

<nav class="navbar navbar-expand-lg justify-content-end bg-info fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand text-white" href="#" style="font-family: 'HallymB'; font-size: 35px; margin-left: 50px;"><i class="fa-regular fa-paper-plane">TRAVELER</i></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent" style="margin-right: 10px;">
     <div class="navContainer" style="margin-right:10px;">
    
      <ul class="navbar-nav mb-2 mb-lg-0">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle fw-semibold text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
           style="font-family: 'HallymM'; font-size: 25px; letter-spacing :1.5px;">
            더보기
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#" style="font-family: 'HallymM';">자주 묻는 질문 FAQ</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/qna/list.do" style="font-family: 'HallymB';">1:1 문의</a></li>
            <li><a class="dropdown-item" href="#" style="font-family: 'HallymM';">공지사항</a></li>
            <li><a class="dropdown-item" href="#" style="font-family: 'HallymM';">약관 및 정책</a></li>
          </ul>
        </li>
        <c:if test="${empty sessionScope.member}">
        	<li class="nav-item">
          		<a class="nav-link fw-semibold text-white" href="javascript:dialogLogin();" title="로그인"
          		 style="font-family: 'HallymM'; font-size: 25px;">로그인</a>
        	</li>
        	<li class="nav-item">
          		<a class="nav-link fw-semibold text-white" href="${pageContext.request.contextPath}/member/member.do" title="회원가입"
          		 style="font-family: 'HallymM'; font-size: 25px;">회원가입</a>
        	</li>
      	</c:if>
      	
      	<c:if test="${not empty sessionScope.member}">
      		
        	<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle fw-semibold text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
           style="font-family: 'HallymM'; font-size: 30px; ">
            <i class="bi bi-person-fill"></i>
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#" style="font-family: 'GmarketSans';">내 정보 관리</a></li>
            <li><a class="dropdown-item" href="#" style="font-family: 'GmarketSans';">쿠폰 조회</a></li>
            <li><a class="dropdown-item" href="#" style="font-family: 'GmarketSans';">예약 내역</a></li>
            <li><a class="dropdown-item" href="#" style="font-family: 'GmarketSans';">나의 후기</a></li>
            <li><a class="dropdown-item" href="#" style="font-family: 'GmarketSans';">찜</a></li>
            <li><a class="dropdown-item" href="#" style="font-family: 'GmarketSans';">알림설정</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout.do" style="font-family: 'HallymM';">로그아웃</a></li>
          </ul>
       
      	</c:if>
      	<li class="nav-item">
      	 <button type="button" class="btn fw-semibold text-white" data-bs-toggle="modal" data-bs-target="#exampleModal">
  			<i class="fa-solid fa-magnifying-glass fa-lg"></i>
		</button>
      	<c:if test="${sessionScope.member.userId == 'admin'}">
			<a class="nav-link fw-semibold text-white" href="${pageContext.request.contextPath}/admin/main.do" title="관리자" style="margin-bottom: 50px;"
           ><i class="fa-solid fa-gears fa-2x"></i></a>
		</c:if>
		</li>
      	</ul>
      	
    </div>
   
  </div>
  </div>
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
	
	<!-- Search Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h1 class="modal-title fs-5" id="exampleModalLabel">검색</h1>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
      			<div class="modal-body">
        			<input type="text" class="form-control" id="recipient-name" placeholder="키워드" name="keyword">
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn" style="background: #B8B5FF">검색</button>
        			<button type="button" class="btn" data-bs-dismiss="modal" style="background: #EDEEF7">닫기</button>
      			</div>
    		</div>
  		</div>
	</div>