<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Noto+Sans+KR|Song+Myung&display=swap" rel="stylesheet">
<style>
<!--

#img {
	height: auto;
	max-width: 403px;
}

.divimg {
	height: 170px;
	overflow: hidden;
}

.divlist {
	overflow: hidden;
	border: 1px solid #e0ebeb;
	max-width: 403px;
	height: 420px;
	margin: 13px;
	display: inline-block;
}

.divlist:hover {
	padding: 0.2%;
	box-shadow: 2px 1px 18px #d9d9f2;
}


.summary {
	height: 120px;
	width:400px;
	padding: 10px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: inherit;
}

/* paging */

.pagelist {
   margin-left:76%;
}
.pagelist .pagination .pagecolor:hover {
   background-color: #F5A9F2;
}

-->
</style>

<!-- section -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<div class="section-title">
					<h2><i class="fa fa-pencil" aria-hidden="true"></i> ESSAY</h2>
				</div>
			</div>
			<!--////////////////////////////////////////              여기 부터                       //////////////////////////////////////-->
			<!-- post -->
			<c:forEach items="${e_list }" var="dto">
				<div class="divlist">
					<div class="post">
						<c:url var="path" value="essay_view.do">
							<c:param name="currentPage" value="${pv.currentPage }" />
							<c:param name="essay_num" value="${dto.essay_num }" />
							<c:param name="mentor_num" value="${dto.mentor_num }" />
						</c:url>
						<div class="divimg">
							<a class="post-img" href="${path }"><img id="img"
								src="/sms/temp/${dto.essay_img }" alt="#"></a>
						</div>
						<div class="post-body">
							<div class="post-meta" style="text-align:right;">
								Date: <span class="date" style="text-align: right; margin-right: 12px">${date }</span>
							</div>
							<hr/>
							<h3 class="post-title"
								style="padding-left: 10px; padding-right: 10px">
								<a href="${path }" style="text-decoration: none; font-family: 'Noto Sans KR', sans-serif;">${dto.essay_subject }</a>
							</h3>
							<p></p>
							<div class="summary">
								<a href="${path }" style="text-decoration: none; font-family: 'Song Myung', serif;">${dto.essay_summary }</a>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->
<!-- 페이지 번호 -->
   <div class="pagelist">
            <!-- 이전 출력 시작 -->
            <c:if test="${pv.startPage > 1 }">
               <ul class="pagination">
                  <li><a class="pagecolor"
                     href="essay_list.do?currentPage=${pv.startPage-pv.blockPage }">이전</a></li>
               </ul>
            </c:if>
            <!-- 이전 출력 끝 -->
            <!-- 페이지 출력 시작 -->
            <c:forEach var="i" begin="${pv.startPage }" end="${pv.endPage }">

               <span> <c:url var="currPage" value="essay_list.do">
                     <c:param name="currentPage" value="${i }" />
                  </c:url> <c:choose>
                     <c:when test="${i == pv.currentPage }">
                        <ul class="pagination">
                           <li><a href="${currPage }" class="pagecolor"> <c:out
                                    value="${i }" />
                           </a></li>
                        </ul>
                     </c:when>
                     <c:otherwise>
                     <ul class="pagination">
                        <li><a href="${currPage }" class="pagecolor"> <c:out value="${i }" />
                        </a></li>
                        </ul>
                     </c:otherwise>
                  </c:choose>
               </span>
            </c:forEach>
            <!-- 페이지 출력 끝 -->
            <!-- 다음 출력 시작 -->
            <c:if test="${pv.totalPage > pv.endPage }">
               <ul class="pagination">
                  <li><a class="pagecolor"
                     href="essay_list.do?currentPage=${pv.startPage+pv.blockPage }">다음</a></li>
               </ul>
            </c:if>
            <!-- 다음 출력 끝 -->
         </div>
         <!-- /페이지 번호 -->

         <div class="clearfix visible-md visible-lg"></div>
         <c:choose>
            <c:when test="${CheckMentor==1}">
               <button id="w_btn" onclick="location.href='essay_write.do'"
                  class="primary-button center-block">글쓰기</button>
            </c:when>
         </c:choose>
<!-- /페이지 번호 -->