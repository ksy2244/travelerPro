<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/resources/images/title.png" />
<jsp:include page="/WEB-INF/views/layout/staticHeader_admin.jsp" />

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
				if (jqXHR.status === 400) {
					alert("요청 처리가 실패 했습니다");
					return false;
				}
				console.log(jqXHR.responseText);
			}
		});
	}

	$(function() {
		$("button[role='tab']").on("click", function(e) {
			

		
		});

	});
</script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
</head>
<body>
	<header>

		<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div id="carouselExampleCaptions"
					class="carousel carousel-dark slide" data-bs-ride="carousel">
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
			</div>
		</div>




		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active text-dark" id="tab-0"
					data-bs-toggle="tab" data-bs-target="#nav-0" type="button"
					role="tab" aria-controls="0" aria-selected="true">숙박 예매</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link text-dark" id="tab-1" data-bs-toggle="tab"
					data-bs-target="#nav-1" type="button" role="tab" aria-controls="1"
					aria-selected="true">지도</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link text-dark" id="tab-2" data-bs-toggle="tab"
					data-bs-target="#nav-2" type="button" role="tab" aria-controls="2"
					aria-selected="true">리뷰</button>
			</li>

		</ul>
		<div class="tab-content pt-2" id="nav-tabContent">
			<div class="tab-pane fade show active" id="nav-0" role="tabpanel"
				aria-labelledby="nav-tab-0"></div>
			<div class="tab-pane fade" id="nav-1" role="tabpanel"
				aria-labelledby="nav-tab-1"></div>
			<div class="tab-pane fade" id="nav-2" role="tabpanel"
				aria-labelledby="nav-tab-2"></div>
			<div class="tab-pane fade" id="nav-3" role="tabpanel"
				aria-labelledby="nav-tab-3"></div>
			<div class="tab-pane fade" id="nav-4" role="tabpanel"
				aria-labelledby="nav-tab-4"></div>
		</div>

	</main>
	
	
	<style>
  .tab_menu{position:relative;}
  .tab_menu .list{overflow:hidden;}
  .tab_menu .list li{float:left; margin-right:14px;}
  .tab_menu .list li.is_on .btn{font-weight:bold; color:green;}
  .tab_menu .list .btn{font-size:13px;}
  .tab_menu .cont_area .cont{position:absolute; top:25px; left:0; background:#555; color:#fff; text-align:center; width:250px; height:100px; line-height:100px;}
</style>

<div class="tab_menu">
  <ul class="list">
    <li class="is_on">
      <a href="#tab1" class="btn">Tab Button1</a>
    </li>
    <li>
      <a href="#tab2" class="btn">Tab Button2</a>
    </li>
    <li>
      <a href="#tab3" class="btn">Tab Button3</a>
    </li>
  </ul>
  
  <div class="cont_area">
    <div id="ㅜㅁ" class="cont">
      Tab Content1
    </div>
    <div id="tab2" class="cont">
      Tab Content2
    </div>
    <div id="tab3" class="cont">
      Tab Content3
    </div>
  </div>
</div>

<script>
  const tabList = document.querySelectorAll('.tab_menu .list li');
  const contents = document.querySelectorAll('.tab_menu .cont_area .cont')
  let activeCont = ''; // 현재 활성화 된 컨텐츠 (기본:#tab1 활성화)

  for(var i = 0; i < tabList.length; i++){
    tabList[i].querySelector('.btn').addEventListener('click', function(e){
      e.preventDefault();
      for(var j = 0; j < tabList.length; j++){
        // 나머지 버튼 클래스 제거
        tabList[j].classList.remove('is_on');

        // 나머지 컨텐츠 display:none 처리
        contents[j].style.display = 'none';
      }

      // 버튼 관련 이벤트
      this.parentNode.classList.add('is_on');

      // 버튼 클릭시 컨텐츠 전환
      activeCont = this.getAttribute('href');
      document.querySelector(activeCont).style.display = 'block';
    });
  }
</script>



	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>