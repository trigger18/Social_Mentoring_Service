<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<style type="text/css">
/*  스크롤 시작*/
#meeting::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: #ffffff;
}

#meeting::-webkit-scrollbar {
	width: 12px;
	background-color: #ffffff;
}

#meeting::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: #cfbad3;
}

#essay::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: #ffffff;
}

#essay::-webkit-scrollbar {
	width: 12px;
	background-color: #F5F5F5;
}

#essay::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: #cfbad3;
}

--
#follow::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: #ffffff;
}

#follow::-webkit-scrollbar {
	width: 12px;
	background-color: #F5F5F5;
}

#follow::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: #cfbad3;
}
/*  스크롤 끝*/

/* 공통시작 */
#left {
	width: 55%;
	height: 850px;
	float: left;
	padding-left: 40px;
	padding-right: 40px;
	border-right: 2px dotted #ccc;
}

#right {
	width: 40%;
	height: 750px;
	float: right;
	padding-right: 10px;
}

#meetingwrap {
	height: 400px;
	width: 90%;
	border: 1px solid #b1adb3;
	padding: 20px;
	margin-left: 70px;
	border-radius: 30px;
}

.title {
	text-align: center;
}

/*  공통 끝*/
#meeting {
	width: 100%;
	height: 300px;
}

.mimg {
	width: 50px;
	height: 50px;
	float: left;
}

.fimg {
	width: 50px;
	height: 50px;
	float: left;
}

#essaywrap {
	height: 400px;
	width: 90%;
	border: 1px solid #b1adb3;
	padding: 20px;
	margin-left: 70px;
	border-radius: 30px;
}

#essay {
	width: 100%;
	height: 300px;
}
/* div 왼쪽 id 끝 */

/*right시작  */
#followwrap {
	height: 835px;
	width: 50%;
	border: 1px solid #b1adb3;
	padding: 20px;
	margin-left: 20px;
	border-radius: 30px;
	border: 1px solid #b1adb3;
}

#follow {
	width: 100%;
	height: 700px;
}

#ffont {
	font-size: 20px;
}
/* right 끝 */
.eimg {
	width: 50px;
	height: 50px;
	float: left;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
	
</script>

<section>
	<div class="section" style="height: 1000px;">
		<div id="all">
			<div id="left">
				<div id="meetingwrap">
					<h2 class="title">
						<i class="fa fa-meetup" aria-hidden="true"></i> 내가 만든 모임
					</h2>
					<hr />
					<div id="meeting"
						style="overflow: auto; background-color: #eef3ff; border-radius: 20px">
						<ul>
							<c:forEach var="meeting" items="${meetingInfoList }"
								varStatus="number">
								<c:url var="mpath" value="detail.do">
									<c:param name="meeting_num" value="${ meeting.meeting_num}" />
									<c:param name="mentor_num" value="${meeting.mentor_num }" />
								</c:url>
								<span
									style="float: left; margin-left: 40px; margin-top: 20px; font-size: 20px;">${number.count }</span>
								<li
									style="height: 50px; line-height: 50px; vertical-align: middle;"><a
									href="${mpath }"><img
										src="/sms/temp/${meeting.meeting_img_name }" class="mimg"
										style="margin-left: 5%;" /></a><a href="${ mpath}"
									style="margin-left: 10px;">모임명: ${ meeting.meeting_title}</a></li>
								<hr />
							</c:forEach>
						</ul>
					</div>
					<!-- meeting -->
				</div>
				<!-- meetingwrap -->


				<c:choose>
					<c:when test="${mCheck==1 }">
						<hr />
						<div id="essaywrap">
							<h2 class="title">
								<i class="fa fa-pencil" aria-hidden="true"></i> 내가 쓴 에세이
							</h2>
							<hr />
							<div id="essay"
								style="overflow: auto; background-color: #eef3ff; border-radius: 20px">
								<ul>
									<c:forEach var="mn" items="${eassayInfoList}"
										varStatus="number">
										<!-- mentor_num -->
										<c:url var="epath" value="essay_view.do">
											<c:param name="essay_num" value="${mn.essay_num }" />
											<c:param name="mentor_num" value="${mn.mentor_num }" />
											<c:param name="essay_img" value="${mn.essay_img }" />
											<c:param name="currentPage" value="1" />
										</c:url>


										<span
											style="float: left; margin-left: 40px; margin-top: 20px; font-size: 20px;">${number.count }</span>
										<li
											style="height: 50px; line-height: 50px; vertical-align: middle;">
											<a href="${epath }" style="margin-left: 10px;"></a><a
											href="${epath}"><img src="/sms/temp/${mn.essay_img }"
												class="eimg" style="margin-left: 5%;" />제목 :
												${mn.essay_subject }</a>
											<p style="float: right">${mn.essay_date}</p>
										</li>
										<hr />
									</c:forEach>
								</ul>
							</div>
							<!-- essay -->
						</div>
						<!-- essaywrap -->
					</c:when>
				</c:choose>
			</div>
			<!-- left -->
			<c:choose>
				<c:when test="${mCheck==1 }">
					<div id="right">
						<div id="followwrap">
							<h2 class="title">
								<i class="fa fa-users" aria-hidden="true"></i>
								${userDTO.user_name }의 팔로잉
							</h2>
							<hr />
							<div id="follow"
								style="overflow: auto; background-color: #eef3ff; border-radius: 20px">
								<ul>
									<c:forEach items="${mymentorInfo}" var="mlist" begin="1">
										<li
											style="height: 30px; line-height: 50px; vertical-align: middle;"><a
											href="mentor_view.do?num=${mlist.mentor_num}"
											style="text-decoration: none;"></a> <c:choose>
												<c:when test="${not empty mlist.mentor_image }">
													<img src="/sms/temp/${mlist.mentor_image }" class="fimg"
														style="margin-left: 5%; border-radius: 50%" />
													<a href="mentor_view.do?num=${mlist.mentor_num}"
														style="text-decoration: none; margin-left:5px; font-size: large; width: 300px;">
														${mlist.mentor_name}</a>
												</c:when>
												<c:otherwise>
													<img src="./img/userpicture.png" class="fimg"
														style="margin-left: 5%; border-radius: 50%" />
													<a href="mentor_view.do?num=${mlist.mentor_num}"
														style="text-decoration: none; margin-left:5px; font-size: large; width: 300px;">
														${mlist.mentor_name}</a>
												</c:otherwise>
											</c:choose>&nbsp; <small>멘토</small></li>
										<hr />
									</c:forEach>
								</ul>
							</div>
							<!-- follow -->
						</div>
						<!-- followwrap -->
					</div>
					<!-- right -->
				</c:when>
				<c:otherwise>
					<div id="right">
						<div id="followwrap">
							<h2 class="title">
								<i class="fa fa-users" aria-hidden="true"></i>
								${userDTO.user_name }의 팔로잉
							</h2>
							<hr />
							<div id="follow"
								style="overflow: auto; background-color: #eef3ff; border-radius: 20px">
								<ul>
									<c:forEach items="${mymentorInfo}" var="mlist" begin="0">
										<li
											style="height: 30px; line-height: 50px; vertical-align: middle;"><a
											href="mentor_view.do?num=${mlist.mentor_num}"
											style="text-decoration: none;"></a> <c:choose>
												<c:when test="${not empty mlist.mentor_image }">
													<img src="/sms/temp/${mlist.mentor_image }" class="fimg"
														style="margin-left: 5%; border-radius: 50%" />
												</c:when>
												<c:otherwise>
													<img src="./img/userpicture.png" class="fimg"
														style="margin-left: 5%; border-radius: 50%" />
												</c:otherwise>
											</c:choose> ${mlist.mentor_name}&nbsp; <small>멘토</small></li>
										<hr />
									</c:forEach>
								</ul>
							</div>
							<!-- follow -->
						</div>
						<!-- followwrap -->
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- all -->
	</div>
</section>

