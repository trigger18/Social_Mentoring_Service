<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/mentor.css" type="text/css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#follow_btn').on('click', mentor_follow);

		$('#question_btn').click(function() {
			$('#myModal').css('display', 'block');
		});

		$('#close').click(function() {
			$('#myModal').css('display', 'none');
		});

		/* $(window).click(function(e) {
			if ($(e.target) == $('#mymodal'))
				$('#myModal').css('display', 'none');
		}); */

		$('form').on('submit', space_change);

	});
	// ////////////end ready()//////////////////////////////
	// 팔로우 처리
	function mentor_follow() {
		$
				.ajax({
					url : 'mentor_follow.do',
					type : 'POST',
					dataType : 'json',
					data : 'mentor_num=${mentorView.mentor_num}&user_id=${sessionScope.user_id}',
					success : follow_success
				});
	}//end mentor_follow

	function follow_success(res) {
		var text = $('#follow_btn').text();
		if (res.check_num == 0) {
			$('#follow_btn').text(text.replace('팔로우 취소', '팔로우'));
			$('#follow_btn').attr(
					'class',
					$('#follow_btn').attr('class').replace("btn btn-danger",
							"btn btn-default"));

			$('.cnt').text(res.cnt2);

			/* console.log(cnt); */
			Swal.fire('팔로우가 취소 되었습니다!', '', 'success')
		} else if (res.check_num == 1) {
			$('#follow_btn').text(text.replace('팔로우', '팔로우 취소'));
			$('#follow_btn').attr(
					'class',
					$('#follow_btn').attr('class').replace("btn btn-default",
							"btn btn-danger"));

			$('.cnt').text(res.cnt2);

			/* console.log(cnt); */
			Swal.fire('팔로우가 완료되었습니다!', '', 'success')
		}
	}//end follow_success

	function space_change() {
		$('[name=question_content]').val(
				$('[name=question_content]').val().replace(/\n/gi, '<br/>'));
		alert("질문 등록 완료!등록하신 질문은 My Q&A 페이지에서 확인하실 수 있습니다.")
	}//end space_change
</script>
</head>

<!-- body -->
<body>
	<div class="body">
		<!-- 멘토 정보 섹션 -->
		<div class="mentor-box">
			<c:choose>
				<c:when test="${not empty mentorView.mentor_image}">
					<div class="mentor-image-circle">
						<img width="200" height="200"
							src="/sms/temp/${mentorView.mentor_image}">
					</div>
				</c:when>
				<c:otherwise>
					<div class="mentor-image-circle">
						<img id="header_profile_pic" src="./img/userpicture.png"
							style="width: 200px; height:200px">
					</div>
				</c:otherwise>
			</c:choose>
			<div class="mentor-info">
				<div id="name">
					<span class="mentor-name">${mentorView.mentor_name} <small>멘토</small></span>
					<span class="follower">팔로워 <span class="cnt">${cnt}</span>명
					</span>
				</div>
				<div class="mentor-job">${mentorView.mentor_co}&nbsp;${mentorView.mentor_dept}</div>
				<div class="detail-block">
					<div class="mentoring-type">대표 멘토링 분야</div>
					<div class="mentoring-type-block">${mentorView.mentor_sub}</div>

					<div class="mentoring-info">멘토링 분야</div>
					<div class="button-container">
						<c:forEach items="${fieldDTO}" var="flist">
							<span class="field-chip">${flist.field_name}</span>
						</c:forEach>
					</div>
				</div>
				<c:choose>
					<c:when test="${sessionScope.user_id!=mentorView.user_id}">
						<div class="btn-container">

							<button id="follow_btn" type="button"
								class=<c:choose><c:when test="${check_num==0}">"btn btn-default"</c:when>
					<c:otherwise>"btn btn-danger"</c:otherwise>
					</c:choose>>
								<c:choose>
									<c:when test="${check_num==0}">
										<i class="fa fa-circle-o" aria-hidden="true"></i> 팔로우
					</c:when>
									<c:otherwise>
										<i class="fa fa-check-circle-o" aria-hidden="true"></i> 팔로우 취소
					</c:otherwise>
								</c:choose>
							</button>
							<button id="question_btn" type="button" class="btn btn-danger"<%-- onclick="location.href='question_write.do?mentor_num=${mentorView.mentor_num}'" --%>>
								<i class="fa fa-question-circle-o" aria-hidden="true"></i>질문하기
							</button>
						</div>
					</c:when>
				</c:choose>
			</div>
		</div>
		<!--/ 멘토 정보 섹션  끝-->

		<!-- 멘토 상세 정보 -->
		<div class="detail-box">
			<div id="block-title">멘토 소개</div>
			<div id="block-content">${mentorView.mentor_info}</div>
			<div id="block-title">주요 경력</div>
			<div id="block-content">${mentorView.mentor_career}</div>
			<br />
		</div>
		<!--/ 멘토 상세 정보 끝 -->

		<button class="primary-button center-block"
			onclick="location.href='mentor_list.do'">List</button>

		<!-- 질문하기 Modal -->
		<div id="myModal" class="modal">
			<!-- Modal content -->
			<div class="modal-content">
				<h3>멘토에게 질문하기</h3>
				<p style="color: red; font-size: 12px;">한 번 작성하신 질문은 수정, 취소가
					어려우니 신중하게 작성해주시기 바랍니다..</p>
				<form name="question_form" action="question_pro.do" method="POST">
					<div class="row">
						<%-- <div class="col-md-7">
							<div class="form-group">
								<span>이름</span> <input class="input" type="text"
									name="user_name" value="${userDTO.user_name}"
									readonly="readonly">
							</div>
						</div> --%>
						<div class="col-md-7">
							<div class="form-group">
								<span>제목</span> <input class="input" type="text"
									name="question_title" placeholder="질문 제목을 작성해주세요" required>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<textarea class="input" id="question_content"
									name="question_content" placeholder="질문 내용을 작성해주세요" row="50"
									required></textarea>
							</div>
							<input type="submit" value="제출" class="primary-button" />
							<button class="primary-button" id="close">닫기</button>
						</div>
					</div>
					<input type="hidden" name="mentor_num" id="mentor_num"
						value="${mentorView.mentor_num}" /> <input type="hidden"
						name="user_id" id="user_id" value="${sessionScope.user_id}" /> <input
						type="hidden" name="user_name" value="${userDTO.user_name}">
				</form>
			</div>
		</div>
		<!-- /질문하기 Modal -->
	</div>
</body>
<!-- /body -->
</html>