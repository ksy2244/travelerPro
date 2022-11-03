<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<title>TRAVELER</title>
<style type="text/css">
.body-contain {
	width: 100%;
	height: 200px;
	
}

.body-title {
	
	margin-bottom: 40px;
}

.card .img {
	padding-top: 5px;
	padding-left: 20px;
	width: 200px;
	height: 200px;
	border-radius: 20%;
}

.card {
	border: none;
	width: 200px;
	height: 500px;
}
.card-body {
	width: 100%;
	height: 200px;
}

.company {
	font-weight: bold;
	font-size: 17px;
	margin-left: 4rem;
}

.png {
	width: 18px;
	margin-left: 22px;
	margin-top: 10px;
}

.pick {	
	color: #787878;
	margin-left: 4rem;
}

.star {
	color: #FFBB00;
	margin-left: 2rem;
	
}

.bold {
	color: black;
	font-weight: 600;
}

.price {
	padding-left: 210px;
	color: #787878;
}

.realprice {
	color: black;
	font-weight: bold;
	font-size: 20px;
	padding-left: 175px;
	float: left;
}

.realpriceMin {
	color: black;
	font-weight: bold;
	font-size: 10px;
	padding-left: 150px;
	float: left;
}

.won {
	color: black;
	font-weight: bold;
	font-size: 10px;
	margin-right: 20px;
}

.paging {
	font-weight: bold; 
	font-size: 18px;
}

</style>
<script type="text/javascript">
/* $(window).on('load', function () {
    load('.card', '6');

});
function load(id, cnt, btn) {
    var girls_list = id + " .js-load:not(.active)";
    var girls_length = $(girls_list).length;
    var girls_total_cnt;
    if (cnt < girls_length) {
        girls_total_cnt = cnt;
    } else {
        girls_total_cnt = girls_length;
        $('.button').hide()
    }
    $(girls_list + ":lt(" + girls_total_cnt + ")").addClass("active");
} */
</script>
</head>
<body class="pt-5">
		<div class="container">
			<div class="body-contain">
				<div class="body-title">
					<h3>${region}지역숙소</h3>
				</div>
				<div class="body-main">
					<div class="row">
						<c:forEach var="dto" items="${list}" varStatus="status" begin="1" end="6">
							<div class="col-md-4 col-lg-3 p-1 mb-6 card"> 
								<div class="card-group" style="width: 300px;height: 300px;">
									<div class="card" style="width:250px; height: 350px;"
										onclick="location.href='${pageContext.request.contextPath}/reservation/roomInfo.do?companyNum=${dto.companyNum}'">
										<img
											src="${pageContext.request.contextPath}/uploads/ceo/${dto.imageFileName}"
											class="card-img-top img">
										<div class="card-body">
											<div class="card-title company">${dto.companyName}</div>
											<c:choose>
												<c:when test="${dto.starRate > 4.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 4.0}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 3.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 3.0}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 2.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 2.0}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 1.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 1.0}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 0.5}">
													<span class="star"><i class="fa-solid fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:when test="${dto.starRate > 0}">
													<span class="star"><i class="fa-solid fa-star-half fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:when>
												<c:otherwise>
													<span class="star"><i class="fa-regular fa-star fa-lg"></i>&nbsp;<span class="bold">${dto.starRate} (리뷰수)</span></span>
												</c:otherwise>
											</c:choose>
											<div class="pick"><img src="${pageContext.request.contextPath}/resources/images/icon/pick.png" class="png">&nbsp;${dto.pick}</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						  <button class="btn bg-info" style="color: white;">더 많은 숙소보기</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>