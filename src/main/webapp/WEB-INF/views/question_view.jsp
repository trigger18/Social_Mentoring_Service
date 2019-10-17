<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/mentor.css" type="text/css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {

				$('form').on(
						'submit',
						function() {
							$('[name=answer_content]').val(
									$('[name=answer_content]').val().replace(
											/\n/gi, '<br/>'));
							alert("답글이 등록되었습니다.")
						});

			});
</script>
</head>
<body>
	<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!-- Post content -->
				<div class="col-md-8">
					<div class="section-row post-container">
						<div class="main-post">
							<h3>${questionView.question_title}</h3>
							<div class="post-info">
								작성자 : ${questionView.user_name} </br> 날짜 :
								<fmt:formatDate pattern="yyyy/MM/dd" dateStyle="short"
									value="${questionView.question_date}" />
							</div>
							<p class="post-content">${questionView.question_content}</p>

						</div>
					</div>

					<!-- comments -->
					<div class="section-row">

						<div class="post-comments">
							<!-- comment -->
							<c:forEach items="${answerList}" var="aList">
								<div class="media">
									<div class="media-left">
										<c:choose>
											<c:when test="${not empty aList.user_image}">
												<img class="media-object"
													src="/sms/temp/${aList.user_image}" alt="" />
											</c:when>
											<c:otherwise>
												<img class="media-object" src="./img/userpicture.png" alt="" />
											</c:otherwise>
										</c:choose>
									</div>
									<div class="media-body">
										<div class="media-heading">
											<h4>${aList.user_name}</h4>
											<span class="time"><fmt:formatDate
													pattern="yyyy/MM/dd HH:mm" dateStyle="short"
													value="${aList.answer_date}" /></span>
										</div>

										<p>${aList.answer_content}</p>

									</div>
								</div>
							</c:forEach>
							<!-- /comment -->
						</div>
					</div>
					<!-- /comments -->

					<!-- reply -->
					<div class="section-row">
						<div class="section-title">
							<h2>대화하기</h2>
							<p>질문에 대한 답변과 멘토님께 더 하고 싶은 말을 자유롭게 남겨주세요.</p>
							<p style="color: red; font-size: 12px;">한 번 작성하신 답글은 수정, 취소가
								어려우니 신중하게 작성해주시기 바랍니다.</p>
						</div>
						<form name="answer_form" class="post-reply" action="answer_pro.do"
							method="POST">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<textarea class="input" name="answer_content" placeholder="내용"
											required></textarea>
										<input type="hidden" name="question_num"
											value="${questionView.question_num}" /> <input type="hidden"
											name="user_name" value="${userDTO.user_name}" /> <input
											type="hidden" name="user_image" value="${userDTO.user_image}" />
									</div>
									<button class="primary-button">등록</button>

								</div>
							</div>
						</form>
					</div>
					<!-- /reply -->
				</div>
				<!-- /Post content -->

				<!-- aside -->
				<div class="col-md-4">

					<!-- post widget -->
					<div class="aside-widget">
						<div class="mentor-section-title">
							<h2>멘토 정보</h2>
						</div>

						<div class="post post-widget">
							<a class="post-img"
								href="mentor_view.do?num=${mentorDTO.mentor_num}"> <c:choose>
									<c:when test="${not empty mentorDTO.mentor_image }">
										<img src="/sms/temp/${mentorDTO.mentor_image}" alt="">
									</c:when>
									<c:otherwise>
										<img src="./img/userpicture.png" alt="">
									</c:otherwise>
								</c:choose>
							</a>
							<div class="post-body">
								<h3 class="post-title">
									<a href="mentor_view.do?num=${mentorDTO.mentor_num}">${mentorDTO.mentor_name}</a>
								</h3>
								</br>
								<p>${mentorDTO.mentor_co}&nbsp;${mentorDTO.mentor_dept}</p>
							</div>
						</div>

					</div>
					<a class="list-btn"
						href="question_list.do?user_id=${sessionScope.user_id}">목록으로
						돌아가기</a>
					<!-- /post widget -->
				</div>
				<!-- /aside -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /section -->
</body>
<!-- /body -->
</html>