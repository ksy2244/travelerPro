<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CEOMain</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
	
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3><i class="bi bi-person-square"></i> 업체정보등록 </h3>
			</div>
			
		    <div class="alert alert-info" role="alert">
		        <i class="bi bi-person-check-fill"></i> 업체상세정보를 입력해 주세요
		    </div>
			
			<div class="body-main">
				
				<form name="memberForm" method="post">
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="userId">업체명</label>
						<div class="col-sm-10 userId-box">
							<div class="row">
								<div class="col-5 pe-1">
									<input type="text" name="userId" id="userId" class="form-control" value="${dto.userId}" 
											${mode=="update" ? "readonly='readonly' ":""}
											placeholder="업체명">
								</div>
							</div>
						</div>
					</div>
				 
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="userPwd">패스워드</label>
						<div class="col-sm-10">
				            <input type="password" name="userPwd" id="userPwd" class="form-control" autocomplete="off" placeholder="패스워드">
				            <small class="form-control-plaintext">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
				        </div>
				    </div>
				    
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="userPwd2">패스워드 확인</label>
				        <div class="col-sm-10">
				            <input type="password" name="userPwd2" id="userPwd2" class="form-control" autocomplete="off" placeholder="패스워드 확인">
				            <small class="form-control-plaintext">패스워드를 한번 더 입력해주세요.</small>
				        </div>
				    </div>
				 
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="userName">이름</label>
				        <div class="col-sm-10">
				            <input type="text" name="userName" id="userName" class="form-control" value="${dto.userName}" 
				            		${mode=="update" ? "readonly='readonly' ":""}
				            		placeholder="이름">
				        </div>
				    </div>
				 
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="birth">생년월일</label>
				        <div class="col-sm-10">
				            <input type="date" name="birth" id="birth" class="form-control" value="${dto.birth}" placeholder="생년월일">
				            <small class="form-control-plaintext">생년월일은 2000-01-01 형식으로 입력 합니다.</small>
				        </div>
				    </div>
				
				    <div class="row mb-3">
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
				    
				    <div class="row mb-3">
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
				
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="zip">우편번호</label>
				        <div class="col-sm-5">
				       		<div class="input-group">
				           		<input type="text" name="zip" id="zip" class="form-control" placeholder="우편번호" value="${dto.zip}" readonly="readonly">
			           			<button class="btn btn-light" type="button" style="margin-left: 3px;" onclick="daumPostcode();">우편번호 검색</button>
				           	</div>
						</div>
				    </div>
			
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="addr1">주소</label>
				        <div class="col-sm-10">
				       		<div>
				           		<input type="text" name="addr1" id="addr1" class="form-control" placeholder="기본 주소" value="${dto.addr1}" readonly="readonly">
				           	</div>
				       		<div style="margin-top: 5px;">
				       			<input type="text" name="addr2" id="addr2" class="form-control" placeholder="상세 주소" value="${dto.addr2}">
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
				     
				    <div class="row mb-3">
				        <div class="text-center">
				            <button type="button" name="sendButton" class="btn btn-primary" onclick="memberOk();"> <i class="bi bi-check2"></i>정보등록</button>
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
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />

</body>
</html>