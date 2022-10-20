<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>coupon</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<jsp:include page="/WEB-INF/views/admin_layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/board2.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_admin/css/coupon.css" type="text/css">

<script type="text/javascript">
function sendOk() {
    const f = document.couponForm;
	let str;
	/*
    str = f.couponName.value.trim();
    if(!str) {
        alert("쿠폰명을 입력하세요. ");
        f.couponName.focus();
        return false;
    }

    str = f.content.value.trim();
    if(!str || str === "<p><br></p>") {
        alert("쿠폰 내용을 입력하세요. ");
        f.content.focus();
        return false;
    }
    
    /*
    if(f.chk_coupon.value === "couponRate"){
    	str = f.couponRate.value.trim();
    	if( !/^\d{1,3}$/.test(couponRate) ){
    		alert("할인율을 입력하세요. ");
    		f.couponRate.focus();
            return false;
    	}
    } else if(f.chk_coupon.value === "couponPrice"){
    	str = f.couponPrice.value.trim();
    	if( !/^\d{1,5}$/.test(couponPrice) ){
    		alert("할인가격을 입력하세요. ");
    		f.couponPrice.focus();
            return false;
    	}
    }
 	
 	
   
    
    str = f.start_date.value.trim();
    if( !str ) {
        alert("쿠폰 시작일를 입력하세요. ");
        f.start_date.focus();
        return false;
    }
    
    str = f.end_date.value.trim();
    if( !str ) {
        alert("쿠폰 만료일를 입력하세요. ");
        f.end_date.focus();
        return false;
    }
    
    if( !f.start_date.value < f.end_date.value ){
    	alert("쿠폰 시작일이 만료일보다 큽니다.");
    	return false;
    }
    */
   	
    if(! confirm('등록하시겠습니까?')){
    	return false;
    }
    f.action = "${pageContext.request.contextPath}/coupon/${mode}_ok.do"; 
    f.submit();
}

$(function(){
	$('input[name=chk_coupon]').click(function(){
		let chk = $('input[name=chk_coupon]:checked').val();
		if(chk == 'couponRate'){
			$(".couponRate").show(500);
		} else {
			$(".couponRate").hide();
		}
		
		if(chk == 'couponPrice'){
			$(".couponPrice").show(500);
		} else {
			$(".couponPrice").hide();
		}
	});
	
})


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
				<form name="couponForm" method="post">
					<table class="table write-form mt-5" id="form">
						<tr id="trbold">
							<td class="col-sm-2 text-center" scope="row" id="color">쿠폰명</td>
							<td>
								<input type="text" name="couponName" class="form-control" value="${dto.couponName}">
							</td>
						</tr>
	
						<tr id="trbold">
							<td class="col-sm-2 text-center" scope="row" id="color">쿠폰 내용</td>
							<td>
								<textarea name="content" id="ir1" class="form-control" style="width: 100%; height: 270px;">${dto.content}</textarea>
							</td>
						</tr>
						
						<tr id="trbold">
							<td class="col-sm-2 text-center" scope="row" id="color">할인 선택</td>
							<td>
								<input type="radio" name="chk_coupon" value="couponRate"> 할인율 
								<input type="radio" name="chk_coupon" value="couponPrice"> 할인금액
							</td>
						</tr>
						
						<c:if test="${mode=='update'}">
							<tr id="trbold">						
								<td class="col-sm-2 text-center" scope="row" id="color">원 할인율 혹은 원 할인금액</td>
								<td>
									<div>${dto.couponPrice}</div>
								</td>
							</tr>
						</c:if>
						
						<tr id="trbold" class="couponRate" style="display: none;">						
							<td class="col-sm-2 text-center" scope="row" id="color">할인율</td>
							<td>
								<input type="number" name="couponRate" class="form-control" value="" min="1" max="100">
							</td>
						</tr>
						
						<tr id="trbold" class="couponPrice" style="display: none;">
							<td class="col-sm-2 text-center" scope="row" id="color">할인금액</td>
							<td>
								<input type="number" name="couponPrice" class="form-control" value="0" min="1000" max="99999">
							</td>
						</tr>
						
				        <tr id="trbold">
				        	<td class="col-sm-2 text-center" scope="row" id="color">쿠폰 시작 일자</td>
				        	<td>
				            	<input type="date" name="start_date" id="start_date" class="form-control" value="" placeholder="쿠폰 시작 일자">
				            </td>
				         </tr>
				         
				          <tr id="trbold">
				        	<td class="col-sm-2 text-center" scope="row" id="color">쿠폰 만료 일자</td>
				        	<td>
				            	<input type="date" name="end_date" id="end_date" class="form-control" value="" placeholder="쿠폰 마지막 일자">
				            </td>
				         </tr>
					
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn text-white" id="bold" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn" id="btn">다시입력</button>
								<button type="button" class="btn" id="btn" onclick="location.href='${pageContext.request.contextPath}/coupon/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/admin_layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin_layout/staticFooter.jsp"/>
</body>
</html>