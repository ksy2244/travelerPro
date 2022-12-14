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
	max-width: 1500px;
}

.body-title {
	margin-top: 20px;
	margin-bottom: 50px;
}

.basic {
	background-color: #6C757D;
}

.basic:hover{background-color:#7689A5;}

.blue {
	background-color: #1687A7;
}

.blue:hover{background-color:#1696A7;}
 
.black {
	background-color: #276678;
}

.black:hover {
	background-color: #2D7A87;
}

.box {
	background: #eee;
	border-radius: 3px;
	border: 5px solid #eee;
	font-size: 13px;
	text-align: center;
	color: #5D5D5D;
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
	$(".blue").click(function(){
		let companyNum = "${dto.companyNum}";
		
		let url = "${pageContext.request.contextPath}/admin/companyUpdate.do";
		let query = "companyNum="+companyNum+"&approval=1";
		
		const fn = function(data){
			if(data.state==="true"){
				alert("승인되었습니다.");
			} else {
				alert("승인이 실패되었습니다.");
			}
		};
		
		ajaxFun(url,"get",query,"json",fn);
		
	})
});

$(function(){
	$(".black").click(function(){
		let companyNum = "${dto.companyNum}";
		
		let url = "${pageContext.request.contextPath}/admin/companyUpdate.do";
		let query = "companyNum="+companyNum+"&approval=2";
		
		const fn = function(data){
			if(data.state==="true"){
				alert("승인 거절되었습니다.");
			} else {
				alert("승인 거절이 실패되었습니다.");
			}
		};
		
		ajaxFun(url,"get",query,"json",fn);
		
	})
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
				<h3> 업체 상세 정보 </h3>
			</div>
			
			<div class="body-main">
				
				<table class="table">
					<thead>
						<tr>
							<td colspan="2" align="center">
								${dto.companyName}
							</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td align="right">
								<span class="box">사업자명</span> ${dto.userName}&nbsp;&nbsp;|&nbsp;&nbsp;<span class="box">전화번호</span> ${dto.tel}
							</td>
						</tr>
						
						<tr>
							<td align="left">
								<span class="box">체크인</span> ${dto.checkInTime}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="box">체크아웃</span> ${dto.checkOutTime}
							</td>
						</tr>
						
						<tr>
							<td align="left">
								<span class="box">주소</span> ${dto.addr}&nbsp;${dto.addrDetail}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="250">
								<div class="fs-5 fw-bold">업체 정보(위치/교통)</div>
								<br>
								${dto.companyInfo}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="250">
								<div class="fs-5 fw-bold">시설/서비스</div>
								<br>
								<c:set var="serviceList" value="${dto.amenities}"></c:set>
							<c:forEach var="service" items="${serviceList}">
									<c:choose>
										<c:when test="${service == 1}">와이파이&nbsp;/ </c:when>
										<c:when test="${service == 2}">애견동반&nbsp;/ </c:when>
										<c:when test="${service == 3}">개별 바베큐&nbsp;/ </c:when>
										<c:when test="${service == 4}">수영장&nbsp;/ </c:when>
										<c:when test="${service == 5}">주차 가능&nbsp;/ </c:when>
										<c:when test="${service == 6}">상비약&nbsp;/ </c:when>
										<c:when test="${service == 7}">기본 양념&nbsp;/ </c:when>
										<c:when test="${service == 8}">매점&편의점&nbsp;/ </c:when>
										<c:when test="${service == 9}">조식 운영&nbsp;/ </c:when>
										<c:when test="${service == 10}">운동장&nbsp;/ </c:when> 
										<c:otherwise><p>기타</p></c:otherwise> 
										
							</c:choose>
							</c:forEach>
							</td>
						</tr>
						
						<tr>
							<td colspan="2" valign="top" height="250">
								<div class="fs-5 fw-bold">안내</div>
								<br>
								${dto.guide}
							</td>
						</tr>

					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<c:if test="${dto.approval==0}">
							<td width="50%">
								<button type="button" class="btn blue text-white" onclick="approve();">승인</button>
								<button type="button" class="btn black text-white" onclick="reject();">거절</button>
							</td>
						</c:if>
						
						<td class="text-end">
							<button type="button" class="btn basic text-white" onclick="location.href='${pageContext.request.contextPath}/admin/companyList.do?${query}';">리스트</button>
						</td>
					</tr>
				</table>
				
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