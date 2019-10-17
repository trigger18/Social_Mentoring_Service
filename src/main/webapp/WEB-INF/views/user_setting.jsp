<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(function() {

		$('#saveUser').on('click', function() {
			alert("저장 되었습니다.");
			$('.form-inline').attr('action', 'userUpdate.do').submit();
		})
		
			$('#quit').on('click',function(){
			Swal.fire({
				  title: '모든 회원님 모든 정보가 사라집니다. 정말로 탈퇴 하시겠습니까?',
				  type: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '탈퇴!',
				}).then((result) => {
				  if (result.value) {
				    Swal.fire({
				    		position: 'center',
				    		  type: 'success',
				    		  title: '탈퇴가 성공적으로 되었습니다',
				    		  showConfirmButton: false,
				    		  timer: 2000
				    })
				  setTimeout(function(){ window.location.href="quitSMS.do"; }, 1500);
				  }
				})
		})

		$('#pictureUpload').on('click', function() {
			alert("picture");
			$('#user_image_filename').click();
		});

		$("#user_image_filename").on('change', function() {
			var str = $("#user_image_filename").val();
			console.log(str);
			// 이미지 첨부파일인지 체크
			var patt = /(.jpg$|.gif$|.png$)/gi;
			var result = str.match(patt);

			if (!result) {
				alert("jpg, gif, png만 가능합니다.");
				$('#user_image_filename').val('');
				return false;
			}
			// 첨부파일 사이즈 체크
			console.log(this.files + "," + this.files[0]);
			// if (this.files && this.files[0]) {

			console.log("size: " + this.files[0].size);
			if (this.files[0].size > 1000000000) {
				alert("1GB 이하만 첨부할수 있습니다.");
				$("#user_image_filename").val('');
				return false;
			}
			// }

			// 파일을 읽기 위한 fileReader 객체 생성.
			var reader = new FileReader();
			// file 내용을 읽어 dataURL형식의 문자열로 저장
			reader.readAsDataURL(this.files[0]);
			// 파일 읽어들이기를 성공했읋때 호출되는 이벤트 핸들러
			reader.onload = function(e) {
				// 이미지Tag의 src속성에 읽어들인 File내용을 지정
				$("#pic").attr('src', e.target.result);
			}

		});// end change
	});
</script>
<style type="text/css">
.settingbody {
	margin: auto;;
	width: 400px;
	height: 500px;
	padding: 5px;
}

.settingbody ul li {
	margin-top: 5px;
	margin-button: 5px;
}

.settingbody ul li input {
	width: 100%
}

.settingbody ul li label {
	text-align: left;
}

#btn {
	margin-top: 10px;
	margin-button: 10px;
}
</style>

<!-- section -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<form method="POST" class="form-inline" enctype="multipart/form-data">
				<div class="settingbody">
					<ul>
						<li><label for="userId">유저아이디</label></li>
						<li><input type="text" name="user_id" class="form-control"
							aria-label="Large" aria-describedby="inputGroup-sizing-sm"
							style="width: 100%" value="${userDTO.user_id}" readonly /></li>
						<li><label for="userName">이름</label></li>
						<li><input type="text" name="user_name" class="form-control"
							aria-label="Large" aria-describedby="inputGroup-sizing-sm"
							style="width: 100%" value="${userDTO.user_name}" /></li>
						<li><label for="userEmail">이메일</label></li>
						<li><input type="text" name="user_email" class="form-control"
							aria-label="Large" aria-describedby="inputGroup-sizing-sm"
							style="width: 100%" value="${userDTO.user_email}" /></li>
						<li><label for="userPhone">휴대폰 번호</label></li>
						<li><input type="text" name="user_phone" class="form-control"
							aria-label="Large" aria-describedby="inputGroup-sizing-sm"
							style="width: 100%" value="${userDTO.user_phone}" /></li>
						<li><button type="button" class="btn btn-default"
								id="pictureUpload" name="pictureUpload" style="float: left">
								<i class="fa fa-cog fa-spin"></i>사진 삽입
							</button> <input type="file" name="user_image_filename"
							id="user_image_filename" style="display: none" /></li>
						<c:choose>
							<c:when test="${userDTO.user_image != null}">
								<li><img src="/sms/temp/${userDTO.user_image}"
									class="img-thumbnail" id="pic" alt=""
									style="width: 100px; height: 100px; margin-left: 10px;"></li>
							</c:when>
							<c:otherwise>
								<li><img src="./img/userpicture.png" class="img-thumbnail"
									id="pic" alt=""
									style="width: 100px; height: 100px; margin-left: 10px;"></li>
							</c:otherwise>
						</c:choose>
						<li><input type="hidden" name="user_image" id="user_image"
							value="${userDTO.user_image}" /></li>
						<li><input type="button" id="saveUser" value="설정 저장하기"
							class="btn btn-danger" /></li>
						<li><button type="button" id="quit" name="guit"
								class="btn btn-light">회원 탈퇴</button></li>
					</ul>
				</div>
			</form>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->

