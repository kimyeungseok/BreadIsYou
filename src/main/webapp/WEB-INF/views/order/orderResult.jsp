<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
</head>
<body>

	<div class="title_underline" id="order-result-title">
		<h3>최종 주문 내역서</h3>
	</div>
	
	<div class="card mt-4" style="width:1400px;">
	  <div class="row g-0">
	  
	    <div class="col-md-7" style="border-right:2px solid lightgrey; padding:0 20px 0 20px;">
	      <br><br>
	     <div class="title_underline">
	   <h3>주문 상품</h3>
	   </div>
	     
	    	<table class="table">
		<tbody align=center>
			<tr style="background: #00BFFE">
			    <td>주문번호 </td>
			    <td></td>
				<td>주문상품명</td>
				<td>수량</td>
				<td>주문금액</td>
				<td>배송비</td>
				<td>주문금액합계</td>
			</tr>
			<tr>
				<c:forEach var="item" items="${myOrderList }">
				    <td> ${item.order_id }</td>
					<td class="goods_image">
					  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
					    <img width="75" alt=""  src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
					  </a>
					</td>
					<td>
					     <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
					</td>
					<td>
					  ${item.order_goods_qty }개
					</td>
					<td>${item.order_goods_qty *item.goods_sales_price}원</td>
					<td>0원</td>
					<td>
					  <b>${item.order_goods_qty *item.goods_sales_price}원</b>
					</td>
			</TR>
			</c:forEach>
		</tbody>
	</table>
	
	<form name="form_order">
	
	<div class="title_underline">
		<h3>배송지 정보</h3>
	</div>
	
	<div class="detail_table">
	
		<table class="table">
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">받으실 분</td>
					<td>
					${myOrderInfo.receiver_name }
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">휴대폰번호</td>
					<td>
					  ${myOrderInfo.receiver_hp1}-${myOrderInfo.receiver_hp2}-${myOrderInfo.receiver_hp3}</td>
				  </tr>
				<tr class="dot_line">
					<td class="fixed_join">유선전화(선택)</td>
					<td>
					   ${myOrderInfo.receiver_tel1}-${myOrderInfo.receiver_tel2}-${myOrderInfo.receiver_tel3}
					</td>
				</tr>


				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>
					   ${myOrderInfo.delivery_address}
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">배송 메시지</td>
					<td>
					${myOrderInfo.delivery_message}
					</td>
				</tr>
			</tbody>
		</table>
		
	</div>
	
	
	
		
	    </div>
	    
	    
	    <div class="col-md-5">
	    
		<div >	
	  <br><br>
	  <div class="title_underline">
	   <h3>주문고객</h3>
	   </div>
		 <table class="table">
		   <tbody>
			 <tr class="dot_line">
				<td >이름</td>
				<td>
				 <input type="text" value="${orderer.member_name}" size="15" disabled />
				</td>
			  </tr>
			  <tr class="dot_line">
				<td >핸드폰</td>
				<td>
				 <input type="text" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}" size="15" disabled />
				</td>
			  </tr>
			  <tr class="dot_line">
				<td >이메일</td>
				<td>
				   <input type="text" value="${orderer.email1}@${orderer.email2}" size="15" disabled />
				</td>
			  </tr>
		   </tbody>
		</table>
	</div>
	
		<div class="title_underline">
			<h3>결제정보</h3>
		</div>
		
		<div class="detail_table">
			<table class="table">
				<tbody>
					<tr class="dot_line">
						<td class="fixed_join">결제방법</td>
						<td>
						   ${myOrderInfo.pay_method }
					    </td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">결제카드</td>
						<td>
						   ${myOrderInfo.card_com_name}
					    </td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">할부기간</td>
						<td>
						   ${myOrderInfo.card_pay_month }
					    </td>
					</tr>
				</tbody>
			</table>
			<a href="${contextPath}/main/main.do"> 
			   <input type="button" value="쇼핑계속하기" class="btn btn-secondary btn-sm" />
			</a>
		</div>
	</form>
		
		
	
    	</div>
    	
	  </div>
	  
	</div>
			
</body>	
			
			