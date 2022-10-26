<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head></head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>traveler</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<script>
$(document).ready(function() {
	$('#myCarousel').carousel({
	interval: 10000
	})
    
    $('#myCarousel').on('slid.bs.carousel', function() {
    	//alert("slid");
	});
    
    
});

</script>
<style type="text/css">
.carousel-control {
	padding-top: 10%;
	width: 5%;
}
</style>

<div class="container">
	<div class="col-md-12">
		<h1>Bootstrap 3 Thumbnail Slider</h1>

		<div class="well">
			<div id="myCarousel" class="carousel slide">

				<!-- Carousel items -->
				<div class="carousel-inner">
					<div class="item active">
						<div class="row">
							<div class="col-sm-3">
								<a href="#x"><img src="http://placehold.it/500x500"
									alt="Image" class="img-responsive"></a>
							</div>
							<div class="col-sm-3">
								<a href="#x"><img src="http://placehold.it/500x500"
									alt="Image" class="img-responsive"></a>
							</div>
							<div class="col-sm-3">
								<a href="#x"><img src="http://placehold.it/500x500"
									alt="Image" class="img-responsive"></a>
							</div>
							<div class="col-sm-3">
								<a href="#x"><img src="http://placehold.it/500x500"
									alt="Image" class="img-responsive"></a>
							</div>
						</div>
						<!--/row-->
					</div>
					<!--/item-->
					<div class="item">
						<div class="row">
							<div class="col-sm-3">
								<a href="#x" class="thumbnail"><img
									src="http://placehold.it/250x250" alt="Image"
									class="img-responsive"></a>
							</div>
							<div class="col-sm-3">
								<a href="#x" class="thumbnail"><img
									src="http://placehold.it/250x250" alt="Image"
									class="img-responsive"></a>
							</div>
							<div class="col-sm-3">
								<a href="#x" class="thumbnail"><img
									src="http://placehold.it/250x250" alt="Image"
									class="img-responsive"></a>
							</div>
							<div class="col-sm-3">
								<a href="#x" class="thumbnail"><img
									src="http://placehold.it/250x250" alt="Image"
									class="img-responsive"></a>
							</div>
						</div>
						<!--/row-->
					</div>
					<!--/item-->
					<div class="item">
						<div class="row">
							<div class="col-sm-3">
								<a href="#x" class="thumbnail"><img
									src="${pageContext.request.contextPath}/resources/images/reservationImg/room.jpg"  alt="Image"
									class="img-responsive"></a>
							</div>
							<div class="col-sm-3">
								<a href="#x" class="thumbnail"><img
									src="${pageContext.request.contextPath}/resources/images/reservationImg/room.jpg"  alt="Image"
									class="img-responsive"></a>
							</div>
							<div class="col-sm-3">
								<a href="#x" class="thumbnail"><img
									src="${pageContext.request.contextPath}/resources/images/reservationImg/room.jpg" alt="Image"
									class="img-responsive"></a>
							</div>
							<div class="col-sm-3">
								<a href="#x" class="thumbnail"><img
									src="${pageContext.request.contextPath}/resources/images/reservationImg/room.jpg"  alt="Image"
									class="img-responsive"></a>
							</div>
						</div>
						<!--/row-->
					</div>
					<!--/item-->
				</div>
				<!--/carousel-inner-->
				<a class="left carousel-control" href="#myCarousel"
					data-slide="prev">‹</a> <a class="right carousel-control"
					href="#myCarousel" data-slide="next">›</a>
			</div>
			<!--/myCarousel-->
		</div>
		<!--/well-->
	</div>
</div>

<body>
	<button></button>
</body>