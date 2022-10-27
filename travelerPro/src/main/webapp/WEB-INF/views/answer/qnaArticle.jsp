<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>admin</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/title.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp"/>

<style type="text/css">
.body-container {
	max-width: 1000px;
}

.basic {
	background-color: #1687A7;
}

.basic:hover{background-color:#1673A7;}

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

.id {
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

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
function ajaxFun(url, method, query, dataType, fn){
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success: function(data){
			fn(data);
		},
		beforeSend:function(jpXHR){
			jpXHR.setRequestHeader("AJAX", true);
		},
		error:function(jpXHR){
			if(jpXHR.status === 400){
				alert("요청 처리가 실패했습니다.");
				return false;
			}
			console.log(jpXHR.responseText);
		}
	})
}

$(function(){
	listAnswer(${dto.questionNum});
});

function listAnswer(questionNum) {
	   let url = "${pageContext.request.contextPath}/answer/qnaDto.do";
	   let query = "page="+${page}+"&questionNum="+questionNum;
	   let selector = "#listReply";
	   
	   const fn = function(data) {
	      $(selector).html(data);
	   };
	   ajaxFun(url,"get",query,"html",fn);
	}
	
$(function(){
	$(".btnSendReply").click(function(){
	    let questionNum = "${dto.questionNum}";
	    let page = "${page}";
	    const $tb = $(this).closest("table");
	    let content = $tb.find("textarea").val().trim();
	    if(!content) {
	       $tb.find("textarea").focus();
	       return false;
	    }
	    content = encodeURIComponent(content);
	      
	    let url = "${pageContext.request.contextPath}/answer/qnaInsert.do";
	    let query = "page="+page+"&questionNum="+questionNum+"&content="+content;
	      
	    const fn = function(data) {
	    	$tb.find("textarea").val("");
	       if(data.state === "true"){
	        	alert("답변을 등록했습니다.");
	        	
	        	listAnswer(questionNum);
	        	
	        } else {
	        	alert("답변 등록이 실패했습니다.");
	        }
	     };
	     ajaxFun(url,"post",query,"json",fn);
	 });
	
});

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
				<h3> 상세 문의 </h3>
			</div>
			
			<div class="body-main reply-list">
				<table class="table">
					<tbody>
						<tr class="title">
							<td colspan="2" align="left">
								<span class="question">Q</span> <span class="subject">${dto.subject}</span>
								<div class="content">${dto.content}</div>
								<c:choose>
									<c:when test="${dto.categoryNum == 1}">
										<span class="blue"><i class="fa-solid fa-bars"></i> 회원/개인정보 </span>
									</c:when>
									<c:when test="${dto.categoryNum == 2}">
										<span class="blue"><i class="fa-solid fa-bars"></i> 쿠폰 </span>
									</c:when>
									<c:when test="${dto.categoryNum == 3}">
										<span class="blue"><i class="fa-solid fa-bars"></i> 환불 </span>
									</c:when>
									<c:otherwise>
										<span class="blue"><i class="fa-solid fa-bars"></i> 예약/결제 </span>
									</c:otherwise>
								</c:choose>
								<div class="id">${dto.userId} <span class="date"> · ${dto.reg_date}</span></div>
							</td>
						</tr>
					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td>
							<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/answer/qnaList.do?${query}';">리스트</button>
						</td>
					</tr>
				</table>
				
				<div class="reply">
					<form name="replyForm" method="post">
						
							<table class="table table-borderless reply-form">
								<tr>
									<td>
										<div class="form-floating">
										  <textarea class="form-control" name="content" style="height: 150px"></textarea>
										  <label for="floatingTextarea2">Answer</label>
										</div>
									</td>
								</tr>
								<tr>
								<c:if test="${dto.answer == 0 }">
								    <td align='right'>
								        <button type='button' class='btn basic btnSendReply'>답변 등록</button>
								    </td>
								 </c:if>
								<c:if test="${dto.answer == 1 }">
								 	<td align='right'>
								        <button type='button' class='btn basic btnSendReply' disabled="disabled" style="border: none; background: #F5EFE6">답변 등록</button>
								    </td>
								    </c:if>
								 </tr>
							</table>
						</form>
					</div>
			
					<div id="listReply"></div>
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