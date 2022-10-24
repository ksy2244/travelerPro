<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>traveler_manage</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp"/>

<style type="text/css">
.body-container {
	max-width: 1000px;
}

.basic {
	background-color: #F5EFE6;
}

.basic:hover{background-color:#D9D2CC;}

.bold {
	background-color: #3C2317;
}

.bold:hover{background-color:#804A30;}

.trbold {
	border-bottom: 1px solid #3C2317;
}

#categoryNum {
	width: 200px;
	border-radius: 4px;
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">
<script type="text/javascript">
function sendOk() {
    const f = document.faqForm;
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
    
    let category = document.getElementById("categoryNum");
    let categoryNum = category.options[category.selectedIndex].value;
  	
    if(! confirm('${submit}'+'하시겠습니까?')){
    	return false;
    }
    
    f.action = "${pageContext.request.contextPath}/faq/${mode}_ok.do"; 
    f.submit();
}

</script>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header_admin.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> ${title} </h3>
			</div>
			
			<div class="body-main">
				<form name="faqForm" method="post">
					<table class="table write-form mt-5">
						<tr class="trbold">
							<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">제목</td>
							<td>
								<input type="text" name="subject" class="form-control">
							</td>
						</tr>
	
						<tr class="trbold">
							<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">내용</td>
							<td>
								<textarea name="content" id="ir1" class="form-control" style="width: 100%; height: 270px;"></textarea>
							</td>
						</tr>
						
						<tr class="trbold">
							<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">카테고리</td>
							<td>
								<select name="categoryNum" id="categoryNum">
									<option value="1">회원/개인정보</option>
									<option value="2">쿠폰</option>
									<option value="3">환불</option>
									<option value="4">예약/결제</option>
								</select>
							</td>
						</tr>
					
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn text-white bold" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn basic">다시입력</button>
								<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/faq/tab.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							</td>
						</tr>
					</table>
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