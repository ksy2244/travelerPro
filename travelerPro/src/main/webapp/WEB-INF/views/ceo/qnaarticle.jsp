<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CEO</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title3.png" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
.img-box img {
	cursor: pointer;

}

.box {
	background: #eee;
	border-radius: 3px;
	border: 5px solid #eee;
	font-size: 13px;
	text-align: center;
	color: #5D5D5D;
}

.content {
	border-bottom: none;
}

.blue {
	color: navy;
	margin-left: 40px;
}

.question {
	color: #B4CDE6;
	font-size: 70px;
	font-weight: 500;
	padding: 0px;
	margin-left: 40px;
}

.subject {
	font-size: 25px;
	margin-left: 25px;
}

.content {
	margin-top: 20px;
	margin-left: 40px;
	margin-right: 40px;
	height: 250px;
}

.nickName {
	margin-left: 40px;
	margin-top: 20px;
	font-size: 15px;
	margin-bottom: 30px;
}

.date {
	color: #787878;
}

.answer {
	margin-left: 40px;
	font-size: 50px;
	color: #628E90;
	font-weight: 500;
}

.margin {
	margin-left: 40px;
	margin-bottom: 30px;
}

.reply-list {
	border: 1px solid #ccc;
	border-radius: 15px;
	padding: 20px;
}

.write {
	margin-top: 30px;
}

.body-container {
	max-width: 1500px;
}

#basic {
	background-color: #6C757D;
}

#basic:hover{background-color:#7689A5;}

#body-title {
	margin-top: 20px;
	margin-bottom: 50px;
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
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
	
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title" id="body-title">
				<h3> 업체 문의 </h3>
			</div>
			
			<div class="body-main reply-list">
				<table class="table">
					<tbody>
						<tr class="title">
							<td colspan="2" align="left">
								<span class="question">Q</span> <span class="subject">${dto.nickName}</span>
								<div class="content">${dto.content}</div>
								<div class="nickName">${dto.nickName} <span class="date"> · ${dto.reg_date}</span></div>
							</td>
						</tr>
					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td>
							<button type="button" class="btn text-white" id="basic" onclick="location.href='${pageContext.request.contextPath}/ceo/qna.do?${query}';">리스트</button>
						</td>
					</tr>
				</table>
				
				<div class="reply">
					<form name="replyForm" method="post">
						<div class='form-header'>
							<span class="bold">&nbsp;&nbsp;문의 답변</span><span> - 회원을 비방하거나 거짓정보를 유출하는 답변을 삼가해 주세요.</span>
						</div>
						
						<table class="table table-borderless reply-form">
							<tr>
								<td>
									<textarea class='form-control' name="content"></textarea>
								</td>
							</tr>
							<tr>
								<td align='right'>
							        <button type='button' class='btn basic btnSendReply text-white' id="basic">답변 등록</button>
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