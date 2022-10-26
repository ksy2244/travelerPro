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
<style type="text/css">
.img-box img {
	cursor: pointer;

}
</style>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
function ajaxFun(url,method,query,dataType,fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType, // html json xml
		success: function(data){
			fn(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true); //헤더에 AJAX 보내기
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}
$(function(){
	listAnswer(${dto.companyNum});
});
$(function(){
	$(".btnSendReply").click(function(){
		let companyNum = "${dto.companyNum}";
		let page = "${page}"
		let inquiryNum = "${dto.inquiryNum}"
		const $tb = $(this).closest("table");
		let content = $tb.find("textarea").val().trim();
		if(!content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content)
		let url = "${pageContext.request.contextPath}/ceo/insertReply.do";
		let query = "page="+page+"&companyNum="+companyNum+"&inquiryNum="+inquiryNum+"&content="+content;
		const fn = function(data) {
			$tb.find("textarea").val("");
			if(data.state==="true") {
				alert('답변완료');
				listAnswer(companyNum);
				$()
			} else {
				alert('답변실패');
			}
		};
		ajaxFun(url,"post",query,"json",fn);
	});
});


function listAnswer(companyNum) {
	let url = "${pageContext.request.contextPath}/ceo/listAnswer.do";
	let query = "companyNum=${dto.companyNum}&inquiryNum=${dto.inquiryNum}"
	let selector = "#listReply";
	
	const fn = function(data) {
		$(selector).html(data);
	};
	ajaxFun(url,"get",query,"html",fn);
}

</script>
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
				<h3><i class="bi bi-app"></i> 업체문의 </h3>
			</div>
			
			<div class="body-main">
				
				<table class="table">
					<tbody>
						<tr>
							<td width="50%">
								닉네임 : ${dto.nickName}
							</td>
							<td align="right">
								${dto.reg_date}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="200" style="border-bottom: none;">
								${dto.content}
							</td>
						</tr>
					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td class="text-end">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/ceo/qna.do?${query}';">리스트</button>
						</td>
					</tr>
				</table>
				
				<div class="reply">
					<form name="replyForm" method="post">
						<div class='form-header'>
							<span class="bold">문의답글</span><span> - 회원을 비방하거나 거짓정보를 유출하는 답글을 삼가해 주세요.</span>
						</div>
						
						<table class="table table-borderless reply-form">
							<tr>
								<td>
									<textarea class='form-control' name="content"></textarea>
								</td>
							</tr>
							<tr>
							   <td align='right'>
							        <button type='button' class='btn btn-light btnSendReply'>답글 하기</button>
							    </td>
							 </tr>
						</table>
					</form>
					
					<div id="listReply"></div>
				</div>
				
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