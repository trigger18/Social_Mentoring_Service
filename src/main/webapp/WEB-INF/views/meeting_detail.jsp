<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
.meeting_form {
	width: 60%;
	margin: 0 auto;
	margin-top: 20px;
}

.meeting_form #li {
	width: 110%;
	margin: 0 auto;
}

.meeting_form .container .list-group {
	width: 70%;
	margin: 0 auto;
}

.meeting_form .li .h4 {
	width: 70%;
	margin: 0 auto;
}

.meeting_form .moli {
	margin-left: 90px;
}

.meeting_form .mentor {
	float: right;
}

.meeting_form .name {
	width: 80%;
	margin: 0 auto;
	margin-top: 20px;
}

.meeting_form .name .btn {
	margin-left: 10px;
}

.meeting_form .program {
	width: 80%;
	margin: 0 auto;
	display: block;
	margin-top: 20px;
}

.meeting_form #notice {
	width: 80%;
	margin: 0 auto;
	margin-top: 20px;
}

.meeting_form #place {
	width: 80%;
	margin: 0 auto;
	margin-top: 20px;
}

.meeting_form #li {
	width: 80%;
	margin: 0 auto;
	margin-top: 20px;
}

.meeting_form .meeting_img {
	width: 80%;
	height: 300px;
	margin: 0 auto;
	margin-top: 20px;
}

.meeting_form .meeting_img img {
	position: relative;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

hr {
	display: block;
	height: 5px;
	border: 0;
	border-top: 1px solid #D8D8D8;
	margin: 3px 0;
	padding: 0;
}

.meeting_form #meeting_apply {
	width: 80%;
	margin: 0 auto;
	margin-top: 20px;
}

.meeting_form #meeting_cancel {
	width: 80%;
	margin: 0 auto;
	margin-top: 20px;
}

.meeting_form #bt_1 {
	width: 80%;
	margin: 0 auto;
	margin-top: 20px;
}

.meeting_form .mentor-box {
	margin: 50px 100px;
}

.meeting_form .mentor-image-circle {
	margin: 30px 30px 30px 30px;
	display: inline-block;
	float: left;
	/* background-color: yellow;  */
}

.meeting_form .btn-container {
	margin-top: 15px;
}

.meeting_form .detail-box {
	margin: 35px 0;
	padding: 15px 0;
	border-top: 1px solid #c8c7cc;
	border-bottom: 1px solid #c8c7cc;
}

.meeting_form .mentoring-info {
	margin-top: 15px;
}

.meeting_form .detail-box #block-title {
	font-weight: bold;
	margin: 35px 15px 10px;
}

.meeting_form .detail-box #block-content {
	padding: 0 15px;
}

.meeting_form .mentor-box {
	width: 260%;
	margin: 0 auto;
	display: inline-block;
	margin-left: 60px;
}

.meeting_form .moli {
	margin-left: 90px;
}

.meeting_form .mentor-box .card {
	border: 1px solid #ccc;
	border-radius: 10px;
	padding: 10px;
	margin: 5px;
	display: block;
}

.meeting_form .mentor-box .card img {
	border-radius: 50%;
	border: 2px solid #ccc;
	position: relative;
}

.meeting_form .mentor-box .card:hover {
	background-color: #E0F2F7;
}

.meeting_form .mentor-box .card-field {
	/* display: block; */
	background-color: #f38037;
	font-size: 13px;
	text-transform: uppercase;
	padding: 3px 10px;
	font-weight: 600;
	border-radius: 2px;
	margin-right: 15px;
	color: #FFF;
	-webkit-transition: 0.2s opacity;
	transition: 0.2s opacity;
	text-align: right;
	float: right;
}

.meeting_form .mentor-box .col-md-4 .card .card-info .card-name {
	font-size: 23px;
	font-weight: bold;
	display: inline-block;
	margin-right: 15px;
}

.meeting_form .mentor-box .card-info, .card-job {
	text-align: right;
	display: block;
	margin-right: 15px;
}

.
.meeting_form .mentor-box .card-job {
	font-size: 13px;
}

.meeting_form .mentor-box #title {
	position: absolute;
	width: 35%;
	font-size: 12px;
	font-weight: bold;
	text-align: right;
	top: 50px;
	right: 42px;
}

.btn_group {
	width: 100%;
	margin: 0 auto;
	padding-left: 1100px;
}

.btn_group .a_btn {
	display: inline;
	text-decoration: none;
}

.bt_group {
	width: 100%;
	margin: 0 auto;
	margin-left: 80px;
}

.bt_group button:hover {
	color: #fff;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('.btn_group').hide();
		$('#meeting_apply').hide();
		var userid = $('.userid').val();/* 유저아이디 */
		var mentorid = $('.mentor_id').val();/*미팅유저아이디*/
		var memberCheck = $('.memberCheck').val();/*멤버 미팅에 있는지 체크*/
		var registered_num = $('.num').text(); /*모집인원*/
		var member_num = $('.count_num').val();/* 체크된 모집인원*/
		var user_num = $('.usercount').val();/* 모집된인원*/

		if (userid != mentorid) {
			$('#meeting_apply').show();
			$('.btn_group').hide();
		} else {
			$('.btn_group').show();
		}

		if (!userid) {
			$('#meeting_apply').hide();
		}

		if (memberCheck != 0) {
			$('#meeting_apply').hide();
		} else {
			$('#meeting_cancel').hide();
		}

		if (registered_num <= user_num) {
			$('#meeting_apply').hide();
		}

	});
</script>
<div class="section">
	<!-- container -->
	<div class="btn_group">
		<a class="a_btn"
			href="meeting_update.do?meeting_num=${meeting.meeting_num}&meeting_file=${meeting.meeting_file}">
			<button id="update_btn" type="button" class="btn btn-warning">수정하기</button>
		</a> <a class="a_btn"
			href="meeting_delete.do?meeting_num=${meeting.meeting_num}">
			<button id="update_btn" type="button" class="btn btn-warning">삭제하기</button>
		</a>
	</div>
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-56">
				<div class="section-title">

					<input type="hidden" class="userid" value="${user_Id}" /> <input
						type="hidden" class="mentor_id" value="${mentor_id}" /> <input
						type="hidden" class="count_num" value="${count_num}" /> <input
						type="hidden" class="memberCheck" value="${memberCheck}" /> <input
						type="hidden" class="usercount" value="${count_num}" />
					<!-- body -->
					<div class="meeting_form">
						<div class="meeting_img">
							<img style="border-radius: 10px; width: 100%; height: 300px;"
								alt="" src="/sms/temp/${meeting.meeting_img_name}" />
						</div>
						<br /> <br />
						<div id="title">
							<c:set var="num" value="${meeting.meeting_recruitment}" />
							<!-- 미팅  명수 -->
							<c:set var="n" value="${count_num}" />
							<!-- 미팅등록인원 -->
							<c:choose>
								<c:when test="${n >= num}">
									<p class="end text-center"
										style="font-size: xx-large; font-weight: bold;">마감되었습니다.</p>
								</c:when>
								<c:otherwise>
									<h3 class="text-center">${meeting.meeting_title}</h3>
									<p class="text-center">${meeting.meeting_introduction}</p>
								</c:otherwise>
							</c:choose>
						</div>
						<br />

						<div id="li" class="deteli">
							<h4 class="h4" style="font-weight: bold;">기본정보</h4>
							<br>
							<ul class="list-group">
								<li class="list">일시 <span class="date"
									style="float: right;">${meeting.meeting_date}</span></li>
								<hr />
								<li class="list">장소 <span class="place"
									style="float: right;">${meeting.meeting_place}</span></li>
								<hr />
								<li class="list">모집인원 <span class="num"
									style="float: right;">${meeting.meeting_recruitment}</span></li>
								<hr />
								<li class="list">참가비 <span class="price"
									style="float: right;">${meeting.meeting_price}</span></li>
							</ul>
						</div>
						<br />
						<h4 class="moli" style="font-weight: bold;">참여멘토</h4>
						<div class="mentor-box">
							<!-- post -->
							<div class="col-md-4">
								<a href="mentor_view.do?num=${mentor.mentor_num}"
									style="text-decoration: none;">
									<div class="card">
										<span class="card-field">멘토 분야</span>
										<div id="title">${mentor.mentor_sub}</div>
										<c:choose>
											<c:when test="${not empty mentor.mentor_image }">
												<img src="/sms/temp/${mentor.mentor_image}" alt="#"
													style="width: 100px; height: 100px;" />
											</c:when>
											<c:otherwise>
												<img src="./img/userpicture.png" alt="#"
													style="width: 100px; height: 100px;" />
											</c:otherwise>
										</c:choose>
										<div class="card-info">
											<span class="card-name">${mentor.mentor_name}</span> <small>멘토</small>
										</div>
										<div class="card-job">${mentor.mentor_co}&nbsp;${mentor.mentor_dept}</div>
									</div>
								</a>
							</div>
						</div>
						<br />
						<div class="program">
							<b style="font-weight: bold;">프로그램내용</b>
							<hr />
							<p>${meeting.meeting_comment}</p>
						</div>

						<div id="notice">
							<p style="font-weight: bold;">안내사항</p>
							<hr />
							<ul>
								<li>1.확정된 분들에게는 참여 확정 안내 메일이 발송됩니다.</li>
								<li>2.사전 취소는 2일 전까지 가능합니다.</li>
								<li>3.무단 No-Show 시에는 참여 신청이 제한됩니다.</li>
								<li>4.주차지원은 불가능하니 대중교통을 이용해 주세요.</li>
							</ul>
							<br />
						</div>
						<div id="place">
							<b style="font-weight: bold;">장소</b>
							<hr />
							<b id="m_p">${meeting.meeting_place}</b>
							<p id="m_d">${meeting.meeting_address}</p>
							<div id="map" style="width: 100%; height: 350px;"></div>
						</div>

						<div class="bt_group">
							<a class="meeting_apply"
								href="meeting_cnt.do?user_Id=${user_Id}&meeting_num=${meeting.meeting_num}"><button
									id="meeting_apply" type="button" class="btn btn-warning">
									<i class="fa fa-users" aria-hidden="true"></i> 모임참여하기
								</button></a> <a class="meeting_cancel"
								href="meeting_cancel.do?user_Id=${user_Id}&meeting_num=${meeting.meeting_num}"><button
									id="meeting_cancel" type="button" class="btn btn-danger">
									<i class="fa fa-times-circle" aria-hidden="true"></i> 참여취소하기
								</button></a> <a class="bt_1" href="list.do"><button id="bt_1"
									type="button" class="btn"
									style="background-color: #9F81F7; bacfont-weight: bold;">
									<i class="fa fa-sign-out" aria-hidden="true"></i> 이전페이지
								</button></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- /body -->



<script type="text/javascript">
	var address = document.getElementById('m_d').innerHTML;
	var point = document.getElementById('m_p').innerHTML;
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder
			.addressSearch(
					address,
					function(result, status) {

						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {

							var coords = new kakao.maps.LatLng(result[0].y,
									result[0].x);

							// 결과값으로 받은 위치를 마커로 표시합니다
							var marker = new kakao.maps.Marker({
								map : map,
								position : coords
							});

							// 인포윈도우로 장소에 대한 설명을 표시합니다
							var infowindow = new kakao.maps.InfoWindow(
									{
										content : '<div style="width:150px;text-align:center;padding:6px 0;">'
												+ point + '</div>'
									});
							infowindow.open(map, marker);

							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
						}
					});
</script>