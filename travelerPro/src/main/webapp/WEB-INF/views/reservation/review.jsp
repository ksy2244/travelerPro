<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">
<style type="text/css">
.font {
	font-size: 15px;
	color: #787878;
}

.text {
	width: 1000px;
	height: 200px;
	margin-left: 100px;
}

.star li{
	font-size:22px;
	letter-spacing:-1px;
	display:inline-block;
	color:#ccc;
	text-decoration:none;
	cursor:pointer;
	
}
.star li.on{color:#F2CB61;}

.box {
	background: #F6F6F6; 
	height: 250px;
	border-radius: 5px;
	margin-left: 100px;
	width: 1000px;
}

.score {
	font-weight: bold;
	font-size: 80px;
	padding-left: 470px;
}

.star {
	margin-left: 410px;
}

.choice {
	font-size: 30px;
	margin-left: 450px;
	font-weight: bold;
	color: #787878;
}

.btn {
	margin-right: 140px;
	margin-top: 20px;
}

.all {
	font-size: 20px;
}

</style>
</head>


<script type="text/javascript">
	function ajaxFun(url, method, query, dataType, fn) {
		$.ajax({
			type : method,
			url : url,
			data : query,
			dataType : dataType,
			success : function(data) {
				fn(data);
			},
			beforeSend : function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			},
			error : function(jqXHR) {
				if (jqXHR.status === 403) {
					login();
					return false;
				} else if (jqXHR.status === 400) {
					alert("요청 처리가 실패 했습니다.");
					return false;
				}

				console.log(jqXHR.responseText);
			}
		});
	}

	//리뷰 등록
	$(function() { $(".btnSendReview").click(
		function() {
		let companyNum = "${companyNum}";
		
		const $tb = $(this).closest("table");
		let content = $tb.find("textarea").val().trim();

		var star = $("input[name=reviewStar]").val();

		if (!content) {
			$tb.find("textarea").focus();
				return false;
		}
	

		content = encodeURIComponent(content);
							
		let url = "${pageContext.request.contextPath}/review/insertReview.do";

		let query = "companyNum=" + companyNum + "&content=" + content + "&star=" + star;

		const fn = function(data) {
			$tb.find("textarea").val("");

			let state = data.state;		

			if (state === "true") {
				listPage(1);
			} else if (state === "false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};

		ajaxFun(url, "post", query, "json", fn);
		});
	});

	// 페이징 처리
	$(function() {
		listPage(1);
	});

	function listPage(page) {
		let url = "${pageContext.request.contextPath}/review/listReview.do";
		let query = "companyNum=${companyNum}&pageNo="+page;
		let selector = "#listReview";
		
		const fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}

	// 댓글 삭제
	$(function() {$("body").on("click",".deleteReview",
			function() {
				if (!confirm("게시물을 삭제하시겠습니까 ? ")) {
					return false;
			}

		let reviewNum = $(this).attr("data-reviewNum");
		let page = $(this).attr("data-pageNo");
		alert(reviewNum);

		let url = "${pageContext.request.contextPath}/review/deleteReview.do";
		let query = "reviewNum=" + reviewNum;

		const fn = function(data) {
			let state = data.state;
			listPage(page);
		};

		ajaxFun(url, "post", query, "json", fn);
		});
	});

	$(function() {
		$(".star li").click(function() {
			let b = $(this).hasClass("on");

			$(this).parent().children("li").removeClass("on");
			$(this).addClass("on").prevAll("li").addClass("on");
			if (b) {
				$(this).removeClass("on");
			}

			let s = $(".star .on").length;
			$("#score").val(s);
		});
	});
	
</script>


</head>
<main>
	<div class="container">
		<div class="body-container">
			<div class="body-main">
				<div class="review pt-3">
					<form name="reviewForm" method="post">
						 	<div class="score pt-2"><span class="all">총점&nbsp;&nbsp;</span>4.2</div>
 	 					
 	 					 <div class="choice mt-4">별점을 선택하세요</div>
 	 					 <ul class="star mt-3">
					              <li><span><i class="fa-solid fa-star fa-2x"></i></span></li>
					              <li><span><i class="fa-solid fa-star fa-2x"></i></span></li>
					              <li><span><i class="fa-solid fa-star fa-2x"></i></span></li>
					              <li><span><i class="fa-solid fa-star fa-2x"></i></span></li>
					              <li><span><i class="fa-solid fa-star fa-2x"></i></span></li>
					     </ul>
 	 					 
 	 					 <div style="margin-top: 10px;">
							<input type="hidden" name="reviewStar" id="score" value="0" readonly="readonly">
  						</div>

						<table class="table table-borderless review-form">
							<tr>
								<td><textarea class='form-control text' name="content" placeholder="타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요."></textarea></td>
							</tr>
							
							<tr>
								<td align='right'>
									<button type='button' class='btn btn-danger btnSendReview'>댓글
										등록</button>
								</td>

								<%-- <c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
					    			<button type="button" class="btn btn-light" onclick="deleteBoard();">삭제</button>
					    		</c:when> --%>
							</tr>
						</table>
					</form>

					<div id="listReview"></div>
				</div>




			</div>
		</div>
	</div>
</main>

</body>
</html>