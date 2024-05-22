<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

	<!-- 주문 취소 후 다시 페이지를 요청할 경우 주문 취소 메시지를 출력합니ㅏㄷ. -->
	<c:if test="${message=='cancel_order'}">
		<script>
		window.onload=function()
		{
		  init();
		}
		
		function init(){
			alert("주문을 취소했습니다.");
		}
		</script>
	</c:if>

<script>
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

	<div class="title_underline">
		<h3 class="mypage-title"><b>마이페이지</b></h3>
	</div>
	
	<div class="myinfo-div" style="border:1px solid rgba(0, 0, 0, 0.2); padding: 40px; border-radius:20px;">

		<h4>내정보
		    <a href="${contextPath}/mypage/myDetailInfo.do"><img src="${contextPath}/resources/image/btn_more_see.jpg" />  </a>
		</h4>
		<table class="table">
		  <tr>
		  	<td>
			   <span>이름</span>
		   </td>
		    <td>
			   <span>${memberInfo.member_name}</span>
		   </td>
		  </tr>
		  <tr>
		    <td>
			   <span>이메일</span>
		   </td>
		    <td>
			   <span>${memberInfo.email1 }@${memberInfo.email2 }</span>
		   </td>
		   </tr>
		   <tr>
		    <td>
			   <span>전화번호</span> 
		   </td>
		    <td>
			   <span>${memberInfo.hp1 }-${memberInfo.hp2}-${memberInfo.hp3 }</span>
		   </td>
		   </tr>
		   <tr>
		    <td>
			  <span>주소</span> 
		   </td>
		    <td>
				<span>[도로명]</span>&nbsp;&nbsp;<span>${memberInfo.roadAddress }</span>  <br>
				<span>[지&nbsp;&nbsp;&nbsp;번]</span>&nbsp;&nbsp;<span>${memberInfo.jibunAddress }</span> 
		   </td>
		   </tr>
		</table>
		</div>
		
		<div class="mypage-div" style="margin-bottom:10px">
			<h4>배송조회</h4>
			<input type="text" id="track-id" placeholder="운송장 번호를 입력하세요">
			<button onclick="track()">조회</button>
		</div>
		
		<div class="mypage-div">
		
		<h4>최근주문내역 
			<a href="${contextPath}/mypage/listMyOrderHistory.do"><img src="${contextPath}/resources/image/btn_more_see.jpg" /> </a>
		</h4>
		
		<table class="table">
				<tbody align=center >
					<tr>
						<td><span>주문번호</span></td>
						<td><span>주문일자</span></td>
						<td><span>주문상품</span></td>
						<td><span>주문상태</span></td>
						<td><span>주문취소</span></td>
					</tr>
		      <c:choose>
		         <c:when test="${ empty myOrderList  }">
				  <tr>
				    <td colspan=5 class="fixed">
						  <strong>주문한 상품이 없습니다.</strong>
				    </td>
				  </tr>
		        </c:when>
		        <c:otherwise>
			      <c:forEach var="item" items="${myOrderList }"  varStatus="i">
			       <c:choose> 
		              <c:when test="${ pre_order_id != item.order_id}">
		                <c:choose>
			              <c:when test="${item.delivery_state=='delivery_prepared' }">
			                <tr  bgcolor="lightgreen">    
			              </c:when>
			              <c:when test="${item.delivery_state=='finished_delivering' }">
			                <tr  bgcolor="lightgray">    
			              </c:when>
			              <c:otherwise>
			                <tr  bgcolor="orange">   
			              </c:otherwise>
			            </c:choose> 
		            <tr>
		             <td >
				       ${item.order_id }
				    <td>${item.pay_order_time }</td>
					<td align="center">
					   <strong>
					   	  <!-- <forEach> 태그를 이용해 주문당 해당 상품명을 한꺼번에 표시합니다. -->
					      <c:forEach var="item2" items="${myOrderList}" varStatus="j">
					          <c:if  test="${item.order_id ==item2.order_id}" >
					            <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }"><span>${item2.goods_title }/${item.order_goods_qty }개</span></a><br>
					         </c:if>   
						 </c:forEach>
						 
						</strong></td>
					<td>
					  
					  <!-- 주문 상품의 배송 상태를 표시합니다. -->
					  <c:choose>
					    <c:when test="${item.delivery_state=='delivery_prepared' }">
					       <span>배송준비중</span>
					    </c:when>
					    <c:when test="${item.delivery_state=='delivering' }">
					       <span>배송중</span>
					    </c:when>
					    <c:when test="${item.delivery_state=='finished_delivering' }">
					       <span>배송완료</span>
					    </c:when>
					    <c:when test="${item.delivery_state=='cancel_order' }">
					       <span>주문취소</span>
					    </c:when>
					    <c:when test="${item.delivery_state=='returning_goods' }">
					       <span>반품완료</span>
					    </c:when>
					  </c:choose>
					  
					</td>
					<td>
					  
					  <!-- '배송준비중'일 때만 주문 취소가 가능합니다. -->
					  <c:choose>
					   <c:when test="${item.delivery_state=='delivery_prepared'}">
					       <input type="button" onClick="fn_cancel_order('${item.order_id}')" value="주문취소" class="btn btn-secondary btn-sm" />
					   </c:when>
					   <c:otherwise>
					      <input type="button" onClick="fn_cancel_order('${item.order_id}')" value="주문취소" class="btn btn-secondary btn-sm" disabled />
					   </c:otherwise>
					  </c:choose>
					  
					</td>
					</tr>
		          <c:set  var="pre_order_id" value="${item.order_id}" />
		           </c:when>
		      </c:choose>
			   </c:forEach>
			  </c:otherwise>
		    </c:choose> 	    
		</tbody>
		</table>
		
		</div>
		<br><br>
		
		<script>
			function track() {
			  var trackId = document.getElementById("track-id").value;
			  if (trackId === "" || isNaN(trackId)) {
			    alert("유효한 운송장 번호를 입력하세요.");
			    return;
			  }
			  var link = "https://tracker.delivery/#/kr.cjlogistics/" + trackId;
			  window.open(link, "_blank");
			}
		</script>

</body>
</html>
