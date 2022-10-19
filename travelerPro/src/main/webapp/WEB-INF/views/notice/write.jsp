﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>notice</title>
<jsp:include page="/WEB-INF/views/admin_layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 850px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/board2.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/notice.css" type="text/css">

<script type="text/javascript">
function check() {
    const f = document.boardForm;
	let str;
	
    str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return false;
    }

    str = f.content.value.trim();
    if(!str || str === "<p><br></p>") {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return false;
    }

    f.action = "${pageContext.request.contextPath}/notice/${mode}_ok.do"; 
}

<c:if test="${mode=='update'}">
	function deleteFile(noticeNum) {
		if( !confirm("파일을 삭제하시겠습니까 ?") ) {
			return;
		}
		let url = "${pageContext.request.contextPath}/notice/deleteFile.do?noticeNum=" + noticeNum + "&page=${page}";
		location.href = url;
	}
</c:if>
</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin_layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> ${title} </h3>
			</div>
			
			<div class="body-main">
				<form name="boardForm" method="post" enctype="multipart/form-data"
					onsubmit="return submitContents(this);">
					<table class="table write-form mt-5" id="form">
						<tr id="trbold">
							<td class="col-sm-2 text-center" scope="row" id="color">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control" value="${dto.subject}">
							</td>
						</tr>
	
						<tr id="trbold">
							<td class="col-sm-2 text-center" scope="row" id="color">내 용</td>
							<td>
								<textarea name="content" id="ir1" class="form-control" style="width: 95%; height: 270px;">${dto.content}</textarea>
							</td>
						</tr>
						
						<tr id="trbold">
							<td class="col-sm-2 text-center" id="color">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
							<td> 
								<input type="file" name="selectFile" class="form-control">
							</td>
						</tr>
						<c:if test="${mode=='update'}">
							<tr id="trbold">
								<td class="col-sm-2 text-center" id="color" scope="row">첨부된 파일</td>
								<td> 
									<p class="form-control-plaintext">
										<c:if test="${not empty dto.saveFilename}">
											<a href="javascript:deleteFile('${dto.noticeNum}');"> <i class="fa-solid fa-trash fa-lg"></i> </a>
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
								<button type="submit" class="btn text-white" id="bold">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn" id="btn">다시입력</button>
								<button type="button" class="btn" id="btn" onclick="location.href='${pageContext.request.contextPath}/notice/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="noticeNum" value="${dto.noticeNum}">
									<input type="hidden" name="page" value="${page}">
									<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
									<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
									<input type="hidden" name="fileSize" value="${dto.fileSize}"> 
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
	<jsp:include page="/WEB-INF/views/admin_layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin_layout/staticFooter.jsp"/>
</body>
</html>