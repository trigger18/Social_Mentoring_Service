<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(function() {

		$('#settingUser').on('click', function() {
			alert("프로파일 세팅으로 이동합니다.");
			$('.form-inline').attr('action', 'userSetting.do').submit();
		})

	});
</script>

<style type="text/css">
.profilebody {
	margin: auto;
	width: 400px;
	height: 500px;
	padding: 5px;
}

.profilebody ul li input {
	width: 100%;
	margin-bottom: 10px;
}

.profilebody ul li label {
	text-align: left;
}

#btn {
	margin-top: 10px;
	margin-button: 10px;
}

#user_picture {
	width: 200px;
	height: 200px;
	margin:20px;
	border-radius: 50%;
}
</style>

<!-- section -->
<div class="section" style="margin-bottom:100px;">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<form method="POST" class="form-inline">
				<div class="profilebody">
					<input type="hidden" name="user_id" value="${userDTO.user_id}" />
					<input type="hidden" name="user_name" value="${userDTO.user_name}" />
					<input type="hidden" name="user_email"
						value="${userDTO.user_email}" />
					<ul>
						<li><label for="userId">유저아이디</label></li>
						<li><input type="text" name="user_id" class="form-control"
							aria-label="Large" aria-describedby="inputGroup-sizing-sm"
							style="width: 100%" value="${userDTO.user_id}" readonly /></li>
						<li><label for="userName">이름</label></li>
						<li><input type="text" name="user_name" class="form-control"
							aria-label="Large" aria-describedby="inputGroup-sizing-sm"
							style="width: 100%" value="${userDTO.user_name}" readonly /></li>
						<li><label for="userEmail">이메일</label></li>
						<li><input type="text" name="user_email" class="form-control"
							aria-label="Large" aria-describedby="inputGroup-sizing-sm"
							style="width: 100%" value="${userDTO.user_email}" readonly /></li>
						<li><label for="userPhone">휴대폰 번호</label></li>
						<li><input type="text" name="user_phone" class="form-control"
							aria-label="Large" aria-describedby="inputGroup-sizing-sm"
							style="width: 100%" value="${userDTO.user_phone}" readonly /></li>
						<li ><label for="userImage">유저 이미지</label></li>
						<c:choose>
							<c:when test="${userDTO.user_image != null}">
								<li style="text-align: center;"><img id="user_picture"
									src="/sms/temp/${userDTO.user_image}" /></li>
							</c:when>
							<c:otherwise>
								<li style="text-align: center; "><img id="user_picture" src="./img/userpicture.png" /></li>
							</c:otherwise>
						</c:choose>
						<li></li>
						<li><input type="button" id="settingUser" value="설정 하기"
							class="btn btn-danger" /></li>
					</ul>
				</div>
			</form>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->

