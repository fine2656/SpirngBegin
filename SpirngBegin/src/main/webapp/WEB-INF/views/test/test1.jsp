<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% 
   String ctxPath = request.getContextPath(); 
   //  /startspring 임.
%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/resources/js/jquery-1.12.4.min.js"></script> 
<script type="text/javascript">
 	$(document).ready(function() {
 		if($("#inputDay").val() != null){
 			keepDay(); 
 		}
	}); 
	function keepDay() {
		 $("#inputDay").val("${inputDay}");
	}
	function goDday(inputDay) {	
		var inputDay = $("#inputDay").val();
		frm = document.showDay;
 		frm.method = "GET";
 		frm.action="<%= ctxPath %>/test/test1.action"; 
 		frm.submit();
	}

</script>
<head>

<body>
	<div>
		<h2>예제1. 날짜 입력받아 db에서 현재날짜와 비교하여 몇일이지났는지 또는 몇일이남았는지에대한 결과 화면에 나타내기!!</h2>
		<form name="showDay">
			<div>
				<input type="date" name="inputDay" id="inputDay"><button type="button" id="btnOk" onClick="goDday('inputDay')">확인</button>
			</div>
		</form>
		</div>
		<div>
		<form name="clearFrm">
			<c:if test="${not empty inputDay}">
				<div style="margin: 10%; border: 0px solid red;" align="left">
					<span>
						${dday} 
					</span>
				</div>
			</c:if>
		</form>
	 </div>
	
</body>
</html>