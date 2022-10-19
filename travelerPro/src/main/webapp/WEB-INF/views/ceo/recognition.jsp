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
				<h3><i class="bi bi-person-square"></i> 업체승인받기 </h3>
			</div>
			
		    <div class="alert alert-info" role="alert">
		        <i class="bi bi-person-check-fill"></i> 업체를 등록하시려면 관리자의 승인을 받아야 합니다.
		    </div>
			
			<div class="body-main">
				
				<form name="memberForm" method="post">
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="userId">업체명</label>
						<div class="col-sm-10 userId-box">
							<div class="row">
								<div class="col-5 pe-1">
									<input type="text" name="userId" id="userId" class="form-control" placeholder="업체명">
								</div>
							</div>
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="userPwd">사업자번호</label>
						<div class="col-sm-4">
				            <input type="text" name="companyNum" id="companyNum" class="form-control" autocomplete="off" placeholder="사업자번호">
				            <small class="form-control-plaintext">유효성 검사를 해야함</small>
				        </div>
				    </div>
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="userName">사장님이름</label>
				        <div class="col-sm-2">
				            <input type="text" name="ceoName" id="ceoName" class="form-control" placeholder="사장님이름">
				        </div>
				    </div>
				     <div class="row mb-3">
				        <div class="text-center">
				            <button type="button" name="sendButton" class="btn btn-primary" onclick="memberOk();"><i class="bi bi-check2"></i>승인받기</button>
							<input type="hidden" name="userIdValid" id="userIdValid" value="false">
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