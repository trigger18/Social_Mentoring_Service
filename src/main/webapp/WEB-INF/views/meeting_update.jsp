<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(function() {
		$('#meeting_price').keypress(function (event) { 
			if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) { event.preventDefault(); } 
			});
		
		$('#pictureUpload').on('click', function() {
			alert("picture");
			$('#meeting_file').click();
		});
		
		$(".form-control").on('change', function() {
			var str = $("#meeting_file").val();
			console.log(str);
			// 이미지 첨부파일인지 체크
			var patt = /(.jpg$|.gif$|.png$)/gi;
			var result = str.match(patt);

			if (str =="") {
            }else if(!result){
               alert("jpg, gif, png만 가능합니다.");
               $('#meeting_file').val('');
               return false;
               
            }
			
			// 첨부파일 사이즈 체크
			console.log(this.files + "," + this.files[0]);
			// if (this.files && this.files[0]) {

			console.log("size: " + this.files[0].size);
			if (this.files[0].size > 1000000000) {
				alert("1GB 이하만 첨부할수 있습니다.");
				$("#meeting_file").val('');
				return false;
			}

			// 파일을 읽기 위한 fileReader 객체 생성.
			var reader = new FileReader();
			// file 내용을 읽어 dataURL형식의 문자열로 저장
			reader.readAsDataURL(this.files[0]);
			// 파일 읽어들이기를 성공했읋때 호출되는 이벤트 핸들러
			reader.onload = function(e) {
				// 이미지Tag의 src속성에 읽어들인 File내용을 지정
				$("#foo").attr('src', e.target.result);
			}

		});// end change
	});
	
</script>
<style type="text/css">
.mewiret {
	width: 10%;
	margin: 0 auto;
	margin-top: 30px;
}

#body {
	width: 30%;
	margin: 0 auto;
	margin-top: 20px;
}

#body .name {
	margin: 0 auto;
}

.m_name #foo {
	float: right;
	position: relative;
	margin-top: -50px;
}

.m_name #address {
	float: right;
}

#body  .btn_1 {
	width: 100px;
    padding: 10px;
	border: none;
	background-color: #9F81F7;
	font-weight: 600;
	text-transform: uppercase;
	font-size: 13px;
	color: #FFFFFF;
	-webkit-transition: 0.2s opacity;
	transition: 0.2s opacity;
	margin-top: 10px;
	border-radius:10px;
}

#body .btn {
	width: 100%;
	margin: 0 auto;
	border: none;
	background-color: #9F81F7;
	font-weight: 600;
	text-transform: uppercase;
	font-size: 13px;
	color: #FFFFFF;
	margin-top: 10px;
}

#bt_1:hover {
	color: #000;
}

#bt:hover {
	color: #000;
}

#address:hover {
	color: #000;
}
#picuture {
	
}

</style>
<!-- body -->
<h3 class="mewiret text-center">모임글 수정</h3>
<form id="body" name="frm" class="meeting" action="meeting_update.do"
	method="post" enctype="multipart/form-data">
	<input type="hidden" name="meeting_num" value="${meeting.meeting_num}">
	<img id="foo" src="/sms/temp/${meeting.meeting_img_name}"
		style="width: 100%; height: 300px;border-radius:10px">
	<div class="m_name">
		<label for="meeting">이미지</label>
		<button type="button" class="btn_1" id="pictureUpload"
			name="pictureUpload" style="float: right">
			<i class="fa fa-cog fa-spin"></i>사진 삽입
		</button>
		<input class="form-control" type="file" name="meeting_file"
			id="meeting_file" style="width: 220px; display: none" />
	</div>
	<br />
	<div class="m_name">
		<label for="meeting">모임명</label> <input type="text"
			name="meeting_title" class="form-control" id="meeting_title"
			value="${meeting.meeting_title}">
	</div>
	<br />
	<div class="m_name">
		<label for="meeting">소개글</label> <input type="text"
			name="meeting_introduction" class="form-control"
			id="meeting_introduction" value="${meeting.meeting_introduction}">
	</div>
	<br />
	<div class="m_name">
		<label for="meeting">날짜 와 시간</label> <input class="form-control"
			id="meeting_date" name="meeting_date" type=datetime-local
			value="${meeting.meeting_date}" />
	</div>
	<br>
	<div class="m_name">
		<label for="meeting">장소명</label> <input type="text"
			name="meeting_place" class="form-control" id="meeting_place"
			value="${meeting.meeting_place}">
	</div>
	<br />
	<div class="m_name">
		<label for="meeting">인원수(명)</label> <input type="number"
			name="meeting_recruitment" class="form-control" min=""
			id="meeting_recruitment" value="${meeting.meeting_recruitment}">
	</div>
	<br />
	<div class="m_name">
		<label for="meeting">주소</label> <input type="text"
			class="form-control" id="meeting_address" name="meeting_address"
			value="${meeting.meeting_address }">
		<button class="btn_1" onclick="sample5_execDaumPostcode()"
			id="address">
			<i class="fa fa-search" aria-hidden="true"></i> 주소 검색
		</button>
		<br>
	</div>
	<br />

	<div class="m_name">
		<label for="meeting">참가비(원)</label> <input type="text"
			name="meeting_price" class="form-control" id="meeting_price"
			value="${meeting.meeting_price}">
	</div>
	<br />
	<div class="m_name">
		<label for="meeting">프로그램 내용</label>
		<textarea class="form-control" id="meeting_comment"
			name="meeting_comment" rows="13" cols="40" style="resize: none;">${meeting.meeting_comment}</textarea>
	</div>
	<br />
	<button id="bt" type="submit" class="btn">
		<i class="fa fa-refresh" aria-hidden="true"></i> 수정완료
	</button>
	<br> <a class="bt_1" href="list.do"><button id="bt_1"
			type="button" class="btn btn-success" style="font-weight: bold;">
			<i class="fa fa-sign-out" aria-hidden="true"></i> 이전페이지
		</button></a>
</form>
<!-- /body -->

<script>
		function sample5_execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					var addr = data.address; // 최종 주소 변수

					// 주소 정보를 해당 필드에 넣는다.
					document.getElementById("meeting_address").value = addr;
					// 주소로 상세 정보를 검색
					geocoder.addressSearch(data.address, function(results,
							status) {
						// 정상적으로 검색이 완료됐으면
						if (status === daum.maps.services.Status.OK) {

							var result = results[0]; //첫번째 결과의 값을 활용

							// 해당 주소에 대한 좌표를 받아서
							var coords = new daum.maps.LatLng(result.y,
									result.x);
							// 지도를 보여준다.
							mapContainer.style.display = "block";
							map.relayout();
							// 지도 중심을 변경한다.
							map.setCenter(coords);
							// 마커를 결과값으로 받은 위치로 옮긴다.
							marker.setPosition(coords)
						}
					});
				}
			}).open();
			
			
		}
	</script>

