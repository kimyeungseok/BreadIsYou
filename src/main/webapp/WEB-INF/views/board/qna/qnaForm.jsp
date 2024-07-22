<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
<meta charset="UTF-8">
 <script src="//code.jquery.com/jquery-3.3.1.js"></script> 
<script type="text/javascript">
function readURL(input, index) {
    if (input.files && input.files[0]) {
	      var reader = new FileReader();
	      reader.onload = function (e) {
	        $('#preview' + index).attr('src', e.target.result);
        }
       reader.readAsDataURL(input.files[0]);
    }
}  

function backToList(obj){
    obj.action="${contextPath}/board/qna/listQna.do";
    obj.submit();
  }
  
var cnt=1;
function fn_addFile(){
	 cnt++;
	 var innerHtml = "";
	 innerHtml +='<tr  width=100%  align=center>';
	 innerHtml +='<td >'+
	 						"<input  type=file  name='file" + cnt + "'  onchange='readURL(this,"+ cnt + ")'   />"+
	 					'</td>';
	 innerHtml +='<td>'+
						"<img  id='preview" + cnt + "''   width=640 height=480/>"+
	                   	'</td>';
	 innerHtml +='</tr>';
	 $("#tb_newImage").append(innerHtml);
}  
  
</script> 
<title>QNA 쓰기 페이지</title>
</head>

<body>

	<main class="mt-2 pt-2">
		<div class="container-fluid px-4" style="width:800px">
			<div class="title_underline">
				<h3 class="mt-4">문의사항</h3>
			</div>
			<div class="card mb-4">
				<div class="card-body">
					<form  name="articleForm" action="${contextPath}/board/qna/addNewQna.do" method="post"  enctype="multipart/form-data">
					
						<div class="mb-3 mt-3">
							<label class="form-label"><span>작성자</span></label> 
							<input type="text" class="form-control" value="${memberInfo.member_name}" readonly/>
						</div>
						<div class="mb-3 mt-3">
							<label class="form-label"><span>제품 이름</span></label> 				<!-- 세션에 바인딩 시킨 goodsInfo에서 goods_title을 빼온다. -->
							<input type="text" class="form-control" value="${goodsInfo.goods_title}" readonly/>
						</div>
											
						<div class="mb-3">
							<label class="form-label"><span>제목</span></label> 
							<input type="text" class="form-control" name="title" />
						</div>
						<div class="mb-3">
							<label class="form-label"><span>내용</span></label>
							<textarea class="form-control" name="content"></textarea>
						</div>
						<!-- <tr>
				<td align="right" valign="top"><br>글내용: </td>
				<td colspan=2><textarea name="content" rows="20" cols="100" maxlength="4000" placeholder="이곳에 글을 쓰세요."></textarea> </td>
     </tr> -->
						
						<input type=submit value="질문 쓰기" class="btn btn-secondary btn-sm"/>
						<input type=button value="취소" class="btn btn-secondary btn-sm" onClick="backToList(this.form)" />
								
					</form>
				</div>
			</div>
		</div>
	</main>
	
</body>
</html>  --%>





<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
<meta charset="UTF-8">
<title>글쓰기창</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function readURL(input, index) {
      if (input.files && input.files[0]) {
	      var reader = new FileReader();
	      reader.onload = function (e) {
	        $('#preview' + index).attr('src', e.target.result);
          }
         reader.readAsDataURL(input.files[0]);
      }
  }  
  function backToList(obj){
    obj.action="${contextPath}/board/qna/listQna.do";
    obj.submit();
  }
  
  var cnt=1;
  function fn_addFile(){
	 cnt++;
	 var innerHtml = "";
	 innerHtml +='<tr  width=100%  align=center>';
	 innerHtml +='<td >'+
	 						"<input  type=file  name='file" + cnt + "'  onchange='readURL(this,"+ cnt + ")'   />"+
	 					'</td>';
	 innerHtml +='<td>'+
						"<img  id='preview" + cnt + "''   width=640 height=480/>"+
	                   	'</td>';
	 innerHtml +='</tr>';
	 $("#tb_newImage").append(innerHtml);
  }  

</script>
 <title>글쓰기창</title>
</head>
<body>
<h1 style="text-align:center">글쓰기</h1>
  <form name="articleForm" method="post"   
  action="${contextPath}/board/qna/addNewQna.do"   
  enctype="multipart/form-data">
    <table border="0"  align="center">
      <tr>
					<td align="right"> 작성자</td>
					<td colspan=2  align="center">${memberInfo.member_id } </td>
			</tr>
	     <tr>
			   <td align="right">글제목: </td>
			   <td colspan="2"><input type="text" size="67"  maxlength="500" name="title"  placeholder="글제목"/></td>
		 </tr>
	 		<tr>
				<td align="right" valign="top"><br>글내용: </td>
				<td colspan=2><textarea name="content" rows="20" cols="100" maxlength="4000" placeholder="이곳에 글을 쓰세요."></textarea> </td>
     </tr>
     <tr>
			  <td align="right">이미지파일 첨부</td>
			  <td> <input type="file" name="imageFileName"  onchange="readURL(this, 0);" /></td>
			  <td><img  id="preview0" src="#"   width=640px height=480px  /></td>
			  
			  
				
	   </tr>

	    <tr>
        <td colspan="3">
           <table width="100%"  border="0" id="tb_newImage">
           </table>
        </td>
     </tr>
      <tr height="200px">
	     <td colspan="3"> 
	     
	     </td>
	   </tr>
	   <tr>
	   		  
			  
			  <td align="right">이미지파일 첨부</td>
				<td align="left"  colspan="2" > <input type="button" value="새 이미지 파일 추가하기" onClick="fn_addFile()"/></td>
				
	   </tr>
	   <tr>
	      <td colspan="4"><div id="d_file"></div></td>
	   </tr>
	    <tr>
	      <td align="right"> </td>
	      <td colspan="2">
	       <input type="submit" value="글쓰기" />
	       <input type=button value="목록보기"onClick="backToList(this.form)" />
	      </td>
     </tr>
    </table>
  </form>
</body>
</html>
 