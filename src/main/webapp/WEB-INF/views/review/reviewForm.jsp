<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page	import="org.springframework.security.core.context.SecurityContext"%>
<fmt:requestEncoding value="utf-8" />	<!-- 이거 없으면 이 밑에 jsp: -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="네티즌 리뷰" name="title"/>   
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/nav.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/board/reviewList.css" />

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

<section class="ink_board guest_mode">
	<div class="sub_title_wrap">
		<div class="container">
			<h2 class="en" style="margin: 0;">네티즌 리뷰</h2>
		</div>
	</div>

	<%-- <div class="bd_header">
		<h2 class="bd_title">
			<img src="${pageContext.request.contextPath}/resources/upload/board/리뷰게시판 타이틀 로고.png" alt="" />
			<a href="${pageContext.request.contextPath}/review/reviewList.do">네티즌 리뷰</a>
		</h2>
	</div> --%>
	<div class="list_wrap">
		<div class="ink_list ldn" style="background-color: #FFFFFF">
			<div id="board-container">
				<form:form 
					name="reviewFrm" 
					action="${pageContext.request.contextPath}/review/reviewEnroll.do?${_csrf.parameterName}=${_csrf.token}" 
					method="post" 
					enctype="multipart/form-data"
					onsubmit="return boardValidate();">
					<input type="text" class="form-control" placeholder="제목" name="reviewTitle" id="title" required>
					<input type="hidden" class="form-control" name="memberId" value="<sec:authentication property="principal.id"/>" readonly required>
					<textarea class="form-control" name="reviewContent" required></textarea>
					<br />
					<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
					<div class="input-group mb-3" style="padding:0px;">
					  <div class="input-group-prepend" style="padding:0px;">
					    <span class="input-group-text">첨부파일1</span>
					  </div>
					  <div class="custom-file">
					    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple>
					    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
					  </div>
					</div>
					
					<div class="input-group mb-3" style="padding:0px;">
					  <div class="input-group-prepend" style="padding:0px;">
					    <span class="input-group-text">첨부파일2</span>
					  </div>
					  <div class="custom-file">
					    <input type="file" class="custom-file-input" name="upFile" id="upFile2" >
					    <label class="custom-file-label" for="upFile2">파일을 선택하세요</label>
					  </div>
					</div>
					<br />
					<div class="bt_area bt_right">
						<button class="ib ib_mono" onclick="window.history.back();return false;" type="button">취소</button>
						<button class="ib ib_color" type="submit">등록</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</section>		
		

<style>
section#main-content {
    background-color: #E6E6E6;
    height: auto;
}
div#board-container{
	width:800px; 
	margin:0 auto; 
	text-align:center;
	padding-top: 40px;	
}
textarea.form-control {
	height: 300px;
}
div#board-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
.ib {
    height: 42px;
    line-height: 42px;
    padding: 0 20px;
    border-radius: 10px;
    position: relative;
    overflow: hidden;
    font-size: 14px;
    z-index: 1;
    border: none;
    color: white;
}
.ib_mono {
    color: #555;
    background-color: #EEE;
}
.bt_right .ib {
    margin-left: 3px;
    vertical-align: middle;
}
.bt_area {
	padding-bottom: 20px; 
}

</style>
		
<script>
function boardValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

$(() => {
	$("[name=upFile]").change((e) => {
		// 1. 파일명 가져오기
		const file = $(e.target).prop("files")[0];
		const filename = file?.name;   // optional chaining : 객체가 undefined인 경우에도 오류가 나지 않는다.
		console.log(e.target);
		console.log(filename);
		
		// 2. label에 설정하기
		const $label = $(e.target).next();   // 다음 형제요소
		if(file != undefined)
			$label.html(filename);
		else
			$label.html("파일을 선택하세요.");
	

	});	
});

function formSubmit() {
	document.reviewFrm.submit();
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>