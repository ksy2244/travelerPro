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

.check {
	background: #F1AEB5;
}

.check:hover {background:#F1C2BF;}

.basic {
	background: #dc3545;
}

.basic:hover {background: #F03545;}

.side {
	background: #E35D6A;
}

.side:hover {background: #ED5D6A;}
</style>

<script type="text/javascript">
function memberOk() {
	const f = document.memberForm;
	let str;

	str = f.userId.value;
	if( !/^[a-z][a-z0-9_]{4,9}$/i.test(str) ) { 
		alert("아이디를 다시 입력 하세요. ");
		f.userId.focus();
		return;
	}

	let mode = "${mode}";
	if(mode === "member" && f.userIdValid.value === "false") {
		str = "아이디 중복 검사가 실행되지 않았습니다.";
		$("#userId").parent().find(".help-block").html(str);
		f.userId.focus();
		return;
	}
	
	str = f.userPwd.value;
	if( !/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str) ) { 
		alert("패스워드를 다시 입력 하세요. ");
		f.userPwd.focus();
		return;
	}

	if( str !== f.userPwd2.value ) {
        alert("패스워드가 일치하지 않습니다. ");
        f.userPwd.focus();
        return;
	}
	
    str = f.userName.value;
    if( !/^[가-힣]{2,5}$/.test(str) ) {
        alert("이름을 다시 입력하세요. ");
        f.userName.focus();
        return;
    }

    str = f.birth.value;
    if( !str ) {
        alert("생년월일를 입력하세요. ");
        f.birth.focus();
        return;
    }
    
    str = f.tel1.value;
    if( !str ) {
        alert("전화번호를 입력하세요. ");
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
    if( !/^\d{3,4}$/.test(str) ) {
        alert("숫자만 가능합니다. ");
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
    if( !/^\d{4}$/.test(str) ) {
    	alert("숫자만 가능합니다. ");
        f.tel3.focus();
        return;
    }
    
    str = f.email1.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }

    str = f.email2.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.email2.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/${mode}_ok.do";
    f.submit();
}

function changeEmail() {
    const f = document.memberForm;
	    
    let str = f.selectEmail.value;
    if(str !== "direct") {
        f.email2.value = str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value = "";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

function userIdCheck() {
	// 아이디 중복 검사
	let userId = $("#userId").val();

	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) { 
		let str = "아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.";
		$("#userId").focus();
		$("#userId").parent().find(".help-block").html(str);
		return;
	}
	
	let url = "${pageContext.request.contextPath}/member/userIdCheck.do";
	let query = "userId=" + userId;
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			let passed = data.passed;

			if(passed === "true") {
				let str = "<span style='color:blue; font-weight: bold;'>" + userId + "</span> 아이디는 사용 가능 합니다.";
				$(".userId-box").find(".help-block").html(str);
				$("#userIdValid").val("true");
			} else {
				let str = "<span style='color:red; font-weight: bold;'>" + userId + "</span> 아이디는 이미 등록되어 있습니다.";
				$(".userId-box").find(".help-block").html(str);
				$("#userId").val("");
				$("#userIdValid").val("false");
				$("#userId").focus();
			}
		}
	});
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
				<h3> ${title} </h3>
			</div>
			
			<div class="body-main">
				<form name="memberForm" method="post">
					<div class="row mb-4">
						<label class="col-sm-2 col-form-label" for="userId">아이디</label>
						<div class="col-sm-10 userId-box">
							<div class="row">
								<div class="col-5 pe-1">
									<input type="text" name="userId" id="userId" class="form-control" value="${dto.userId}" 
											${mode=="update" ? "readonly='readonly' ":""}
											placeholder="아이디">
								</div>
								<div class="col-3 ps-1">
									<c:if test="${mode=='member'}">
										<button type="button" class="btn text-white check" onclick="userIdCheck();">아이디 중복검사</button>
									</c:if>
								</div>
							</div>
							<c:if test="${mode=='member'}">
								<small class="form-control-plaintext help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
							</c:if>
						</div>
					</div>
				 
					<div class="row mb-4">
						<label class="col-sm-2 col-form-label" for="userPwd">패스워드</label>
						<div class="col-sm-10">
				            <input type="password" name="userPwd" id="userPwd" class="form-control" autocomplete="off" placeholder="패스워드">
				            <small class="form-control-plaintext">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
				        </div>
				    </div>
				    
				    <div class="row mb-4">
				        <label class="col-sm-2 col-form-label" for="userPwd2">패스워드 확인</label>
				        <div class="col-sm-10">
				            <input type="password" name="userPwd2" id="userPwd2" class="form-control" autocomplete="off" placeholder="패스워드 확인">
				            <small class="form-control-plaintext">패스워드를 한번 더 입력해 주세요.</small>
				        </div>
				    </div>
				 
				    <div class="row mb-4">
				        <label class="col-sm-2 col-form-label" for="userName">이름</label>
				        <div class="col-sm-10">
				            <input type="text" name="userName" id="userName" class="form-control" value="${dto.userName}" 
				            		${mode=="update" ? "readonly='readonly' ":""}
				            		placeholder="이름">
				        </div>
				    </div>
				    
				    <div class="row mb-4">
				        <label class="col-sm-2 col-form-label" for="nickName">닉네임</label>
				        <div class="col-sm-10">
				            <input type="text" name="nickName" id="nickName" class="form-control" value="${dto.nickName}" 
				            		${mode=="update" ? "readonly='readonly' ":""}
				            		placeholder="닉네임">
				        </div>
				    </div>
				 
				    <div class="row mb-4">
				        <label class="col-sm-2 col-form-label" for="birth">생년월일</label>
				        <div class="col-sm-10">
				            <input type="date" name="birth" id="birth" class="form-control" value="${dto.birth}" placeholder="생년월일">
				            <small class="form-control-plaintext">생년월일은 2000-01-01 형식으로 입력합니다.</small>
				        </div>
				    </div>
				
				    <div class="row mb-4">
				        <label class="col-sm-2 col-form-label" for="selectEmail">이메일</label>
				        <div class="col-sm-10 row">
							<div class="col-3 pe-0">
								<select name="selectEmail" id="selectEmail" class="form-select" onchange="changeEmail();">
									<option value="">선 택</option>
									<option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
									<option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
									<option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
									<option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
									<option value="direct">직접입력</option>
								</select>
							</div>
							
							<div class="col input-group">
								<input type="text" name="email1" class="form-control" maxlength="30" value="${dto.email1}" >
							    <span class="input-group-text p-1" style="border: none; background: none;">@</span>
								<input type="text" name="email2" class="form-control" maxlength="30" value="${dto.email2}" readonly="readonly">
							</div>		
		
				        </div>
				    </div>
				    
				    <div class="row mb-4">
				        <label class="col-sm-2 col-form-label" for="tel1">전화번호</label>
				        <div class="col-sm-10 row">
							<div class="col-sm-3 pe-2">
								<input type="text" name="tel1" id="tel1" class="form-control" value="${dto.tel1}" maxlength="3">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 px-1">
								<input type="text" name="tel2" id="tel2" class="form-control" value="${dto.tel2}" maxlength="4">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 ps-1">
								<input type="text" name="tel3" id="tel3" class="form-control" value="${dto.tel3}" maxlength="4">
							</div>
				        </div>
				    </div>
			
					<c:if test="${mode == 'member' }">
					    <div class="row mb-3">
					        <label class="col-sm-2 col-form-label" for="agree">약관 동의</label>
							<div class="col-sm-8" style="padding-top: 5px;">
								<input type="checkbox" id="agree" name="agree"
									class="form-check-input"
									checked="checked"
									style="margin-left: 0;"
									onchange="form.sendButton.disabled = !checked">
								<label class="form-check-label">
									<a href="#" class="text-decoration-none">이용약관</a>에 동의합니다.
								</label>
							</div>
					    </div>
					 </c:if>
				     
				    <div class="row mb-4">
				        <div class="text-center">
				            <button type="button" name="sendButton" class="btn text-white basic" onclick="memberOk();"> ${mode=="member"?"회원가입":"정보수정"} <i class="bi bi-check2"></i></button>
				            <button type="button" class="btn text-white side" onclick="location.href='${pageContext.request.contextPath}/';"> ${mode=="member"?"가입취소":"수정취소"} <i class="bi bi-x"></i></button>
							<input type="hidden" name="userIdValid" id="userIdValid" value="false">
				        </div>
				    </div>
				
				    <div class="row">
						<p class="form-control-plaintext text-center">${message}</p>
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