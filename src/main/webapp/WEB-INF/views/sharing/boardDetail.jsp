    <%@page import="com.kh.spring.sharing.model.vo.BoardComment"%>
<%@page import="com.kh.spring.sharing.model.vo.Board"%>
<%@page import="java.util.List"%>
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

<fmt:requestEncoding value="utf-8" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/nav.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/footer.css" />
	
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sharing/boardList.css" />

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sharing/boardDetail.css" />


<%
	boolean editable = false;
	SecurityContext securityContext = SecurityContextHolder.getContext();
	Authentication authentication = securityContext.getAuthentication();
	System.out.println(authentication.getPrincipal());
	
	Board board = (Board) request.getAttribute("board");
	
	if(authentication.getPrincipal() != "anonymousUser"){
		Member loginMember = (Member) authentication.getPrincipal();
		pageContext.setAttribute("loginMember", loginMember);
		editable = loginMember != null && (
				loginMember.getId().equals(board.getMemberId())
				);
		
	List<BoardComment> commentList = (List<BoardComment>) request.getAttribute("commentList");
}
%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="??????????????? ????????????" name="title"/>   
</jsp:include>

<!-- ?????? ?????? nav? ???????????????. nav ?????? ????????? ?????? ???????????? ?????? ??????????????????. -->
<div id="snb">
	<div class="container-xl">
		<ul class="list-inline snb_ul" id="snbul1">
			<li class="on_"><a
				href="${pageContext.request.contextPath }/notice/noticeList.do"
				target="_top">????????????</a></li>
			<li class="on_"><a href="${pageContext.request.contextPath}/review/reviewList.do" target="_top">???????????????</a></li>
			<li class="on_"><a
				href="${pageContext.request.contextPath}/sharing/boardList.do"
				target="_top">???????????????</a></li>
			<li class="on_"><a href="${pageContext.request.contextPath }/question/faq.do" target="_top">???????????? ??????</a></li>
			<li class="on_"><a href="${pageContext.request.contextPath }/question/questionList.do" target="_top">1:1 ??????</a></li>
		</ul>
	</div>
</div>
<!-- ?????? ????????? ??? ?????? -->
	<div class="sub_title_wrap">
		<div class="container">
			<h2 class="en">???????????????</h2>
		</div>
	</div> 
	<!-- ???????????? ?????? ????????? ??? ???????????????. -->
<div class="ink_board guest_mode">
	<div class="list_wrap">
		<div class="ink_list ldn" style="background-color: #FFFFFF">
	<div class="ink_atc round20 has_list">
		<div class="atc_header">
			<p class="boardTitle">${board.title}</p>		
			
			<div class="atc_info clearfix">
				<span class="atc_nickname">
					
					<a href="#popup_menu_area" class="member_45775485" onclick="return false">
						<img src="" alt="" title="" class="xe_point_level_icon" style="vertical-align:middle;margin-right:3px;">${board.member.nickname}
					</a>
				</span>
				<span class="text_en atc_date font_grey1"><span><fmt:formatDate value="${board.regDate}" pattern="yyyy.MM.dd HH:mm"></fmt:formatDate></span></span>
				<div class="atc_info_right text_en font_grey1">
					<span class="count_read"><i class="fas fa-eye" title="?????? ???"></i>????????? ${board.readCount}</span>					
				</div>
			</div>
		</div>
		<div class="atc_body">
		<div class="content">
			<p style="text-align:center;">${board.content} </p>
				<br /><br />
				<c:forEach items="${board.attachments}" var="attach" varStatus="vs">
					<div class="image-box">
						<center>
							<img class="" src="${pageContext.request.contextPath}/resources/upload/board/${attach.renamedFilename}" alt="" />
						</center>				
					</div>
				</c:forEach>
				<br /><br />
	
		</div>	
			<div class="atc_buttons clearfix"></div>
		</div>
		
<%--     -------- ???????????? ?????? --------        --%>		

		<div id="comment" class="cmt cmt_bubble">
			<div class="cmt_title">
				<div class="btn_wrapper">
					<sec:authorize access="isAuthenticated()">
				<% 	if(editable){ %>	
		
					<%-- ???????????? ??????/??????????????? ????????? ?????? ??? ??? --%>
					<!-- <a href="javascript:goUpdateBoard();" 
							class="btn btn-outline-success">????????????</a> -->
					<button class="btn_brd_edit btn btn-xs btn-secondary" 
							onclick="location.href='${pageContext.request.contextPath}/sharing/boardUpdate.do?no=${board.no}';" 
							type="button">????????????</button>&nbsp&nbsp
					<!-- <a href="javascript:goDeleteBoard();" 
							class="btn btn-outline-success">????????????</a> -->
					<button class="btn btn-outline-success" 
							type="button"  
							onclick="deleteBoard()">????????????</button>&nbsp&nbsp
							
				<% 	} %>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<!-- <a href="javascript:goUpdateBoard();" 
							class="btn_brd_edit btn btn-xs btn-secondary">????????????</a> -->
						<button class="btn_brd_edit btn btn-xs btn-secondary" 
							onclick="location.href='${pageContext.request.contextPath}/sharing/boardUpdate.do?no=${board.no}';" 
							type="button">????????????</button>&nbsp&nbsp
						
						<a href="javascript:goDeleteBoard();" 
							class="btn_brd_del btn btn-xs btn-secondary" onclick="deleteBoard()">????????????</a>&nbsp&nbsp&nbsp&nbsp	
					</sec:authorize>
		
					</sec:authorize>
					<input type="button" value="????????????" id="btn-add" class="btn btn-outline-success" onclick="goBoardList();"/>
				</div>
			</span>
			</div>
	<!-- //cmt_notice -->
		
	<sec:authorize access="isAuthenticated()">
		<c:set var="loginMemberImage">
		   	<sec:authentication property="principal.image"/> 
		</c:set>
		<c:set var="loginMemberId">
	    	<sec:authentication property="principal.id"/>
		</c:set>		
	</sec:authorize>		
		
	<div class="cmt_wrap has_top">
		<div class="cmt_list">
			<c:forEach items="${commentList}" var="comment" varStatus="vs">
			
				<!-- ?????? 1?????? -->
				<c:if test="${comment.commentLevel eq 1}">
					
					<article class="cmt_unit" id="commentNo${comment.no}">
						<div class="inkpf_wrap">
							<span class="inkpf round"><img class="inkpf_img" src="${pageContext.request.contextPath}/resources/upload/member/${comment.member.image}" alt="" /></span>				
						</div>
						<div class="cmt_header" style="margin-bottom: 6px;">
							<a href="#popup_menu_area" class="nickname member_25365243" onclick="return false">
								${comment.member.nickname}
							</a>
						</div>
						<div class="cmt_body">
						<!--BeforeComment(71876047,25365243)-->
							<div class="comment_71876047_25365243 rhymix_content xe_content" data-pswp-uid="2">
								${comment.content}
							</div>
							<div class="cmt_buttons">
								<div class="cmt_vote">
									<sec:authorize access="isAuthenticated()">
										<a class="bt bt2 reply" href="javascript:void(0)" data-no="${comment.no}" data-image="${loginMemberImage}" data-id="${loginMemberId}" data-boardno="${board.no}" data-commentRef="1" style=" border-radius: 2.5px;">
											??????
										</a>
										<c:if test="${loginMemberId eq comment.writer}">
											<a class="bt bt2 deleteComment" href="javascript:void(0)" data-no="${comment.no}" style="border-radius: 2.5px;">
												??????
											</a>
										</c:if>
									</sec:authorize>
									<sec:authorize access="isAnonymous()">
									<a class="bt bt2 anonymous" href="javascript:void(0)">
										??????
									</a>
									</sec:authorize>
								</div>
							<div class="font_grey1">
								<span class="cmt_time"><fmt:formatDate value="${comment.regDate}" pattern="yyyy.MM.dd HH:mm"></fmt:formatDate></span>
							</div>
							</div>
						</div>
					
					<!-- //cmt_body -->
					
					</article>
				</c:if>


				<!-- ?????????(2??????) -->
				<c:if test="${comment.commentLevel eq 2}">
					<article class="cmt_unit level2" id="commentNo${comment.no}">
						<div class="inkpf_wrap">
							<span class="inkpf round"><img class="inkpf_img" src="${pageContext.request.contextPath}/resources/upload/member/${comment.member.image}" alt="" /></span>
						</div>
						<div class="cmt_header" style="margin-bottom: 6px;">
							<a href="#popup_menu_area" class="nickname member_25365243" onclick="return false">
								${comment.member.nickname}
							</a>
						</div>
						<div class="cmt_body">
						<!--BeforeComment(71876047,25365243)-->
							<div class="comment_71876047_25365243 rhymix_content xe_content" data-pswp-uid="2">
								${comment.content}
							</div>
							<div class="cmt_buttons">
								<div class="cmt_vote">
									<sec:authorize access="isAuthenticated()">
										<a class="bt bt2 reply" href="javascript:void(0)" data-no="${comment.no}" data-image="${loginMemberImage}" data-id="${loginMemberId}" data-boardno="${board.no}" data-commentRef="1" style=" border-radius: 2.5px;">
											??????
										</a>
										<c:if test="${loginMemberId eq comment.writer}">
											<a class="bt bt2 deleteComment" href="javascript:void(0)" data-no="${comment.no}" style="border-radius: 2.5px;">
												??????
											</a>
										</c:if>
									</sec:authorize>
									<sec:authorize access="isAnonymous()">
									<a class="bt bt2 anonymous" href="javascript:void(0)">
										??????
									</a>
									</sec:authorize>
								</div>
							<div class="font_grey1">
								<span class="cmt_time"><fmt:formatDate value="${comment.regDate}" pattern="yyyy.MM.dd HH:mm"></fmt:formatDate></span>
							</div>
							</div>
						</div>
					<!-- //cmt_body -->
					</article>
				</c:if>
			</c:forEach>
			<br /><br />
		<!-- ?????? ????????? ??? -->
		<form:form 
			action="${pageContext.request.contextPath}/sharing/boardCommentDelete.do?${_csrf.parameterName}=${_csrf.token}" 
			name="boardCommentDelFrm"
			method="POST">
			<input type="hidden" name="no" />
			<input type="hidden" name="boardNo" value="${board.no}" />
		</form:form>			

		</div> <!-- cmt_list -->
		
	</div> <!-- cmt_wrap -->
	 	
	<!-- ????????? ????????? ??? -->		
	<form:form 
		action="${pageContext.request.contextPath}/sharing/boardDelete.do?${_csrf.parameterName}=${_csrf.token}"
		name="deleteBoardFrm"
		method="POST">
		<input type="hidden" name="no" value="${board.no}" />
	</form:form>			
				
	<!-- ????????? ??? ???????????? ?????? -->
	<sec:authorize access="isAuthenticated()">
		<div class="cmt_write cmt_write_unit">
			<span class="inkpf round"><img class="inkpf_img" src="${pageContext.request.contextPath}/resources/upload/member/${loginMemberImage}" alt="" /></span>
			<form:form 
				action="${pageContext.request.contextPath}/sharing/boardCommentEnroll.do?${_csrf.parameterName}=${_csrf.token}"
				name="boardCommentFrm" 
				method="post" 
				id="ws_comment_frm1"
				class="cmt_form">
				<input type="hidden" name="writer" class="writer" value="${loginMemberId}" />
				<input type="hidden" name="boardNo" value="${board.no}" />
				<input type="hidden" name="commentLevel" value="1">
				<input type="hidden" name="commentRef" value="0">
				<div class="cmt_write_input text_ver">
					<textarea name="content" class="cmt_textarea" cols="50" rows="4" placeholder="?????? ????????? ??????????????????." style="width: 100%; height: 106px;"></textarea>
				</div>
				<div class="cmt_write_option">
					<span class="write_option"></span>
					<div class="bt_area bt_right">
						<button class="ib ib2 ib_color" type="submit" style="border-radius: 3.5px;">?????? ??????</button>
					</div>
				</div>
			</form:form>
		</div>
	</sec:authorize>
	
	
	<!-- ????????? ??? ??? ?????? ??????????????? ????????? ????????? ??? -->
	<%-- <sec:authorize access="isAnonymous()">
		<div class="cmt_write cmt_write_unit no_grant">
			<div class="cmt_not_permitted" style="font-size: 14px">
				<img src="${pageContext.request.contextPath}/resources/upload/board/????????? ?????????.png" style="position: relative; top: 5px; right: 2px;" alt="" /> ????????? ????????????. &nbsp;&nbsp;<a class="ink_link2" href="${pageContext.request.contextPath}/member/memberLogin.do" >?????????</a>
			</div>
		</div>
	</sec:authorize> --%>

	<%-- <div class="ink_message ink_warn cmt_delete">
		<div>
			<h3>?????? ??????</h3>
			<button class="bt_close bt_xclose" type="button"><svg viewBox="0 0 1024 1024"><title>close</title><path class="path1" d="M548.203 537.6l289.099-289.098c9.998-9.998 9.998-26.206 0-36.205-9.997-9.997-26.206-9.997-36.203 0l-289.099 289.099-289.098-289.099c-9.998-9.997-26.206-9.997-36.205 0-9.997 9.998-9.997 26.206 0 36.205l289.099 289.098-289.099 289.099c-9.997 9.997-9.997 26.206 0 36.203 5 4.998 11.55 7.498 18.102 7.498s13.102-2.499 18.102-7.499l289.098-289.098 289.099 289.099c4.998 4.998 11.549 7.498 18.101 7.498s13.102-2.499 18.101-7.499c9.998-9.997 9.998-26.206 0-36.203l-289.098-289.098z"></path></svg></button>
			<form 
				class="inner" 
				action="${pageContext.request.contextPath}/sharing/boardCommentDelete.do?${_csrf.parameterName}=${_csrf.token}" 
				method="get" 
				onsubmit="return procFilter(this, delete_comment)">
				<input type="hidden" name="error_return_url" value="/movietalk/71875352?category=61633579"><input type="hidden" name="act" value="dispBoardContent">
				<input type="hidden" name="mid" value="movietalk">
				<input type="hidden" name="document_srl" value="71875352">
				<input type="hidden" name="comment_srl" value="">
				<p class="message_target">"<span class="nickname"></span>?????? ??????"</p>
				<p class="message_text">??? ????????? ?????????????????????????</p>
				<div class="bt_area bt_duo">
					<button class="ib ib_mono bt_close" type="button">??????</button><button class="ib ib_color" onclick="deleteSubmit(this);" type="submit">??????</button>
				</div>
			</form>
		</div>
	</div> --%>
	</div> <!-- cmt --> 
	</div> <!-- class="ink_atc round20 has_list" -->
	</div>
</div>
	
</div>	

<input type="hidden" class="ws_id" value="${board.memberId }" />

<script>

$("#ws_comment_frm1").submit(function(e){
    let type = '???????????????';
    let target = $(".ws_id").val();
    let content = '[???????????????] ???????????? ?????? ????????? ?????????????????????.'
    let url = '${contextPath}/notify/saveNotify.do';
    let writer = $(".writer").val();
    	    
    console.log(type);
    console.log(target);
    console.log(content);
    console.log(url);
    
    // ??? ???????????? ?????? ???????????? ????????? ?????? ????????? ??????
    if(target == writer) {
    	target = null;
    }
    
    // ????????? ????????? db??? ??????	
    $.ajax({
        type: "post",
        url:"${pageContext.request.contextPath}/notify/saveNotify.do",
        dataType: "text",
        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
        data: {
            target: target,
            content: content,
            type: type,
            url: url
        },
        beforeSend : function(xhr) {   
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success:    // db?????? ????????? ????????? ?????? ??????
            // ????????? ???????????? ?????????
            // ?????? ????????? EchoHandler?????? ,(comma)??? ???????????? ???????????????.
        	socket.send("ITFF,"+target+","+content+","+url)
//			console.log("?????????,"+target+","+content+","+url)

    });
});

</script>	

<script>
$(".anonymous").click((e) => {
	alert("????????? ????????????.");
});

// ?????? ??????
$(".deleteComment").click(function(e){
	console.log(this);
	console.log(e.target);
	console.log(e.target === this);
	
	if(confirm("?????? ????????? ?????????????????????????")){
		var $frm = $(document.boardCommentDelFrm);
		/* var no = $(this).val(); */
		var no = $(this).data("no");
		console.log(no);
		$frm.find("[name=no]").val(no);
		$frm.submit();
	}
});

</script>

<script>
// ?????? ??????
$(".reply").click((e) => {
	console.log("reply ?????? ???????????????");
	$(".cmt_write_re").remove();
	
	const commentRef = $(e.target).data("no");
	const image = $(e.target).data("image");
	const id = $(e.target).data("id");
	const boardNo = $(e.target).data("boardno");   <%-- data ????????? ???????????? ????????? ??????????????????. data-reviewNo ??? ????????? undefined ??????. --%>
	
	console.log(commentRef);
	console.log(image);
	console.log(id);
	console.log(boardNo);
	
	
	const div = `<div class="cmt_write_unit cmt_write_re" id="cmt_write_re" style="display: block;">
		<form:form 
			action="${pageContext.request.contextPath}/sharing/boardCommentEnroll.do"
			name="boardCommentEnrollFrm"
			method="post" 
			class="cmt_form" 
			style="height: auto;">
			<input type="hidden" name="writer" value="\${id}" />
			<input type="hidden" name="boardNo" value="\${boardNo}" />
			<input type="hidden" name="commentLevel" value="2">
			<input type="hidden" name="commentRef" value="\${commentRef}">
			<span class="inkpf round"><img class="inkpf_img" src="${pageContext.request.contextPath}/resources/upload/member/\${image}" alt="" /></span>
			<div class="cmt_write_input text_ver">
				<textarea class="cmt_textarea" name="content" id="editor_2" placeholder="?????? ????????? ??????????????????." style="width: 100%;" required></textarea>
			</div>
			<div class="cmt_write_option">
				<div class="bt_area bt_right">
					<button class="ib ib2 ib_color" type="submit" style="border-radius: 3.5px;">?????? ??????</button>
					<button class="ib ib2 ib_mono bt_close" type="button" onclick='$(".cmt_write_re").remove();' style="border-radius: 3.5px;">??????</button>
				</div>
			</div>
		</form:form>
	</div>`;
	
	console.log(div);
	console.log($(div));
	
	const $commentArticle = $(e.target).parent().parent().parent().parent();
	
	$(div)
	.insertAfter($commentArticle)
	.find("form")
	.submit((e) => {
		// ????????????
		const $textarea = $("[name=content]", e.target); 

		if(!/^(.|\n)+$/.test($textarea.val())) {
			alert("?????? ????????? ??????????????????.");
			$textarea.focus();
			return false;
		}	
	})
	.find("[name=content]")
	.focus();
})

$(document.reviewCommentEnrollFrm).submit((e) => {
	// ????????????
	// const textarea = $("[name=content]", document.boardCommentFrm);
	const $textarea = $("[name=content]", e.target); 

	if(!/^(.|\n)+$/.test($textarea.val())) {
		alert("?????? ????????? ??????????????????.");
		$textarea.focus();
		return false;
	}
	
});

function goBoardList() {
	location.href = `${pageContext.request.contextPath}/sharing/boardList.do`;
};


/* function goUpdateBoard() {
	const boardNo = $("[name=no]").val();
	console.log("boardNo = ", boardNo);
	location.href = `${pageContext.request.contextPath}/sharing/boardUpdate.do?no=\${boardNo}`;
};
 */
/* function goDeleteBoard() {
	var delBoard = confirm("???????????? ?????????????????????????");
	if(delBoard) {
		const boardNo = $("[name=no]").val();
		console.log("boardNo = ", boardNo);
		location.href = `${pageContext.request.contextPath}/sharing/boardDelete.do?no=\${boardNo}`;
	}
}; */

const deleteBoard = () => {
	if(confirm("?????? ??? ???????????? ?????????????????????????")){
		$(document.deleteBoardFrm).submit();
	}
};

</script>


<script type="text/javascript">

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

    
