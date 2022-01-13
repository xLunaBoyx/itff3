<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page
	import="org.springframework.security.core.context.SecurityContext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/nav.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/footer.css" />

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/board/reviewList.css" />

<fmt:requestEncoding value="utf-8" />
<!-- 이거 없으면 이 밑에 jsp: -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="네티즌 리뷰" name="title" />
</jsp:include>

<!-- 메뉴 아래 nav? 영역입니다. nav 메뉴 가지고 있는 페이지는 전부 복사해주세요. -->
<div id="snb">
	<div class="container-xl">
		<ul class="list-inline snb_ul" id="snbul1">
			<li class="on_"><a
				href="${pageContext.request.contextPath }/notice/noticeList.do"
				target="_top">공지사항</a></li>
			<li class="on_"><a href="${pageContext.request.contextPath}/review/reviewList.do" target="_top">네티즌리뷰</a></li>
			<li class="on_"><a
				href="${pageContext.request.contextPath}/sharing/boardList.do"
				target="_top">티켓나눔터</a></li>
			<li class="on_"><a href="${pageContext.request.contextPath}/question/faq.do" target="_top">자주찾는 질문</a></li>
			<li class="on_"><a href="${pageContext.request.contextPath}/question/questionList.do" target="_top">1:1 문의</a></li>
		</ul>
	</div>
</div>
<!-- 여기까지 nav 입니다. -->


<section class="ink_board guest_mode" style="padding-bottom: 20px;">
<!-- 해당 페이지 큰 글씨 -->
<div class="sub_title_wrap">
	<div class="container">
		<h2 class="en">네티즌 리뷰</h2>
	</div>
</div> 
<!-- 여기까지 해당 페이지 큰 글씨입니다. -->
	<%-- <div class="bd_header">
		<h2 class="bd_title">
			<img src="${pageContext.request.contextPath}/resources/upload/board/리뷰게시판 타이틀 로고.png" alt="" />
			<a href="${pageContext.request.contextPath}/review/reviewList.do"></a>
		</h2>
	</div> --%>
	<div class="list_wrap">
		<div class="list_buttons">
			<div class="fix">
				<ul>
					<li>
						<a class="has_bubble" href = "${pageContext.request.contextPath}/review/reviewForm.do"><i class="fas fa-pen"></i></a>
						<span class="ink_bubble bubble_left">글쓰기</span>
					</li>
				</ul>
			</div>
		</div>
		<div class="ink_list ldn">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				summary="List of Articles">
				<thead>
					<!-- LIST HEADER -->
					<tr>
						<th class="no" scope="col">번호</th>
						<th scope="col" class="title">제목</th>
						<th scope="col">글쓴이</th>
						<th class="date" scope="col">날짜</th>
						<th class="extra_col" scope="col">조회수</th>
						<th class="extra_col" scope="col">추천수</th>
					</tr>
					<!-- /LIST HEADER -->
				</thead>
				<tbody class="">

					<!-- LIST -->
					<c:forEach items="${list}" var="review" varStatus="vs">
						<tr>
							<td class="no text_en">${review.reviewNo}</td>
							<td class="list_left list_title" style="display: flex;">
								<div class="article_type">
									<c:choose>
										<%-- 첨부파일 유무에 따라 다른 이미지 표시 --%>
										<c:when test="${review.attachCount eq 0}">
											<span><img src="${pageContext.request.contextPath}/resources/upload/board/첨부파일 없음.png" style="position: relative; top: 3px;" alt="" /></span>
										</c:when>
										<c:otherwise>
											<span><img src="${pageContext.request.contextPath}/resources/upload/board/첨부파일 있음.png" style="position: relative; top: 3px;" alt="" /></span>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="title_area">
									<sec:authorize access="isAuthenticated()">
										<c:set var="loginMemberId">
										    <sec:authentication property="principal.id"/>
										</c:set>
										<a href="${pageContext.request.contextPath}/review/reviewDetail.do?reviewNo=${review.reviewNo}&memberId=${loginMemberId}"
											class="title_link"> ${review.reviewTitle}
										</a>
									</sec:authorize>
									<sec:authorize access="isAnonymous()">
										<a href="${pageContext.request.contextPath}/review/reviewDetail.do?reviewNo=${review.reviewNo}"
											class="title_link"> ${review.reviewTitle}
										</a>
									</sec:authorize>
									<!-- 댓글수가 0이 아니면 글제목 옆에 댓글수 표시 -->
									<c:if test="${review.reviewCommentCount ne 0}">
										<a href="#" class="cmt_num updated">${review.reviewCommentCount}</a>
									</c:if>
								</div>
							</td>
							<td class="list_left list_author has_profile">
								<span class="inkpf round"><img class="inkpf_img small" src="${pageContext.request.contextPath}/resources/upload/member/${review.member.image}" alt=""></span> 
								<a href="#popup_menu_area" class="member_66300686" onclick="return false">${review.member.nickname}</a>
							</td>
							<td class="date text_en">
								<%-- 글 작성일 표시되는 방식을 오늘이면 시간, 오늘 아니면 날짜로 하려고 했는데 잘 안돼서 일단 보류 
									<jsp:useBean id="today" class="java.util.Date"></jsp:useBean>
									<fmt:parseNumber value="${today.time / (1000 * 60 * 60 * 24)}" var="nowDays" integerOnly="true" />      
									<fmt:parseNumber value="${review.regDate.time / (1000 * 60 * 60 * 24)}" var="regDays" integerOnly="true" />
									<c:set value="${nowDays - regDays }" var="dayDiff" />
									<c:set value="${nowDays - regDays }" var="dayDiff" />
									
									<span class="ink_time">
										<c:choose>
											<c:when test="${dayDiff == 0 }">
												<fmt:formatDate value="${review.regDate}" pattern="HH:mm:ss"/>
											</c:when>
											<c:otherwise>
										        <fmt:formatDate value="${review.regDate}" pattern="yyyy.MM.dd"/>
										    </c:otherwise>
				  						</c:choose>
					  				</span> --%>
								<span class="ink_time"><fmt:formatDate value="${review.regDate}" pattern="MM-dd"/></span>
								
							</td>
							<td class="extra_col text_en">
								<span>${review.readCount}</span>
							</td>
							<td class="extra_col text_en">
								<span>${review.recommend}</span>
							</td>
						</tr>
					</c:forEach>
					<!-- <tr>
						<td class="no text_en">53972</td>
						<td class="list_left list_title">
							<div class="article_type">
								<span class="list_icon2 image"></span>
							</div>
							<div class="title_area">
								<a href="/movietalk/71816953?category=61633579"
									class="title_link"> 킹스맨: 퍼스트 에이전트 짧은 후기 </a> <a
									href="/movietalk/71816953?category=61633579#comment"
									class="cmt_num updated">1</a>
							</div>
						</td>
						<td class="list_left list_author has_profile"><span
							class="inkpf round"></span> <a href="#popup_menu_area"
							class="member_56947472" onclick="return false"><img
								src="https://extmovie.com/modules/point/icons/xeicon_coa/10.gif"
								alt="[레벨:10]" title="포인트:10783point (94%), 레벨:10/99"
								class="xe_point_level_icon"
								style="vertical-align: middle; margin-right: 3px;">자구자구</a></td>
						<td class="date text_en"><span class="msover_date"><span
								class="ink_date">39분 전</span><span class="ink_time">00:31</span></span></td>
						<td class="extra_col text_en"><span>189</span></td>
					</tr>
				

					<!-- //LIST -->
				</tbody>
			</table>
		</div>
	
	</div>
	<div class="bt_area bt_left clearfix">
		<sec:authorize access="isAuthenticated()">
			<a class="ib ib2 ib_color bt_write" href="${pageContext.request.contextPath}/review/reviewForm.do" style="color: white"><i class="fas fa-pen"></i><span>글쓰기</span></a>
		</sec:authorize>	
	</div>
	<div class="ink_align_center"></div>
</section>

<!-- 페이지바 -->
<div class="pagebar_footer">
	${pagebar}
</div>

<!-- 검색바 -->
<div class="search_wrapper" style="width:352px">
	<form action="${pageContext.request.contextPath}/review/reviewSearch.do">
		<div class="board_search">
			<select class="search_select col" name="searchType" style="width:82px; padding-right: 5px; padding-left: 5px;">
	            <option value="title" ${"title".equals(searchType) || searchType eq null ? "selected" : ""}>제목</option>
	            <option value="content" ${"content".equals(searchType) ? "selected" : ""}>본문</option>
	            <option value="title_content" ${"title_content".equals(searchType) ? "selected" : ""}>제목+본문</option>
	            <option value="name" ${"name".equals(searchType) ? "selected" : ""}>글쓴이</option>
			</select>
	        <input type="text" class="search_input col" name="searchKeyword" value="${searchKeyword}" style="width: 210px;">
	        <button class="search_btn col" style="width: 55px;" onclick="return app.board_search()">검색</button>
		</div>
	</form>
</div>

<!-- 페이지 제일 위로 가는 버튼 -->
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>

<script>
//페이지 제일 위로 가는 버튼
//Get the button:
mybutton = document.getElementById("myBtn");

//When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
	if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	  mybutton.style.opacity = 1;
	} else {
	  mybutton.style.opacity = 0;
	}
}

//When the user clicks on the button, scroll to the top of the document
function topFunction() {
document.body.scrollTop = 0; // For Safari
document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
}
</script>


<!-- </body> -->



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>