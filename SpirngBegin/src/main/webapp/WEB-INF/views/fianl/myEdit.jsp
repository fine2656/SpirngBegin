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
<div class="col-md-2 space-sm-4" ></div>
    <div class="col-md-2 space-sm-4" style="border: 1px solid red">
	      <div class="sidenav">
			  <ul class="sidenav-list">
			    <li>
			      <a href="https://www.airbnb.co.kr/users/edit/231754930" aria-selected="true" class="sidenav-item">프로필 수정</a>
			    </li>
			    <li>
			      <a href="https://www.airbnb.co.kr/users/reviews/231754930" aria-selected="false" class="sidenav-item">후기</a>
			    </li>
			    <li>
			      <a href="https://www.airbnb.co.kr/users/reviews/231754930" aria-selected="false" class="sidenav-item">예약 관리</a>
			    </li>
			  </ul>
		 </div>	
	  </div>
<!--  사이드바끝 -->  
    <div class="col-md-6">
     
      <div id="dashboard-content">
       
<form>
	<h1 class="screen-reader-only">프로필 수정</h1>
	<div class="panel space-4">
	  <div class="panel-header">
	    <h2 class="edit-profile-section-heading">필수사항 </h2>
	  </div>
	  <div class="panel-body">
	    <input type="hidden" name="password" id="user_email_password" value="">

	          <div class="row row-condensed space-4">
	        <label class="text-right col-sm-3" for="user_last_name">
	          이름(예: 홍) 
	        </label>
	        <div class="col-sm-9">
	          
	      <input id="user_last_name" name="user[last_name]" size="30" type="text" value="Choi">
	
	          <div class="text-muted space-top-1">예약 요청 시 호스트는 회원님의 이름을 모두 확인할 수 있습니다.</div>
	        </div>
	      </div>
	
	      <div class="row row-condensed space-4"><label class="text-right col-sm-3" for="user_sex">
	          성별 <i aria-label="비공개" class="icon icon-lock icon-ebisu" data-behavior="tooltip" role="img" tabindex="0"></i>
	        </label>
	        <div class="col-sm-9">
	          
	      <div class="select">
	        <select id="user_sex" name="user[sex]">
	        	<option value="" selected="selected">성별</option>
				<option value="Male">남자</option>
				<option value="Female">여자</option>
				<option value="Other">기타</option>
			</select>
	      </div>	
	       <div class="text-muted space-top-1">이 정보는 통계 목적으로 사용되며 다른 회원들에게 절대 공개되지 않습니다.</div>
	        </div>
	      </div>
	<!--  생년월일 -->
	       <div class="row row-condensed space-4">
		        <label class="text-right col-sm-3" for="user_birthdate">
					생년월일 <i aria-label="비공개" class="icon icon-lock icon-ebisu" data-behavior="tooltip" role="img" tabindex="0"></i>
		        </label>
	        <div class="col-sm-9">	          
	        <fieldset>
	          <legend class="screen-reader-only">생년월일</legend>
	          <div class="select">
	            <select aria-label="월" id="user_birthdate_2i" name="user[birthdate(2i)]">
					<option value="">월</option>
					<option value="1">1월</option>
					<option value="2">2월</option>
					<option value="3">3월</option>
					<option selected="selected" value="4">4월</option>
					<option value="5">5월</option>
					<option value="6">6월</option>
					<option value="7">7월</option>
					<option value="8">8월</option>
					<option value="9">9월</option>
					<option value="10">10월</option>
					<option value="11">11월</option>
					<option value="12">12월</option>
					</select>					
	          </div>
	          <div class="select">
	            <select aria-label="일" id="user_birthdate_3i" name="user[birthdate(3i)]">
				<option value="">일</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				<option value="6">6</option>
				<option value="7">7</option>
				<option value="8">8</option>
				<option value="9">9</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
				<option value="13">13</option>
				<option value="14">14</option>
				<option value="15">15</option>
				<option value="16">16</option>
				<option value="17">17</option>
				<option value="18">18</option>
				<option value="19">19</option>
				<option value="20">20</option>
				<option value="21">21</option>
				<option selected="selected" value="22">22</option>
				<option value="23">23</option>
				<option value="24">24</option>
				<option value="25">25</option>
				<option value="26">26</option>
				<option value="27">27</option>
				<option value="28">28</option>
				<option value="29">29</option>
				<option value="30">30</option>
				<option value="31">31</option>
				</select>	
	          </div>
	          <div class="select">
	            <select aria-label="년" id="user_birthdate_1i" name="user[birthdate(1i)]">
					<option value="">년</option>
					<option value="2018">2018</option>
					<option value="2017">2017</option>
					<option value="2016">2016</option>
					<option value="2015">2015</option>
					<option value="2014">2014</option>
					<option value="2013">2013</option>
					<option value="2012">2012</option>
					<option value="2011">2011</option>
					<option value="2010">2010</option>
					<option value="2009">2009</option>
					<option value="2008">2008</option>
					<option value="2007">2007</option>
					<option value="2006">2006</option>
					<option value="2005">2005</option>
					<option value="2004">2004</option>
					<option value="2003">2003</option>
					<option value="2002">2002</option>
					<option value="2001">2001</option>
					<option value="2000">2000</option>
					<option value="1999">1999</option>
					<option value="1998">1998</option>
					<option value="1997">1997</option>
					<option value="1996">1996</option>
					<option value="1995">1995</option>
					<option value="1994">1994</option>
					<option value="1993">1993</option>
					<option selected="selected" value="1992">1992</option>
					<option value="1991">1991</option>
					<option value="1990">1990</option>
					<option value="1989">1989</option>
					<option value="1988">1988</option>
					<option value="1987">1987</option>
					<option value="1986">1986</option>
					<option value="1985">1985</option>
					<option value="1984">1984</option>
					<option value="1983">1983</option>
					<option value="1982">1982</option>
					<option value="1981">1981</option>
					<option value="1980">1980</option>
					<option value="1979">1979</option>
					<option value="1978">1978</option>
					<option value="1977">1977</option>
					<option value="1976">1976</option>
					<option value="1975">1975</option>
					<option value="1974">1974</option>
					<option value="1973">1973</option>
					<option value="1972">1972</option>
					<option value="1971">1971</option>
					<option value="1970">1970</option>
					<option value="1969">1969</option>
					<option value="1968">1968</option>
					<option value="1967">1967</option>
					<option value="1966">1966</option>
					<option value="1965">1965</option>
					<option value="1964">1964</option>
					<option value="1963">1963</option>
					<option value="1962">1962</option>
					<option value="1961">1961</option>
					<option value="1960">1960</option>
					<option value="1959">1959</option>
					<option value="1958">1958</option>
					<option value="1957">1957</option>
					<option value="1956">1956</option>
					<option value="1955">1955</option>
					<option value="1954">1954</option>
					<option value="1953">1953</option>
					<option value="1952">1952</option>
					<option value="1951">1951</option>
					<option value="1950">1950</option>
					<option value="1949">1949</option>
					<option value="1948">1948</option>
					<option value="1947">1947</option>
					<option value="1946">1946</option>
					<option value="1945">1945</option>
					<option value="1944">1944</option>
					<option value="1943">1943</option>
					<option value="1942">1942</option>
					<option value="1941">1941</option>
					<option value="1940">1940</option>
					<option value="1939">1939</option>
					<option value="1938">1938</option>
					<option value="1937">1937</option>
					<option value="1936">1936</option>
					<option value="1935">1935</option>
					<option value="1934">1934</option>
					<option value="1933">1933</option>
					<option value="1932">1932</option>
					<option value="1931">1931</option>
					<option value="1930">1930</option>
					<option value="1929">1929</option>
					<option value="1928">1928</option>
					<option value="1927">1927</option>
					<option value="1926">1926</option>
					<option value="1925">1925</option>
					<option value="1924">1924</option>
					<option value="1923">1923</option>
					<option value="1922">1922</option>
					<option value="1921">1921</option>
					<option value="1920">1920</option>
					<option value="1919">1919</option>
					<option value="1918">1918</option>
					</select>	
	          </div>
	        </fieldset>	
	          <div class="text-muted space-top-1">이 정보는 통계 목적으로 사용되며 다른 회원들에게 절대 공개되지 않습니다.</div>
	        </div>
	      </div>
		<!--  생년월일 끝-->
	   	<div class="row row-condensed space-4">
	        <label class="text-right col-sm-3" for="user_email">
	       	   이메일 주소 <i aria-label="비공개" class="icon icon-lock icon-ebisu" data-behavior="tooltip" role="img" tabindex="0"></i>
	        </label>
	        <div class="col-sm-9">
	        	<input id="user_email" name="user[email]" size="30" type="text" value="">
	            <div class="text-muted space-top-1">이메일 주소는 다른 에어비앤비 회원에게 공개되지 않습니다.</div>
	        </div>
	      </div>
	
	      <div class="row row-condensed space-4">
	        <label class="text-right col-sm-3" for="user_phone_numbers">
	          전화번호
	        </label>
	        <div class="col-sm-9">
	        <div style="margin-top:8px"><button type="button" class="_1k01n3v1" aria-busy="false">전화번호 입력</button></div>
	       	<!--  전화번호 입력 버튼 선택 시  -->
	      <!--  번호 입력 네모 박스 -->
	       <div class="col-sm-9">
                <div data-hypernova-key="edit_profilephone_numbersbundlejs" data-hypernova-id="2bfcb4d3-787f-44ee-b8a5-8f3873c1a055"><div dir="ltr" data-reactroot=""><div style="margin-top:9px"><div><strong>입력된 전화번호가 없습니다.</strong><div style="margin-top:4px"><div class="text-muted">예약 요청, 미리 알림 및 기타 알림을 보내드립니다.</div></div>
	                <div style="margin-top:8px"><div class="phone-number-verify-widget "><div class="_16lavrk"><div class="phone-number-input-widget"><strong>전화번호 추가하기</strong><div style="margin-bottom: 16px;">이 전화번호로 알림을 보내드립니다.</div><div class=""></div><div class="pniw-number-container clearfix"><input type="tel" id="phone_number" style="width: 70%" ></div>
		                <div style="margin-top: 16px;"><button type="button" class="btn btn-primary" style="margin: 2%">문자로 인증하기</button><button type="button" class="btn btn-primary">전화로 인증</button></div>
						</div></div></div>
	                </div>
	                </div></div></div>
                </div>
		   </div> 
		  <!--  번호 입력 네모 박스 끝 -->
        <!--  전화번호 입력 버튼 선택 시  -->
	        </div>
	      </div>
	
	          <div class="row row-condensed space-4">
	        <label class="text-right col-sm-3" for="user_profile_info_about">
	          자기소개 
	        </label>
	        <div class="col-sm-9">
	          
	      <textarea cols="40" id="user_profile_info_about" name="user_profile_info[about]" rows="5"></textarea>
	
	          <div class="text-muted space-top-1">에어비앤비는 사람들 간의 관계를 기반으로 만들어졌습니다. 회원님이 어떤 사람인지 알려주세요. <br><br> 어떤 것들을 좋아하는지 알려주세요. 가장 좋아하는 여행지, 책, 영화, TV 프로그램, 음악, 음식 등 뭐든지 좋습니다.<br><br> 회원님은 어떤 스타일의 게스트 또는 호스트인가요? <br><br> 인생의 좌우명은 무엇인가요?</div>
	        </div>
	      </div>
	  </div>
	</div>
	
	
	
	
	
	<button type="submit" class="btn btn-primary btn-large">
	  저장하기
	</button>
	</form>

     </div>
    </div>
  </div>

</body>
</html>
