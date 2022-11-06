<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
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
.body-container {
	max-width: 1500px;
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

#basic {
	background-color: #6C757D;
}

#basic:hover{background-color: #7689A5;}

#bold {
	background-color: #1687A7;
}

#bold:hover{background-color: #1696A7;}

.gray {
	color: #787878;
}

.alert {
	margin-bottom: 40px;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<script type="text/javascript">
function check() {
    const f = document.roomForm;
	let str;
	
    str = f.roomName.value.trim();
    if(!str) {
        alert("객실명을 입력하세요. ");
        f.roomName.focus();
        return false;
    }

    str = f.roomInfo.value.trim();
    if(!str || str === "<p><br></p>") {
        alert("객실정보를 입력하세요. ");
        f.roomInfo.focus();
        return false;
    }

    f.action = "${pageContext.request.contextPath}/room/${mode}_ok.do";
}

$(function(){
	var sel_files = [];
	
	$("body").on("click", ".body-main .img-add", function(event){
		$("form[name=roomForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=roomForm] input[name=selectFile]").change(function(){
		if(! this.files) {
			let dt = new DataTransfer();
			for(file of sel_files) {
				dt.items.add(file);
			}
			document.roomForm.selectFile.files = dt.files;
			
	    	return false;
	    }
	    
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
		document.roomForm.selectFile.files = dt.files;
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
		document.roomForm.selectFile.files = dt.files;
		
		$(this).remove();
	});
});


</script>

<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/ceoheader.jsp" />
</header>



</head>
<body>


	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3> 객실 등록 </h3>
			</div>
			<div class="alert alert-info" role="alert">
		         객실 상세 정보를 입력해 주세요
		    </div>
			<div class="body-main">
				<form name="roomForm" method="post" enctype="multipart/form-data"
					onsubmit="return submitContents(this);">
					<table class="table table-borderless write-form mt-5">
						<tr>
							<td class="col-sm-2" scope="row">객실명</td>
							<td>
								<input type="text" name="roomName" class="form-control" value="${dto.roomName}">
							</td>
						</tr>
	        		
						
						<tr>
							<td class="col-sm-2" scope="row">객실정보</td>
							<td>
								<textarea name="roomInfo" id="ir1" class="form-control" style="width: 95%; height: 270px;">${dto.roomInfo}</textarea>
							</td>
						</tr>
						 
						<tr>
							<td class="col-sm-2" scope="row">가격</td>
							<td>
								<input type="text" name="price" class="form-control" value="${dto.price}">
							</td>
						</tr>
						
						
						<tr>
							<td class="col-sm-2" scope="row">할인율</td>
							<td>
								<input type="text" name="discountRate" class="form-control" value="${dto.discountRate}">
							</td>
						</tr>
						
						
						<tr>
							<td class="col-sm-2" scope="row">인원수</td>
							<td>
								<input type="text" name="headCount" class="form-control" value="${dto.headCount}">
							</td>
						</tr>
										
						<tr>
							<td class="col-sm-2" scope="row">이미지</td>
							<td>
								<div class="img-grid"><img class="item img-add rounded" src="${pageContext.request.contextPath}/resources/images/add_photo.png"></div>
								<input type="file" name="selectFile" accept="image/*" multiple="multiple" style="display: none;" class="form-control">
							</td>
						</tr>
						
						<c:if test="${mode=='update'}">
							<tr>
								<td class="col-sm-2" scope="row">등록이미지</td>
								<td> 
									<div class="img-box">
										<c:forEach var="vo" items="${listFile}">
											<img src="${pageContext.request.contextPath}/uploads/room/${vo.imageFilename}"
												onclick="deleteFile('${vo.fileNum}');">
										</c:forEach>
									</div>
								</td>
							</tr>
						</c:if>
						
					</table>
					
					<div class="row mb-3">
				        <div class="text-center">
								<button type="submit" class="btn text-white" id="bold" >${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn text-white" id="basic">다시입력</button>
								<button type="button" class="btn text-white" id="basic" onclick="location.href='${pageContext.request.contextPath}/room/list.do?companyNum=${companyNum}';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<input  type="hidden" name="companyNum" value="${companyNum}">
								<c:if test="${mode=='update'}">
									<input type="hidden" name="roomNum" value="${dto.roomNum}">
									<input type="hidden" name="page" value="${page}">
								</c:if>
					    </div>
				    </div>
				</form>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
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
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />


</body>
</html>