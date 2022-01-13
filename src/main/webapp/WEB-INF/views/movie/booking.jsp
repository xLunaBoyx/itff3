<%@page import="com.kh.spring.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page	import="org.springframework.security.core.context.SecurityContext"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<fmt:requestEncoding value="utf-8" />	<!-- 이거 없으면 이 밑에 jsp: -->

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/nav.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/movie/booking.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="영화 예매" name="title"/>   
</jsp:include>


<!-- 메뉴 아래 nav? 영역입니다. nav 메뉴 가지고 있는 페이지는 전부 복사해주세요. -->
<div id="snb">
	<div class="container-xl">
		<ul class="list-inline snb_ul" id="snbul1">
			<li class="on_">
				<a href="${pageContext.request.contextPath}/movie/booking.do" target="_top" style="font-weight: bold;">빠른예매</a>
			</li>	
			<li class="on_">
				<a href="${pageContext.request.contextPath}/schedule/day1.do" target="_top">상영시간표</a>
			</li>
		</ul>
	</div>
</div>
<!-- 여기까지 nav 입니다. -->

<!-- 코드 한줄로 되어있는건 ctrl shift f 누르면 펴진다. -->

<div id="contents" class="contents_full contents_reserve">
	<div class="wrap_reserve" id="wrap1">	
		<h2 class="hidden">예매하기</h2>
		<div class="section_step_tit">
			<ul>
				<li class="active step01" id="step01">
					<a style="cursor: default;"> 
						<strong class="tit" style="font-weight: normal;"><span>01</span><br>상영시간</strong>
						<div class="bx_con step01">
							<dl>
								<dt>선택한 영화 제목</dt>
								<dd id="bx_step01_title"></dd>
								<dt>선택한 상영관</dt>
								<dd id="bx_step01_theater"></dd>
								<dt>선택한 상영 날짜</dt>
								<dd id="bx_step01_startDate"></dd>
								<dt>선택한 시간</dt>
								<dd id="bx_step01_startTime"></dd>
							</dl>
						</div>

							
					</a>
				</li>
				<li class="disabled step02" id="step02">
					<a style="cursor: default;"> 
						<strong class="tit" style="font-weight: normal;"><span>02</span><br>인원/좌석</strong>
						<div class="bx_con step02">
							<dl>
								<dt>선택한 인원</dt>
								<dd id="bx_step02_count"></dd>
								<dt>선택한 좌석</dt>
								<dd id="bx_step02_seats"></dd>
							</dl>
						</div>
				
					</a>
				</li>
				<li class="disabled step03" id="step03">
					<a style="cursor: default;"> 
						<strong	class="tit" style="font-weight: normal;"><span>03</span><br>결제</strong>
						<div class="bx_con step03">
							<dl>
								<dt>티켓금액</dt>
								<dd>10,000원</dd>
								<dt>할인금액</dt>
								<dd>0원</dd>
								<dt>총합계</dt>
								<dd>10,000원</dd>
							</dl>
						</div>
					</a>
				</li>
				<li class="disabled step04" id="step04">
					<a style="cursor: default;">
						<strong	class="tit" style="font-weight: normal;"> <span>04</span><br>결제완료</strong> 
					</a>
				</li>
			</ul>
		</div>
		<div id="reserveStep01" class="section_step_con step01 active" style="position: absolute;">
			<h3 class="hidden">상영시간</h3>

			<!-- 상영관 정보 자리에 영화정보 넣음 -->
			<div class="article article_sum_infor" style="width: 351px">
				<div class="group_top">
					<h4 class="tit" style="position: relative; top: 16px;">영화 정보</h4>
				</div>
				<div class="inner" id="movieInfo">
					<c:if test="${oneMovie ne null}">
						<div class="movie_infor new2020" style="border-bottom: 0">
							<span class="thm">
								<img src="${pageContext.request.contextPath}/resources/upload/poster/${oneMovie.image}" alt="" style="width: 250px;">
							</span>
							<strong class="tit" style="margin-left: 0">
								<span class="ic_grade gr_${oneMovie.ageLimit}" style="position: relative; bottom: 2px;"></span>&nbsp;${oneMovie.titleKor}
							</strong>
							<dl class="dlist_infor" style="margin-left: 0; line-height: 20px;">
								<dt>개봉일</dt>
								<dd style="left: 30px;"><fmt:formatDate value="${oneMovie.openingDate}" pattern="yyyy-MM-dd"/></dd>
								<dt>감독</dt>
								<dd style="left: 30px;">${oneMovie.director}</dd>
								<dt>출연</dt>
								<dd style="left: 30px; width: 240px;">${oneMovie.actors}</dd>
								<dt>장르</dt>
								<dd style="left: 30px;">${oneMovie.genre}</dd>
								<dt>상영시간</dt>
								<dd>${oneMovie.runningTime}</dd>
								<dt>시놉시스</dt>
								<dd style="width: 238px;" id="synopsis">${oneMovie.description}</dd>
								<dt></dt>
								<dd style="margin-left: 11px;"><a href="<%-- ${pageContext.request.contextPath}/program/synopsis/eagleEye.do?movieId=002 --%>">더보기</a></dd>
							</dl>
						</div>
					</c:if>
				</div>
			</div>
			
			

			<div class="article article_movie">
				<div class="group_top">
					<h4 class="tit movie_name" style="position: relative; top: 16px;">영화 선택</h4>
					<div id="movie_name_test">1</div>
				</div>
				<div class="inner">
					<div class="list_filter">
						<select title="영화 정렬 방법 선택"><option value="A">예매순</option>
							<option value="B">관객순</option>
							<option value="C">평점순</option>
							<option value="D">예정작</option></select>
						<div class="bx_btn_view">
							<span class="hidden">목록 보기 방식</span>
							<ul>
								<li><button type="button"
										class="btn_view_txt viewTxt active">텍스트형</button></li>
								<li><button type="button" class="btn_view_thm viewThm">썸네일형</button></li>
							</ul>
						</div>
					</div>
					<div class="movie_select_wrap list movieSelect">
						<div class="mCustomScrollbar movieScroll _mCS_9 mCS-autoHide"
							data-mcs-theme="minimal-dark"
							style="position: relative; overflow: visible;">
							<div id="mCSB_9"
								class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
								style="max-height: none; overflow: auto;" tabindex="0">
								<div id="mCSB_9_container" class="mCSB_container"
									style="position: relative; left: 0px;" dir="ltr">
									<ul>
																									
										<c:forEach items="${totalMovieList}" var="movie" varStatus="vs">
											<!-- 영화 아이디가 전달되었을 경우 페이지 로드시 해당 영화가 선택되어있게 함 -->
											<li class="movieList ${oneMovie.movieId eq movie.movieId ? 'active' : ''}" data-id="${movie.movieId}" data-title="${movie.titleKor}">
												<a href="#none" class="moviearea" <%-- onclick="movieTitle('${movie.movieId}');" --%>>
													<div class="bx_thm" style="float: left;">
														<span class="rank">
															<span class="hidden">순위</span>
															<strong>${vs.count}</strong>
														</span>
														<img
															src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202112/17857_101_1.jpg"
															alt="포스터" class="mCS_img_loaded">
													</div>
													<div class="group_infor" style="float: left;">
														<div class="bx_tit">
															<span class="ic_grade gr_${movie.ageLimit}">${movie.ageLimit}</span>
															<strong	class="tit">${movie.titleKor}</strong>
														</div>
														<dl>
															<!-- <dt>예매율</dt>
															<dd>
																<strong>52.8%</strong>
															</dd>
															<dt class="side">
																<span class="txt_ic_score ty1"><em>평점</em></span>
															</dt>
															<dd>
																<span class="txt_ic_score ty1"><strong>9.1</strong></span>
															</dd> -->
															<dt>개봉일</dt>
															<dd><fmt:formatDate value="${movie.openingDate}" pattern="yyyy-MM-dd"/></dd>
															<!-- <dt class="side day">d -day</dt>
															<dd>
																<strong class="expired"></strong>
															</dd> -->
														</dl>
													</div>
												</a>
											</li>
										</c:forEach>
										<!-- <li class=""><a href="#none"><div class="bx_thm">
													<span class="rank"><span class="hidden">순위</span><strong>2</strong></span><img
														src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202002/15011_101_1.jpg"
														alt="포스터" class="mCS_img_loaded">
												</div>
												<div class="group_infor">
													<div class="bx_tit">
														<span class="ic_grade gr_18">18세 관람가</span><strong
															class="tit">킹스맨: 퍼스트 에이전트</strong>
													</div>
													<dl>
														<dt>예매율</dt>
														<dd>
															<strong>13.9%</strong>
														</dd>
														<dt class="side">
															<span class="txt_ic_score ty1"><em>평점</em></span>
														</dt>
														<dd>
															<span class="txt_ic_score ty1"><strong>8.2</strong></span>
														</dd>
														<dt>개봉일</dt>
														<dd>2021.12.22</dd>
														<dt class="side day">d -day</dt>
														<dd>
															<strong class="expired"></strong>
														</dd>
													</dl>
												</div></a></li> -->
										
									</ul>
								</div>
							</div>
							<div id="mCSB_9_scrollbar_vertical"
								class="mCSB_scrollTools mCSB_9_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical"
								style="display: block;">
								<div class="mCSB_draggerContainer">
									<div id="mCSB_9_dragger_vertical" class="mCSB_dragger"
										style="position: absolute; min-height: 50px; display: block; height: 395px; max-height: 720px; top: 107px;">
										<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
									</div>
									<div class="mCSB_draggerRail"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="article article_time">
				<div class="group_top">
					<h4 class="tit" id="date" style="position: relative; top: 16px;">2022-01-07(월)</h4>
				</div>
				<div class="inner">
					<div class="date_select_wrap dateReserveWrap">
						<div class="slide_wrap slide_reserve_date">
							<ul class="owl-carousel owl-loaded owl-drag">
								<div class="owl-stage-outer">
									<div class="owl-stage"
										style="transform: translate3d(0px, 0px, 0px); transition: all 0.5s ease 0s; width: 735px;">
										<div class="owl-item active" style="width: 52.5px;">
											<li class="item">
												<strong class="month">1월</strong>
												<span class="date">
													<label>
														<input
															type="radio" 
															name="radioDate1" 
															data-displayyn="N"
															data-playdate="2022-01-07" 
															data-isplaydate="Y"
															data-playweek="금"
															${playdate eq '2022-01-07' ? 'checked' : ''}>
														<strong>7</strong>
														<em>금</em>
													</label>
												</span>
											</li>
										</div>
										
										
										
										
										
										<div class="owl-item active" style="width: 52.5px;">
											<li class="item">
												<span class="date sun">
													<label>
														<input
															type="radio" 
															name="radioDate1" 
															data-displayyn="Y"
															data-playdate="2022-01-08" 
															data-isplaydate="Y"
															data-playweek="토"
															${playdate eq '2022-01-08' ? 'checked' : ''}>
														<strong>8</strong>
														<em>토</em>
													</label>
												</span>
											</li>
										</div>
										<div class="owl-item active" style="width: 52.5px;">
											<li class="item">
													<span class="date sun">
														<label>
															<input type="radio"
																name="radioDate1" 
																data-displayyn="Y"
																data-playdate="2022-01-09" 
																data-isplaydate="Y"
																data-playweek="일" 
																${playdate eq '2022-01-09' ? 'checked' : ''}>
															<strong>9</strong>
															<em>일</em>
														</label>
													</span>
												</li>
										</div>
										<div class="owl-item active" style="width: 52.5px;">
											<li class="item"><span class="date"><label><input
														type="radio" name="radioDate1" data-displayyn="Y"
														data-playdate="2022-01-10" data-isplaydate="Y"
														data-playweek="월" ${playdate eq '2022-01-10' ? 'checked' : ''}><strong>10</strong><em>월</em></label></span></li>
										</div>
										<div class="owl-item active" style="width: 52.5px;">
											<li class="item"><span class="date"><label><input
														type="radio" name="radioDate1" data-displayyn="Y"
														data-playdate="2022-01-11" data-isplaydate="Y"
														data-playweek="화" ${playdate eq '2022-01-11' ? 'checked' : ''}><strong>11</strong><em>화</em></label></span></li>
										</div>
										<div class="owl-item active" style="width: 52.5px;">
											<li class="item"><span class="date"><label><input
														type="radio" name="radioDate1" data-displayyn="Y"
														data-playdate="2022-01-12" data-isplaydate="Y"
														data-playweek="수" ${playdate eq '2022-01-12' ? 'checked' : ''}><strong>12</strong><em>수</em></label></span></li>
										</div>
										<div class="owl-item active" style="width: 52.5px;">
											<li class="item"><span class="date"><label><input
														type="radio" name="radioDate1" data-displayyn="Y"
														data-playdate="2022-01-13" data-isplaydate="Y"
														data-playweek="목" ${playdate eq '2022-01-13' ? 'checked' : ''}><strong>13</strong><em>목</em></label></span></li>
										</div>
										<div class="owl-item active" style="width: 52.5px;">
											<li class="item"><span class="date"><label>
														<input type="radio" name="radioDate1" data-displayyn="Y"
														data-playdate="2022-01-14" data-isplaydate="Y"
														data-playweek="금" ${playdate eq '2022-01-14' ? 'checked' : ''}><strong>14</strong><em>금</em>
												</label></span></li>
										</div>
										
									</div>
								</div>
								<div class="owl-nav">
									<button type="button" role="presentation"
										class="owl-prev disabled">
										<span aria-label="Previous">‹</span>
									</button>
									<button type="button" role="presentation" class="owl-next">
										<span aria-label="Next">›</span>
									</button>
								</div>
								<div class="owl-dots disabled"></div>
							</ul>
						</div>
					</div>
					<ul class="tab_wrap outer sml">
						<li class="active">
							<button type="button" class="tab_tit"
								style="width: 16.6667%; left: 0%;">
								<span>상영일정</span>
							</button>
							<div class="tab_con ty5">
								<h5 class="hidden">상영일정</h5>
								<div class="timeScroll mCustomScrollbar _mCS_71 mCS-autoHide"
									data-mcs-theme="minimal-dark"
									style="position: relative; overflow: visible;">
									<div id="mCSB_71"
										class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
										style="max-height: none; overflow: auto;" tabindex="0">
										
										<!-- 상영시간표가 나오는 공간. ajax로 채우는 공간이지만 상영시간표 페이지에서 선택해서 들어오거나 하는 경우를 위해서 내용을 채워둠 -->
										<div id="mCSB_71_container" class="mCSB_container"
											style="position: relative; top: 0; left: 0; border-top: 1px solid grey;" dir="ltr">
											
											<!-- 조회결과가 없을 때 나오는 화면 -->
											<c:if test="${list eq null}">
												<div class="bx_notice"><p>조회 가능한 상영시간이 없습니다.</p><p>조건을 변경해주세요.</p></div>
											</c:if>
											
											<c:forEach items="${list}" var="movie" varStatus="vs">
												<div class="group_time_select">
													<div class="time_select_tit">
														<span class="ic_grade gr_${movie.ageLimit}">${movie.ageLimit}</span><strong>${movie.titleKor}</strong>
													</div>
													<div class="time_select_wrap timeSelect">
														<ul class="list_time">
															<c:forEach items="${movie.schedules}" var="schedule" varStatus="vs2">
																<li class="">
																	<sec:authorize access="isAuthenticated()">
																		<a role="button" href="#none" onclick="selectSeats('${schedule.movieScheduleId}', '${schedule.movieId}');">
																			<!-- <span class="txt_ntc ic">조조</span> -->
																			<dl>
																				<dt>상영시간</dt>
																				<dd class="time">
																					<strong>${schedule.startTime}</strong>
																					<div class="tooltip">종료 11:10</div>
																				</dd>
																				<dt>잔여석</dt>
																				<dd class="seat">
																					<strong>${schedule.availableSeats}</strong> / ${schedule.maxSeat}
																				</dd>
																				<dt>상영관</dt>
																				<dd class="hall">${schedule.theaterId}관</dd>
																			</dl>
																		</a>
																	</sec:authorize>
																	<!-- 로그인 안 한 경우 -->
																	<sec:authorize access="isAnonymous()">
																	<input type="hidden" name="reviewNo" value="${review.reviewNo}" />
																		<a role="button" href="#none" onclick="loginplz();">
																		<!-- <span class="txt_ntc ic">조조</span> -->
																			<dl>
																				<dt>상영시간</dt>
																				<dd class="time">
																					<strong>${schedule.startTime}</strong>
																					<div class="tooltip">종료 11:10</div>
																				</dd>
																				<dt>잔여석</dt>
																				<dd class="seat">
																					<strong>${schedule.availableSeats}</strong> / ${schedule.maxSeat}
																				</dd>
																				<dt>상영관</dt>
																				<dd class="hall">${schedule.theaterId}관</dd>
																			</dl>
																		</a>
																	</sec:authorize>
																</li>
															</c:forEach>
														</ul>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
									
					</ul>
				</div>
			</div>
		</div>
		
		
		<!-- 좌석선택페이지 -->
		<div id="reserveStep02" class="section_step_con step02 active" style="position: absolute; display: none; z-index: 1; background-color: white;">
            
		</div>
		
		
		<!-- 결제페이지 -->
		<div id="reserveStep03" class="section_step_con step03 active" style="position: absolute; display: none; z-index: 2; background-color: white;">
			
		</div>
		
		
		<!-- 예매완료 페이지 -->
		<div id="reserveStep04" class="section_step_con step04 active" style="position: absolute; display: none; z-index: 3; background-color: white;">
			
		</div>
		
	</div>
	<!-- <div class="wrap_reserve" id="wrap2" style="z-index: 1; background-color: white;"></div> -->
</div>

<script>
// 영화제목 클릭하면 선택되게 하려는데, a태그 범위랑 그 안의 strong태그가 따로 논다. 뭔 짓을 해도 한놈이 되면 다른놈이 안된다. 일단 strong이 안되는 상태로 뒀다.
const movieTitle = ((movieId) => {
	console.log(movieId);
});

$(() => {
	<%-- click 함수 계속 안되길래 ready function에 넣으니까 작동한다. 전에는 그냥 됐던거같은데 아닌가? --%>
	$(".moviearea").click((e) => {
		const $li = $(e.target).parent("li");
		console.log($li.data("title"));
		$(".movie_select_wrap ul > li.active").removeClass("active");
		$li.addClass("active");
		$("h4.movie_name").html($li.data("title"));
		
		var movieId = $li.data("id");
		var playdate = $("[name=radioDate1]:checked").data("playdate");
		console.log(movieId);
		console.log(playdate);
		
		if(playdate != null) {
			$.ajax ({
				url: "${pageContext.request.contextPath}/movie/selectMovieSchedule.do",
				data: {
						playdate : playdate,
						movieId : movieId
					  },
				method: "GET", 
				contentType: "application/json",
				success: function(data) {
					$("#mCSB_71_container").html(data);
					
				},
				complete: function() {
					console.log("complete")
				}
			});
		}
		
		// 영화정보 뜨게 함
		$.ajax ({
			url: "${pageContext.request.contextPath}/movie/selectMovieInfo.do",
			data: {
					movieId : movieId
				  },
			method: "GET", 
			contentType: "application/json",
			success: function(data) {
				$("#movieInfo").html(data);
			},
			complete: function() {
				console.log("complete")
			}
		});
		
	});
	
	$("strong.tit").click((e) => {
		console.log("strong");
		const $li = $("li").has($(e.target));
		console.log($li.val());
		$(".movie_select_wrap ul > li.active").removeClass("active");
		$li.addClass("active");
	});
	
	
	
})


// 날짜 선택하면 해당일의 상영일정 전부 표시
$("[name=radioDate1]").change((e) => {
	var playdate = $(e.target).data("playdate");
	var movieId = $(".movieList.active").data("id");  // class="movieList active" 인 dom객체를 지정하는 셀렉터는 이렇게 쓰면 된다. 
	console.log(playdate);
	console.log(movieId);
	$("#date").html(playdate);
	
	$.ajax ({
		url: "${pageContext.request.contextPath}/movie/selectMovieSchedule.do",
		data: {
				playdate : playdate,
				movieId : movieId
			  },
		method: "GET", 
		contentType: "application/json",
		success: function(data) {
			$("#mCSB_71_container").html(data);
			
		},
		complete: function() {
			console.log("complete")
		}
	});
	
});


function loginplz() {
	alert("로그인이 필요한 서비스입니다.");
	window.location.href="${pageContext.request.contextPath}/member/memberLogin.do";
}


function selectSeats(scheduleId, movieId) {
	/* console.log(memberId); */
	console.log(scheduleId);
	console.log(movieId);
	
	$.ajax ({
		url: "${pageContext.request.contextPath}/movie/selectSeats.do",
		data: {
			scheduleId : scheduleId,
			movieId : movieId
		  },
		method: "GET", 
		contentType: "application/json",
		success: function(data) {
			$("#reserveStep02").html(data);
			
		},
		complete: function() {
			$("#reserveStep02").show();
			$("#step01").removeClass("active").addClass("prev");
			$("#step02").removeClass("disabled").addClass("active");
			
			console.log("complete")
		}	
	});
}

// .step02.prev 안먹혀서 할수없이 아이디로
$("#step02").hover(
	e => {
		$(".bx_con.step02").show();   
	},
	e => {
		$(".bx_con.step02").hide();   
});


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>




<!-- 영화관 선택 div 
			<div class="article article_cinema">
				<div class="group_top">
					<h4 class="tit" style="position: relative; top: 16px;">용산</h4>
				</div>
				<div class="inner">
					<ul class="tab_wrap outer">
						<li class="active">
							<button type="button" class="tab_tit"
								style="width: 50%; left: 0%;">
								<span>전체</span>
							</button>
							<div class="tab_con">
								<h5 class="hidden">전체</h5>
								<div class="cinema_select_wrap cinemaSelect basicCinema">
									<ul>
										<li class="depth1"><a href="#none">MY 영화관<em>(0)</em></a>
											<div class="depth2">
												<div
													class="mCustomScrollbar _mCS_10 mCS-autoHide mCS_no_scrollbar"
													data-mcs-theme="minimal-dark"
													style="position: relative; overflow: visible;">
													<div id="mCSB_10"
														class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
														style="max-height: 753px;" tabindex="0">
														<div id="mCSB_10_container"
															class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y"
															style="position: relative; top: 0; left: 0;" dir="ltr">
															<div class="bx_notice">
																<p class="txt">
																	MY 영화관을 등록 후<br>이용해 주세요.
																</p>
																<a
																	href="https://www.lottecinema.co.kr/NLCHS/MyCinema/TicketingOrderList?mTab=1&amp;sTab=1&amp;vType=0"
																	class="btn_col3 ty3 rnd">MY 영화관 설정</a>
															</div>
														</div>
													</div>
													<div id="mCSB_10_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_10_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical"
														style="display: none;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_10_dragger_vertical" class="mCSB_dragger"
																style="position: absolute; min-height: 50px; top: 0px;">
																<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div></li>
										<li class="depth1 active"><a href="#none">서울<em>(23)</em></a>
										<div class="depth2">
												<div
													class="mCustomScrollbar basicCinemaScroll _mCS_1 mCS-autoHide"
													data-mcs-theme="minimal-dark"
													style="position: relative; overflow: visible;">
													<div id="mCSB_1"
														class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
														style="max-height: none;" tabindex="0">
														<div id="mCSB_1_container" class="mCSB_container"
															style="position: relative; top: -128px; left: 0px;"
															dir="ltr">
															<ul>
																<li class=""><a href="#none">가산디지털</a></li>
																<li class=""><a href="#none">가양</a></li>
																<li class=""><a href="#none">강동</a></li>
																<li class=""><a href="#none">건대입구</a></li>
																<li class=""><a href="#none">김포공항</a></li>
																<li class=""><a href="#none">노원</a></li>
																<li class=""><a href="#none">도곡</a></li>
																<li class=""><a href="#none">독산</a></li>
																<li class=""><a href="#none">브로드웨이(신사)</a></li>
																<li class=""><a href="#none">서울대입구</a></li>
																<li class=""><a href="#none">수락산</a></li>
																<li class=""><a href="#none">수유</a></li>
																<li class=""><a href="#none">신도림</a></li>
																<li class=""><a href="#none">신림</a></li>
																<li class=""><a href="#none">에비뉴엘(명동)</a></li>
																<li class=""><a href="#none">영등포</a></li>
																<li class="active"><a href="#none">용산</a></li>
																<li class=""><a href="#none">월드타워</a></li>
																<li class=""><a href="#none">은평(롯데몰)</a></li>
																<li class=""><a href="#none">중랑</a></li>
																<li class=""><a href="#none">청량리</a></li>
																<li class=""><a href="#none">합정</a></li>
																<li class=""><a href="#none">홍대입구</a></li>
															</ul>
														</div>
													</div>
													<div id="mCSB_1_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_1_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical mCSB_scrollTools_onDrag"
														style="display: block;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_1_dragger_vertical"
																class="mCSB_dragger mCSB_dragger_onDrag"
																style="position: absolute; min-height: 50px; display: block; height: 623px; max-height: 719px; top: 106px;">
																<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div></li>
										<li class="depth1"><a href="#none">경기/인천<em>(44)</em></a>
										<div class="depth2">
												<div
													class="mCustomScrollbar basicCinemaScroll _mCS_2 mCS-autoHide mCS_no_scrollbar"
													data-mcs-theme="minimal-dark"
													style="position: relative; overflow: visible;">
													<div id="mCSB_2"
														class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
														style="max-height: 753px;" tabindex="0">
														<div id="mCSB_2_container"
															class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y"
															style="position: relative; top: 0; left: 0;" dir="ltr">
															<ul>
																<li class=""><a href="#none">광교아울렛</a></li>
																<li class=""><a href="#none">광명(광명사거리)</a></li>
																<li class=""><a href="#none">광명아울렛</a></li>
																<li class=""><a href="#none">광주터미널</a></li>
																<li class=""><a href="#none">구리아울렛</a></li>
																<li class=""><a href="#none">동탄</a></li>
																<li class=""><a href="#none">라페스타</a></li>
																<li class=""><a href="#none">마석</a></li>
																<li class=""><a href="#none">별내</a></li>
																<li class=""><a href="#none">병점</a></li>
																<li class=""><a href="#none">부천(신중동역)</a></li>
																<li class=""><a href="#none">부천역</a></li>
																<li class=""><a href="#none">부평</a></li>
																<li class=""><a href="#none">부평역사</a></li>
																<li class=""><a href="#none">북수원(천천동)</a></li>
																<li class=""><a href="#none">산본피트인</a></li>
																<li class=""><a href="#none">서수원</a></li>
																<li class=""><a href="#none">성남중앙(신흥역)</a></li>
																<li class=""><a href="#none">센트럴락</a></li>
																<li class=""><a href="#none">송탄</a></li>
																<li class=""><a href="#none">수원(수원역)</a></li>
																<li class=""><a href="#none">수지</a></li>
																<li class=""><a href="#none">시화</a></li>
																<li class=""><a href="#none">시흥장현<span
																		class="txt_rnd_new">신규오픈</span></a></li>
																<li class=""><a href="#none">안산</a></li>
																<li class=""><a href="#none">안산고잔</a></li>
																<li class="disabled"><a href="#none">안성</a></li>
																<li class=""><a href="#none">안양(안양역)</a></li>
																<li class=""><a href="#none">안양일번가</a></li>
																<li class=""><a href="#none">영종하늘도시</a></li>
																<li class=""><a href="#none">오산(원동)</a></li>
																<li class=""><a href="#none">용인기흥</a></li>
																<li class=""><a href="#none">용인역북</a></li>
																<li class=""><a href="#none">위례</a></li>
																<li class=""><a href="#none">의정부민락</a></li>
																<li class=""><a href="#none">인덕원</a></li>
																<li class=""><a href="#none">인천아시아드</a></li>
																<li class=""><a href="#none">인천터미널</a></li>
																<li class=""><a href="#none">주엽</a></li>
																<li class=""><a href="#none">진접</a></li>
																<li class=""><a href="#none">파주운정</a></li>
																<li class=""><a href="#none">판교(창조경제밸리)</a></li>
																<li class=""><a href="#none">평촌(범계역)</a></li>
																<li class="disabled"><a href="#none">평택비전(뉴코아)</a></li>
																<li class=""><a href="#none">하남미사</a></li>
																<li class=""><a href="#none">향남</a></li>
															</ul>
														</div>
													</div>
													<div id="mCSB_2_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_2_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical"
														style="display: none;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_2_dragger_vertical" class="mCSB_dragger"
																style="position: absolute; min-height: 50px; top: 0px;">
																<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div></li>
										<li class="depth1"><a href="#none">충청/대전<em>(11)</em></a>
										<div class="depth2">
												<div
													class="mCustomScrollbar basicCinemaScroll _mCS_3 mCS-autoHide mCS_no_scrollbar"
													data-mcs-theme="minimal-dark"
													style="position: relative; overflow: visible;">
													<div id="mCSB_3"
														class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
														style="max-height: 753px;" tabindex="0">
														<div id="mCSB_3_container"
															class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y"
															style="position: relative; top: 0; left: 0;" dir="ltr">
															<ul>
																<li class=""><a href="#none">당진</a></li>
																<li class=""><a href="#none">대전(백화점)</a></li>
																<li class=""><a href="#none">대전관저</a></li>
																<li class=""><a href="#none">대전둔산(월평동)</a></li>
																<li class=""><a href="#none">대전센트럴</a></li>
																<li class=""><a href="#none">서산</a></li>
																<li class=""><a href="#none">서청주(아울렛)</a></li>
																<li class=""><a href="#none">아산터미널</a></li>
																<li class=""><a href="#none">천안불당</a></li>
																<li class=""><a href="#none">청주용암</a></li>
																<li class=""><a href="#none">충주</a></li>
															</ul>
														</div>
													</div>
													<div id="mCSB_3_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_3_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical"
														style="display: none;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_3_dragger_vertical" class="mCSB_dragger"
																style="position: absolute; min-height: 50px; top: 0px;">
																<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div></li>
										<li class="depth1"><a href="#none">전라/광주<em>(10)</em></a>
										<div class="depth2">
												<div
													class="mCustomScrollbar basicCinemaScroll _mCS_4 mCS-autoHide mCS_no_scrollbar"
													data-mcs-theme="minimal-dark"
													style="position: relative; overflow: visible;">
													<div id="mCSB_4"
														class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
														style="max-height: 753px;" tabindex="0">
														<div id="mCSB_4_container"
															class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y"
															style="position: relative; top: 0; left: 0;" dir="ltr">
															<ul>
																<li class=""><a href="#none">광주(백화점)</a></li>
																<li class=""><a href="#none">광주광산</a></li>
																<li class=""><a href="#none">군산나운</a></li>
																<li class=""><a href="#none">군산몰</a></li>
																<li class=""><a href="#none">수완(아울렛)</a></li>
																<li class=""><a href="#none">익산모현</a></li>
																<li class=""><a href="#none">전주(백화점)</a></li>
																<li class=""><a href="#none">전주송천</a></li>
																<li class=""><a href="#none">전주평화</a></li>
																<li class=""><a href="#none">충장로</a></li>
															</ul>
														</div>
													</div>
													<div id="mCSB_4_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_4_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical"
														style="display: none;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_4_dragger_vertical" class="mCSB_dragger"
																style="position: absolute; min-height: 50px; top: 0px;">
																<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div></li>
										<li class="depth1"><a href="#none">경북/대구<em>(18)</em></a>
										<div class="depth2">
												<div
													class="mCustomScrollbar basicCinemaScroll _mCS_5 mCS-autoHide mCS_no_scrollbar"
													data-mcs-theme="minimal-dark"
													style="position: relative; overflow: visible;">
													<div id="mCSB_5"
														class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
														style="max-height: 753px;" tabindex="0">
														<div id="mCSB_5_container"
															class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y"
															style="position: relative; top: 0; left: 0;" dir="ltr">
															<ul>
																<li class=""><a href="#none">경산</a></li>
																<li class=""><a href="#none">경주</a></li>
																<li class=""><a href="#none">경주황성</a></li>
																<li class=""><a href="#none">구미공단</a></li>
																<li class=""><a href="#none">대구광장</a></li>
																<li class=""><a href="#none">대구율하</a></li>
																<li class=""><a href="#none">대구현풍</a></li>
																<li class=""><a href="#none">동성로</a></li>
																<li class=""><a href="#none">상인</a></li>
																<li class=""><a href="#none">상주</a></li>
																<li class=""><a href="#none">성서</a></li>
																<li class=""><a href="#none">영주</a></li>
																<li class=""><a href="#none">영천</a></li>
																<li class=""><a href="#none">포항</a></li>
																<li class=""><a href="#none">프리미엄구미센트럴</a></li>
																<li class=""><a href="#none">프리미엄만경</a></li>
																<li class=""><a href="#none">프리미엄안동</a></li>
																<li class=""><a href="#none">프리미엄칠곡</a></li>
															</ul>
														</div>
													</div>
													<div id="mCSB_5_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_5_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical"
														style="display: none;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_5_dragger_vertical" class="mCSB_dragger"
																style="position: absolute; min-height: 50px; top: 0px;">
																<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div></li>
										<li class="depth1"><a href="#none">경남/부산/울산<em>(27)</em></a>
										<div class="depth2">
												<div
													class="mCustomScrollbar basicCinemaScroll _mCS_6 mCS-autoHide mCS_no_scrollbar"
													data-mcs-theme="minimal-dark"
													style="position: relative; overflow: visible;">
													<div id="mCSB_6"
														class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
														style="max-height: 753px;" tabindex="0">
														<div id="mCSB_6_container"
															class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y"
															style="position: relative; top: 0; left: 0;" dir="ltr">
															<ul>
																<li class=""><a href="#none">거창</a></li>
																<li class=""><a href="#none">광복</a></li>
																<li class=""><a href="#none">김해부원</a></li>
																<li class=""><a href="#none">김해아울렛(장유)</a></li>
																<li class=""><a href="#none">대영</a></li>
																<li class=""><a href="#none">동래</a></li>
																<li class=""><a href="#none">동부산아울렛</a></li>
																<li class=""><a href="#none">드라이브 오시리아</a></li>
																<li class=""><a href="#none">마산(합성동)</a></li>
																<li class=""><a href="#none">부산명지</a></li>
																<li class=""><a href="#none">부산본점</a></li>
																<li class=""><a href="#none">사상</a></li>
																<li class=""><a href="#none">사천</a></li>
																<li class=""><a href="#none">서면(전포동)</a></li>
																<li class=""><a href="#none">센텀시티</a></li>
																<li class=""><a href="#none">양산물금<span
																		class="txt_rnd_new">신규오픈</span></a></li>
																<li class=""><a href="#none">엠비씨네(진주)</a></li>
																<li class=""><a href="#none">오투(부산대)</a></li>
																<li class=""><a href="#none">울산(백화점)</a></li>
																<li class=""><a href="#none">울산성남</a></li>
																<li class=""><a href="#none">진주혁신(롯데몰)</a></li>
																<li class=""><a href="#none">진해</a></li>
																<li class=""><a href="#none">창원</a></li>
																<li class=""><a href="#none">통영</a></li>
																<li class=""><a href="#none">프리미엄경남대</a></li>
																<li class=""><a href="#none">프리미엄진주(중안)</a></li>
																<li class=""><a href="#none">프리미엄해운대(장산역)</a></li>
															</ul>
														</div>
													</div>
													<div id="mCSB_6_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_6_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical"
														style="display: none;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_6_dragger_vertical" class="mCSB_dragger"
																style="position: absolute; min-height: 50px; top: 0px;">
																<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div></li>
										<li class="depth1"><a href="#none">강원<em>(5)</em></a>
										<div class="depth2">
												<div
													class="mCustomScrollbar basicCinemaScroll _mCS_7 mCS-autoHide mCS_no_scrollbar"
													data-mcs-theme="minimal-dark"
													style="position: relative; overflow: visible;">
													<div id="mCSB_7"
														class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
														style="max-height: 753px;" tabindex="0">
														<div id="mCSB_7_container"
															class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y"
															style="position: relative; top: 0; left: 0;" dir="ltr">
															<ul>
																<li class=""><a href="#none">남원주</a></li>
																<li class=""><a href="#none">동해</a></li>
																<li class=""><a href="#none">속초</a></li>
																<li class=""><a href="#none">원주무실</a></li>
																<li class=""><a href="#none">춘천</a></li>
															</ul>
														</div>
													</div>
													<div id="mCSB_7_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_7_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical"
														style="display: none;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_7_dragger_vertical" class="mCSB_dragger"
																style="position: absolute; min-height: 50px; top: 0px;">
																<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div></li>
										<li class="depth1"><a href="#none">제주<em>(3)</em></a>
										<div class="depth2">
												<div
													class="mCustomScrollbar basicCinemaScroll _mCS_8 mCS-autoHide mCS_no_scrollbar"
													data-mcs-theme="minimal-dark"
													style="position: relative; overflow: visible;">
													<div id="mCSB_8"
														class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside"
														style="max-height: 753px;" tabindex="0">
														<div id="mCSB_8_container"
															class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y"
															style="position: relative; top: 0; left: 0;" dir="ltr">
															<ul>
																<li class=""><a href="#none">서귀포</a></li>
																<li class=""><a href="#none">제주삼화지구</a></li>
																<li class=""><a href="#none">제주아라</a></li>
															</ul>
														</div>
													</div>
													<div id="mCSB_8_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_8_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical"
														style="display: none;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_8_dragger_vertical" class="mCSB_dragger"
																style="position: absolute; min-height: 50px; top: 0px;">
																<div class="mCSB_dragger_bar" style="line-height: 50px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div></li>
									</ul>
								</div>
							</div>
						</li>
						<li><button type="button" class="tab_tit"
								style="width: 50%; left: 50%;">
								<span>스페셜관</span>
							</button>
							<div class="tab_con">
								<h5 class="hidden">전체</h5>
								<div class="cinema_select_wrap cinemaSelect">
									<ul>
										<li class="depth1 active"><a href="#none">샤롯데<em>(10)</em></a>
										<div class="depth2">
												<ul>
													<li class=""><a href="#none">월드타워</a></li>
													<li class=""><a href="#none">동탄</a></li>
													<li class=""><a href="#none">건대입구</a></li>
													<li class=""><a href="#none">에비뉴엘(명동)</a></li>
													<li class="disabled"><a href="#none">김포공항</a></li>
													<li class=""><a href="#none">안산</a></li>
													<li class=""><a href="#none">평촌(범계역)</a></li>
													<li class=""><a href="#none">광주(백화점)</a></li>
													<li class=""><a href="#none">동성로</a></li>
													<li class=""><a href="#none">광복</a></li>
													<li class=""><a href="#none">센텀시티</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">수퍼플렉스 G<em>(1)</em></a>
										<div class="depth2">
												<ul>
													<li class=""><a href="#none">월드타워</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">수퍼 S<em>(4)</em></a>
										<div class="depth2">
												<ul>
													<li class=""><a href="#none">월드타워</a></li>
													<li class=""><a href="#none">건대입구</a></li>
													<li class=""><a href="#none">천안불당</a></li>
													<li class=""><a href="#none">센텀시티</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">수퍼플렉스<em>(8)</em></a>
										<div class="depth2">
												<ul>
													<li class=""><a href="#none">수지</a></li>
													<li class=""><a href="#none">파주운정</a></li>
													<li class=""><a href="#none">은평(롯데몰)</a></li>
													<li class=""><a href="#none">청주용암</a></li>
													<li class=""><a href="#none">광명아울렛</a></li>
													<li class=""><a href="#none">상인</a></li>
													<li class=""><a href="#none">광복</a></li>
													<li class=""><a href="#none">수원(수원역)</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">수퍼 4D<em>(10)</em></a>
										<div class="depth2">
												<ul>
													<li class="disabled"><a href="#none">월드타워</a></li>
													<li class=""><a href="#none">가산디지털</a></li>
													<li class=""><a href="#none">광복</a></li>
													<li class=""><a href="#none">김포공항</a></li>
													<li class=""><a href="#none">노원</a></li>
													<li class=""><a href="#none">서청주(아울렛)</a></li>
													<li class=""><a href="#none">수완(아울렛)</a></li>
													<li class=""><a href="#none">수원(수원역)</a></li>
													<li class=""><a href="#none">울산(백화점)</a></li>
													<li class=""><a href="#none">청량리</a></li>
													<li class=""><a href="#none">평촌(범계역)</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">컬러리움<em>(1)</em></a>
										<div class="depth2">
												<ul>
													<li class=""><a href="#none">수원(수원역)</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">씨네살롱<em>(1)</em></a>
										<div class="depth2">
												<ul>
													<li class=""><a href="#none">도곡</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">씨네패밀리<em>(0)</em></a>
										<div class="depth2">
												<ul>
													<li class="disabled"><a href="#none">월드타워</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">씨네커플<em>(29)</em></a>
										<div class="depth2">
												<ul>
													<li class=""><a href="#none">시흥장현<span
															class="txt_rnd_new">신규오픈</span></a></li>
													<li class=""><a href="#none">사천</a></li>
													<li class=""><a href="#none">도곡</a></li>
													<li class=""><a href="#none">홍대입구</a></li>
													<li class=""><a href="#none">부평역사</a></li>
													<li class=""><a href="#none">수원(수원역)</a></li>
													<li class=""><a href="#none">북수원(천천동)</a></li>
													<li class=""><a href="#none">대전관저</a></li>
													<li class=""><a href="#none">원주무실</a></li>
													<li class=""><a href="#none">은평(롯데몰)</a></li>
													<li class=""><a href="#none">대영</a></li>
													<li class=""><a href="#none">파주운정</a></li>
													<li class=""><a href="#none">인천아시아드</a></li>
													<li class=""><a href="#none">향남</a></li>
													<li class=""><a href="#none">인천터미널</a></li>
													<li class=""><a href="#none">청주용암</a></li>
													<li class=""><a href="#none">군산나운</a></li>
													<li class=""><a href="#none">제주삼화지구</a></li>
													<li class=""><a href="#none">의정부민락</a></li>
													<li class=""><a href="#none">진주혁신(롯데몰)</a></li>
													<li class=""><a href="#none">합정</a></li>
													<li class=""><a href="#none">오투(부산대)</a></li>
													<li class=""><a href="#none">상인</a></li>
													<li class=""><a href="#none">서산</a></li>
													<li class=""><a href="#none">월드타워</a></li>
													<li class=""><a href="#none">광복</a></li>
													<li class=""><a href="#none">노원</a></li>
													<li class=""><a href="#none">부산본점</a></li>
													<li class=""><a href="#none">충장로</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">씨네비즈<em>(5)</em></a>
										<div class="depth2">
												<ul>
													<li class=""><a href="#none">월드타워</a></li>
													<li class=""><a href="#none">서청주(아울렛)</a></li>
													<li class=""><a href="#none">안양(안양역)</a></li>
													<li class=""><a href="#none">울산(백화점)</a></li>
													<li class=""><a href="#none">대구율하</a></li>
													<li class="disabled"><a href="#none">파주아울렛(종료)</a></li>
												</ul>
											</div></li>
										<li class="depth1"><a href="#none">씨네컴포트(리클라이너)<em>(18)</em></a>
										<div class="depth2">
												<ul>
													<li class=""><a href="#none">시흥장현<span
															class="txt_rnd_new">신규오픈</span></a></li>
													<li class=""><a href="#none">천안불당</a></li>
													<li class=""><a href="#none">전주송천</a></li>
													<li class=""><a href="#none">동탄</a></li>
													<li class="disabled"><a href="#none">라페스타(종료)</a></li>
													<li class=""><a href="#none">판교(창조경제밸리)</a></li>
													<li class=""><a href="#none">춘천</a></li>
													<li class=""><a href="#none">중랑</a></li>
													<li class=""><a href="#none">사천</a></li>
													<li class=""><a href="#none">당진</a></li>
													<li class=""><a href="#none">제주삼화지구</a></li>
													<li class=""><a href="#none">제주아라</a></li>
													<li class=""><a href="#none">용인역북</a></li>
													<li class=""><a href="#none">성남중앙(신흥역)</a></li>
													<li class=""><a href="#none">수지</a></li>
													<li class=""><a href="#none">대전센트럴</a></li>
													<li class=""><a href="#none">대전관저</a></li>
													<li class=""><a href="#none">원주무실</a></li>
													<li class=""><a href="#none">영주</a></li>
												</ul>
											</div></li>
									</ul>
								</div>
							</div></li>
					</ul>
				</div>
			</div> -->