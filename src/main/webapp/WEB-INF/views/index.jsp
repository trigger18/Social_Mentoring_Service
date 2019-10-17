<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

.post {
	margin-bottom: 15px;
}
/* border: 1px solid #e0ebeb; */
.col-md-4 {
	width: auto;
}

.aside-widget {
	padding: 20px;
	border: 1px solid #e0ebeb;
	border-radius: 10px;
}

#follower:hover {
	background-color: aliceblue;
}

.meeting_body {
	width: 90%;
	margin-top: 0;
	margin-bottom: 60px;
	margin-left: 120px;
	display: inline-block;
	margin-left: 120px;
}

.meeting_body .meeting {
	width: 100%;
	margin: 0 auto;
}

.meeting_body .meeting .metable {
	width: 30%;
	height: 470px;
	float: left;
	margin: 0 auto;
	margin-left: 30px;
	margin-top: 50px;
	border: 1px solid #e0ebeb;
	border-radius: 10px;
}

.meeting_body .meeting .metable:hover {
	padding: 0.2%;
	box-shadow: 2px 1px 18px #d9d9f2;
}

.meeting_body .meeting .metable .text_group {
	margin-left: 10px;
	margin-right: 10px;
	color: #585858;
}

.meeting_body .meeting .metable img {
	width: 100%;
	height: 190px;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	margin: 0 auto;
	margin-bottom: 15px;
}

img:after {
	background-image: linear-gradient(rgba(0, 0, 0, 0.10),
		rgba(0, 0, 0, 0.05));
}

.meeting_body .meeting .metable p {
	margin-top: 10px;
}

.meeting_body .meeting .metable .mm {
	margin-top: 10px;
}

hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 1px solid #F2F2F2;
	margin: 10px 0;
	padding: 0;
}

.meeting_body .meeting .metable .mm #m {
	float: right;
}

.meeting_body .meeting .metable .mento {
	display: flex;
	margin-top: 20px;
	margin-left: 10px;
	margin-right: 10px;
	color: #585858;
}

.meeting_body .meeting .metable .mento .badge {
	float: right;
	width: 120px;
	height: 20px;
}

.btn {
	padding: 9px 45px;
	border: none;
	background-color: #212631;
	font-weight: 600;
	text-transform: uppercase;
	font-size: 13px;
	color: #fff;
	margin-left: 410px;
	margin-top: 20px;
	-webkit-transition: 0.2s opacity;
	transition: 0.2s opacity;
}

.write {
	margin-left: 450px;
	border: 0;
	padding: 0;
}

.pageList {
	margin-left: 1500px;
}

.text_num {
	width: 130px;
	height: 30px;
	border: 1px solid #9F81F7;
	border-radius: 10px;
	padding-top: auto;
	font-size: small;
	line-height: 30px;
}

#introduction {
	white-space: nowrap;
	width: 300px;
	overflow: hidden;
	text-overflow: ellipsis;
	border: 0px solid #000000;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {

		var yesUser = $('#yesUser').val();
		if (yesUser == 1) {
			Swal.fire({
				position : 'top-end',
				type : 'success',
				title : 'Your work has been saved',
				showConfirmButton : false,
				timer : 2500
			})
		}
	})
</script>


<!-- section -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-8">
				<div class="row">
					<div class="section-title">
						<h2>
							<i class="fa fa-pencil" aria-hidden="true"></i> 최근 에쎄이
						</h2>
					</div>
					<div class="col-md-12"></div>

					<c:forEach items="${main_list}" var="dto" begin="0" end="2">

						<div class="essay_list">
							<c:url var="path" value="essay_view.do">
								<c:param name="currentPage" value="1" />
								<c:param name="essay_num" value="${dto.essay_num }" />
								<c:param name="mentor_num" value="${dto.mentor_num }" />
							</c:url>
							<div class="post post-row">
								<a class="post-img" href="${path}"
									style="width: 200px; height: 150px; margin-right: 50px;"> <img
									id="img" src="/sms/temp/${dto.essay_img }" alt="#"></a>
								<div class="post-body" style="margin: auto;">
									<div class="post-meta"></div>
									<h3 class="post-title"
										style="padding-left: 10px; padding-right: 10px">
										<a href="${path}">${dto.essay_subject }</a>
									</h3>
									<div class="subtitle"
										style="padding: 10px width: 100px; height: 30px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
										${dto.essay_summary }</div>
								</div>
							</div>
						</div>
						<hr />
					</c:forEach>
					<!-- /post -->
					<div class="col-md-12">
						<div class="section-row">
							<a class="w3-input" href="essay_list.do"
								style="float: right; margin-bottom: 30px; text-decoration: none;"><button
									class="primary-button center-block">더 보기</button></a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4" style="margin-left: 20px">
				<br /> <br />
				<!-- catagories -->
				<div class="aside-widget">
					<div class="section-title">
						<h3>
							<i class="fa fa-thumbs-o-up" aria-hidden="true"></i> 베스트 팔로워
						</h3>
					</div>
					<div style="width: 300px">
						<div>
							<span style="text-decoration: none; font-size: large;">팔로워
								아이디</span> <span style="display: inline-block; float: right;">
								팔로워 수</span>
						</div>
						<hr />
					</div>
					<div class="category-widget">
						<c:forEach items="${mentorInfo}" var="bflist" begin="0" end="2"
							varStatus="num">
							<div id="follower">
								<img src="./img/트로피${num.count }.png"
									style="width: 35px; height: 35px;" alt=""> <a
									href="mentor_view.do?num=${bflist.mentor_num}"
									style="text-decoration: none; font-size: x-large; width: 300px;">
									${bflist.mentor_name}</a> <small>멘토님</small> <span id="follownum"
									style="display: inline-block; float: right;">(
									${bflist.follow_num} )</span>
								<hr />
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- /catagories -->
				<!-- catagories -->
				<c:if test="${not empty sessionScope.user_id}">
					<div class="aside-widget">
						<div class="section-title">
							<h2>${userDTO.user_name }의 팔로잉</h2>
						</div>
						<div class="category-widget">
							<c:if test="${not empty sessionScope.user_id}">
								<p>
									<c:choose>
										<c:when test="${mCheck==1 }">
											<c:forEach items="${mymentorInfo}" var="mlist" begin="1"
												end="3">
												<div id="follower">
													<a href="mentor_view.do?num=${mlist.mentor_num}"
														style="text-decoration: none;">
														<h3>
															<span class="card-name">${mlist.mentor_name}</span>&nbsp;
															<small>멘토</small>
														</h3>
														<hr />
													</a>
												</div>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach items="${mymentorInfo}" var="mlist" begin="0"
												end="3">
												<div id="follower">
													<a href="mentor_view.do?num=${mlist.mentor_num}"
														style="text-decoration: none;">
														<h3>
															<span class="card-name">${mlist.mentor_name}</span>&nbsp;
															<small>멘토</small>
														</h3>
														<hr />
													</a>
												</div>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</p>
							</c:if>
							<a style="float: right" href="myPage.do">더 보기..</a>
						</div>
						<!-- /catagories -->
					</div>
				</c:if>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /section -->
	<!-- section -->
	<div class="section section-grey">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-12">
					<div class="section-title text-center">
						<h2>
							<i class="fa fa-meetup" aria-hidden="true"></i> 최근 개설된 모임
						</h2>
					</div>
				</div>
				<div class="meeting_body">
					<form name="frm" class="meeting" action="list.do" method="get">
						<c:forEach items="${mm}" var="men" begin="0" end="2">
							<c:forEach items="${men.mentorDTO}" var="mee">
								<a href="detail.do?meeting_num=${men.meeting_num}"
									style="text-decoration: none;">
									<div class="metable">
										<img alt="#" src="/sms/temp/${men.meeting_img_name}">
										<div class="text_group">
											<b class="title">${men.meeting_title}</b>
											<p id="introduction">${men.meeting_introduction}</p>
											<div class="mm">
												<span><b>장소</b></span><span id="m">${men.meeting_place}</span>
												<hr />
												<span><b>일시</b></span><span id="m">${men.meeting_date}</span>
												<hr />
												<span><b>주최</b></span><span id="m">${mee.mentor_co}</span>
											</div>
										</div>
								</a>
								<a class="mentor_de" href="mentor_view.do?num=${mee.mentor_num}"
									style="text-decoration: none;">
									<div class="mento" id="${mee.mentor_num}">
										<div id="me_1">
											<c:choose>
												<c:when test="${not empty mee.mentor_image }">
													<img class="img-responsive"
														style="width: 45px; height: 45px; border-radius: 50%;"
														src="/sms/temp/${mee.mentor_image}">
												</c:when>
												<c:otherwise>
													<img class="img-responsive"
														style="width: 45px; height: 45px; border-radius: 50%;"
														src="./img/userpicture.png">
												</c:otherwise>
											</c:choose>
										</div>
										<div id="me_2" style="margin-left: 10px; width: 160px;">
											<span class="mento_name"
												style="font-size: small; width: 90px;">${mee.mentor_name}</span>
											<span class="mem" style="font-size: small; width: 90px;">멘토</span>
											<span class="so"
												style="display: block; font-size: small; border: 0;">${mee.mentor_co},
												${mee.mentor_dept}</span>
										</div>
										<c:choose>
											<c:when test="${men.memberCheck==0}">
												<div class="text_num text-center"
													style="background-color: #ef3730; color: white; border: none">
													<span style="margin-left: 5px; margin-right: 5px;">
														<i class="fa fa-users" aria-hidden="true"></i> 마감 되었습니다
													</span>
												</div>
											</c:when>
											<c:otherwise>
												<div class="text_num text-center">
													<span style="margin-left: 5px; margin-right: 5px;">
														<i class="fa fa-users" aria-hidden="true"></i> 모집인원
														:${men.meeting_recruitment }명
													</span>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</a>
				</div>
				</c:forEach>
				</c:forEach>
				</form>
			</div>
			<input type="hidden" id="yesUser" value="${sessionScope.yesUser }" />
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->
