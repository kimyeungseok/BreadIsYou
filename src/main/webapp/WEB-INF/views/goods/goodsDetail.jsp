<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goodsVO}"  />
<c:set var="imageList"  value="${goodsMap.imageList }"  />
<c:set var="reviewList" value="${reviewList }" />
 <%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn" , "\n"); //Ajax로 변경 시 개행 문자 
      pageContext.setAttribute("br", "<br/>"); //br 태그
%>  
<html>
<head>
<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
}

#popup {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 40%;
	top: 50%;
	width: 300px;
	height: 100px;
	background-color: white;
	border: 4px solid #87CEFA;
	font-family: 'Cafe24SsurroundAir' !important;
	border-radius: 10px;
	line-height: 90px;
}

#close {
	z-index: 4;
	float: right;
}

</style>
<script type="text/javascript">

//해당 장바구니 담기 스크립트 함수 수정

function add_cart(goods_id) {
    var order_goods_qty = document.getElementsByName("order_goods_qty")[0].value;
    $.ajax({
        type : "post",
        async : false, //false인 경우 동기식으로 처리한다.

        // Ajax를 이용해 장바구니에 추가할 상품 번호를 전송합니다.
        url : "${contextPath}/cart/addGoodsInCart.do",
        data : {goods_id:goods_id,
            order_goods_qty:order_goods_qty},

        success : function(data, textStatus) {
            //alert(data);
        //    $('#message').append(data);
            // 장바구니에 추가하면 알림창을 표시합니다.
            if(data.trim()=='add_success'){
                imagePopup('open', '.layer01');

            }else if(data.trim()=='already_existed'){
                alert("이미 카트에 등록된 상품입니다.");
            }

        },
        error : function(data, textStatus) {
            alert("로그인 후 장바구니에 담을 수 있습니다.");
            location.href = "${contextPath}/member/loginForm.do?action=/goods/goodsDetail.do&goods_id="+goods_id;
        },
        complete : function(data, textStatus) {
            //alert("작업을완료 했습니다");
        }
    }); //end ajax
}

	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');

			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer').height(jQuery(document).height());
		}

		else if (type == 'close') {

			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}
	
	function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
		
		// <hidden> 태그의 id로 로그인 상태를 가져옵니다.
		var _isLogOn=document.getElementById("isLogOn");
		var isLogOn=_isLogOn.value;
		
		// 로그인 상태를 확인합니다.
		if(isLogOn=="false" || isLogOn=='' ){
			alert("로그인 후 주문이 가능합니다!!!");
		} 
	
		var total_price,final_total_price;
		
		// 상품 주문 개수를 가져옵니다.
		var order_goods_qty=document.getElementById("order_goods_qty");
		
		// <form> 태그를 동적으로 생성합니다.
		var formObj=document.createElement("form");
		
		// 주문 상품 정보를 전송할 <input> 태그를 동적으로 생성합니다.
		var i_goods_id = document.createElement("input"); 
	    var i_goods_title = document.createElement("input");
	    var i_goods_sales_price=document.createElement("input");
	    var i_fileName=document.createElement("input");
	    var i_order_goods_qty=document.createElement("input");
	    
	    // <input> 태그에 name/value로 값을 설정합니다.
	    i_goods_id.name="goods_id";
	    i_goods_title.name="goods_title";
	    i_goods_sales_price.name="goods_sales_price";
	    i_fileName.name="goods_fileName";
	    i_order_goods_qty.name="order_goods_qty";
	    i_goods_id.value=goods_id;
	    i_order_goods_qty.value=order_goods_qty.value;
	    i_goods_title.value=goods_title;
	    i_goods_sales_price.value=goods_sales_price;
	    i_fileName.value=fileName;
	    
	    // 동적으로 생성한 <input> 태그에 값을 설정한 후 다시 <form> 태그에 추가합니다.
	    formObj.appendChild(i_goods_id);
	    formObj.appendChild(i_goods_title);
	    formObj.appendChild(i_goods_sales_price);
	    formObj.appendChild(i_fileName);
	    formObj.appendChild(i_order_goods_qty);
	
	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    
	    // 컨트롤러로 요청하면서 <input> 태그의 값을 매개변수로 전달합니다.
	    formObj.action="${contextPath}/order/orderEachGoods.do";
	    formObj.submit();
	}
	
	//리뷰 로그인 여부
	function fn_review_Form(isLogOn,url,goods_id) {
		if (isLogOn != '' && isLogOn != 'false'){
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", url);
			var Goods_IdInput = document.createElement("input");
			Goods_IdInput.setAttribute("type", "hidden");
			Goods_IdInput.setAttribute("name", "goods_id");
			Goods_IdInput.setAttribute("value", goods_id);

			form.appendChild(Goods_IdInput);
			document.body.appendChild(form);
			form.submit();
		}else {
			alert("로그인 후 글쓰기가 가능합니다.");
			location.href = "${contextPath}/member/loginForm.do?action=/board/review/reviewForm.do&goods_id="+goods_id;
		}
	}
	
	//QNA 로그인 여부
	function fn_qna_Form(isLogOn,url,goods_id) {
		if (isLogOn != '' && isLogOn != 'false'){
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", url);
			var Goods_IdInput = document.createElement("input");
			Goods_IdInput.setAttribute("type", "hidden");
			Goods_IdInput.setAttribute("name", "goods_id");
			Goods_IdInput.setAttribute("value", goods_id);

			form.appendChild(Goods_IdInput);
			document.body.appendChild(form);
			form.submit();
		}else {
			alert("로그인 후 글쓰기가 가능합니다.");
			location.href = "${contextPath}/member/loginForm.do?action=/board/qna/qnaForm.do&goods_id="+goods_id;
		}
	}
	
	 /* 리뷰삭제 */
	 function deleteReview(review_id){
		$.ajax({
		    type : "post",
		    async : true, //false인 경우 동기식으로 처리한다.
		    url : "${contextPath}/board/review/removeReview.do",
		    data: {review_id:review_id},
		    success : function(data, textStatus) {
		    	location.reload();
		    	alert("리뷰를 삭제했습니다!!");
		            tr.style.display = 'none';
		    },
		    error : function(data, textStatus) {
		    	alert("에러가 발생했습니다."+textStatus);
		    },
		    complete : function(data, textStatus) {
		    	//alert("작업을 완료 했습니다");
		    			
		    }
		}); //end ajax	
	}
	 
	/* QNA 삭제 */
	function deleteQna(qna_id){
	   	$.ajax({
	 		type : "post",
	 		async : true, //false인 경우 동기식으로 처리한다.
	 		url : "${contextPath}/board/qna/removeQna.do",
	 		data: {qna_id:qna_id},
	 		success : function(data, textStatus) {
	 			location.reload();
	 			alert("QNA를 삭제했습니다!!");
	            tr.style.display = 'none';
		                
	 		},
	 		error : function(data, textStatus) {
	 			alert("에러가 발생했습니다."+textStatus);
	 		},
	 		complete : function(data, textStatus) {
	 			//alert("작업을 완료 했습니다");
		    			
	   		}
	   	}); //end ajax	
	}
	 
	
	
	setTimeout(function() { //setTimeout 함수 이용
		var popup = document.getElementById("layer"); //layer라는 id를 가진 element 요소 불러와서 popup에 담음
		popup.style.visibility = "hidden"; //popup을 hidden으로 변경해서 보이지 않도록 팝업창 숨김
	}, 2300); //2.3초
	
</script>
</head>
<body>
	
	<div style="border-bottom: 1px solid black">
		<h3 class="goods-title"><b>${goods.goods_title }</b></h3>
	</div>
	
	<div class="card mt-5">
	
  		<div class="row g-0">
    		
    		<div class="col-md-5">
     			<img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_fileName}" />
    		</div>
    
	    <div class="col-md-7">
	    
	    	<div class="card-body">
				<br><br><br>
	    		<table class="table">
	    			<tr>
	    				<td><b>정가</b></td>
	    				<td>
	    					<fmt:formatNumber value="${goods.goods_price}" type="number" var="goods_price" />
				         	${goods_price}원
	    				</td>
	    			</tr>
	    			<tr>
	    				<td><b>판매가</b></td>
	    				<td>
	    					<fmt:formatNumber value="${goods.goods_sales_price}" type="number" var="discounted_price" />
				        	${discounted_price}원
	    				</td>
	    			</tr>
	    			<!-- <tr>
	    				<td><b>포인트적립</b></td>
	    				<td>
	    					10% 적립
	    				</td>
	    			</tr> -->
	    			<tr>
	    				<td><b>배송비</b></td>
	    				<td>무료</td>
	    			</tr>
	    			<tr>
	    				<td><b>배송방법</b></td>
	    				<td>택배배송</td>
	    			</tr>
	    			<tr>
	    				<td class="fixed"><b>수량</b></td>
						<td class="fixed">
							<!-- 셀렉트 박스로 주문 수량을 선택합니다. -->
							<select id="order_goods_qty" style="width: 60px;" name="order_goods_qty">
	                            <option value="1">1</option>
	                            <option value="2">2</option>
	                            <option value="3">3</option>
	                            <option value="4">4</option>
	                            <option value="5">5</option>
                            </select>
						</td>
	    			</tr>
	    		</table>
	    			
	    			<br>
	    			
			    	<input value="구매" type="button" class="btn btn-secondary btn-sm" onClick="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title }','${goods.goods_sales_price}','${goods.goods_fileName}');">
					<input value="장바구니" type="button" class="btn btn-secondary btn-sm" onClick="javascript:add_cart('${goods.goods_id }')">
					
					<c:if test="${isLogOn==true and not empty memberInfo}">
						<a href='${contextPath}/cart/myCartList.do'><input value="장바구니 보기" type="button" class="btn btn-secondary btn-sm"></a>
	    			</c:if>
	    			
	      		</div>
	      		
	    	</div>
	    	
		</div>
		
	</div>
	
	
	<!-- 내용 들어 가는 곳 -->
	<div class="container">
	
		<ul class="tabs" id="goods_detail_menu">
			<li><a href="#tab1"><span><b><font color = "white" >상세정보</font></b></span></a></li>
			<li><a href="#tab2"><span><b><font color = "white" >후기</font>&nbsp;(<span id="review_count"></span>)</b></span></a></li>
			<li><a href="#tab3"><span><b><font color = "white" >질문과답변</font>&nbsp;(<span id="qna_count"></span>)</b></span></a></li>
			<li><a href="#tab4"><span><b><font color = "white" >반품/교환정보</font></b></span></a></li>
		</ul>
		
		<div class="tab_container">
		
			<div class="tab_content" id="tab1">
				<c:forEach var="image" items="${imageList }">
					<img src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${image.fileName}">
				</c:forEach>
			</div>
			
			<div class="tab_content" id="tab2">
			<table class="table table-striped table-hover">
  				<tr height="10" align="center" style="background:#2a4c34">
     				 <td width="7%"><b>번호</b></td>
    				 <td width="59%"><b>내용</b></td>
    				 <td width="10%"><b>별점</b></td>
    				 <td width="10%"><b>작성자</b></td>              
     				 <td width="14%" align="left">&nbsp;&nbsp;<b>작성일</b></td>
  				</tr>
			
					<c:choose>
						<c:when test="${reviewList == null}">
							<tr height="10">
				     			<td colspan="4">
					         		<p align="center">
					            		<b><span style="font-size:9pt;">등록된 리뷰가 없습니다.</span></b>
					        		</p>
				      			</td>  
			      			</tr>
			  			</c:when>
					
						<c:when test="${reviewList != null }">
							<c:forEach var="review" items="${reviewList }" varStatus="reviewNum">
							 	<tr align="center">
									<td>${reviewNum.count}</td>
									<td>${review.content}</td>
									<c:if test="${review.star == 5}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
									<c:if test="${review.star == 4}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
									<c:if test="${review.star == 3}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
									<c:if test="${review.star == 2}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
									<c:if test="${review.star == 1}"><td><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
									<td>${review.member_id}</td>
									<td align="left">
										${review.write_date}
										<c:if test="${isLogOn == true and review.member_id == memberInfo.member_id || isLogOn == true and memberInfo.member_id == 'admin'}">
											&nbsp;<input type=button value="X" onClick="deleteReview('${review.review_id}')" />
										</c:if>
									</td>
										
							 	</tr>
							 </c:forEach>
						</c:when>
		   			</c:choose>
				</table>
				<!-- 리뷰쓰기 버튼 -->
				<input type=button class="btn btn-secondary btn-sm" value="후기 작성" onClick="fn_review_Form('${isLogOn}', '${contextPath}/board/review/reviewForm.do', '${goods.goods_id}')"   />
			</div>
			
			<script>
			  // 리뷰글 총 갯수를 출력하는 함수
			  function showReviewCount(count) {
			    var reviewCount = document.getElementById("review_count");
			    reviewCount.innerHTML =  + count + "개";
			  }
		
			  // 리뷰글 총 갯수를 표시할 span 요소에 데이터 바인딩
			  //showReviewCount(${fn:length(reviewList)});
			</script>
			
			<!-- QNA 구역 -->
			<div class="tab_content" id="tab3">
				
				<table class="table table-striped table-hover">
  				<tr height="10" align="center" style="background:#2a4c34">
  					<td width="10%"><b>번호</b></td>
    				 <td width="66%"><b>제목</b></td>
    				 <td width="10%"><b>작성자</b></td>              
     				 <td width="14%" align="left">&nbsp;&nbsp;<b>작성일</b></td>
  				</tr>
			
					<c:choose>
						<c:when test="${qnaList == null}">
							<tr height="10">
				     			<td colspan="4">
					         		<p align="center">
					            		<b>등록된 QnA가 없습니다.</b>
					        		</p>
				      			</td>  
			      			</tr>
			  			</c:when>
					
						<c:when test="${qnaList != null }">
							<c:forEach var="qna" items="${qnaList }" varStatus="qnaNum">
							 	<tr align="center">
									<td>${qnaNum.count}</td>
									<td>
										<a href="${contextPath}/board/qna/viewQna.do?qna_id=${qna.qna_id}">
					    					${qna.title}
										</a>
									 </td>
									<td>${qna.member_id}</td>
									<td align="left">
										${qna.write_date}
										<c:if test="${isLogOn == true and qna.member_id == memberInfo.member_id || isLogOn == true and memberInfo.member_id == 'admin'}">
											&nbsp;<input type=button value="X" onClick="deleteQna('${qna.qna_id}')" />
										</c:if>
									</td>
									
							 	</tr>
							 </c:forEach>
						</c:when>
		   			</c:choose>
				</table>
				<!-- QNA쓰기 버튼 -->
				<input type=button class="btn btn-secondary btn-sm" value="질문과 답변 작성" onClick="fn_qna_Form('${isLogOn}', '${contextPath}/board/qna/qnaForm.do', '${goods.goods_id}')"   />
			</div>
				
			<script>
  				// qna글 총 갯수를 출력하는 함수
	  			function showReviewCount(count) {
	    		var reviewCount = document.getElementById("qna_count");
	    		reviewCount.innerHTML =  + count + "개";
	  			}
	
	  			// qna
	  			//showReviewCount(${fn:length(qnaList)});
			</script>	
				
			</div>
			
			<div class="tab_content" id="tab4">
				<table class="table">
					<tr>
						<td colspan="2" align="center">
							<h3><b>BREAD IS YOU 반품/교환 안내</b></h3>
						</td>
					</tr>
					<tr>
						<td align="center">지정 택배사</td>
						<td>모두택배</td>
					</tr>
					<tr>
						<td align="center">반품 배송비</td>
						<td>편도 3,000원</td>
					</tr>
					<tr>
						<td align="center">보내실 곳</td>
						<td>대전광역시 서구 계룡로 637 정일빌딩 7층, 3층</td>
					</tr>
					<tr>
						<td align="center">반품/교환 사유에 따른<br>요청 가능 기간</td>
						<td>구매자 단순 변심은 상품 수령 후 7일 이내</td>
					</tr>
					<tr>
						<td align="center">반품/교환 불가능 사유</td>
						<td>
							1. 반품 요청 기간이 지난 경우<br>
							2. 구매자의 책임있는 사유로 상품 등이 멸실 또는 훼손된 경우<br>
							3. 구매자의 책임있는 사유로 포장이 훼손되어 상품 가치가 현저히 상실된 경우<br>
							4. 구매자의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우<br>
							5. 시간의 경과에 의하여 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한 경우<br>
							6. 고객의 요청사항에 맞춰 제작에 들어가는 맞춤 제작 상품의 경우<br>
							7. 복제가 가능한 상품 등의 포장을 훼손한 경우
						</td>
					</tr>
				</table>
			</div>
			
		</div>

	<div id="layer" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup" >
			<!-- 팝업창 닫기 버튼 -->
			<font size="3.5" id="contents">
			<b>상품을 장바구니에 담았습니다.</b></font>
			<%-- <a href='${contextPath}/cart/myCartList.do'><input value="장바구니 보기" type="button" class="btn btn-secondary btn-sm"></a> --%>
			<a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');">
				<!-- <input type="button" class="btn btn-secondary btn-sm" value="닫기"/> -->
			</a>
			</div>
		</div>
	
</body>
</html>

<!-- 로그인 상태를 <hidden> 태그에 저장합니다. -->
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>