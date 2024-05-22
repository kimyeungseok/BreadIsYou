<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />

<c:set var="totalGoodsNum" value="0" /> <!-- 장바구니에 추가된 상품의 '총 개수'입니다. -->
<c:set var="totalDeliveryPrice" value="0" /> <!-- 장바구니에 추가된 상품의 '총 배송비'입니다. -->
<c:set var="totalDiscountedPrice" value="0" /> <!-- 장바구니에 추가된 상품의 '총 주문 금액'입니다. -->

<head>
<script type="text/javascript">

function calcGoodsPrice(bookPrice,obj){
	var totalPrice,final_total_price,totalNum;
	var goods_qty=document.getElementById("select_goods_qty");
	var p_totalNum=document.getElementById("p_totalNum");
	var p_totalPrice=document.getElementById("p_totalPrice");
	var p_final_totalPrice=document.getElementById("p_final_totalPrice");
	var h_totalNum=document.getElementById("h_totalNum");
	var h_totalPrice=document.getElementById("h_totalPrice");
	var h_totalDelivery=document.getElementById("h_totalDelivery");
	var h_final_total_price=document.getElementById("h_final_totalPrice");
	if(obj.checked==true){
		
		totalNum=Number(h_totalNum.value)+Number(goods_qty.value);
		totalPrice=Number(h_totalPrice.value)+Number(goods_qty.value*bookPrice);
		final_total_price=totalPrice+Number(h_totalDelivery.value);

	}else{
		totalNum=Number(h_totalNum.value)-Number(goods_qty.value);
		totalPrice=Number(h_totalPrice.value)-Number(goods_qty.value)*bookPrice;
		final_total_price=totalPrice-Number(h_totalDelivery.value);
	}
	
	h_totalNum.value=totalNum;
	
	h_totalPrice.value=totalPrice;
	h_final_total_price.value=final_total_price;
	
	p_totalNum.innerHTML=totalNum;
	p_totalPrice.innerHTML=totalPrice;
	p_final_totalPrice.innerHTML=final_total_price;
}

function modify_cart_qty(goods_id,bookPrice,index){
   var length=document.frm_order_all_cart.cart_goods_qty.length;
   var _cart_goods_qty=0;
	if(length>1){ //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index].value;		
	}else{
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty.value;
	}
		
	var cart_goods_qty=Number(_cart_goods_qty);
	
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/cart/modifyCartQty.do",
		data : {
			goods_id:goods_id,
			cart_goods_qty:cart_goods_qty
		},
		
		success : function(data, textStatus) {
			//alert(data);
			location.reload();
			if(data.trim()=='modify_success'){
				alert("수량을 변경했습니다!!");	
			}else{
				alert("다시 시도해 주세요!!");	
			}
			
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax	
}

function delete_cart_goods(cart_id){
	var cart_id=Number(cart_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_id";
	i_cart.value=cart_id;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartGoods.do";
    formObj.submit();
}

function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	var total_price,final_total_price,_goods_qty;
	var cart_goods_qty=document.getElementById("cart_goods_qty");
	
	_order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=_order_goods_qty;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
}

//주문하기 버튼 수정
function fn_order_all_cart_goods(){
//	alert("모두 주문하기");
	var order_goods_qty;
	var order_goods_id;
	var objForm=document.frm_order_all_cart;
	var cart_goods_qty=objForm.cart_goods_qty;
	var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
	
	// 상품 주문 여부를 체크하는 체크박스 객체를 가져옵니다.
	var checked_goods=objForm.checked_goods;
	
	// 주문용으로 선택한 총 상품 개수를 가져옵니다.
	var length=checked_goods.length;
	
	// 여러 상품을 주문할 경우 하나의 상품에 대해 '상품 번호:주문 수량' 문자열을 만든 후 전체 상품 정보를 배열로 전송합니다.
	if(length>1){
		for(var i=0; i<length;i++){
			if(checked_goods[i].checked==true){
				//goods_id,cart_id 문자열로 받은뒤에 ,를 기준으로 나눠 담으며 
				//첫번째 오는 값을 담는다.
				order_goods_id = checked_goods[i].value.split(',')[0];
				order_goods_qty=cart_goods_qty[i].value;
				cart_goods_qty[i].value="";
				cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
				//alert(select_goods_qty[i].value);
				console.log(cart_goods_qty[i].value);
			}
		}
	// 상품을 하나만 주문할 경우 문자열로 전송합니다.	
	}else{
		order_goods_id=checked_goods.value[0];
		order_goods_qty=cart_goods_qty.value;
		cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
	}
		
 	objForm.method="post";
 	objForm.action="${contextPath}/order/orderAllCartGoods.do";
	objForm.submit();
	}
	
	
	function backToList(obj){
	  obj.action="${contextPath}/main/main.do";
	  obj.submit();
	}
	
	//상품 체크 삭제 함수
	function deleteCheckedGoods() {
	  var checkboxes = document.getElementsByName('checked_goods');
	  var checkedCartIds = [];
	  // checkedCartIds 배열에 체크된 상품의 카트 ID가 저장된다
	  for (var i = 0; i < checkboxes.length; i++) {
	    if (checkboxes[i].checked) {
	      var valueArr = checkboxes[i].value.split(","); // value에서 ','를 기준으로 문자열을 분리하여 배열에 저장
	      var cartId = valueArr[1].trim(); // 분리된 배열에서 두번째 요소는 카트 ID이므로, 이를 추출하여 trim() 메소드로 좌우 공백을 제거한 후, checkedCartIds 배열에 추가
	      checkedCartIds.push(cartId);
	    }
	  }
	  // form과 input 요소를 생성하여 데이터 전송
	  var formObj = document.createElement('form');
	  var i_cartList = document.createElement('input');
	  i_cartList.type = 'hidden';
	  i_cartList.name = 'checkedCartIds';
	  i_cartList.value = checkedCartIds.join(','); // 배열을 문자열로 변환

	  formObj.appendChild(i_cartList);
	  document.body.appendChild(formObj); 
	  formObj.method = 'POST';
	  formObj.action = '${contextPath}/cart/checkRemove.do';
	  formObj.submit();    
	}
	
	//체크박스 전체선택/해제
	function allCheckboxes() {
	  var checkboxes = document.getElementsByName('checked_goods');
	  for (var i = 0; i < checkboxes.length; i++) {
	    checkboxes[i].checked = !checkboxes[i].checked;
	  }
	}
	
</script>

</head>
<body>
	
	
	
	<main class="mt-4 pt-2">
		<div class="container-fluid px-4" style="width:800px">
			<div class="title_underline">
				<h3 class="cart-title"><b>장바구니</b></h3>
			</div>
			<div class="card mb-4">
				<div class="card-body">
					<div class="cart-list-div">
	
	<table class="table">
		<tbody align=center >
			<tr>
				<td><!-- <input type="checkbox" onclick="allCheckboxes()"/> --></td>
				<td></td>
				<td>상품명</td>
				<td>정가</td>
				<td>판매가</td>
				<td>수량</td>
				<td>합계</td>
				<td>주문</td>
			</tr>
			
			 <c:choose>
				    <c:when test="${ empty myCartList }">
				    <tr>
				       <td colspan=8 class="fixed">
				         <strong>장바구니에 상품이 없습니다.</strong>
				       </td>
				     </tr>
				    </c:when>
			        <c:otherwise>
			 <tr>       
				<form name="frm_order_all_cart">
				
					<!-- 장바구니에 등록된 상품 번호로 조회한 상품 목록을 표시합니다. -->
					<c:forEach var="item" items="${myGoodsList }" varStatus="cnt">
						
						<!-- 장바구니에 담긴 상품 수량을 표시하기 위해 변수를 설정합니다. -->
						<c:set var="cart_goods_qty" value="${myCartList[cnt.count-1].cart_goods_qty}" />
						
						<c:set var="cart_id" value = "${myCartList[cnt.count-1].cart_id}" />
					<td>
						<input type="checkbox" name="checked_goods" checked value="${item.goods_id},${cart_id}" onchange="updateTotalGoodsNum(this)" data-price="${item.goods_sales_price*cart_goods_qty}">
						<!-- 이 스크립트 함수를 바로 아래에 넣어야함 -->
						<script>
							
							//체크된 항목의 갯수와 총 가격을 구하는 함수
							function updateTotalGoodsNum() {
								//checked_goods인 모든 input 요소를 선택하는 query 선택자를 사용해 여러개의 체크박스의 값을 가져와 const에 넣는다
								
								  const checkedGoods = document.querySelectorAll('input[name="checked_goods"]');
								  let totalNum = 0;
								  let totalPrice = 0;
								  
								//위에서 query 선택자는 NodeList 객체의 형태로 반환하는데  forEach() 메서드를 사용해 각 요소의 값을 가져올 수 있다.
								  checkedGoods.forEach(function(checkbox) {
									//체크박스가 실행된 항목만 실행한다
								    if (checkbox.checked) {
								    //체크박스에 저장된 상품 가격 정보를 가져와서 price 변수에 저장한다.
								      const price = Number(checkbox.dataset.price);
								    //totalNum 변수에 1을 더해줌으로써 체크된 항목의 개수를 세고
								      totalNum++;
								    //totalPrice 변수에 체크된 항목의 가격을 더해줌으로써 총 가격을 계산한다.
								      totalPrice += price;
								    }
								  });
								
									//p_~~는 출력용 h_는 값을 서버로 전송하는 용
								  const p_totalGoodsNum = document.getElementById('p_totalGoodsNum');
								  const h_totalGoodsNum = document.getElementById('h_totalGoodsNum');
								  p_totalGoodsNum.textContent = totalNum + '개';
								  h_totalGoodsNum.value = totalNum;
						
								  const p_totalGoodsPrice = document.getElementById('p_totalGoodsPrice');
								  const h_totalGoodsPrice = document.getElementById('h_totalGoodsPrice');
								  p_totalGoodsPrice.textContent = totalPrice.toLocaleString() + '원';
								  h_totalGoodsPrice.value = totalPrice;
								  
								  //최종가격으로도 나타내기 위해 변수 하나 더 설정
								  const p_finalGoodsPrice = document.getElementById('p_finalGoodsPrice');
								  //p_totalGoodsPrice와 같은 값을 내보냄
								  p_finalGoodsPrice.textContent = p_totalGoodsPrice.textContent;
								}
								
								//웹 페이지가 로드되면 아래 함수를 호출해 체크박스의 상태에 따라 상품의 갯수와 가격을 계산하고 결과를 HTML에 출력
								window.onload = function() {
								  updateTotalGoodsNum();
								
								//input 요소중에 checked_goods인 것들을 모두 선택해  forEach로 모든 요소에 반복하면서 change 이벤트가 발생했을때 함수를 실행한다
								//말 그대로 상태가 바로바로 변경된다.
								  const checkedGoods = document.querySelectorAll('input[name="checked_goods"]');
								  checkedGoods.forEach(function(checkbox) {
								    checkbox.addEventListener('change', function() {
								      updateTotalGoodsNum();
								    });
								  });
								};
								
							</script>
					</td>
					<td class="goods_image">
					<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
						<!-- 상품의 이미지를 표시합니다. -->
						<img width="75" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"  />
					</a>
					</td>
					<td>
						<!-- 상품 이름을 표시합니다. -->
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
					</td>
					<td class="price"><span>${item.goods_price }원</span></td>
					<td>
					   
					      <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="discounted_price" />
				            ${discounted_price}원
				        
					</td>
					<td>
					   <input type="text" id="cart_goods_qty" name="cart_goods_qty" size=3 value="${cart_goods_qty}"><br>
						<a href="javascript:modify_cart_qty(${item.goods_id },${item.goods_sales_price*0.9 },${cnt.count-1 });" >
						    <img width="25" src="${contextPath}/resources/image/modify.png" />
						</a>
					</td>
					<td>
					   
					    <fmt:formatNumber value="${item.goods_sales_price*cart_goods_qty}" type="number" var="total_sales_price" />
				         ${total_sales_price}원
						
					</td>
					<td>
					    <a href="javascript:fn_order_each_goods('${item.goods_id }','${item.goods_title }','${item.goods_sales_price}','${item.goods_fileName}');">
					   		<input type="button" class="btn btn-secondary btn-sm" value="주문" />
						</a><br>
						
						<a href="javascript:delete_cart_goods('${cart_id}');">
						   <input type="button" class="btn btn-light btn-sm" value="삭제" />
					   </a>
					</td>
			</tr>
				
				<c:set  var="totalGoodsPrice" value="${item.goods_sales_price*cart_goods_qty }" />
				
				<c:set  var="totalGoodsPrice2" value="${totalGoodsPrice2 + totalGoodsPrice }" />
				
				<c:set  var="totalGoodsNum" value="${totalGoodsNum+1 }" />
				
			   </c:forEach>
		    
		</tbody>
	</table>
     	
	 </c:otherwise>
	</c:choose> 
	
	</div>
	
	<br>
	<br>
	
	<div class="cart-price-div">
	<table class="table">
	     <tr  align=center  class="fixed" >
	       <td class="fixed">총 상품수 </td>
	       <td>총 상품금액</td>
	       <td>  </td>
	       <td>총 배송비</td>
	       <td>  </td>
	       <td>최종 결제금액</td>
	     </tr>
		<tr align=center>
			<td>
  				<p id="p_totalGoodsNum">0개</p>
  				<input id="h_totalGoodsNum" type="hidden" value="0" />
			</td>
	        <td>
  				<p id="p_totalGoodsPrice"></p>
  				<input id="h_totalGoodsPrice" type="hidden" value="0" />
			</td>
	       <td> 
	          <img width="25" src="${contextPath}/resources/image/plus.jpg" style="margin-top:-13px">  
	       </td>
	       <td>
	         <p> 0원 </p>
	       <td>  
	         <img width="25" src="${contextPath}/resources/image/equal.jpg" style="margin-top:-13px">
	       </td>
	       <td>
	       <!-- 최종 결제금액 -->     
  				<p id="p_finalGoodsPrice"></p>
  			</td>
		</tr>
	</table>
	<center>
    <br><br>	
    	<input value="주문하기" type="button" class="btn btn-secondary btn-sm" onClick="fn_order_all_cart_goods()" />
    	<input value="쇼핑계속하기" type="button" class="btn btn-secondary btn-sm" onClick="backToList(this.form)" />

		<input value="선택삭제" type="button" class="btn btn-secondary btn-sm" onClick="deleteCheckedGoods()" />
		
	<center>
</form>
</div>
				</div>
			</div>
		</div>
	</main>
	
</body>
</html>