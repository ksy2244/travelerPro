<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
@import url('https://webfontworld.github.io/hallym/Hallym.css');
@import url('https://webfontworld.github.io/gmarket/GmarketSans.css');
.navContainer {
	display: grid;
	line-height: 1.0;
	margin-left: 20px;
	float: right;
}

.traveler {
	font-family: 'GmarketSans'; 
	font-size: 45px; 
	margin-left: 300px;
	margin-top: 10px;
	letter-spacing: 7px;
	height: 65px;
}

.navbar {
	border: none;
}

#width {
	height: 150px;
	width: 220px;
}

</style>

<nav class="navbar navbar-expand-lg justify-content-end bg-info fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand text-white traveler" href="${pageContext.request.contextPath}/"><i class="fa-regular fa-paper-plane">TRAVELER</i></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
	    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent" style="margin-right: 10px;">
	     <div class="navContainer" style="margin-right:10px;">
	    
	      <ul class="navbar-nav mb-2 mb-lg-0">
	        <c:if test="${empty sessionScope.member}">
		      	<li class="nav-item">
		          		<a class="nav-link text-white" href="#" title=""
		          		 style="font-family: 'GmarketSans'; font-size: 23px; margin-right: 45px;">관광지</a>
		        </li>
		    	<li class="nav-item">
		          		<a class="nav-link text-white" href="javascript:dialogLogin();" title="예약내역"
		          		 style="font-family: 'GmarketSans'; font-size: 23px; margin-right: 45px;">예약내역</a>
		        </li>
		        <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
		           style="font-family: 'GmarketSans'; font-size: 23px; letter-spacing :1.5px; margin-right: 45px;">
		            더보기
		          </a>
		          <ul class="dropdown-menu">
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/more/faq.do" style="font-family: 'GmarketSans';">자주 묻는 질문 FAQ</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/qna/list.do" style="font-family: 'GmarketSans';">1:1 문의</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/more/notice.do" style="font-family: 'GmarketSans';">공지사항</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/more/service.do" style="font-family: 'GmarketSans';">약관 및 정책</a></li>
		          </ul>
		        </li>
	        	<li class="nav-item">
	          		<a class="nav-link text-white" href="javascript:dialogLogin();" title="로그인"
	          		 style="font-family: 'GmarketSans'; font-size: 23px; margin-right: 45px;">로그인</a>
	        	</li>
	        	<li class="nav-item">
	          		<a class="nav-link text-white" href="#" title="회원가입" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
	          		 style="font-family: 'GmarketSans'; font-size: 23px; margin-right: 220px;">회원가입</a>
	        	</li>
	      	</c:if>
	      	
	      	<c:if test="${not empty sessionScope.member}">
	      		<li class="nav-item">
		          		<a class="nav-link text-white" href="#" title=""
		          		 style="font-family: 'GmarketSans'; font-size: 23px; margin-right: 50px;">관광지</a>
		        </li>
		    	<li class="nav-item">
		          		<a class="nav-link text-white" href="${pageContext.request.contextPath}/reservation/myReservation.do" title="예약내역"
		          		 style="font-family: 'GmarketSans'; font-size: 23px; margin-right: 50px;">예약내역</a>
		        </li>
		        <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
		           style="font-family: 'GmarketSans'; font-size: 23px; letter-spacing :1.5px; margin-right: 50px;">
		            더보기
		          </a>
		          <ul class="dropdown-menu">
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/more/faq.do" style="font-family: 'GmarketSans';">자주 묻는 질문 FAQ</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/qna/list.do" style="font-family: 'GmarketSans';">1:1 문의</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/more/notice.do" style="font-family: 'GmarketSans';">공지사항</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/more/service.do" style="font-family: 'GmarketSans';">약관 및 정책</a></li>
		          </ul>
		        </li>	      		
	        	<li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
		           style= "font-size: 30px; margin-right: 220px; padding: 0px;"> 
	            		<i class="fa-regular fa-face-smile"></i>
	          		</a>
		          <ul class="dropdown-menu">
		            <li><a class="dropdown-item" href="javascript:dialogPwd();" style="font-family: 'GmarketSans';">내 정보</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mypage/coupon.do" style="font-family: 'GmarketSans';">쿠폰함</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/reservation/myReservation.do" style="font-family: 'GmarketSans';">예약내역</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/review/myReview.do" style="font-family: 'GmarketSans';">나의 후기</a></li>
		            <li><a class="dropdown-item" href="#" style="font-family: 'GmarketSans';">찜</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mypage/alarm.do" style="font-family: 'GmarketSans';">알림설정</a></li>
		            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout.do" style="font-family: 'GmarketSans';">로그아웃</a></li>
		          </ul>
	      	</c:if>
	      	</ul>     	
	    </div>  
	  </div>
 	</div>
</nav>

	
	<!-- 회원가입 선택 모달 -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered">
   	 		<div class="modal-content">
      			<div class="modal-header">
	        		<h1 class="modal-title fs-5" id="staticBackdropLabel">회원가입</h1>
	        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
		      	<div class="modal-body">
		       		<button class="btn btn-outline-danger" id="width" type="button" onclick="location.href='${pageContext.request.contextPath}/member/member.do'">일반 회원으로<br>가입하기</button>
		       		<span style="margin-right: 20px;"></span>
			       	<button class="btn btn-outline-danger" id="width" type="button" onclick="location.href='${pageContext.request.contextPath}/ceomember/ceomember.do'">사업자 회원으로<br>가입하기</button>
			     </div>
    		</div>
  		</div>
	</div>

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
	
	function dialogPwd() {
	    $("form[name=modelPwdForm] input[name=userId]").val("");
	    $("form[name=modelPwdForm] input[name=userPwd]").val("");
	    
		$("#pwdModal").modal("show");	
		
	    $("form[name=modelPwdForm] input[name=userId]").focus();
	}
	
	
	function sendOk() {
		const f = document.modelPwdForm;

		let str = f.userPwd.value;
		if(!str) {
			alert("패스워드를 입력하세요. ");
			f.userPwd.focus();
			return;
		}

		f.action = "${pageContext.request.contextPath}/member/pwd_ok.do?mode=update";
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
	                            <button type="button" class="btn w-100 text-white btn-danger" onclick="sendModelLogin();">Login</button>
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
	                        	<a href="#" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#staticBackdrop">회원가입</a> 
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
	
	
	
	<!-- 비밀번호 재확인 모달 -->
	
	<div class="modal fade" id="pwdModal" tabindex="-1"
			data-bs-backdrop="static" data-bs-keyboard="false" 
			aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="loginViewerModalLabel">비밀번호 재확인</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
	                <div class="p-3">
	                    <form name="modelPwdForm" action="" method="post" class="row g-3">
	                    	<div class="mt-0">
	                    		 <p class="form-control-plaintext">정보 보호를 위해 비밀번호를 다시 한 번 입력해주세요.</p>
	                    	</div>
	                  
	                        <div>
	                            <input type="password" name="userPwd" class="form-control" placeholder="비밀번호">
	                        </div>
	                        <div>
	                            <button type="button" class="btn w-100 text-white btn-danger" onclick="sendOk();">확인</button>
	                        </div>
	                      
	                    </form>
	                    <hr class="mt-3">
	                </div>
				</div>
			</div>
		</div>
	</div>