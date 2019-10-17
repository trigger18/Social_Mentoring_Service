<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(function() {
		$('#smslogin').on('click', function() {
			$('.form-inline').attr('action', 'home.do').submit();
		})
		var needMentor = $('#needMentor').val();
		var noUser = $('#noUser').val();
		console.log(needMentor);
		if(needMentor==1){
			Swal.fire({
				  position: 'center',
				  type: 'warning',
				  title: '로그인하셔야 맨토 정보를 볼수있어요!!',
				  showConfirmButton: false,
				  timer: 2000
				})
		}
		
		if(noUser==1){
			Swal.fire({
				  type: 'error',
				  title: '로그인을 할 수가 없습니다!',
				  text: 'Something went wrong!',
				  timer: 2000
				})
		}
		
	});
	

	(function(d, s, id) {
	    var js, fjs = d.getElementsByTagName(s)[0];
	    if (d.getElementById(id))
	        return;
	    js = d.createElement(s);
	    js.id = id;
	    js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v4.0&appId=1175138719340209";
	    fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));

	window.fbAsyncInit = function() {
	    FB.init({
	        appId : '{APPID}',
	        cookie : true,
	        xfbml : true,
	        version : 'v2.8'
	    });

	    FB.getLoginStatus(function(response) {
	        
	        console.log('statusChangeCallback');
	        console.log(response);

	        if (response.status === 'connected') {                    
	            $("#result").append("status : connected");
	        } else {
	            $("#result").append(response);
	        }
	    });
	};

	function fbLoginAction() {
	    FB.login(function(response) {
	        var fbname;
	        var accessToken = response.authResponse.accessToken;
	        FB.api('/me?fields=id,name,age_range,birthday,gender,email', function(response) {
	            var fb_data = jQuery.parseJSON(JSON.stringify(response));
			
	            window.location.href='fblogin.do?name='+fb_data.name+'&email='+fb_data.email;
	        });
	        
	    }, {scope: 'public_profile, email'});
	}

</script>

<style type="text/css">
.logbody {
	margin: auto;
	width: 400px;
	height: auto;
	padding: 15px;
	border: 0.5px solid #c1d1eb;
	border-radius: 10px;
}

.logbody ul li input {
	width: 100%;
	margin-bottom: 10px;
}

.logbody ul li label {
	text-align: left;
}

#btn {
	margin-top: 10px;
	margin-button: 10px;
}

#login_btn {
	padding-bottom: 10px;
	width: 100%;
	margin-bottom: 10px;
	height: 50px;
}

span {
	color: red;
	font-style: bold;
}
}
</style>

<!-- section -->
<div class="section" style="margin-bottom: 100px;">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<form method="POST" class="form-inline">
				<div class="logbody">
					<ul>
						<li id="naver_id_login" style="text-align: center"><a
							href="${url}"><input type="button" id="login"
								value="네이버 아이디로 로그인" class="btn btn-success" /> </a></li>
						<li id="kakao_id_login" style="text-align: center"><a
							href="https://kauth.kakao.com/oauth/authorize?client_id=e125bfc102f60cc43e9ffab343755532&redirect_uri
							=http://192.168.30.87:8090/sms/kakao.do&response_type=code"><input
								type="button" id="login" value="카카오 아이디로 로그인"
								class="btn btn-warning" /> </a></li>
						<li id="google_id_login" style="text-align: center"><a
							href="${google_url}"><input type="button" id="login"
								value="구글 아이디로 로그인" class="btn btn-danger" /> </a></li>
						<li id="facebook_id_login" style="text-align: center">
						<input  class=" btn btn-primary"type="button" id="fb"  onclick="fbLoginAction();" value="페이스북 아이디 로그인"/>
							</li>
						<hr />
						<li><label for="userId">유저아이디</label></li>
						<li><input type="text" name="user_id" class="form-control"
							aria-label="Large" aria-describedby="inputGroup-sizing-sm"
							style="width: 100%" placeholder="아이디를  입력해주세요." /></li>
						<li>
							<div id="id_check"></div>
						</li>
						<li><label for="password">패스워드</label></li>
						<li><input type="password" name="user_pass"
							class="form-control" aria-label="Large"
							aria-describedby="inputGroup-sizing-sm" style="width: 100%"
							placeholder="패스워드를 입력해주세요." /></li>
						<div>
							<c:choose>
								<c:when test="${noUser==1  }">
									<span>아이디 또는 비밀번호를 다시 확인하세요. <br />등록되지 않은 아이디이거나, 아이디
										또는 비밀번호를 잘못 입력하셨습니다.
									</span>
								</c:when>
							</c:choose>
						</div>
						<li style="text-align: center;"><a href="signUp.do"
							class="signup-image-link">Are you "Not" a member?</a></li>
						<li><input type="button" id="smslogin" value="로그인"
							class="btn btn-info" /></li>
					</ul>
						<input type="hidden" id="needMentor" value="${needMentor }"/>
						<input type="hidden" id="noUser" value="${noUser }"/>
				</div>
			</form>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->

