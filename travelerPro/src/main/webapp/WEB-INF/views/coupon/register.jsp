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

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">
<script type="text/javascript">
function sendOk() {
    const f = document.couponForm;
	let str;
	
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
    
    if(f.couponRate.value === "0" && f.couponPrice.value === "0" || 
    		f.couponRate.value === "" && f.couponPrice.value === "0" ||
    		f.couponRate.value === "0" && f.couponPrice.value === ""){
    	alert("할인율 혹은 할인가격을 입력하세요. ");
        return false;
    }
    
    let couponRate = parseInt(f.couponRate.value);
    let couponPrice = parseInt(f.couponPrice.value);
    if(couponPrice ===  0){
    	if(couponRate < 1 || couponRate > 100){
    		alert("할인율은 1%~100% 내에서 가능합니다.");
        	f.couponRate.focus();
            return false;	
    	}
    }
    
    if(couponRate === 0){
    	if(couponPrice < 1000 || couponPrice > 99999){
    		alert("할인금액은 1000원~99999원 내에서 가능합니다.");
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
    
    var start_date = new Date(f.start_date.value);
    var end_date = new Date(f.end_date.value);
 
    
    if( start_date > end_date ){
    	alert("쿠폰 시작일이 만료일보다 큽니다.");
    	f.start_date.focus();
    	return false;
    }
  
   	
    if(! confirm('${submit}'+'하시겠습니까?')){
    	return false;
    }
    
    f.action = "${pageContext.request.contextPath}/coupon/${mode}_ok.do"; 
    f.submit();
}

$(function(){
	$('input[name=chk_coupon]').click(function(){
		let chk = $('input[name=chk_coupon]:checked').val();
		if(chk === 'couponRate'){
			$(".couponRate").show(500);
			$(".couponPrice").hide();
			$("input[name=couponPrice]").val("0");
		} else {
			$(".couponRate").hide();
			$(".couponPrice").show(500);
			$("input[name=couponRate]").val("0");
		}
		
		
	});
	
})


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
				<form name="couponForm" method="post">
					<table class="table write-form mt-5">
						<tr class="trbold">
							<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">쿠폰명</td>
							<td>
								<input type="text" name="couponName" class="form-control" value="${dto.couponName}">
							</td>
						</tr>
	
						<tr class="trbold">
							<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">쿠폰 내용</td>
							<td>
								<textarea name="content" id="ir1" class="form-control" style="width: 100%; height: 270px;">${dto.content}</textarea>
							</td>
						</tr>
						
						<tr class="trbold">
							<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">할인 선택</td>
							<td>
								<input type="radio" name="chk_coupon" value="couponRate" checked="checked"> 할인율 
								<input type="radio" name="chk_coupon" value="couponPrice"> 할인금액
							</td>
						</tr>
						
						<tr class="trbold couponRate">						
							<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">할인율</td>
							<td>
								<input type="number" name="couponRate" class="form-control" value="0" min="0" max="100">
								<small class="form-control-plaintext">할인율은 1% ~ 100% 내에서 입력 가능합니다.</small>
							</td>
						</tr>
						
						<tr class="trbold couponPrice" style="display: none;">
							<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">할인금액</td>
							<td>
								<input type="number" name="couponPrice" class="form-control" value="0" min="0" max="99999">
								<small class="form-control-plaintext">할인금액은 1,000원 ~ 99,000원 내에서 입력 가능합니다.</small>
							</td>
						</tr>
						
				        <tr class="trbold">
				        	<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">쿠폰 시작 일자</td>
				        	<td>
				            	<input type="date" name="start_date" id="start_date" class="form-control" placeholder="쿠폰 시작 일자">
				            </td>
				         </tr>
				         
				          <tr class="trbold">
				        	<td class="col-sm-2 text-center basic" scope="row" style="background-color: #F5EFE6">쿠폰 만료 일자</td>
				        	<td>
				            	<input type="date" name="end_date" id="end_date" class="form-control" placeholder="쿠폰 마지막 일자">
				            </td>
				         </tr>
					
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn text-white bold" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn basic">다시입력</button>
								<button type="button" class="btn basic" onclick="location.href='${pageContext.request.contextPath}/coupon/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="couponNum" value="${dto.couponNum}">
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

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>