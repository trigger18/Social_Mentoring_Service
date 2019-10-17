<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/mentor.css" type="text/css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<div class="section">
<!--멘토 답변 start -->
		<c:choose>
			<c:when test="${mCheck==1}">
				<div class="body">
					<h3>
						<i class="fa fa-paw" aria-hidden="true"></i> ${userDTO.user_name }님이 받은 질문
					</h3>
					<table class="table table-hover" id="question_table">
						<thead>
							<th>제목&emsp;&emsp;&emsp;&emsp;&emsp;</th>
							<th>작성자</th>
							<th>날짜</th>
							<!-- <th>질문 번호</th> -->
						</thead>
						<tbody>
							<c:forEach items="${questionList2}" var="qlist">
								<tr>
									<td><a
										href="question_view.do?question_num=${qlist.question_num}">
											${qlist.question_title}</a></td>
									<td>${qlist.user_name}</td>
									<td><fmt:formatDate pattern="yyyy/MM/dd" dateStyle="short"
											value="${qlist.question_date}" /></td>
									<%-- <td>${qlist.question_num}</td> --%>
								</tr>
							</c:forEach>
						</tbody>

					</table>
				</div>
			</c:when>
		</c:choose>
		<!--멘토 답변 end -->

		<hr />
		<div class="body">
			<h3>
				<i class="fa fa-paw" aria-hidden="true"></i> ${userDTO.user_name }님이 한 질문
			</h3>
			<table class="table table-hover" id="question_table">
				<thead>
					<th>제목&emsp;&emsp;&emsp;&emsp;&emsp;</th>
					<th>작성자</th>
					<th>날짜</th>
					<!-- <th>질문 번호</th> -->
				</thead>
				<tbody>
					<c:forEach items="${questionList}" var="qlist">
						<tr>
							<td><a
								href="question_view.do?question_num=${qlist.question_num}">
									${qlist.question_title}</a></td>
							<td>${qlist.user_name}</td>
							<td><fmt:formatDate pattern="yyyy/MM/dd" dateStyle="short"
									value="${qlist.question_date}" /></td>
							<%-- <td>${qlist.question_num}</td> --%>
						</tr>
					</c:forEach>
				</tbody>

			</table>
		</div>
	</div>
</body>
</html>