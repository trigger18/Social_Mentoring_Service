<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
.
* {
	margin: 0;
	padding: 0;
	border: 0;
}

.section-title {
	width: 100%;
	margin: 0 auto;
}

.meeting_body {
	width: 30%;
	height: 470px;
	float: left;
	margin: 0 auto;
	margin-left: 20px;
	margin-top: 50px;
	border: 1px solid #e0ebeb;
	border-radius: 10px;
}

.meeting_body img {
	width: 100%;
	height: 200px;
	border: 1px solid #e0ebeb;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	margin: 0 auto;
	margin-bottom: 15px;
}

.meeting_body:hover {
	padding: 0.1%;
	box-shadow: 2px 1px 18px #d9d9f2;
}

.meeting_body .meeting  .text_group {
	margin-left: 10px;
	margin-right: 10px;
	color: #585858;
}

.meeting_body .meeting  .text_group b {
	font-weight: bold;
	text-shadow: maroon;
}

hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 1px solid #F2F2F2;
	margin: 10px 0;
	padding: 0;
}

.meeting_body .meeting  .mm #m {
	float: right;
}

.meeting_body .meeting  .mento {
	display: flex;
	margin-top: 20px;
	margin-left: 10px;
	margin-right: 10px;
	color: #585858;
}

.meeting_body .meeting .mento .ba {
	float: right;
	width: 120px;
	height: 30px;
	border: 1px solid black;
}

.btn {
	padding: 9px 45px;
	border: none;
	background-color: #9F81F7;
	font-weight: 600;
	text-transform: uppercase;
	font-size: 13px;
	color: #FFFFFF;
	margin-left: 410px;
	margin-top: 20px;
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
	background-color:
}

.pageList .pagination a:hover {
	background-color: #F5A9F2;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$('.write').hide();
		var mentor_um = $('.b').val();
		mentor_um = mentor_um * 1;
		if (mentor_um != 0) {
			$('.write').show();
		}

	});
</script>
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-56">
				<input class="b" type="hidden" value="${user}" />
				<div class="section-title">
					<c:forEach items="${meetingList}" var="men">
						<c:forEach items="${men.mentorDTO}" var="mee">
							<!-- body -->
							<div class="meeting_body">
								<form name="frm" class="meeting" action="list.do" method="get">
									<a href="detail.do?meeting_num=${men.meeting_num}"
										style="text-decoration: none;"> <img alt="#"
										src="/sms/temp/${men.meeting_img_name}" />
										<div class="text_group">
											<b>${men.meeting_title}</b>
											<p>${men.meeting_introduction}</p>
											<div class="mm">
												<span><b>장소</b></span><span id="m">${men.meeting_place}</span>
												<hr />
												<span><b>일시</b></span><span id="m">${men.meeting_date}</span>
												<hr />
												<span><b>주최</b></span><span id="m">${mee.mentor_co}</span>
											</div>
										</div>
									</a> <a class="mentor_de"
										href="mentor_view.do?num=${mee.mentor_num}"
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
													style="display: block; font-size: small; border: 0;">${mee.mentor_co}
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
											<input type="hidden" class="num-1"
												value="${men.meeting_recruitment}" /> <input type="hidden"
												class="num-2" value="${men.memberCheck}" />
										</div>
									</a>
								</form>
							</div>
						</c:forEach>
					</c:forEach>
				</div>

			</div>
		</div>
	</div>
</div>
<br />
<div class="pageList">
	<!-- 이전 출력 시작 -->
	<c:if test="${pv.startPage > 1}">
		<ul class="pagination">
			<li><a href="list.do?currentPage=${pv.startPage-pv.blockPage}"
				class="pagecolor" style="text-decoration: none;">이전페이지</a></li>
		</ul>
	</c:if>
	<!-- 이전페이지 끝 -->
	<!-- 페이지 출력 시작 -->
	<c:forEach var="i" begin="${pv.startPage}" end="${pv.endPage}">
		<span> <c:url var="currPage" value="list.do">
				<c:param name="currentPage" value="${i}" />
			</c:url> <c:choose>
				<c:when test="${i==pv.currentPage}">
					<ul class="pagination">
						<li><a href="${currPage}" class="pagecolor"
							style="text-decoration: none;"> <c:out value="${i}"></c:out></a></li>
					</ul>
				</c:when>
				<c:otherwise>
					<ul class="pagination">
						<li><a href="${currPage}" style="text-decoration: none;"><c:out
									value="${i}" /></a></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</span>
	</c:forEach>
	<!--  페이지 출력 끝 -->

	<!-- 다음 출력 시작 -->
	<c:if test="${pv.totalPage>pv.endPage}">
		<ul class="pagination">
			<li><a href="list.do?currentPage=${pv.startPage+pv.blockPage}"
				class="pagecolor" style="text-decoration: none;">다음페이지</a></li>
		</ul>
	</c:if>
</div>
<a class="write" href="write.do"><input type="button" class="btn"
	value="모임글 쓰기"></a>


