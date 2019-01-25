<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>

<title>:::HOMEPAGE:::</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="https://a0.muscache.com/airbnb/static/packages/dls/common_o2.1_cereal-b820ae7d16d76b0900accdef6c28185e.css" media="all" rel="stylesheet" type="text/css" />
<link href="https://a0.muscache.com/airbnb/static/packages/common-c2d2e28a641516ec0a21bccaae33f2ea.css" media="all" rel="stylesheet" type="text/css" />
<link href="https://a0.muscache.com/airbnb/static/packages/address_widget-4f18ee66a37930ce1c93c8f33690c7b0.css" media="screen" rel="stylesheet" type="text/css" /><link href="https://a0.muscache.com/airbnb/static/packages/phonenumbers-7c1faf80765f8cab48b45693af597ea9.css" media="screen" rel="stylesheet" type="text/css" /><link href="https://a0.muscache.com/airbnb/static/business_travel/quick_enroll-9fe44fac8aa94516d93764b9b4e57633.css" media="screen" rel="stylesheet" type="text/css" /><link href="https://a0.muscache.com/airbnb/static/packages/edit_profile-57ea8223a84513da61b565fa5448d1c2.css" media="screen" rel="stylesheet" type="text/css" />
          <style data-aphrodite="data-aphrodite">._1k01n3v1{color:#008489 !important;font:inherit !important;font-family:Circular,-apple-system,BlinkMacSystemFont,Roboto,Helvetica Neue,sans-serif !important;text-decoration:none !important;-webkit-appearance:none !important;-moz-appearance:none !important;appearance:none !important;background:transparent !important;border:0px !important;cursor:pointer !important;margin:0px !important;padding:0px !important;-webkit-user-select:auto !important;-moz-user-select:auto !important;-ms-user-select:auto !important;user-select:auto !important;text-align:left !important;}._1k01n3v1:hover{text-decoration:underline !important;color:#008489 !important;}._1k01n3v1:focus{text-decoration:underline !important;}@supports(--custom: properties){._1k01n3v1{color:var(--color-text-link, #008489) !important;font-family:var(--font-font_family, Circular,-apple-system,BlinkMacSystemFont,Roboto,Helvetica Neue,sans-serif) !important;}._1k01n3v1:hover{color:var(--color-text-link-hover, #008489) !important;}._1k01n3v1:active{color:var(--color-text-link-active, #006C70) !important;}}._1k01n3v1:active{color:#006C70 !important;outline:0px !important;}</style>
<style type="text/css">
._1k01n3v1 {
    color: var(--color-text-link, #008489) !important;
    font-family: var(--font-font_family, Circular,-apple-system,BlinkMacSystemFont,Roboto,Helvetica Neue,sans-serif) !important;
}
</style>
<script type="text/javascript" src="<%= ctxPath %>/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script> 

<script type="text/javascript">
</script>
</head>
<body>

<div class="row">
<!--  사이드바 -->
<div class="col-md-1" style="border: 1px solid red"></div>
    <div class="col-md-2" style="border: 0px solid red;">
	      <div class="sidenav" align="center">
			  <ul class="sidenav-list">
			    <li>
			      <a href="https://www.airbnb.co.kr/users/edit/231754930" aria-selected="true" class="sidenav-item"><h4>프로필 수정</h4></a>
			    </li>
			    <li>
			      <a href="https://www.airbnb.co.kr/users/reviews/231754930" aria-selected="false" class="sidenav-item"><h4>후기</h4></a>
			    </li>
			    <li>
			      <a href="https://www.airbnb.co.kr/users/reviews/231754930" aria-selected="false" class="sidenav-item"><h4>예약 관리</h4></a>
			    </li>
			  </ul>
		 </div>	
	  </div>
<!--  사이드바끝 -->  
    <div class="col-md-6" style="border: 1px solid yellow">
     
      <div id="dashboard-content">
   

	  <ul class="nav nav-tabs">

	    <li class="active"><a data-toggle="tab" href="#home">나에 대한 후기</a></li>

	    <li><a data-toggle="tab" href="#menu1">내가작성한후기</a></li>

	  </ul>

	

	  <div class="tab-content" style="border: 1px solid yellow">

	    <div id="home" class="tab-pane fade in active" style="border: 1px solid red">

	      <div class="panel-header" style="margin-top: 3%; border: 1px solid red">

	     	 <h3 class="edit-profile-section-heading">지난 후기</h3>

	      </div>

	      <div class="panel-body" style="border: 1px solid gray;">

		    <ul class="list-layout reviews-list">

	          <li class="reviews-list-item">

	                           후기는 에어비앤비 숙박이 완료된 후 작성됩니다. 나에 대한 후기는 이곳과 공개 프로필에서 볼 수 있습니다.

			  </li>

			  <li>아직 작성된 후기가 없습니다.</li>

	        </ul>	 

         </div>

	

	    </div>

	    <div id="menu1" class="tab-pane tab-panel">

	    	 <div class="panel-header" style="margin-top: 3%;">

	      		<h3 class="edit-profile-section-heading">작성해야 할 후기</h3>

	         </div>

		     <div class="panel-body" style="border: 1px solid gray; ">

		       <ul class="list-layout reviews-list">

	             <li class="reviews-list-item">

		      		현재 작성할 후기가 없습니다. 여행을 한번 다녀올 때가 된 것 같네요!

		       	 </li>

	        	</ul>	 

        	</div>

          <div class="panel-header" style="margin-top: 3%;">	     

	      	<h3 class="edit-profile-section-heading">내가 작성한 후기</h3>

	      </div>

	      <div class="panel-body" style="border: 1px solid gray;">

	        <ul class="list-layout reviews-list">

	             <li class="reviews-list-item">

	                               아직 후기를 남기지 않으셨습니다.

				 </li>

			</ul>

			</div>

	    </div>	

	   </div>

	  </div>

 </div>

     </div>


</body>
</html>
