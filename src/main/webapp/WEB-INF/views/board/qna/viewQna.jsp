<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<c:set var="article"  value="${articleMap.article}"  />
<c:set var="removeCompleted"  value="${articleMap.removeCompleted}"  />
<c:set var="imageFileList"  value="${articleMap.imageFileList}"  />

<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
   <meta charset="UTF-8">
   <title>글보기</title>
   <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
      
<c:choose>
   <c:when test="${removeCompleted eq true }">
   <script type="text/javascript" >
   $(window).load(function(){
	   fn_enable()
	}); 
   </script>
    </c:when>
</c:choose>


   <style>
     #tr_btn_modify{
       display:none;
     }
     
    .tr_modEnable {
      visibility:hidden;
     }
   </style>
   
   <script type="text/javascript" >
     function backToList(obj){
	    obj.action="${contextPath}/board/qna/listQna.do";
	    obj.submit();
     }
 
	function fn_enable( ){
		 document.getElementById("i_title").disabled=false;
		 document.getElementById("i_content").disabled=false;
		 document.getElementById("tr_btn_modify").style.display="block";
		 document.getElementById("tr_btn").style.display="none";
		 $(".tr_modEnable").css('visibility', 'visible');
	 }
	 
	 
	 function fn_modify_article(obj){
		 obj.action="${contextPath}/board/qna/modQna.do";
		 obj.submit();
	 }
	 
	 function fn_remove_article(url,articleNO){
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","articleNO");
	     articleNOInput.setAttribute("value", articleNO);
		 
	     form.appendChild(articleNOInput);
	     document.body.appendChild(form);
	     form.submit();
	 
	 }
	 
	 
	 function fn_reply_form(isLogOn, url, parentNO, groupNO){
			//	 alert("groupNO : " + groupNO )
				  if(isLogOn != '' && isLogOn != 'false'){
						 var form = document.createElement("form");
						 form.setAttribute("method", "post");
						 form.setAttribute("action", url);
					     var parentNOInput = document.createElement("input");
					     parentNOInput.setAttribute("type","hidden");
					     parentNOInput.setAttribute("name","parentNO");
					     parentNOInput.setAttribute("value", parentNO);
					     
					     var groupNOInput = document.createElement("input");
					     groupNOInput.setAttribute("type","hidden");
					     groupNOInput.setAttribute("name","groupNO");
					     groupNOInput.setAttribute("value", groupNO);
					     
						 
					     form.appendChild(parentNOInput);
					     form.appendChild(groupNOInput);
					     document.body.appendChild(form);
						 form.submit();
					  }else{
					    alert("로그인 후 글쓰기가 가능합니다.");
					    location.href="${contextPath}/member/loginForm.do?action=/board/qna/replyForm.do&groupNO=" +groupNO
					    		                                                                                                + "&parentNO="+parentNO;
					  }
				 }

	 
	 function readURL(input, index) {
	     if (input.files && input.files[0]) {
	         var reader = new FileReader();
	         reader.onload = function (e) {
	             $('#preview'+index).attr('src', e.target.result);
	         }
	         reader.readAsDataURL(input.files[0]);
	     }
	 }  
	 
	 function fn_removeModImage(_imageFileNO, _articleNO, _imageFileName, rowNum){
		 alert(rowNum);
			 $.ajax({
		       type:"post",
		       async:false,  
		       url:"http://localhost:8090/pro31/board/qna/removeModImage.do",
		       dataType:"text",
		       data: {imageFileNO : _imageFileNO,  articleNO : _articleNO, imageFileName : _imageFileName},
		       success:function (result, textStatus){
		          if(result == 'success'){
		       	    alert("이미지를 삭제했습니다.");
		     	 	location.href="http://localhost:8090/pro31/board/qna/viewQna.do?removeCompleted=true&articleNO=" + _articleNO;
		  
		  			$('#tr_'+rowNum).remove();
		 			$('#tr_sub'+rowNum).remove();
				  			
		          }else{
		        	  alert("다시 시도해 주세요");
		          }
		       },
	       error:function(data,textStatus){
	          alert("에러가 발생했습니다.");
	       },
	       complete:function(data,textStatus){
	       }
	    });  //end ajax	
	 }
	 
	 var pre_img_num = 0;  //수정 이전의 이미지 수
	 var img_index = 0;     //수정 후 이미지 수 
	 
	 var isFirstAddImage = true;
	 function fn_addModImage(_img_index){
		 
		 if(isFirstAddImage == true){
			 pre_img_num = _img_index;
			 img_index = ++_img_index;
			 isFirstAddImage = false;
		 }else{
			 ++img_index;	 
		 }
		 
		 var innerHtml = "";
		 innerHtml +='<tr  width=200px  align=center>';
		 innerHtml +='<td >'+
		 						"<input  type=file  name=imageFileName" + img_index + "  onchange='readURL(this,"+ img_index+")'   />"+
		 					'</td>';
		 innerHtml +='<td>'+
							"<img  id=preview"+img_index+"  />"+
		                   	'</td>';
		 innerHtml +='</tr>';
		 $("#tb_addImage").append(innerHtml);
	
		 $("#added_img_num").val(img_index);  // 추가된 이미지수를 히든 태그에 저장해서 컨트롤러로 보낸다.
	 }


 </script>
</head>
<body>
  <form name="frmArticle" method="post"   enctype="multipart/form-data">
  <table  border=0  align="center" >
  <tr>
   <td width=150 align="center" bgcolor=#FF9933>
      글번호
   </td>
   <td >
    <input type="text"  value="${article.articleNO }"  disabled />
    <input type="hidden" name="articleNO" value="${article.articleNO}"  />
   </td>
  </tr>
  
  <tr>
    <td width=150 align="center" bgcolor=#FF9933>조회수</td>
    <td> <input type=text value="${article.viewCounts }" name="viewCounts"  disabled /></td>
  </tr>
 
  <tr>
    <td width="150" align="center" bgcolor="#FF9933">
      작성자 아이디
   </td>
   <td >
    <input type=text value="${article.member_id }" name="writer"  disabled />
   </td>
  </tr>
  <tr>
    <td width="150" align="center" bgcolor="#FF9933">
      제목 
   </td>
   <td>
    <input type=text value="${article.title }"  name="title"  id="i_title" disabled />
   </td>   
  </tr>
  <tr>
    <td width="150" align="center" bgcolor="#FF9933">
      내용
   </td>
   <td>
    <textarea rows="20" cols="60"  name="content"  id="i_content"  disabled />${article.content }</textarea>
   </td>  
  </tr>

<c:set  var="img_index" />
<c:choose>  
	 <c:when test="${not empty imageFileList && imageFileList!='null' }">
		  <c:forEach var="item" items="${imageFileList}" varStatus="status" >
			    <tr  id="tr_${status.count}">
				    <td width="150" align="center" bgcolor="#FF9933" >
				      이미지${status.count }
				   </td>
				   <td>
				     <input  type= "hidden"   name="oldFileName" value="${item.imageFileName }" />
				     <input  type= "hidden"   name="imageFileNO" value="${item.imageFileNO }" />
				    <img src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${item.imageFileName}" id="preview${status.index }"  /><br>
				   </td>   
				  </tr>  
				  <tr  class ="tr_modEnable"   id="tr_sub${status.count }">
				    <td>
				       
				    </td>
				    <td >
				       <input  type="file"  name="imageFileName${status.index }" id="i_imageFileName${status.index }"     onchange="readURL(this, ${status.index });"   />
				       <input  type="button" value="이미지 삭제하기"
				           onclick="fn_removeModImage(${item.imageFileNO },  ${item.articleNO }, '${item.imageFileName }', ${status.count })" />
				    </td>
				 </tr>
				 <c:if test="${status.last eq true }">
				      <c:set var="img_index"  value="${status.count}" />
				      <input  type= "hidden"   name="pre_img_num" value="${status.count}" /> <!-- 기존의 이미지수 -->
				      <input  type= "hidden"   id = "added_img_num"   name="added_img_num"  value="${status.count}" />  <!--   수정시 새로 추가된 이미지 수  -->
				 </c:if>
			</c:forEach>
   </c:when>	
   <c:otherwise>
       <c:set var="img_index"  value="${0}" />
      <input  type= "hidden"   name="pre_img_num" value="${0}" /> <!-- 기존의 이미지수 -->
      <input  type= "hidden"   id = "added_img_num"   name="added_img_num"  value="${0}" />  <!--   수정시 새로 추가된 이미지 수  -->
   </c:otherwise>	
 </c:choose>
  <tr>
     <td colspan="2" >
          <table id="tb_addImage"  align="center">
          </table>
	   </td>
  </tr>

  <tr class ="tr_modEnable">
	   <td colspan="2">
	      <input type="button"   value="이미지 추가"  onclick="fn_addModImage(${img_index})"/>
	   </td>
  </tr>
 	  
	 
  <tr>
	   <td width="150" align="center" bgcolor="#FF9933">
	      등록일자
	   </td>
	   <td bgcolor="yellow">
	      ${article.writeDate}
	   </td>   
  </tr>
 
   
  <tr   id="tr_btn_modify"  align="right"  >
	   <td colspan="2"  >
	       <input type=button value="수정반영하기"   onClick="fn_modify_article(frmArticle)"  >
           <input type=button value="취소"  onClick="backToList(frmArticle)">
	   </td>   
	
  </tr>
    
  <tr  id="tr_btn"    >
   <td colspan="2" align="center">
       <c:if test="${memberInfo.member_id == article.member_id }">
	      <input type=button value="수정하기" onClick="fn_enable()">
	      <input type=button value="삭제하기" onClick="fn_remove_article('${contextPath}/board/qna/removeQna.do', ${article.articleNO})">
	    </c:if>
	    <input type=button value="리스트로 돌아가기"  onClick="backToList(this.form)">
	      <input type=button value="답글쓰기"  
	       				onClick="fn_reply_form('${isLogOn}', '${contextPath}/board/qna/replyQnaForm.do', ${article.articleNO}, ${article.groupNO} )">
   </td>
  </tr>
 </table>
 </form>
</body>
</html>