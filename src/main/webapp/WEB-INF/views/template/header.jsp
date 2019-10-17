<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- ////////////////////////////////////////////////////////////// -->
<!-- Nav -->
<script type="text/javascript">
	$(document).ready(function() {
		var mCheck = $('#mcheck').val();

		var login = $('#loginSuccess').val();
		console.log(login);
		if (login == 1) {
			Swal.fire({
				type : 'success',
				title : '로그인이 성공적으로 되었습니다',
				text : '환영합니다!!'
			})
		}
		$('#logout').on('click',function(){
			Swal.fire({
				  title: '로그아웃 하시겠습니까?',
				  type: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: 'logout!',
				}).then((result) => {
				  if (result.value) {
				    Swal.fire({
				    		position: 'center',
				    		  type: 'success',
				    		  title: '로그아웃이 성공적으로 되었습니다',
				    		  showConfirmButton: false,
				    		  timer: 2000
				    })
				  setTimeout(function(){ window.location.href="userLogout.do"; }, 2000);
				  }
				})
		})

		$("#wannabe").on('click', function() {
			if (mCheck == 1) {
				Swal.fire({
					type : 'info',
					title : '어~라~~?',
					text : '이미 멘토신데요? 멘토를 지원하실 필요가 없습니다 :)'
				})
				return false;
			} else if (mCheck == "") {
				Swal.fire({
					type : 'error',
					title : '이런이런~맙소사',
					text : '로그인을 먼저 해주셔야 합니다!'
				})
				return false
			} else {
				return true;
			}

		});

		$(".post-category").on('click', function() {
			if (mCheck == 1) {
				Swal.fire({
					type : 'info',
					title : '어~라~~?',
					text : '이미 멘토신데요? 멘토를 지원하실 필요가 없습니다 :)'
				})
				return false;
			} else if (mCheck == "") {
				Swal.fire({
					type : 'error',
					title : '이런이런~맙소사',
					text : '로그인을 먼저 해주셔야 합니다!'
				})
				return false
			} else {
				return true;
			}

		});

		$(document).ready(function() {
			var mCheck = $('#mcheck').val();
			$("#update_mentor").on('click', function() {
				if (mCheck == 0) {
					Swal.fire({
						type : 'warning',
						title : '이런이런~맙소사',
						text : '멘토지원을 먼저 해주셔야되요~!',
						footer : '<a href="wannabe.do">멘토 지원을 하시겠습니까?</a>'
					})
					return false;
				} else if (mCheck == "") {
					Swal.fire({
						type : 'error',
						title : '이런이런~맙소사',
						text : '로그인을 먼저 해주셔야 합니다!'
					})
					return false
				} else {
					return true;
				}

			});

		});

	});
</script>
<style type="text/css">

#logout:hover{
	 text-decoration: underline;
}

</style>

<div id="nav">
	<!-- Main Nav -->
	<div id="nav-fixed">
		<div class="container">
			<!-- logo -->
			<div class="nav-logo">
				<a href="home.do?${session.user_id}" class="logo"><img
					src="./img/logo3.png" alt=""></a>
			</div>

			<!-- /logo -->
			<!-- nav -->
			<input type="hidden" id="mcheck" value="${mCheck}" /> <input
				type="hidden" id="loginSuccess" value="${loginSuccess}" />
			<ul class="nav-menu nav navbar-nav" style="margin-left: 300px;">
				<c:choose>
					<c:when test="${not empty userDTO.user_id}">
						<li><a style="padding-left: 0px; padding-right: 0px"><marquee
									width="200px" direction="left"> ${userDTO.user_name }님
									SMS 에 오신 걸 환영합니다! :) </marquee></a></li>
					</c:when>
				</c:choose>
				<li class="cat-4"><a href="about.do">About</a></li>
				<li class="cat-4"><a href="mentor_list.do">멘토 찾기</a></li>
				<li class="cat-4"><a href="essay_list.do">에세이</a></li>
				<li class="cat-4"><a href="list.do">모임</a></li>
				<li class="cat-4"><a id="wannabe" href="wannabe.do">멘토지원하기</a></li>
				<c:choose>
					<c:when test="${empty sessionScope.user_id}">
						<li class="cat-4"><a href="signUp.do">회원가입</a></li>
						<li class="cat-4"><a href="userLogin.do">로그인</a></li>
					</c:when>
					<c:otherwise>
						<li><div class="nav-btns">
								<c:choose>
									<c:when test="${not empty userDTO.user_image}">
										<button class="aside-btn">
											<img id="header_profile_pic"
												src="/sms/temp/${userDTO.user_image}"
												style="width: 40px; height: 40px">
										</button>
									</c:when>
									<c:otherwise>
										<button class="aside-btn">
											<img id="header_profile_pic" src="./img/userpicture.png"
												style="width: 40px; height: 40px">
										</button>
									</c:otherwise>
								</c:choose>
							</div></li>
					</c:otherwise>
				</c:choose>
			</ul>
			<!-- /nav -->
		</div>
	</div>
	<!-- /Main Nav -->

	<!-- Aside Nav -->
	<div id="nav-aside">
		<!-- nav -->
		<div class="section-row">
			<ul class="nav-aside-menu">
				<li><a href="home.do">Home</a></li>
				<li><a href="userSetting.do?user_id=${sessionScope.user_id}">Profile
						Setting</a></li>
				<li id="update_mentor"><a href="update_Mento.do">Mentor
						Setting</a></li>
				<li><a href="myPage.do?user_id=${sessionScope.user_id }">MyPage</a></li>
				<li><a href="question_list.do?user_id=${sessionScope.user_id}">My
						Q&A</a></li>
				<%-- <li><a id="logout" href="userLogout.do?user_id=${sessionScope.user_id }">Logout</a></li> --%>
				<li><button id="logout"
						style="font-family: 'Nunito Sans', sans-serif; font-weight: 700; font-size: 23px; border: 0px; background-color: white">Logout</button></li>
			</ul>
		</div>

		<!-- /social links -->

		<!-- aside nav close -->
		<button class="nav-aside-close">
			<i class="fa fa-times"></i>
		</button>
		<!-- /aside nav close -->
	</div>
	<!-- Aside Nav -->
</div>
<!-- /Nav -->


<!-- Page Header -->
<div id="post-header" class="page-header">
	<div class="background-img"
		style="background-image: url('./img/llogo.png');"></div>
	<div class="container">
		<div class="row">
			<div class="col-md-10">
				<div class="post-meta">
					<a class="post-category cat-2" href="wannabe.do">멘토 지원하기</a>
				</div>
				<h1>가치 있는 커리어 경험을 공유해 보세요 :)</h1>
			</div>
		</div>
	</div>
</div>

<!-- /Page Header -->









