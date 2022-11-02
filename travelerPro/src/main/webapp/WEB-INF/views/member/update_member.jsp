<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>travler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<style type="text/css">
.body-container {
	max-width: 800px;
}

.max-small {
	width: auto;
	height: auto;
	max-width: 150px;
	max-height: 150px;
}
</style>

<script type="text/javascript">
	function memberOk() {
		const f = document.memberForm;
		let str;

		str = f.userPwd.value;
		if (!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) {
			alert("패스워드를 다시 입력 하세요. ");
			f.userPwd.focus();
			return;
		}

		if (str !== f.userPwd2.value) {
			alert("패스워드가 일치하지 않습니다. ");
			f.userPwd.focus();
			return;
		}

		str = f.userName.value;
		if (!/^[가-힣]{2,5}$/.test(str)) {
			alert("이름을 다시 입력하세요. ");
			f.userName.focus();
			return;
		}

		str = f.birth.value;
		if (!str) {
			alert("생년월일를 입력하세요. ");
			f.birth.focus();
			return;
		}

		str = f.tel1.value;
		if (!str) {
			alert("전화번호를 입력하세요. ");
			f.tel1.focus();
			return;
		}

		str = f.tel2.value;
		if (!/^\d{3,4}$/.test(str)) {
			alert("숫자만 가능합니다. ");
			f.tel2.focus();
			return;
		}

		str = f.tel3.value;
		if (!/^\d{4}$/.test(str)) {
			alert("숫자만 가능합니다. ");
			f.tel3.focus();
			return;
		}

		str = f.email1.value.trim();
		if (!str) {
			alert("이메일을 입력하세요. ");
			f.email1.focus();
			return;
		}

		str = f.email2.value.trim();
		if (!str) {
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
		if (str !== "direct") {
			f.email2.value = str;
			f.email2.readOnly = true;
			f.email1.focus();
		} else {
			f.email2.value = "";
			f.email2.readOnly = false;
			f.email1.focus();
		}
	}
</script>
</head>
<body class="pt-5">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="pt-5">
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>내 정보 관리</h3>
				</div>
				<div class="body-main">

					<form name="memberForm" method="post">
						<div class="row mb-3">
							<div class="d-flex justify-content-center">
								<img class='max-small'
									src="${pageContext.request.contextPath}/resources/images/icon_profile.png"
									alt="프로필" class="img-circle">

							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="userId">아이디</label>
							<div class="col-sm-10 userId-box">
								<div class="row">
									<div class="col-5 pe-1">
										<input type="text" name="userId" class="form-control"
											value="${dto.userId}" readonly="readonly"
											style="border: none">
									</div>
								</div>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="userName">이름</label>
							<div class="col-sm-10">
								<input type="text" name="userName" id="userName"
									class="form-control" value="${dto.userName}"
									${mode=="update" ?  "":""} placeholder="${dto.userName}">
							</div>
						</div>



						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="nickName">닉네임</label>
							<div class="col-sm-10">
								<input type="text" name="nickName" id="nickName"
									class="form-control" value="${dto.nickName}"
									${mode=="update" ?  "":""} placeholder="${dto.nickName}">
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="userPwd">비밀번호</label>
							<div class="col-sm-10">
								<input type="password" name="userPwd" id="userPwd"
									value="${dto.userPwd}" class="form-control" autocomplete="off"
									placeholder="패스워드"> <small
									class="form-control-plaintext">비밀번호는 5~10자이며 하나 이상의 숫자나
									특수문자가 포함되어야 합니다.</small>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="userPwd2">비밀번호
								확인</label>
							<div class="col-sm-10">
								<input type="password" name="userPwd2" id="userPwd2"
									class="form-control" autocomplete="off" placeholder="비밀번호 확인">
								<small class="form-control-plaintext">비밀번호를 한번 더 입력해주세요.</small>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="birth">생년월일</label>
							<div class="col-sm-10">
								<input type="date" name="birth" id="birth" class="form-control"
									value="${dto.birth}" placeholder="${dto.birth}"
									> <small
									class="form-control-plaintext">생년월일은 2000-01-01 형식으로
									입력합니다.</small>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="selectEmail">이메일</label>
							<div class="col-sm-10 row">
								<div class="col-3 pe-0">
									<select name="selectEmail" id="selectEmail" class="form-select"
										onchange="changeEmail();">
										<option value="">선 택</option>
										<option value="naver.com"
											${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버
											메일</option>
										<option value="gmail.com"
											${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지
											메일</option>
										<option value="hanmail.net"
											${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한
											메일</option>
										<option value="hotmail.com"
											${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫
											메일</option>
										<option value="direct">직접입력</option>
									</select>
								</div>

								<div class="col input-group">
									<input type="text" name="email1" class="form-control"
										maxlength="30" value="${dto.email1}"> <span
										class="input-group-text p-1"
										style="border: none; background: none;">@</span> <input
										type="text" name="email2" class="form-control" maxlength="30"
										value="${dto.email2}" readonly="readonly">
								</div>

							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="tel1">전화번호</label>
							<div class="col-sm-10 row">
								<div class="col-sm-3 pe-2">
									<input type="text" name="tel1" id="tel1" class="form-control"
										value="${dto.tel1}" maxlength="3">
								</div>
								<div class="col-sm-1 px-1" style="width: 2%;">
									<p class="form-control-plaintext text-center">-</p>
								</div>
								<div class="col-sm-3 px-1">
									<input type="text" name="tel2" id="tel2" class="form-control"
										value="${dto.tel2}" maxlength="4">
								</div>
								<div class="col-sm-1 px-1" style="width: 2%;">
									<p class="form-control-plaintext text-center">-</p>
								</div>
								<div class="col-sm-3 ps-1">
									<input type="text" name="tel3" id="tel3" class="form-control"
										value="${dto.tel3}" maxlength="4">
								</div>

							</div>
						</div>

						<div class="row mb-3">
							<div class="text-center">
								<button type="button" name="sendButton"
									class="btn btn-danger text-white" onclick="memberOk();">
									${mode=="member"?"회원가입":"정보수정"}</button>
								<button type="button" class="btn"
									onclick="location.href='${pageContext.request.contextPath}/';">
									${mode=="member"?"가입취소":"취소"}<i class="bi bi-x"></i>
								</button>

								<input type="hidden" name="userIdValid" id="userIdValid"
									value="false">

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
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>