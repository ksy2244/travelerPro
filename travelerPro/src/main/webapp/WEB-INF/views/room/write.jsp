<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">
function check() {
    const f = document.boardForm;
	let str;
	
    str = f.roomName.value.trim();
    if(!str) {
        alert("객실명을 입력하세요. ");
        f.roomName.focus();
        return false;
    }

    str = f.roomInfo.value.trim();
    if(!str || str === "<p><br></p>") {
        alert("객실정보를 입력하세요. ");
        f.roomInfo.focus();
        return false;
    }

    f.action = "${pageContext.request.contextPath}/room/${mode}_ok.do";
}

<c:if test="${mode=='update'}">
	function deleteFile(num) {
		if( !confirm("파일을 삭제하시겠습니까 ?") ) {
			return;
		}
		let url = "${pageContext.request.contextPath}/room/deleteFile.do?roomNum=" + roomNum + "&page=${page}";
		location.href = url;
	}
</c:if>
</script>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<style type="text/css">
.body-container {
	max-width: 1200px;
}
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>



</head>
<body>


	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3><i class="bi bi-person-square"></i> 객실등록 </h3>
			</div>
			<div class="alert alert-info" role="alert">
		        <i class="bi bi-person-check-fill"></i> 객실상세정보를 입력해 주세요
		    </div>
			<div class="body-main">
				<form name="boardForm" method="post" enctype="multipart/form-data"
					onsubmit="return submitContents(this);">
					<table class="table  write-form mt-5">
						<tr>
							<td class="table-light col-sm-2" scope="row">객실명</td>
							<td>
								<input type="text" name="roomName" class="form-control" value="${dto.roomName}">
							</td>
						</tr>
	        
						<tr>
							<td class="table-light col-sm-2" scope="row">객실정보</td>
							<td>
								<textarea name="roomInfo" id="ir1" class="form-control" style="width: 95%; height: 270px;">${dto.roomInfo}</textarea>
							</td>
						</tr>
						
						<tr>
							<td class="table-light col-sm-2" scope="row">가격</td>
							<td>
								<input type="text" name="price" class="form-control" value="${dto.price}">
							</td>
						</tr>
						
						
						<tr>
							<td class="table-light col-sm-2" scope="row">할인율</td>
							<td>
								<input type="text" name="discountRate" class="form-control" value="${dto.discountRate}">
							</td>
						</tr>
						
						
						<tr>
							<td class="table-light col-sm-2" scope="row">인원수</td>
							<td>
								<input type="text" name="headCount" class="form-control" value="${dto.headCount}">
							</td>
						</tr>
						
						
						<tr>
							<td class="table-light col-sm-2">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
							<td> 
								<input type="file" name="selectFile" class="form-control">
							</td>
						</tr>
						<c:if test="${mode=='update'}">
							<tr>
								<td class="table-light col-sm-2" scope="row">첨부된파일</td>
								<td> 
									<p class="form-control-plaintext">
										<c:if test="${not empty dto.saveFilename}">
											<a href="javascript:deleteFile('${dto.roomNum}');"><i class="bi bi-trash"></i></a>
											${dto.originalFilename}
										</c:if>
										&nbsp;
									</p>
								</td>
							</tr>
						</c:if>
						
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="submit" class="btn btn-dark" id="bold">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light" id="btn">다시입력</button>
								<button type="button" class="btn btn-light" id="btn" onclick="location.href='${pageContext.request.contextPath}/room/list.do?companyNum=${companyNum}';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="roomnum" value="${dto.roomNum}">
									<input type="hidden" name="page" value="${page}">
						
								</c:if>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "${pageContext.request.contextPath}/resources/se2/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
});

function submitContents(elClickedObj) {
	 oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	 try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {
	}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 12;
	oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />


</body>
</html>