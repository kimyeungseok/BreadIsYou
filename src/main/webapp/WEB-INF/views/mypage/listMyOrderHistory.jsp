<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta   charset="utf-8">
<script>
function search_order_history(fixedSearchPeriod){
	var formObj=document.createElement("form");
	var i_fixedSearch_period = document.createElement("input");
	i_fixedSearch_period.name="fixedSearchPeriod";
	i_fixedSearch_period.value=fixedSearchPeriod;
    formObj.appendChild(i_fixedSearch_period);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/mypage/listMyOrderHistory.do";
    formObj.submit();
}

function fn_cancel_order(order_id){
	var answer=confirm("주문을 취소하시겠습니까?");
	if(answer==true){
		var formObj=document.createElement("form");
		var i_order_id = document.createElement("input"); 
	    
	    i_order_id.name="order_id";
	    i_order_id.value=order_id;
		
	    formObj.appendChild(i_order_id);
	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="${contextPath}/mypage/cancelMyOrder.do";
	    formObj.submit();	
	}
}

</script>
</head>
<body>
	
	<div class="title_underline" id="order-history-title">
		<h3><b>주문 배송 조회</b></h3>
	</div>
	
<table class="table">
		<tbody align=center >
			<tr style="background:skyblue" >
				<td><b>주문번호</b></td>
				<td><b>주문일자</b></td>
				<td><b>주문내역</b></td>
				<td><b>주문금액/수량</b></td>
				<td><b>주문상태</b></td>
				<td><b>주문자</b></td>
				<td><b>수령자</b></td>
				<td><b>주문취소</b></td>
			</tr>
   <c:choose>
     <c:when test="${empty myOrderHistList }">			
			<tr>
		       <td colspan=8 class="fixed">
				  주문한 상품이 없습니다.
			   </td>
		     </tr>
	 </c:when>
	 <c:otherwise> 
     <c:forEach var="item" items="${myOrderHistList }" varStatus="i">
        <c:choose>
          <c:when test="${item.order_id != pre_order_id }">   
            <tr>       
				<td>
				  ${item.order_id }
				</td>
				<td >
				 ${item.pay_order_time}
				</td>
				<td> 
				    <strong>
					   <c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
				          <c:if  test="${item.order_id ==item2.order_id}" >
				            <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title }</a><br>
				         </c:if>   
					 </c:forEach>
					 </strong>
				</td>
				<td>
				   <strong>
				      <c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
				          <c:if  test="${item.order_id ==item2.order_id}" >
				            ${item.goods_sales_price*item.order_goods_qty }원/${item.order_goods_qty }<br>
				         </c:if>   
					 </c:forEach>
				   </strong>
				</td>
				<td>
				  <strong>
				    <c:choose>
					    <c:when test="${item.delivery_state=='delivery_prepared' }">
					       배송준비중
					    </c:when>
					    <c:when test="${item.delivery_state=='delivering' }">
					       배송중
					    </c:when>
					    <c:when test="${item.delivery_state=='finished_delivering' }">
					       배송완료
					    </c:when>
					    <c:when test="${item.delivery_state=='cancel_order' }">
					       주문취소
					    </c:when>
					    <c:when test="${item.delivery_state=='returning_goods' }">
					       반품
					    </c:when>
				  </c:choose>
				  </strong>
				</td>
				<td>
				 ${item.orderer_name } 
				</td>
				<td>
					${item.receiver_name }
				</td>
				<td>
			     <c:choose>
			   <c:when test="${item.delivery_state=='delivery_prepared'}">
			       <input  type="button" onClick="fn_cancel_order('${item.order_id}')" value="주문취소"  />
			   </c:when>
			   <c:otherwise>
			      <input  type="button" onClick="fn_cancel_order('${item.order_id}')" value="주문취소" disabled />
			   </c:otherwise>
			  </c:choose>
			    </td>
			</tr>
			<c:set  var="pre_order_id" value="${item.order_id }" />
		   </c:when>	
	  </c:choose>		
	</c:forEach>
	</c:otherwise>
  </c:choose>			   
		</tbody>
	</table>
     	
	<div class="clear"></div>
</body>
</html>