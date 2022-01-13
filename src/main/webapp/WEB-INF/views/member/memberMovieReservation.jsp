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
	href="${pageContext.request.contextPath }/resources/css/member/memberMovieReservation.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/footer.css" />

<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

<script src='${pageContext.request.contextPath }/resources/js/qrcodejs/jquery.min.js'></script>
<script src='${pageContext.request.contextPath }/resources/js/qrcodejs/qrcode.js'></script>


<fmt:requestEncoding value="utf-8" />
<!-- 이거 없으면 이 밑에 jsp: -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="예매내역" name="title" />
</jsp:include>

<!-- 메뉴 아래 nav? 영역입니다. nav 메뉴 가지고 있는 페이지는 전부 복사해주세요. -->
<jsp:include page="/WEB-INF/views/member/common/memberNav.jsp">
	<jsp:param value="멤버 네베게이션 바" name="nav" />
</jsp:include>
<!-- 여기까지 nav 입니다. -->


<%-- <c:if test="${not empty msg}">
<script>
	alert(${msg});
</script>
</c:if>
 --%>
<!-- 해당 페이지 큰 글씨 -->
<div class="sub_title_wrap">
	<div class="container">
		<h2 class="en">예매 내역</h2>
	</div>
</div>
<!-- 여기까지 해당 페이지 큰 글씨입니다. -->
	<!-- <style>
		table {
		border:8px solid black; 
		/* border:선두께 선모양 선색상;
		- 선모양(none, dotted, dashed, solid, double, groove, ridge, inset, outset)은 
				반드시 명시를 해주어야만 한다. 선모양을 명시해주지 않으면 선이 안보여진다.
		- 선색상은 색상이름이나 색상코드로 표기한다. */
	    border-spacing:10px;  /* 셀과 셀사이의 간격 cellspacing을 대체함*/
	}
		table td, table th {
	    border:1px solid black; 
    	padding:20px; 		/* 셀테두리와 셀속에 들어있는 내용물 사이의 간격(셀여백) - cellpadding을 대체함 */
	}
	</style>
	 -->
<!-- 예매내역 -->
<div class="biggerPoint">

	<c:if test="${empty list}">
		<div class="sub_ex">
			<p class="ex">예매내역이 없습니다.</p>
		</div>	
	</c:if>

	<input type="hidden" id="msg" class="msg" value="<%= request.getParameter("msg") %>" />

	<c:forEach items="${list }" var="mv" varStatus="vs">
		<form
			id="memberMovieReservationFrm"
			name="memberMovieReservationFrm"
			method="POST"
			action="${pageContext.request.contextPath }/member/memberMovieReservationCansel">
			<s:csrfInput />
			<div class="sub_sc">
				<div id="_listContentArea">
					<div class="booking_history">
						<div class="history_list clear">
							<input id="hidden${vs.count}" type="hidden" value="${mv.movieReservationId}" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" id="movieReservationId" name="movieReservationId" value="${mv.movieReservationId }"/>
							<div class="img_box">
								<img src="${pageContext.request.contextPath}/resources/upload/poster/${mv.image}" alt="">
							</div>
							<ul class="history_info clear">
								<li>
									<b>예매번호</b>
									<strong>${mv.movieReservationId }</strong>
								</li>
								<li>
									<b>영화</b>
									<span>${mv.titleKor }</span>
								</li>
								<li>
									<b>영화관</b>
									<span>KH극장 ${mv.theaterId }관</span>
								</li>
								<li>
									<b>일시</b>
									<span>${mv.startDate } ${mv.startTime }</span>
								</li>
								<li>
									<b>인원</b>
									<span>일반 ${mv.count }인</span>
								</li>
								<li>
									<b>좌석</b>
									<span>${mv.selectedSeat }</span>
								</li>
								<li>
									<b>결제금액</b>
									<span>${mv.amount }원(카드결제)</span>
								</li>
								<li>
									<b>결제일</b>
									<span><fmt:formatDate value="${mv.regDate}" pattern="yyyy-MM-dd"/></span>
								</li>
								<li>
									<input type="submit" class="btn btn-dark" value="예매 취소"/>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<div id="qrcode${vs.count}" title="QR" class="qrcode"></div>
			</div>
		</form>
	</c:forEach>
		<div class="pagebar_footer">
			${pagebar}
		</div>
</div>
	
	
	
	
	
	
<%-- <div class="biggerPoint">

<br />


<div class="sub_sc">
<div id="_listContentArea">


	<c:forEach items="${list }" var="mv" varStatus="vs">
		<table>
			<input id="hidden${vs.count}" type="hidden" value="${mv.movieReservationId}" />
			<tr>
				<th rowspan="5">
					<img src="${pageContext.request.contextPath}/resources/upload/poster/${mv.image}" alt="" style="float:left; margin:0; padding:0; width:300px"/>
				</th>
				<th>${mv.titleKor }</th>
				<th>예매번호 : ${mv.movieReservationId }</th>
				<th rowspan="5">
					<div id="qrcode${vs.count}" title="QR" style="width:100px; height:100px; margin:auto; margin-top:15px;"></div>
				</th>
			</tr>
			<tr>
				<th>관람일시 : ${mv.startDate } ${mv.startTime }</th>
				<th>상영관 : ${mv.theaterId }관</th>
			</tr>
			<tr>
				<th>관람극장 : KH극장, 강남점</th>
				<th>관람좌석 : ${mv.selectedSeat }</th>
			</tr>
			<tr>
				<th>결제 날짜 : <fmt:formatDate value="${mv.regDate}" pattern="yyyy-MM-dd"/></th>
				<th>매수 : 일반 ${mv.count }인</th>
			</tr>
			<tr>
				<th colspan="2">결제 금액 : ${mv.amount }원(카드결제)</th>
			</tr>
						
			<br />
		</table>
		</c:forEach>
	
	
	
    

		</div>
	</div>
	<div class="pagebar_footer">
		${pagebar}
		
	</div>


</div> --%>



<script>
for(var i = 1; i < 11; i++){
	var qrcode = new QRCode(document.getElementById("qrcode" + i), {
		width: 150,
		height: 150
	})

	function makeCode () {
		var codeValue = document.getElementById("hidden" + i);

		qrcode.makeCode(codeValue.value);
	}

	makeCode();
}
</script>
 
 <script>
 	const msg = $('.msg').val();
 	
 	
 	if(msg == "null"){
 		console.log(1);
 	}
 	else{
 		alert(msg);
 	}
 	
 
 </script>


<!-- </body> -->



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>