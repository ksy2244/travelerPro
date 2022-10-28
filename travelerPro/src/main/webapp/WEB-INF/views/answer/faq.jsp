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
	background-color: #6C757D;
}

.basic:hover{background-color:#7689A5;}

.title {
	border-bottom: 2px solid #B4CDE6;
	background: #B4CDE6;
}

.red {
	color: red;
	font-weight: bold;
	font-style: italic;
}

.blue {
	color: blue;
	font-weight: bold;
	font-style: italic;
}

.img {
	width: 20px;
	height: 20px;
}

#topButton {
	position: fixed; 
	right: 400px; 
	bottom: 100px; 
	display: none; 
	z-index: 999;
	width: 50px;
	height: 50px;
}

.plus {
	background: #DEE2E6;
}

.plus:hover {
	background: #DEEBF0;
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">
<script type="text/javascript">
function ajaxFun(url,method,query,dataType,fn) {
	 $.ajax({
	    type:method, 
	    url:url, 
	    data:query, 
	    dataType:dataType, 
	    success: function(data){
	       fn(data);
	    },
	    beforeSend:function(jqXHR){
	         jqXHR.setRequestHeader("AJAX",true);
	      },
	    error:function(jqXHR) {
	       if(jqXHR.status === 400) {
	          alert("요청 처리가 실패 했습니다");
	          return false;
	       }
	       console.log(jqXHR.responseText);
	    }
	});
}

$(function(){
	list(0);
	
    $("button[role='tab']").on("click", function(e){
		var categoryNum = $(this).attr("aria-controls");
       	
		list(categoryNum);
    });
    
});


function list(categoryNum){
	let url = "${pageContext.request.contextPath}/answer/faqList.do";
	let query = "categoryNum="+categoryNum;
	let selector = "#nav-"+categoryNum;
	
	const fn = function(data){
		$(selector).html(data);
	};

	ajaxFun(url, "get", query, "html", fn);
}

$(function() {
	$(window).scroll(function() {
	    // top button controll
	    if ($(this).scrollTop() > 50) {
	        $('#topButton').fadeIn();
	    } else {
	        $('#topButton').fadeOut();
	    }
	});

	$("#topButton").click(function() {   
		   $('html, body').animate({
		     scrollTop : 0    
		    }, 200);          
		    return false;
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
				<h3> faq 관리 </h3>
			</div>
			
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link active text-dark" id="tab-0" data-bs-toggle="tab" data-bs-target="#nav-0" type="button" role="tab" aria-controls="0" aria-selected="true">전체</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link text-dark" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-1" type="button" role="tab" aria-controls="1" aria-selected="true">회원/개인정보</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link text-dark" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-2" type="button" role="tab" aria-controls="2" aria-selected="true">쿠폰</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link text-dark" id="tab-3" data-bs-toggle="tab" data-bs-target="#nav-3" type="button" role="tab" aria-controls="3" aria-selected="true">환불</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link text-dark" id="tab-4" data-bs-toggle="tab" data-bs-target="#nav-4" type="button" role="tab" aria-controls="4" aria-selected="true">예약/결제</button>
				</li>
			</ul>
			
			<div class="tab-content pt-2" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-0" role="tabpanel" aria-labelledby="nav-tab-0">	
				</div>
				<div class="tab-pane fade" id="nav-1" role="tabpanel" aria-labelledby="nav-tab-1">
				</div>
				<div class="tab-pane fade" id="nav-2" role="tabpanel" aria-labelledby="nav-tab-2">
				</div>
				<div class="tab-pane fade" id="nav-3" role="tabpanel" aria-labelledby="nav-tab-3">
				</div>
				<div class="tab-pane fade" id="nav-4" role="tabpanel" aria-labelledby="nav-tab-4">
				</div>
			</div>

			<div class="row board-list-footer" style="margin-top: 50px;">
				<div class="col">
					<button type="button" class="btn basic text-white" onclick="location.href='${pageContext.request.contextPath}/answer/faq.do';">새로고침</button>
				</div>
				<div class="col text-end">
					<button type="button" class="btn basic text-white" onclick="location.href='${pageContext.request.contextPath}/answer/faqWrite.do';">faq 작성</button>
				</div>
			</div>
		</div>
	</div>
	<div id="topButton"><img src="${pageContext.request.contextPath}/resources/images/topbutton.png" style="width: 50px;"></div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>