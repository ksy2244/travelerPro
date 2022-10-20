<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>traveler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<script type="text/javascript">
	function memberOk() {
		const f = document.memberForm;
		let str;

		str = f.userId.value;
		if (!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) {
			alert("아이디를 다시 입력 하세요. ");
			f.userId.focus();
			return;
		}

		let mode = "${mode}";
		if (mode === "member" && f.userIdValid.value === "false") {
			str = "아이디 중복 검사가 실행되지 않았습니다.";
			$("#userId").parent().find(".help-block").html(str);
			f.userId.focus();
			return;
		}

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
</script>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3>${title}</h3>
				</div>

				<div class="alert" role="alert" style="background: #E4FBFF">
					객실를 위한 정보를 입력해주세요.</div>
				<div class="card border-secondary mb-3" style="max-width: 100rem;">
					<div class="card-header">
						<h5><i class="fa-solid fa-hotel"></i>&nbsp; ${dto.roomName}</h5>
					</div>
					<div class="card-body text-secondary">
						<h5 class="card-title">[초강력 특가] 스탠다드 더블 + 2시 체크인</h5>
						<p class="card-text">
						<p>200.10.19(수)~2022.10.20(목) 1박</p>
						<p>체크인 15:00 | 체크아웃 14:00</p>
					</div>
				</div>
				<hr>

				<div class="body-main">
					<form name="reservationForm" method="post">
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="realUserName">이용자
								이름</label>
							<div class="col-sm-10 userId-box">
								<div class="row">
									<div class="col-5 pe-1">
										<input type="text" name="realUserName" id="realUserName"
											class="form-control" value="${dto.userId}"
											${mode=="update" ? "readonly='readonly' ":""}
											placeholder="체크인시 필요한 이름입니다.">
									</div>
									<div class="col-3 ps-1">
										<c:if test="${mode=='member'}">
											<button type="button" class="btn btn-light"
												onclick="userIdCheck();">아이디중복검사</button>
										</c:if>
									</div>
								</div>
								<c:if test="${mode=='member'}">
									<small class="form-control-plaintext help-block">아이디는
										5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
								</c:if>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="realUserTel">이용자
								전화번호</label>
							<div class="col-sm-10">
								<input type="password" name="realUserTel" id="realUserTel"
									class="form-control" autocomplete="off"
									placeholder="체크인시 필요한 전화번호입니다.">
							</div>
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