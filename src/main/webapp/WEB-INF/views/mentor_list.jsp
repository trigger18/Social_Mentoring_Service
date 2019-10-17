<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SMS - 멘토 찾기</title>
<link href="css/mentor.css" type="text/css" rel="stylesheet">
<body>

	<!-- 멘토링 카테고리 -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="aside-widget">
					<div class="tags-widget">
						<h2 class="block-title">멘토링 유형</h2>
						<ul>
							<li><a href="mentor_list.do">전체보기</a></li>
							<li><a href="mentor_list.do?field_num=1">직무</a></li>
							<li><a href="mentor_list.do?field_num=2">진로</a></li>
							<li><a href="mentor_list.do?field_num=3">스펙</a></li>
							<li><a href="mentor_list.do?field_num=4">외국어</a></li>
							<li><a href="mentor_list.do?field_num=5">면접/자소서</a></li>
							<li><a href="mentor_list.do?field_num=6">회사생활</a></li>
							<li><a href="mentor_list.do?field_num=7">창업</a></li>
							<li><a href="mentor_list.do?field_num=8">이직</a></li>
							<li><a href="mentor_list.do?field_num=9">기타</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /멘토링 카테고리 -->

	<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-12">
					<div class="mentor-section-title">
						<h2>멘토</h2>
					</div>
				</div>

				<!-- post -->
				<c:forEach items="${mentorList}" var="mlist">
					<div class="col-md-4">
						<a href="mentor_view.do?num=${mlist.mentor_num}"
							style="text-decoration: none;">
							<div class="card">
								<span class="card-field">멘토 한마디</span>
								<div id="title">${mlist.mentor_sub}</div>
								<c:choose>
									<c:when test="${not empty mlist.mentor_image }">
										<img src="/sms/temp/${mlist.mentor_image}" alt=""
											style="width: 120px; height: 120px;" />
									</c:when>
									<c:otherwise>
										<img src="./img/userpicture.png" alt=""
											style="width: 120px; height: 120px;" />
									</c:otherwise>
								</c:choose>
								<div class="card-info">
									<span class="card-name">${mlist.mentor_name}</span> <small>멘토</small>
								</div>
								<div class="card-job">${mlist.mentor_co}&nbsp;${mlist.mentor_dept}</div>
							</div>
						</a>
					</div>
				</c:forEach>
				<!-- /post -->
			</div>
			<!-- /row -->

		</div>
		<!-- /container -->
	</div>
	<!-- /section -->
</body>