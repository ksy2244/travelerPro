﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>1:1 문의글 작성</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 850px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

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
    if(!str || str === "<p><br></p>") { // 아무것도 입력 안하면 "<p><br></p>" 만 출력
        alert("내용을 입력하세요. "); 
        f.content.focus();
        return false;
    }

    f.action = "${pageContext.request.contextPath}/qna/${mode}_ok.do";
}

<c:if test="${mode=='update'}">
	function deleteFile(num) {
		if( !confirm("파일을 삭제하시겠습니까 ?") ) {
			return;
		}
		let url = "${pageContext.request.contextPath}/qna/deleteFile.do?num=" + num + "&page=${page}";
		location.href = url;
	}
</c:if>
</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3><i class="bi bi-book-half"></i> 1:1문의 </h3>
			</div>
			
			<div class="body-main">
				<form name="boardForm" method="post" enctype="multipart/form-data"
					onsubmit="return submitContents(this);">
					<table class="table  write-form mt-5">
						<tr>
							<td class="table-light col-sm-2" scope="row">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control" value="${dto.subject}">
							</td>
						</tr>
						
						<tr>
							<td class="table-light col-sm-2" scope="row" >카테고리</td>
							<td>
								<select name="categoryNum" id="categoryNum">
									<option value="1">회원/개인정보</option>
									<option value="2">쿠폰</option>
									<option value="3">환불</option>
									<option value="4">예약/결제</option>
								</select>
							</td>
						</tr>
	        
						<tr>
							<td class="table-light col-sm-2" scope="row">작성자명</td>
	 						<td>
								<p class="form-control-plaintext">${sessionScope.member.userName}</p>
							</td>
						</tr>
	
						<tr>
							<td class="table-light col-sm-2" scope="row">내 용</td>
							<td>
								<textarea name="content" id="ir1" class="form-control" style="width: 95%; height: 270px;">${dto.content}</textarea>
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
											<a href="javascript:deleteFile('${dto.num}');"><i class="bi bi-trash"></i></a>
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
								<button type="submit" class="btn btn-dark">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/qna/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="num" value="${dto.num}"> 
									<input type="hidden" name="page" value="${page}">
									<input type="hidden" name="fileSize" value="${dto.fileSize}">
									<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
									<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
								</c:if>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</main>

<!-- 스마트에디터 스크립트 --> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
// 스마트에디터를 나타기위한 기본 코드
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
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>