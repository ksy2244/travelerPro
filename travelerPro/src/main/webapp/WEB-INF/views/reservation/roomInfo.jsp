<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %> <!-- 소연 -->
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<title>traveler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/reservation/reservationStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/travelerStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/datePicker.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style/traveler/review.css"
	type="text/css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>


<script>
 $(function() {
     var thisDate = new Date();
     var thisYear = thisDate.getFullYear();        //해당 연
     var thisMonth = thisDate.getMonth() + 1;    //해당 월

     $.datepicker.setDefaults({
         dateFormat: 'yy-mm-dd'         
         ,showOtherMonths: true     
         ,showMonthAfterYear:true  
         ,changeYear: true           
         ,changeMonth: true            
         ,yearSuffix: "년"           
         ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12']                  
         ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] 
         ,dayNamesMin: ['일','월','화','수','목','금','토']                                        
         ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']               
     });                    
     
     //시작일의 초기값을 설정
     $('#start_date').datepicker({
    	 minDate : 0,
         onClose: function( selectedDate) {   
        	
        	 var select = selectedDate.split('-');
        	 var date = new Date(select[0], select[1]-1, parseInt(select[2])+1);
        	
        	 selectedDate = date.getFullYear() +"-"+ (date.getMonth()+1)+"-" + (date.getDate());
               	 
        	 console.log(selectedDate);
             $("#end_date").datepicker( "option", "minDate", selectedDate );
  
         }                
     });
     $('#start_date').datepicker('setDate', thisYear+'-'+thisMonth+'-01');    //시작일 초기값 셋팅
     
     //종료일의 초기값을 내일로 설정
     $('#end_date').datepicker({
    	 minDate : 0
         
     });
     $('#end_date').datepicker('setDate', 'minDate'+1); //끝일 초기값 셋팅
 });
	function ajaxFun(url, method, query, dataType, fn) {
		$.ajax({
			type:method,
			url:url,
			data:query,
			dataType:dataType,
			success:function(data) {
				fn(data);
			},
			beforeSend:function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			},
			error:function(jqXHR) {
				if(jqXHR.status === 403) {
					login();
					return false;
				} else if(jqXHR.status === 400) {
					alert("요청 처리가 실패 했습니다.");
					return false;
				}
		    	
				//console.log(jqXHR.responseText);
			}
		});
	}

	// 업체 찜
	$(function(){
		$(".btnSendCompanyLike").click(function(){
			const $i = $(this).find("i");
			let isNoLike = $i.css("color") == "rgb(0, 0, 0)";
			let msg = isNoLike ? "업체를 찜 하시겠습니까 ? " : "업체 찜을 취소하시겠습니까 ? ";

			if(! confirm( msg )) {
				return false;
			}
			
			let url = "${pageContext.request.contextPath}/reservation/insertCompanyLike.do";
			let companyNum = "${companyNum}";
			
			let query = "companyNum=" + companyNum + "&isNoLike=" + isNoLike;
			
			const fn = function(data){
				let state = data.state;
				if(state === "true") {
					let color = "black";
					if( isNoLike ) {
						color = "red";
					}
					$i.css("color", color);
					
					let count = data.companyLikeCount;
					$("#companyLikeCount").text(count);
				} else if(state === "liked") {
					alert("찜은 한번만 가능합니다. !!!");
				}
			};
			
			ajaxFun(url, "post", query, "json", fn);
		});
	});
	
	 
</script>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0662433c3f6d691c3d739417758f655c&libraries=services"></script>

<script type="text/javascript">
	$(function() {
		let u = "${pageContext.request.contextPath}/reservation/roomList.do?companyNum=${companyNum}&start_date=${start_date}&end_date=${end_date}&tmp="+new Date().getTime();
		$("#nav-1").load(u);

		// 탭을 클릭할 때 마다
		$("button[role='tab']").on("click", function(e) {
			let tab = $(this).attr("aria-controls");
			let selector = "#nav-" + tab;

			let url = "${pageContext.request.contextPath}/reservation/";

			if (tab == "1") {
				url += "roomList.do?companyNum=${companyNum}&start_date=${start_date}&end_date=${end_date}&tmp="+new Date().getTime();
				alert(url);
			} else if (tab == "2") {
				url += "map.do?companyNum=${companyNum}";
			} else {
				url += "review.do?companyNum=${companyNum}";
			}

			$(selector).load(url);

		});

	});

</script>


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>


	<main>

		<div id="carouselExampleCaptions" class="carousel carousel-dark slide"
			data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner" data-bs-interval="100"
				style="text-align: right; font-family: 'GmarketSans'">
				<div class="carousel-item active">
					<img class="roomImg"
						src="${pageContext.request.contextPath}/resources/images/mainImg/bokcheon.png"
						class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block"></div>
				</div>
				<div class="carousel-item">
					<img class="roomImg"
						src="${pageContext.request.contextPath}/resources/images/mainImg/busan.png"
						class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block"></div>
				</div>
				<div class="carousel-item">
					<img class="roomImg"
						src="${pageContext.request.contextPath}/resources/images/mainImg/bokcheon.png"
						class="d-block w-100 bestRegion" alt="...">
					<div class="carousel-caption d-none d-md-block"></div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>

	</main>


	<div class="container">
		<div class="body-container">
			<div class="body-title">

				<!-- 시작일, 종료일 -->
				<div class="card border-secondary mb-3" style="max-width: 100rem;">
					<div class="card-body">
						<p class="roomInfoTitle">
							&nbsp; <i class="fa-solid fa-calendar"></i>&nbsp;날짜
						</p>
						<hr>


						<div
							style="text-align: center; font-size: 25px; font-weight: 400; margin: auto; margin-top: 20px; margin-bottom: 20px;">
							<div class="card-body">
								<form name="dateForm" action="roomInfo.do" method="get">
									<p style="font-size: 25px;">
										<input type="hidden" value="${companyNum}" name="companyNum"> 시작일 
										<input type="text" id="start_date" name="start_date" class="styleInput">종료일 
										<input type="text" id="end_date" name="end_date" class="styleInput">
									</p>

									<button class="dateBtn btn btn-danger" type="submit">날짜
										선택</button>
								</form>

							</div>
						</div>
					</div>
				</div>

				

				<div class="card border-secondary mb-3" style="max-width: 100rem;">

					<div class="card-body">
						<div class="roomDetailInfo" style="float: center">
							<p class="roomInfoTitle">
								&nbsp; <i class="fa-sharp fa-solid fa-hotel"></i>&nbsp;${companyDto.companyName}
							</p>
							<hr>
							<p class="address">
								<i class="fa-solid fa-location-dot"></i>&nbsp;${companyDto.addr}&nbsp;${companyDto.addrDetail}
							</p>
							<p class="roomInfoContent">${companyDto.companyInfo}</p>
							<p class="roomInfoContent">${companyDto.guide}</p>
							<p class="roomInfoContent">${companyDto.notice}  sadsda ${isUserLike}</p>
							
							<c:set var="serviceList" value="${companyDto.amenities}"></c:set>
							
							<c:forEach var="service" items="${serviceList}"><br>
							
							<c:choose>
											<c:when test="${service == 1}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/wifi.png" class="png">
														<p>와이파이</p></div>
											</c:when>
											<c:when test="${service == 2}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/pet.png" class="png">
													<p>애완동물</p></div>
											</c:when>
											<c:when test="${service == 3}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/meat.png" class="png">
													<p>바베큐</p></div>
											</c:when>
											<c:when test="${service== 4}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/pool.png" class="png">
													<p>수영장</p></div>
											</c:when>
											<c:when test="${service == 5}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/park.png" class="png">
													<p>주차 가능</p></div>
											</c:when>
											<c:when test="${service == 6}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/medicine.png" class="png">
													<p>상비약</p></div>
											</c:when>
											<c:when test="${service == 7}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/source.png" class="png">
													<p>양념</p></div>
											</c:when>
											<c:when test="${service == 8}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/store.png" class="png">
													<p>매점/편의점</p></div>
											</c:when>
											<c:when test="${service== 9}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/breakFast.png" class="png">
													<p>조식 제공</p></div>
											</c:when>
											<c:when test="${service == 10}">
													<div><img src="${pageContext.request.contextPath}/resources/images/service/palyGround.png" class="png">
													<p>운동장</p></div>
											</c:when>		
											<c:otherwise>
													<div><img src="${pageContext.request.contextPath}/resources/images/service/pool.png" class="png">&nbsp;</div>
											</c:otherwise>
										</c:choose>
							</c:forEach>

						
							<p class="roomInfoContent">
								<span style="background-color: #E4FBFF; text-align: center">체크인
								</span>&nbsp; ${companyDto.checkInTime}
							</p>
							<p class="roomInfoContent">
								<span style="background-color: #E4FBFF; text-align: center">체크아웃
								</span>&nbsp; ${companyDto.checkOutTime}
							</p>

							<p class="roomInfoContent">
								<span style="background-color: #E4FBFF; text-align: center">업체 전화번호
								 </span> ${companyDto.companyTel}
							</p>


							<table>
								<tr>
								<td colspan="2" class="text-center p-3">
									<button type="button" class="btn btn-outline-secondary btnSendCompanyLike" title="좋아요">
									<i class="fa-sharp fa-solid fa-heart"  style="color: ${isUserLike?'red':'black'}"></i>&nbsp;&nbsp;<span id="companyLikeCount">${companyDto.pick}</span></button>								
								</td>
								</tr>
							</table>

							<hr>
							



						</div>
					</div>
				</div>
				<br>
				<div class="container mb-2 pt-3">

					<ul class="nav nav-tabs nav-justified" " id="myTab" role="tablist">
						<li class="nav-item" role="presentation">

							<button class="nav-link active  bg-info text-white h-100 p-3 h1"
								id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-1"
								type="button" role="tab" aria-controls="1" aria-selected="true">객실정보</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link bg-info text-white h-100 p-3" id="tab-2"
								data-bs-toggle="tab" data-bs-target="#nav-2" type="button"
								role="tab" aria-controls="2" aria-selected="true">지도</button></li>
						<li class="nav-item" role="presentation">
							<button class="nav-link  bg-info text-white h-100 p-3" id="tab-3"
								data-bs-toggle="tab" data-bs-target="#nav-3" type="button"
								role="tab" aria-controls="3" aria-selected="true">리뷰</button>
						</li>
					</ul>

					<div class="tab-content pt-2" id="nav-tabContent">
						<div class="tab-pane fade show active" id="nav-1" role="tabpanel"
							aria-labelledby="nav-tab-1"></div>
						<div class="tab-pane fade" id="nav-2" role="tabpanel"
							aria-labelledby="nav-tab-2"></div>
						<div class="tab-pane fade" id="nav-3" role="tabpanel"
							aria-labelledby="nav-tab-2"></div>
					</div>

				</div>


			</div>


			<footer>
				<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
			</footer>

			<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
		</div>
	</div>
</body>
</html>