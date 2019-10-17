<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
.w3-input {
	width: 100%;
	resize: none;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	transition: 1.5s;
	width: 600px;
}

#img {
	/*  visibility: hidden; */
	height: 300px;
	max-width: 600px;
}

.primary-button {
	display: inline-block;
	text-align: center;
}

.section {
	margin-left: 0%;
}

.container {
	display: flex;
	flex-direction: row;
}

#author {
	position: absolute;
	width: 500px;
	height: 400px;
	top: 420px;
	background-color: transparent;
	color: #212631;
}

.field-chip {
	display: inline-block;
	font-size: 13px;
	text-transform: uppercase;
	padding: 3px 10px;
	font-weight: 600;
	border-radius: 2px;
	margin-right: 5px;
	margin-bottom: 5px;
	color: #FFF;
	background-color: #ff8700;
	-webkit-transition: 0.2s opacity;
	transition: 0.2s opacity
}

#author_border {
	border: 1px solid #ccc;
	border-radius: 10px;
	padding: 20px;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {

		$('#pictureUpload').on('click', function() {
			alert("picture");
			$('#essay_img').click();
		});

		floatB();
		//첨부파일 용량체크
		$('#essay_img').on('change', function() {
			if (this.files && this.files[0]) {
				if (this.files[0].size > 10000000) {
					alert("10MB바이트 이하만 첨부할 수 있습니다.");
					$('#essay_img').val('');
					return false;
				}
			}
		});

		//업로드시 이미지 보기
		$("#essay_img").change(function() {
			imgFileCheck();
			readURL(this);
		});

	});

	//업로드시 이미지 보기
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#img').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	//이미지 확장자 체크
	function imgFileCheck() {
		var imgFormat = "\.(bmp|gif|jpg|jpeg|png)";
		if (!(new RegExp(imgFormat, "i")).test(document.frm.essay_img.value)) {
			alert("이미지 파일만 등록 가능합니다");
			$('#essay_img').val('');
			return;
		}
	}

	function floatB() {
		// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
		var floatPosition = parseInt($("#author").css('top'));
		// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

		$(window).scroll(function() {
			// 현재 스크롤 위치를 가져온다.
			var scrollTop = $(window).scrollTop();
			var newPosition = scrollTop + floatPosition - 300;
			if (newPosition <= 393) {
				newPosition = 420;
			}
			$("#author").stop().animate({
				"top" : newPosition + "px"
			}, 0);
		}).scroll();

	}
</script>



<!-- section -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row" style="width: 70%;">
			<div class="col-md-5 col-md-offset-1">
				<div class="section-row">
					<h3>Essay Update</h3>
					<form class="frm" name="frm" method="post"
						enctype="multipart/form-data" action="essay_update.do">
						<div class="row">
							<div class="col-md-7">
								<div class="form-group">
									<span>Subject</span> <input class="w3-input" type="text"
										name="essay_subject" id="essay_subject"
										value="${essayDTO.essay_subject}">
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group ">
									<span>Image</span><br /> <span class="w3-input"
										style="height: 300px; text-align: center"><img id="img"
										src="/sms/temp/${essayDTO.essay_img }"
										style="max-height: 270px" /> </span> <input style="display: none"
										type="file" id="essay_img" name="filepath" />
								</div>

								<p></p>
								<div class="form-group">
									<span>
										<button type="button" class="primary-button center-block"
											id="pictureUpload" name="pictureUpload" style="float: left">
											<i class="fa fa-cog fa-spin"></i>사진 삽입
										</button>
									</span><br /> <br /> <span>Summary</span>
									<textarea class="w3-input" rows="10" cols="40"
										id="essay_summary" name="essay_summary" placeholder="">${essayDTO.essay_summary}</textarea>
								</div>
								<div class="form-group">
									<span>Content</span>
									<textarea class="w3-input" rows="10" cols="50"
										id="essay_content" name="essay_content" placeholder="">${essayDTO.essay_content}</textarea>
								</div>
								<input type="hidden" name="essay_num" id="essay_num"
									value="${essayDTO.essay_num}" /> <input type="hidden"
									name="currentPage" id="currentPage" value="${currentPage}" />
								<input type="hidden" id="mentor_num" name="mentor_num"
									value="${essayDTO.mentor_num}" />
								<button class="primary-button center-block" id="submit">Submit</button>
								<a href="essay_list.do"><input type="button"
									class="primary-button center-block"
									onclick="location.replace()='essay_list.do'" value="list"></a>

							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- /row -->
		<!-- author -->
		<div class="section-row"
			style="border-left: 2px dotted #ccc; padding-left: 63px;">
			<div id="author">
				<div id="author_border">
					<div class="post-author" style="width: 78%">

						<div class="media">
							<div class="media-left">
								<c:choose>
									<c:when test="${not empty mentorDTO.mentor_image }">
										<a href="mentor_view.do?num=${mentorDTO.mentor_num}" style="text-decoration: none;">
                             				 <img class="media-object" src="/sms/temp/${mentorDTO.mentor_image}" alt="" style="height: 120px">
                           			   </a>
									</c:when>
									<c:otherwise>
									<img class="media-object"
											src="./img/userpicture.png" alt=""
											style="height: 120px">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="media-body">
								<div class="media-heading">
									<h3>${mentorDTO.mentor_name}</h3>
								</div>
								<div id="mentorSub">${mentorDTO.mentor_sub}</div>

								<hr />
								<h6>맨토링 분야</h6>
								<ul>
									<c:forEach items="${fieldDTO}" var="flist">
										<li class="field-chip">${flist.field_name}</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- author -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->