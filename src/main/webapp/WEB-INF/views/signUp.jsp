<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(function() {
		$('#reUser_Pass').blur(function() {
			var user_pass = $('#user_pass').val();
			var reUser_Pass = $('#reUser_Pass').val();
			if (user_pass != reUser_Pass) {
				$.ajax({
					url : 'signUp.do?user_pass=' + user_pass,
					type : 'GET',
					dataType : "text",
					success : function(object) {
						$("#pw_check").text("비밀번호가 일치하지 않아요");
						$("#pw_check").css("color", "red");
						$("#signup").attr("disabled", true);
					}
				})
			} else {
				$.ajax({
					url : 'signUp.do?user_pass=' + user_pass,
					type : 'GET',
					dataType : "text",
					success : function(object) {
						$("#pw_check").text("사용가능한 비밀번호입니다.");
						$("#pw_check").css("color", "blue");
						$("#signup").attr("disabled", false);
					}
				})
			}
		})

		$("#user_id").blur(function() {
			var user_id = $('#user_id').val();
			if (!(user_id == "")) {
				$.ajax({
					url : 'chkid.do?user_id=' + user_id,
					type : 'GET',
					dataType : "text",
					success : function(object) {
						if (object == "true") {
							$("#id_check").text("사용중인 아이디입니다");
							$("#id_check").css("color", "red");
							$("#signup").attr("disabled", true);
						} else {
							$("#id_check").text("사용가능한 아이디입니다.");
							$("#id_check").css("color", "blue");
						}
					}
				})
			}
		})
	})
</script>

<style type="text/css">
.signUpbody {
	margin: auto;
	width: 400px;
	height: auto;
	padding: 15px;
	border: 0.5px solid #c1d1eb;
	border-radius: 10px;
}

.signUpbody ul li input {
	width: 100%;
	margin-bottom: 10px;
}

.signUpbody ul li label {
	text-align: left;
}

#btn {
	margin-top: 10px;
	margin-button: 10px;
}
}
</style>

<!-- section -->
<div class="section" style="margin-bottom: 100px;">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<form method="POST" class="form-inline" action="userInsert.do">
				<div class="signUpbody">
					<ul>
						<li><label for="userId">유저아이디</label></li>
						<li><input type="text" name="user_id" id="user_id"
							class="form-control" aria-label="Large"
							aria-describedby="inputGroup-sizing-sm" style="width: 100%"
							placeholder="아이디를  입력해주세요." required/></li>
						<li><div id="id_check"></div></li>
						<li><label for="userId">이름</label></li>
						<li><input type="text" name="user_name" id="user_name"
							class="form-control" aria-label="Large"
							aria-describedby="inputGroup-sizing-sm" style="width: 100%"
							placeholder="이름을  입력해주세요." required /></li>
						<li><label for="password">패스워드</label></li>
						<li><input type="password" name="user_pass" id="user_pass"
							class="form-control" aria-label="Large"
							aria-describedby="inputGroup-sizing-sm" style="width: 100%"
							placeholder="패스워드를 입력해주세요." required /></li>
						<li><label for="password">패스워드 재확인</label></li>
						<li><input type="password" name="reUser_Pass"
							id="reUser_Pass" class="form-control" aria-label="Large"
							aria-describedby="inputGroup-sizing-sm" style="width: 100%"
							placeholder="위와 같은 패스워드를 다시 입력해주세요." required/></li>
						<li><div id="pw_check"></div></li>
						<li><label for="userEmail">이메일</label></li>
						<li><input type="email" name="user_email" id="user_email"
							class="form-control" aria-label="Large"
							aria-describedby="inputGroup-sizing-sm" style="width: 100%"
							placeholder="email을 입력해주세요." required/></li>

						<hr />

						<li style="text-align: center;"><a href="userLogin.do"
							class="signup-image-link">Are you "already" a member?</a></li>
						<li><input type="submit" id="signUp" value="회원가입"
							class="btn btn-info" /></li>
					</ul>

				</div>
			</form>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->

