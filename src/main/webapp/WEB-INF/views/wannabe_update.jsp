<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style type="text/css">
.section {
	margin-left: 35%;
	width: 600px;
}

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
}

.w3-button {
	background: #fff;
	color: black 2px;;
	font-weight: bold;
	border: none;
	position: relative;
	height: 40px;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	border: 1px solid #d17acb;
}

.w3-button:hover {
	background: #d17acb;
	transition: 400ms ease all;
}

.item-checkbox {
	height: 100%;
	width: 190px;
	padding: 10px;
	display: inline-block;
}

.item-checkbox:hover {
	background: #ececa6;
	transition: 400ms ease all;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("input:text[numberOnly]").on("keyup", function() {
			$(this).val($(this).val().replace(/[^0-9]/g, ""));
		});

		$('.w3-button').on('click', function() {
			if ($("input:checkbox[name='field_num']").is(":checked") == false) {
				alert('멘토링 분야를 설정해주세요~');
				return false;
			} else {
				return true;
			}

		});
	});
</script>

<div class="section">
	<div class="w3-container w3-card-4">
		<div class="w3-center w3-large w3-margin-top">
			<h1 style="text-align: center">멘토정보 수정하기</h1>
		</div>
		<br />
		<br />
		<div>
			<form id="myForm" action="setmentor.do" method="POST">
				<div>
					<label>이름</label>
				</div>
				<div>
					<input class="w3-input" type="text" id="mentor_name"
						name="mentor_name" value="${userDTO.user_name}" required>
				</div>
				<br />
				<div>
					<label>회사명</label>
				</div>
				<div>
					<input class="w3-input" type="text" id="mentor_co" name="mentor_co"
						value="${MentorDTO.mentor_co}" required>
				</div>
				<br />
				<div>
					<label>부서</label>
				</div>
				<div>
					<input class="w3-input" type="text" id="mentor_dept"
						name="mentor_dept" value="${MentorDTO.mentor_dept}" required>
				</div>
				<br />
				<div>
					<label>직급</label>
				</div>
				<div>
					<input class="w3-input" type="text" id="mentor_level"
						name="mentor_level" value="${MentorDTO.mentor_level}" required>
				</div>
				<br />
				<div>
					<label>주요 경력</label>
				</div>
				<div>
					<label>멘토링 분야</label>
				</div>
				<br /> <label class="item-checkbox"> <input type="checkbox"
					name="field_num" value="1"> 직무&emsp;
				</label> <label class="item-checkbox"> <input type="checkbox"
					name="field_num" value="2">진로&emsp;
				</label> <label class="item-checkbox"> <input type="checkbox"
					name="field_num" value="3">스펙&emsp;
				</label> <label class="item-checkbox"> <input type="checkbox"
					name="field_num" value="4">외국어&emsp;
				</label> <label class="item-checkbox"> <input type="checkbox"
					name="field_num" value="5">면접/자소서&emsp;
				</label> <label class="item-checkbox"> <input type="checkbox"
					name="field_num" value="6">회사생활&emsp;
				</label> <label class="item-checkbox"> <input type="checkbox"
					name="field_num" value="7">창업&emsp;
				</label> <label class="item-checkbox"> <input type="checkbox"
					name="field_num" value="8">이직&emsp;
				</label> <label class="item-checkbox"> <input type="checkbox"
					name="field_num" value="9">기타&emsp;
				</label> <br /> <br />
				<div>
					<textarea class="w3-input" rows="10" cols="50" name="mentor_career"
						required>${MentorDTO.mentor_career}</textarea>
				</div>
				<br />

				<div>
					<label>멘토 소개</label>
				</div>
				<div>
					<textarea class="w3-input" rows="10" cols="50" name="mentor_info"
						required>${MentorDTO.mentor_info}</textarea>
				</div>
				<br />
				<div>
					<label>멘티에게 하고 싶은 말</label>
				</div>
				<div>
					<input class="w3-input" type="text" id="mentor_sub"
						name="mentor_sub" value="${MentorDTO.mentor_sub}" required>
				</div>
				<br /> <input class="hidden" type="text" id="mentor_sub"
					name="mentor_image" value="${userDTO.user_image }"> <input
					type="hidden" id="mentor_num" name="mentor_num"
					value="${MentorDTO.mentor_num}"> <input type="hidden"
					id="user_id" name="user_id" value="${MentorDTO.user_id}"> <br />

				<button type="submit" class="w3-button"
					style="position: relative; margin-left: 40%;">제출</button>
				<br />
				<br />
				<br />
			</form>
		</div>
	</div>
</div>