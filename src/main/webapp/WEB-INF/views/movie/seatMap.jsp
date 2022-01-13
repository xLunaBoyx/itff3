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

<fmt:requestEncoding value="utf-8" />	<!-- 이거 없으면 이 밑에 jsp: -->

<!--  좌석선택 페이지. booking.jsp의 div id="reserveStep02" 에 들어간다. -->
<h3 class="hidden">인원/좌석</h3>
            <!--<div id="PersonSeatHeader"></div>-->
            
            <div class="article article_seat">
                <div class="group_top">
                    <h4 class="tit" style="position: relative; top: 16px;">인원/좌석 선택</h4>
                    <!-- <p class="txt">인원은 최대 8명까지 선택 가능합니다.</p> -->
                </div>
                <div class="inner">

					<div id="PersonSeatCount">
						<div class="select_num_people_wrap">
							<h5 class="hidden">인원선택</h5>
							<div class="movie_infor">
								<h6 class="hidden">예매 정보</h6>
								<span class="thm"><img
									src="${pageContext.request.contextPath}/resources/upload/poster/${movie.image}"></span>
								<div class="group_infor">
									<div class="bx_tit">
										<span class="ic_grade gr_${movie.ageLimit}">관람가</span><strong>${movie.titleKor}</strong>
									</div>
									<dl>
										<dt>일시</dt>
										<dd class="sub_info1">
											${schedule.startDate}<em></em><span class="time">${schedule.startTime} 시작</span>
										</dd>
										<dt>영화관</dt>
										<dd class="sub_info1">${schedule.theaterId}관</dd>
									</dl>
								</div>
							</div>
							<div class="count_people">
								<h6 class="hidden">인원선택</h6>
								<ul>
									<li id="person_10" data-code="10" data-peple="성인"
										data-count="0"><strong class="tit">인원</strong><span
										class="bx_num"><button class="btn_mins" id="Minus|10" onclick="min();">감소</button>
											<div class="txt_num" id="count" onchange="change();">1</div>
											<button class="btn_plus" id="Plus|10" onclick="add();">증가</button></span></li>
									<p class="txt" style="color: #767575; position: relative; top: 10px;">인원은 최대 4명까지 선택 가능합니다.</p>											
									<!-- <li id="person_20" data-code="20" data-peple="청소년"
										data-count="0"><strong class="tit">청소년</strong><span
										class="bx_num"><button class="btn_mins" id="Minus|20">감소</button>
											<div class="txt_num">0</div>
											<button class="btn_plus" id="Plus|20">증가</button></span></li>
									<li id="person_12" data-code="12" data-peple="시니어"
										data-count="0"><strong class="tit">시니어</strong><span
										class="bx_num"><button class="btn_mins" id="Minus|12">감소</button>
											<div class="txt_num">0</div>
											<button class="btn_plus" id="Plus|12">증가</button></span></li>
									<li id="person_11" data-code="11" data-peple="장애인"
										data-count="0"><strong class="tit">장애인</strong><span
										class="bx_num"><button class="btn_mins" id="Minus|11">감소</button>
											<div class="txt_num">0</div>
											<button class="btn_plus" id="Plus|11">증가</button></span></li> -->
								</ul>
							</div>
						</div>
					</div>



					<div class="select_seat_wrap">
                        <h5 class="hidden">좌석선택</h5>
                        <div class="top_txt_info">
                            <p id="ticketMessageInfo">좌석 선택 후 결제하기 버튼을 선택하세요.</p>
                        </div>
                        <div id="PersonSeatSelect"> </div>
                        
                        <div id="container" class="seat_wrap">
                            <article class="mseat_wrap">
                                <div class="mseat_inner">

                                    <div class="mCustomScrollbar _mCS_1 mCS-autoHide" data-mcs-theme="minimal-dark" style="position: relative; overflow: visible;"><div id="mCSB_1" class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside" style="max-height: none;" tabindex="0"><div id="mCSB_1_container" class="mCSB_container" style="position: relative; top: -16px; left: 0px;" dir="ltr">
                                        <div class="meat_door_pos" id="scrollWrap" style="top: 16px;">
                                            <div class="mseat_hidden">
                                                
                                                <span class="title_screen1">SCREEN</span>

														<div class="showMap">
															<div class="floor_bx seatSet1">
																<span class="floor_tit" style="display: none;">10F</span>

																<div class="seat_area" style="margin-top: 40px; width: 562.364px; height: 398.304px;">
																	<!-- A열 표시 -->
																	<span class="seat_tit" style="left: -30px; top: -10px;">A</span>
																
																	<!-- 좌석 리스트를 forEach로 돌려서 배치한다. 좌석id가 6으로 끝나고 리스트의 마지막 요소가 아니면 줄 넘기고 다음 열 알파벳을 표기하게 했다. -->
																	<!-- 예약된 좌석은 class="booked" 붙이고 disabled 처리. 좌석선택할때 예약된 좌석들을 따로 처리하기 위해 class가 필요했다. -->
																	<c:forEach items="${seatList}" var="seat" varStatus="vs">
																		<label class="check">
																			<input type="checkbox" name="seatNo" value="${seat.seatNo}" ${seat.isBooked eq 1 ? 'class="booked" disabled' : ''}> 
																			<span ${seat.isBooked eq 1 ? 'style="background-color: #747474"' : ''}><br />${fn:substring(seat.seatNo, 1, 2)}</span> 
																		</label>
																		<c:if test="${fn:endsWith(seat.seatNo, '6') && vs.last eq false}">
																			<br>
																			<c:choose>
																			<c:when test="${seat.seatNo eq 'A6'}"><span class="seat_tit" style="left: -30px; top: -10px;">B</span></c:when>
																			<c:when test="${seat.seatNo eq 'B6'}"><span class="seat_tit" style="left: -30px; top: -10px;">C</span></c:when>
																			<c:when test="${seat.seatNo eq 'C6'}"><span class="seat_tit" style="left: -30px; top: -10px;">D</span></c:when>
																			<c:when test="${seat.seatNo eq 'D6'}"><span class="seat_tit" style="left: -30px; top: -10px;">E</span></c:when>
																			<c:when test="${seat.seatNo eq 'E6'}"><span class="seat_tit" style="left: -30px; top: -10px;">F</span></c:when>
																			    
																			</c:choose>
																		</c:if>
																	</c:forEach>
																	<!-- <a
																		href="javascript:void(0);" alt="좌석 번호:L8 일반석"
																		class="sel  p0 grNum75" block-code="p0" data-seat="L8"
																		seat-statuscode="0" seat-group="grNum75"
																		seat-code="1L08" style="left: 210.318px; top: 0px;"><span
																		class=" f1" style="top: 0px;">8</span></a><a
																		href="javascript:void(0);" alt="좌석 번호:L9 일반석"
																		class="sel  Impossible p0 completed grNum76"
																		block-code="p0" data-seat="L9" seat-statuscode="30"
																		seat-group="grNum76" seat-code="1L09"
																		style="left: 237.364px; top: 0px;"><span
																		class="Impossible f1 blind" style="top: 0px;">9</span></a> -->
																</div>
																<span data-y="189px" data-x="537px" class="w_right"
																	style="top: 189px; left: 822px;">상영관 출입문 입니다.</span>
															</div>
														</div>

													</div>
                                        </div>
                                    </div></div><div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical" style="display: block;"><div class="mCSB_draggerContainer"><div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 50px; height: 431px; top: 15px; display: block; max-height: 436px;"><div class="mCSB_dragger_bar" style="line-height: 50px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div>
                                
                                
                                </div>

                                <div class="seat_btm_box">
                                    
                                    <div class="seat_type_box">
                                        <div class="top_info">
                                            <span class="seat_type1">선택좌석</span>
                                            <span class="seat_type2">&nbsp;선택가능</span>
                                            <span class="seat_type3">&nbsp;예매완료</span>
                                            <span class="seat_type4">&nbsp;선택불가</span>
                                        </div>
                                        <div class="btm_info">
                                            <!-- <span class="seat_type12">거리두기석</span>
                                            <span class="seat_type5">스위트스팟</span>
                                            <span class="seat_type6">씨네커플</span>
                                            <span class="seat_type7">씨네패밀리</span>
                                            <span class="seat_type8">리클라이너석</span>
                                            <span class="seat_type9">장애인석</span>
                                            <span class="seat_type10">발받침</span>
                                            <span class="seat_type11">출입문</span> -->
                                        </div>
                                    </div>

                                    
                                    <div class="notice_box" style="display:none;">
                                        <h6 class="tit_info">이용안내</h6>
                                        <ul class="list_txt ty3">
                                            <li>12세 미만의 고객님(영,유아 포함)은 부모님 또는 보호자를 동반하여도 관람이 불가합니다.</li>
                                            <li>영화 관람 시, 신분증을 지참하여 주시기 바랍니다.</li>
                                        </ul>
                                    </div>
                                    
                                </div>
                            </article>
                        </div>
                        
                    </div>

					<div id="PersonSeatSummery">
						<div class="select_seat_result">
							<div class="group_lft">
								<dl class="total_price">
									<dt>총 합계</dt>
									<dd>
										<strong id="total_step2">0</strong>원
									</dd>
								</dl>
							</div>
							<div class="group_rgt">
								<%-- <c:set var="loginMemberId">
								    <sec:authentication property="principal.id"/>
								</c:set> --%>
								<a href="#" onclick="payment('${schedule.movieScheduleId}', '${schedule.movieId}');" class="btn_col1" id="link_rpay">결제하기</a><!-- <a href="#"
									class="btn_col3" id="link_lpay"><span class="ico_lpay"><em>L.pay</em></span>결제하기</a> -->
							</div>
						</div>
					</div>
 
				</div>
            </div>
        
        <input type="hidden" id="selectedTitle" value="${movie.titleKor}"/>     
        <input type="hidden" id="selectedTheater" value="${schedule.theaterId}관"/>     
        <input type="hidden" id="selectedStartDate" value="${schedule.startDate}"/>     
        <input type="hidden" id="selectedStartTime" value="${schedule.startTime} 시작"/>     
<script>
$(() => {
	$("#bx_step01_title").html($("#selectedTitle").val());
	$("#bx_step01_theater").html($("#selectedTheater").val());
	$("#bx_step01_startDate").html($("#selectedStartDate").val());
	$("#bx_step01_startTime").html($("#selectedStartTime").val()); 
});

// 1단계 지나간 다음 마우스 올리면 선택한 내용 나옴
$(".step01.prev").hover(
	e => {
		$(".bx_con.step01").show();   /* .animate({opacity: 1}, 300) */
	},
	e => {
		$(".bx_con.step01").hide();   /* $(".bx_con").animate({opacity: 0}, 300); */
});

// 이거 클래스명으로 대체 왜 안되냐? .step02의 id값으로 셀렉터 하면 작동하는데, 이 클래스값으로 하면 안된다. 바로 위의 step1 prev는 되면서 왜 이건 안되냐고
// 할수없이 일단 id로 해놓고 발표할때 제대로 되는 척 해야겠네 (booking.jsp에 이거 아이디 호버 있음)
$(".step02.prev").hover( 
	e => {
		$(".bx_con.step02").show();   
	},
	e => {
		$(".bx_con.step02").hide();   
});


// 1단계 지나간 다음 1단계 클릭하면 처음 화면으로 돌아감
$(".step01.prev").click(e => {
	$("#reserveStep02").hide();
	$("#reserveStep03").hide();
	
	$("#step01").removeClass("prev").addClass("active");
	
	$("#step02").removeClass("active prev").addClass("disabled");
	
	$("#step03").removeClass("active").addClass("disabled");
});

$("#step02").click(e => {
	$("#reserveStep03").hide();
	
	$("#step02").removeClass("prev").addClass("active");
	
	$("#step03").removeClass("active").addClass("disabled");
});




// 좌석 선택시
$("[name=seatNo]").change((e) => {
		
	// 체크한 좌석번호 출력 테스트. 
	console.log($(e.target).val());
	
	// 체크한 좌석수 출력 테스트
	var len = $('[name=seatNo]:checked').length;
	console.log(len);
	
	// 체크한 좌석번호 전체 출력
	var checkArr = [];
		$('[name=seatNo]:checked').each(function(e) {
			var seat = $(this).val();
			checkArr.push(seat);
		})
	console.log(checkArr);
	
	// 결제금액 표시
	$("#total_step2").html((5000 * $("[name=seatNo]:checked").length).toLocaleString());
	
	// 체크된 좌석수가 위에 인원수 입력란의 숫자와 같을 경우 모든 좌석 체크박스를 disabled 처리. 
	// 같지 않을 경우(자리 바꾸려고 체크 해제한 경우) 모든 좌석의 disabled를 해제하고 예약된 좌석들(class="booked")은 다시 disabled 처리
	if($("[name=seatNo]:checked").length == parseInt($("#count").html())) {
		$("[name=seatNo]:not(:checked)").prop("disabled", true);
		$("[name=seatNo]:not(:checked)").next().addClass("seat_finished");
	}
	else {
		$("[name=seatNo]").prop("disabled", false);
		$(".booked").prop("disabled", true);
		$("[name=seatNo]:not(:checked)").next().removeClass("seat_finished");
	} 
	
});

 
/* 더하기 함수 */
function add () {
	if (parseInt($("#count").html()) < 4) {
		$("#count").html(parseInt($("#count").html()) + 1);
		$("[name=seatNo]").prop("checked", false);
		$("[name=seatNo]").prop("disabled", false);
		$(".booked").prop("disabled", true);
		$("[name=seatNo]:not(:checked)").next().removeClass("seat_finished");
	}
}

/* 빼기 함수 */
function min () {
	if (parseInt($("#count").html()) > 1) {
		$("#count").html(parseInt($("#count").html()) - 1);
		$("[name=seatNo]").prop("checked", false);
		$("[name=seatNo]").prop("disabled", false);
		$(".booked").prop("disabled", true);
		$("[name=seatNo]:not(:checked)").next().removeClass("seat_finished");
	}
}


function payment(scheduleId, movieId) {
	console.log(scheduleId);
	console.log(movieId);
	
	var checkArr = [];
	$('[name=seatNo]:checked').each(function(e) {
		var seat = $(this).val();
		checkArr.push(seat);
	})
		console.log(checkArr);
		console.log(checkArr.join(', '));
		console.log(checkArr.length);
		
	if(checkArr.length != parseInt($("#count").html())) {
		alert("좌석을 선택해주세요.");
	} 
	else {
		$.ajax ({
			url: "${pageContext.request.contextPath}/movie/payment.do",
			data: {
				scheduleId : scheduleId,
				movieId : movieId,
				selectedSeats : checkArr.join(', '),
				total : 1000 * $("[name=seatNo]:checked").length
			  },
			method: "GET", 
			contentType: "application/json",
			success: function(data) {
				$("#reserveStep03").html(data);
				
			},
			complete: function() {
				$("#reserveStep03").show();
				$("#step02").removeClass("active");
				$("#step02").addClass("prev");
				
				$("#step03").removeClass("disabled");
				$("#step03").addClass("active");
				
				console.log("complete")
			}	
		});
	}
}

	
</script>