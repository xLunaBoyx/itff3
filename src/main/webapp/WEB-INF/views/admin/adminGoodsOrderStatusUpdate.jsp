<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/admin/common/adminHeader.jsp">
	<jsp:param value="ITFF" name="title" />
</jsp:include>

		      <div class="modal-header">
		        <h4 class="modal-title" id="exampleModalLabel">일괄상태변경</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      
    	    <form
				action="${pageContext.request.contextPath}/admin/adminGoodsOrderStatusUpdate.do?${_csrf.parameterName}=${_csrf.token}"
				name="goods_order_delete_frm"
				method="post">
		      
    		  <div class="modal-body">
				<input type="hidden" name="orderNo" value="${payment.orderNo }" />
    		  	<input type="hidden" name="paymentNo" value="${payment.paymentNo }" />
					<table class="table">
					  <tbody>
						   <tr>
						     <th scope="row">주문일자</th>
						     <td><fmt:formatDate value="${payment.paymentDate }" pattern="yy-MM-dd HH:mm:ss"/></td>
						   </tr>
						   <tr>
						     <th scope="row">주문번호</th>
						     <td>${payment.paymentNo}</td>
						   </tr>
						   <tr>
						     <th scope="row">주문자</th>
						     <td>${payment.receiver }</td>
						   </tr>
						   <tr>
						     <th scope="row">결제금액</th>
						     <td>${payment.totalPrice }</td>
						   </tr>
					  </tbody>
					  <tfoot>
						  <th scope="row">진행상태</th>
						  <td>
						    <div>
							    <select id="status-select" name="status" class="form-select order_select"  data-order-detail-no="${list.orderDetail.orderDetailNo }" aria-label="Default select example" style="width: 100px;">
								  <option selected>선택</option>
								  <option value="상품준비중">상품준비중</option>
								  <option value="배송준비중">배송준비중</option>
								  <option value="배송중">배송중</option>
								  <option value="배송완료">배송완료</option>
								  <option value="주문취소">주문취소</option>
								</select>
							</div>
						  </td>
					  </tfoot>
					</table>
		      </div>
		      <div class="modal-footer">
				<button type="submit" class="btn btn-outline-secondary">변경</button>
		        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
		      </div>
			</form>
			
		<input type="hidden" name="memberId" class="memberId" value="${payment.memberId }" />

<script>

$("[name=goods_order_delete_frm]").submit((e) => {
    let type = '굿즈샵';
    let target = $(".memberId").val();
    let status = $("#status-select option:selected").val();
    let content = '주문하신 상품의 진행 상태는 ['+status+'] 입니다.'
    let url = '${contextPath}/notify/saveNotify.do';
    
    // 전송한 정보를 db에 저장	
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
        success:    // db전송 성공시 실시간 알림 전송
            // 소켓에 전달되는 메시지
            // 위에 기술한 EchoHandler에서 ,(comma)를 이용하여 분리시킨다.
        	socket.send("ITFF,"+target+","+content+","+url)
    });
});

</script>