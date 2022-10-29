<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CEOMain</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">
.body-container {
	max-width: 1500px;
}

.body-title {
	margin-top: 16px;
	margin-bottom: 40px;
}

.img-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, 65px);
	grid-gap: 5px;
}

.img-grid .item {
    object-fit: cover; /* 가로세로 비율은 유지하면서 컨테이너에 꽉 차도록 설정 */
    width: 65px;
    height: 65px;
	cursor: pointer;
}

.img-box {
	max-width: 600px;

	box-sizing: border-box;
	display: flex; /* 자손요소를 flexbox로 변경 */
	flex-direction: row; /* 정방향 수평나열 */
	flex-wrap: nowrap;
	overflow-x: auto;
}
.img-box img {
	width: 65px; height: 65px;
	margin-right: 5px;
	flex: 0 0 auto;
	cursor: pointer;
}

.alert-info {
	background: #D4F4FA;
	color: black;
}

.basic {
	background-color: #6C757D;
}

.basic:hover{background-color:#7689A5;}

.bold {
	background-color: #1687A7;
}

.bold:hover{background-color:#1696A7;}

.gray {
	color: #787878;
}

.alert {
	margin-bottom: 40px;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/ceo.js"></script>
<script type="text/javascript">
function companyOk() {
	const f = document.companyForm;
	
		
	f.action = "${pageContext.request.contextPath}/ceo/${mode}_ok.do"; 
	f.submit();
	
}
 
<c:if test="${mode=='update'}">
function deleteFile(fileNum) {
	if(! confirm("이미지를 삭제 하시겠습니까 ?")) {
		return;
	}
	
	let query = "companyNum=${dto.companyNum}&fileNum=" + fileNum + "&page=${page}";
	let url = "${pageContext.request.contextPath}/ceo/delete.do?" + query;
	location.href = url;
}
</c:if>

$(function(){
	var sel_files = [];
	
	$("body").on("click", ".body-main .img-add", function(event){
		$("form[name=companyForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=companyForm] input[name=selectFile]").change(function(){
		if(! this.files) {
			let dt = new DataTransfer();
			for(file of sel_files) {
				dt.items.add(file);
			}
			document.companyForm.selectFile.files = dt.files;
			
	    	return false;
	    }
	    
		// 유사 배열을 배열로 변환
	    const fileArr = Array.from(this.files);
	
		fileArr.forEach((file, index) => {
			sel_files.push(file);
			
			const reader = new FileReader();
			const $img = $("<img>", {class:"item img-item"});
			$img.attr("data-filename", file.name);
	        reader.onload = e => {
	        	$img.attr("src", e.target.result);
	        };
	        
	        reader.readAsDataURL(file);
	        
	        $(".img-grid").append($img);
	    });
		
		let dt = new DataTransfer();
		for(file of sel_files) {
			dt.items.add(file);
		}
		document.companyForm.selectFile.files = dt.files;		
	    
	});
	
	$("body").on("click", ".body-main .img-item", function(event) {
		if(! confirm("선택한 파일을 삭제 하시겠습니까 ?")) {
			return false;
		}
		
		let filename = $(this).attr("data-filename");
		
	    for(let i = 0; i < sel_files.length; i++) {
	    	if(filename === sel_files[i].name){
	    		sel_files.splice(i, 1);
	    		break;
			}
	    }
	
		let dt = new DataTransfer();
		for(file of sel_files) {
			dt.items.add(file);
		}
		document.companyForm.selectFile.files = dt.files;
		
		$(this).remove();
	});
});

</script>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>
	
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 승인 요청 </h3>
			</div>
			
		    <div class="alert alert-info" role="alert">
		        승인을 위해 모든 정보를 입력해 주세요.
		    </div>
			
			<div class="body-main">
				<form name="companyForm" method="post" enctype="multipart/form-data">
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="companyName">업체명</label>
						<div class="col-sm-10 userId-box">
							<div class="row">
								<div class="col-5 pe-1">
									<input type="text" name="companyName" id="companyName" class="form-control" placeholder="업체명" value="${dto.companyName}">
								</div>
							</div>
						</div>
					</div>
					<div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="businessNum">사업자 등록번호</label>
				        <div class="col-sm-10 row">
							<div class="col-sm-3 pe-2">
								<input type="text" name="businessNum1" id="businessNum1" class="form-control" value="${dto.businessNum1}" maxlength="3" placeholder="사업자 등록번호">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 px-1">
								<input type="text" name="businessNum2" id="businessNum2" class="form-control" value="${dto.businessNum2}" maxlength="2">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 ps-1">
								<input type="text" name="businessNum3" id="businessNum3" class="form-control" value="${dto.businessNum3}" maxlength="5">
							</div>
				        </div>
				    </div>
				    

				 
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="userId">아이디</label>
				        <div class="col-sm-10">
				            <input type="text" name="userId" id="userId" class="form-control" placeholder="아이디" value="${dto.userId}">
				        </div>
				    </div>
				 
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="regionName">지역명</label>
				        <div class="col-sm-10">
				            <input type="text" name="regionName" id="regionName" class="form-control" placeholder="지역명" value="${dto.regionNum == 1 ? '강원도':'' }">
				        </div>
				    </div>
				    
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="images">이미지</label>
				        <div class="col-sm-10">
				            <div class="img-grid"><img class="item img-add rounded" src="${pageContext.request.contextPath}/resources/images/add_photo.png"></div>
							<input type="file" name="selectFile" accept="image/*" multiple="multiple" style="display: none;" class="form-control">
				        </div>
				    </div>
				    <c:if test="${mode=='update'}">
							 <label class="col-sm-2 col-form-label" for="images">등록 이미지</label>
								<div class="col-sm-10 img-box">
									<c:forEach var="vo" items="${listFile}">
										<img src="${pageContext.request.contextPath}/uploads/ceo/${vo.imageFilename}"
											onclick="deleteFile('${vo.fileNum}');">
									</c:forEach>
								</div>
					</c:if>

				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="checkinTime">체크인 시간</label>
				        <div class="col-sm-10 row">
							<div class="col-3 pe-0">
								<select name="checkinTime" id="checkinTime" class="form-select" onchange="changeEmail();">
									<option value="">선 택</option>
									<option value="9:00" ${dto.checkinTime=="9:00" ? "selected='selected'" : ""}>9:00</option>
									<option value="10:00" ${dto.checkinTime=="10:00"? "selected='selected'" : ""}>10:00</option>
									<option value="11:00" ${dto.checkinTime=="11:00" ? "selected='selected'" : ""}>11:00</option>
									<option value="12:00" ${dto.checkinTime=="12:00" ? "selected='selected'" : ""}>12:00</option>
									<option value="13:00" ${dto.checkinTime=="13:00" ? "selected='selected'" : ""}>13:00</option>
									<option value="14:00" ${dto.checkinTime=="14:00" ? "selected='selected'" : ""}>14:00</option>
									<option value="15:00" ${dto.checkinTime=="15:00" ? "selected='selected'" : ""}>15:00</option>
								</select>
							</div>
						</div>
					</div>
					<div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="checkoutTime">체크아웃 시간</label>
				        <div class="col-sm-10 row">
							<div class="col-3 pe-0">
								<select name="checkoutTime" id="checkoutTime" class="form-select" onchange="changeEmail();">
									<option value="">선 택</option>
									<option value="9:00" ${dto.checkoutTime=="9:00" ? "selected='selected'" : ""}>9:00</option>
									<option value="10:00" ${dto.checkoutTime=="10:00" ? "selected='selected'" : ""}>10:00</option>
									<option value="11:00" ${dto.checkoutTime=="11:00" ? "selected='selected'" : ""}>11:00</option>
									<option value="12:00" ${dto.checkoutTime=="12:00" ? "selected='selected'" : ""}>12:00</option>
									<option value="13:00" ${dto.checkoutTime=="13:00" ? "selected='selected'" : ""}>13:00</option>
									<option value="14:00" ${dto.checkoutTime=="14:00" ? "selected='selected'" : ""}>14:00</option>
									<option value="15:00" ${dto.checkoutTime=="15:00" ? "selected='selected'" : ""}>15:00</option>
								</select>
							</div>
						</div>
					</div>
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="tel1">전화번호</label>
				        <div class="col-sm-10 row">
							<div class="col-sm-3 pe-2">
								<input type="text" name="tel1" id="tel1" class="form-control" value="${dto.companyTel1}" maxlength="3" placeholder="전화번호">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 px-1">
								<input type="text" name="tel2" id="tel2" class="form-control" value="${dto.companyTel2}" maxlength="4">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 ps-1">
								<input type="text" name="tel3" id="tel3" class="form-control" value="${dto.companyTel3}" maxlength="4">
							</div>
				        </div>
				    </div>
				
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="zip">우편번호</label>
				        <div class="col-sm-5">
				       		<div class="input-group">
				           		<input type="text" name="zip" id="zip" class="form-control" placeholder="우편번호" value="${dto.zip}" readonly="readonly">
			           			<button class="btn basic text-white" type="button" style="margin-left: 3px;" onclick="daumPostcode();">우편번호 검색</button>
				           	</div>
						</div>
				    </div>
			
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="addr1">주소</label>
				        <div class="col-sm-10">
				       		<div>
				           		<input type="text" name="addr1" id="addr1" class="form-control" placeholder="기본 주소" value="${dto.addr}" readonly="readonly">
				           	</div>
				       		<div style="margin-top: 5px;">
				       			<input type="text" name="addr2" id="addr2" class="form-control" placeholder="상세 주소" value="${dto.addrDetail}">
							</div>
						</div>
				    </div>
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">업체 정보</label>
					  <textarea class="form-control" name="companyInfo" id="companyInfo" rows="3" placeholder="위치·주차·교통 등을 상세히 기입해 주세요.">${dto.companyInfo}</textarea>
					</div>
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">서비스(편의시설)</label>
					  <textarea class="form-control" name="amenities" id="amenities" rows="3" placeholder="고객 및 시설 서비스·숙소 편의시설 정보 등을 상세히 기입해 주세요.">${dto.amenities}</textarea>
					</div>
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">안내</label>
					  <textarea class="form-control" name="guide" id="guide" rows="3" placeholder="숙소 소개를 상세히 기입해 주세요.">${dto.guide}</textarea>
					</div>
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">예약 공지</label>
					  <textarea class="form-control" name="notice" id="notice" rows="3" placeholder="예약 및 이용 안내를 상세히 기입해 주세요.">${dto.notice}</textarea>
					</div>

				    <div class="row mb-3">
				        <div class="text-center">
				            <button type="button" name="sendButton" class="btn bold text-white" onclick="companyOk();">${mode=='update'? '수정완료':'승인받기'}&nbsp;<i class="bi bi-check2"></i></button>
				            <button type="reset" class="btn basic text-white">다시입력</button>
				            <button type="button" class="btn basic text-white" onclick="location.href='${pageContext.request.contextPath}/ceo/main.do';">${mode=='update'?'수정취소':'승인취소'}&nbsp;<i class="bi bi-x"></i></button>
							<input type="hidden" name="userIdValid" id="userIdValid" value="false">
							<c:if test="${mode=='update'}">
								<input type="hidden" name="companyNum" value="${dto.companyNum}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
				        </div>
				    </div>
				</form>
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