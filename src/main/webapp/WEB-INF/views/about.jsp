<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1f75a84d0eb877f705113abb414ec0dd"></script>

<style type="text/css">
.section {
	margin-left: 30%;
}

.cover-image {
	width: 100%;
	height: 400px;
	background-size: cover;
	margin-bottom: 30px;
}

.partner {
	width: 100px;
	margin-right: 30px;
}

h1 {
	color: darkred;
}
</style>



	<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-8">
					<div class="section-row">


						<h1>WHAT WE DO</h1>
						<h3>SMS는 국내 유일의 실명 기반 커리어 멘토링 서비스를 제공합니다.</h3>
						<p>불확실한 정보의 바다 속에서 기업과 직무를 이해하는데 막막한 취업준비생, 치열한 경쟁을 이겨내고
							입사하였지만 업무가 맞지않아 커리어를 고민하는 사회초년생 SMS는 업계 현직자의 현실적인 조언, 전문성이 담긴 콘텐츠를
							바탕으로 커리어 경험 공유 서비스를 만들어 갑니다.</p>
						<br /> <br /> <br />
						<div class="cover-image"
							style="background-image: url(https://d2ljmlcsal6xzo.cloudfront.net/assets/about/accomplishment-cbd399f626fbace917239fc1eca8c18ecd22b0728481ff1244a7bbe10a2ad29c.jpg); background-repeat: no-repeat;">
						</div>
						<br/>

					</div>
					<h1>ABOUT SMS</h1>
					<h3>Social Mentoring Service는 커리어와 취업을 고민하는 모든 곳에 현직자를 연결합니다.</h3>
					<p>SMS는 대학, 정부, 기업 등을 ‘고객’으로 정의하고, 도움이 필요한 70여 곳에 양질의 콘텐츠와 현직
						멘토를 연결하고 있습니다. 지난 1달 간 오프라인으로 30 여 명의 취업 준비생, 사회 초년생에게 300회 이상 SMS
						멘토를 연결하여 신뢰할 수 있는 콘텐츠를 제공하는 기업으로 고객에게 인정받고 있습니다.</p>
					<br /> <br /> <br />

					<div>
						<h1>PARTNERS</h1>
						<img class="partner"
							src="https://d2ljmlcsal6xzo.cloudfront.net/assets/about/seoul-78981fb916ff24c168bdc8b4d3b59493bb82edbf853e7cb603e01b084ecf7095.jpg">
						<img class="partner"
							src="https://d2ljmlcsal6xzo.cloudfront.net/assets/about/naver-ac303b4bb7d416e689b2429e2d129726d68d4cc3829929baf75675e3df81f367.jpg">
						<img class="partner"
							src="https://d2ljmlcsal6xzo.cloudfront.net/assets/about/kakao-1c24d4a62b0d4ef5213c2beda0ed858365fefb7cba5bb6b13f8b2264dccb343e.jpg">
						<img class="partner" src="./img/google.png"> <img
							class="partner"
							src="https://d2ljmlcsal6xzo.cloudfront.net/assets/icons/logo-c99a7cbe11906a7c7a8084fbb47e605c16d0586f068ea095c19efc48f6d087e6.png">
						<img class="partner" src="./img/top_logo.jpg">
					</div>
					<br /> <br /> <br />




					<div class="row section-row">
						<div class="col-md-6">
							<figure class="figure-img">
								<img class="img-responsive" src="./img/about-2.jpg" alt="">
							</figure>
						</div>
						<div class="col-md-6">
							<br />
							<h3>좋은 인재는 좋은 질문에서 시작한다고 믿습니다.</h3>
							<br />
							<p>SMS는 인재 발굴과 육성의 새로운 모델을 제시합니다. 멘토에게 1:1 멘토링을 요청하는 질문하기, 멘토를
								만나서 활동하는 모임 등의 활동 데이터를 분석하여 우수 멘티 회원은 멘토가 직접 추천합니다. 커리어와 취업 고민
								해소를 넘어, 각 분야의 전문가들이 추천하는 인재가 되어 보세요.</p>
						</div>
					</div>

					<h1>CONTACT</h1>
					<p>SMS에게 궁금하신 점이 있다면 언제든지 연락주세요.</p>
					<hr />

					<h4>주소</h4>
					<p>서울 중구 남대문로 120 대일빌딩 2층, 3층</p>



					<div id="map" style="width: 100%; height: 300px;"></div>
					<script type="text/javascript">
						var container = document.getElementById('map');
						var options = {
							center : new kakao.maps.LatLng(37.5677653,
									126.9825355),
							level : 2
						};
						var markerPosition = new kakao.maps.LatLng(37.5679850,
								126.9829455);
						var marker = new kakao.maps.Marker({
							position : markerPosition
						});

						var map = new kakao.maps.Map(container, options);
						marker.setMap(map);
					</script>

				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /section -->









