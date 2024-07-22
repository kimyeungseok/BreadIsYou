<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"    
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
</head>
<body>

<footer class="text-center text-lg-start bg-light text-muted">
 <section class="d-flex justify-content-center justify-content-center p-4 border-bottom">
    <div>
      최고의 빵을 제공합니다.
    </div>
  </section>

  <section class="">
    <div class="container text-center text-md-start mt-5">
      <div class="row mt-3">

        <div class="col-md-4 col-lg-2 col-xl-2 mx-auto mb-4">
          <h6 class="text-uppercase fw-bold mb-4">
            메뉴 
          </h6>
          
          <p>
           <a href="#total">
			<div class="btn" id="main_btn_menu">
			<font color = "black" >
				전체제품
				</font>
			</div>
		</a>
          </p>
          <p>
            <a href="#best">
			<div class="btn" id="main_btn_menu">
			<font color = "black" >
				인기제품
				</font>
			</div>
		</a>
          </p>
          <p>
           <a href="#new">
			<div class="btn" id="main_btn_menu">
			<font color = "black" >
				신제품
				</font>
			</div>
		</a>
          </p>
          <p>
           <a href="#discount">
			<div class="btn" id="main_btn_menu">
			<font color = "black" >
				사장님 추천 제품
				</font>
			</div>
		</a>
          </p>
        </div>

        <div class="col-md-4 col-lg-2 col-xl-2 mx-auto mb-4">
          <h6 class="text-uppercase fw-bold mb-4">
            자주 쓰는 메뉴
          </h6>
          <p>
            <a href="${contextPath}/main/main.do" class="text-reset">홈</a>
          </p>
          <p>
            <a href="${contextPath}/admin/notice/listNotice.do" class="text-reset">공지사항</a>
          </p>
          <p>
            <a href="${contextPath}/board/qna/listQna.do" class="text-reset">질문과답변</a>
          </p>
          <p>
            <a href="${contextPath}/board/review/listReview.do" class="text-reset">후기</a>
          </p>
        </div>

        <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
          <h6 class="text-uppercase fw-bold mb-4">고객센터</h6>
          <div id="daumRoughmapContainer1678798418740" class="root_daum_roughmap root_daum_roughmap_landing"></div>
	      <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
		  <script charset="UTF-8">
		    new daum.roughmap.Lander({
			"timestamp" : "1678798418740",
			"key" : "2e3bt",
			"mapWidth" : "400",
			"mapHeight" : "200"
			}).render();
		  </script>
          <p>대전 서구 계룡로 637 정일빌딩 3층 Bread Is You</p>
          <p>+82 123 456 78</p>
          <p>+82 234 567 89</p>
        </div>
      </div>
    </div>
  </section>
 
 <div class="text-center p-4" style="background-color: rgba(0, 0, 0, 0.05);">
	   <p class="footer_p">Copyright 2024. Bread Is You<br>
		All rights reserved.</p>
  </div>
</footer>
</body>
</html>