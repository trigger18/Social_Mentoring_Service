<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(function() {
		floatB();
		$('#u_btn').on('click', updateRun);
		$('#d_btn').on('click', deleteRun);
		$('#l_btn').on('click', listRun);
	})

	function updateRun() {
		$('.frm').attr('action', "essay_update.do").submit();
	}
	function deleteRun() {
		$('.frm').attr('action', "essay_delete.do").submit();
	}
	function listRun() {
		$('.frm').attr('action', "essay_list.do").submit();
	}

	function floatB() {
		// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
		var floatPosition = parseInt($("#author").css('top'));
		// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

		$(window).scroll(function() {
			// 현재 스크롤 위치를 가져온다.
			var scrollTop = $(window).scrollTop();
			var newPosition = scrollTop + floatPosition - 300;
			if (newPosition <= 393) {
				newPosition = 420;
			}
			$("#author").stop().animate({
				"top" : newPosition + "px"
			}, 0);
		}).scroll();

	}
</script>

<style type="text/css">
.w3-input {
	width: 100%;
	resize: none;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	transition: 1.5s;
	width: 600px;
}

#img {
	/*  visibility: hidden; */
	height: 300px;
	max-width: 600px;
}

.primary-button {
	display: inline-block;
	text-align: center;
}

.section {
	margin-left: 0%;
}

.container {
	display: flex;
	flex-direction: row;
}

#author {
	position: absolute;
	width: 500px;
	height: 400px;
	top: 420px;
	background-color: transparent;
	color: #212631;
}

.field-chip {
	display: inline-block;
	font-size: 13px;
	text-transform: uppercase;
	padding: 3px 10px;
	font-weight: 600;
	border-radius: 2px;
	margin-right: 5px;
	margin-bottom: 5px;
	color: #FFF;
	background-color: #ff8700;
	-webkit-transition: 0.2s opacity;
	transition: 0.2s opacity
}

#author_border {
	border: 1px solid #ccc;
	border-radius: 10px;
	padding: 20px;
}

.media-body {
	width: 200px
}
</style>

<!-- section -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!-- Post content -->


			<div class="section-row sticky-container"
				style="padding-left: 30px; padding-right: 30px; width: 900px;">
				<div class="main-post" style="margin-right: 30px">
					<h2 style="margin-left: 15px; margin-right: 15px;">${essayDTO.essay_subject }</h2>
					<p style="text-align: right">
						<span class="date">작성일 : ${essayDTO.essay_date }</span>
					</p>

					<p style="text-align: center">
						<img class="" id="img" src="/sms/temp/${essayDTO.essay_img }"
							alt="" />
					</p>
					<hr/>
					<h4> <요약> </h4>
					<h4><div style="text-indent: 30px;">${essayDTO.essay_summary }</div></h4>
					<p></p>
					<hr/>
					<h4> <내용> </h4>
					<div style="text-indent: 30px;">${essayDTO.essay_content }</div>
				</div>
				<!-- ////////////////////////뷰 화면 끝/////////////////////////////////// -->
				<p style="height: 50px;"></p>
				<!-- 페이지 번호 & 에세이 넘버  보내기 버튼부-->
				<div class="section-row text-center">
					<form class="frm" method="get">
						<input type="hidden" name="currentPage" id="currentPage"
							value="${currentPage}" /> <input type="hidden" name="essay_num"
							value="${essayDTO.essay_num }" /> <input type="hidden"
							name="mentor_num" value="${mentorDTO.mentor_num}" />
						<div class="essay-btn">
							<button class="primary-button center-block" id="l_btn">List</button>
							<c:choose>
								<c:when test="${cmau eq 1}">
									<button class="primary-button center-block" id="u_btn">Update</button>
									<button class="primary-button center-block" id="d_btn">Delete</button>
								</c:when>
							</c:choose>
						</div>
					</form>
				</div>
				<!-- 페이지 번호 & 에세이 넘버  보내기 버튼부 -->
			</div>
			<!-- /row -->
		</div>


		<!-- author -->
		<div class="section-row"
			style="border-left: 2px dotted #ccc; padding-left: 63px;">
			<div id="author">
				<div id="author_border">
					<div class="post-author" style="width: 78%">

						<div class="media">
							<div class="media-left">
								<c:choose>
									<c:when test="${not empty mentorDTO.mentor_image }">
										<a href="mentor_view.do?num=${mentorDTO.mentor_num}" style="text-decoration: none;">
                             				 <img class="media-object" src="/sms/temp/${mentorDTO.mentor_image}" alt="" style="height: 120px">
                           			   </a>
									</c:when>
									<c:otherwise>
										<img class="media-object"
											src="./img/userpicture.png" alt=""
											style="height: 120px">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="media-body">
								<div class="media-heading">
									<h3>${mentorDTO.mentor_name}</h3>
								</div>
								<div id="mentorSub">${mentorDTO.mentor_sub}</div>
								<hr />
								<h6>맨토링 분야</h6>
								<ul>
									<c:forEach items="${fieldDTO}" var="flist">
										<li class="field-chip">${flist.field_name}</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- author -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->