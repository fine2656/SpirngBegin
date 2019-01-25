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
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/resources/js/jquery-3.3.1.min.js"></script>
<style type="text/css">
	table#tblGender, table#tblYearpay {width: 100%;
					                   margin-top: 10%;
					                   border: 1px solid gray;
					       			   border-collapse: collapse;
					                  }
	
	table#tblGender th, table#tblGender td, table#tblYearpay th, table#tblYearpay td {border: 1px solid gray;
	                                                                                  text-align: center;}
	                                        
	table#tblGender th {background-color: #ffffe6;} 
	
	table#tblYearpay th {background-color: #ffe6e6;}                                        
</style>



<script type="text/javascript">

    $(document).ready(function(){
    	$("#btnOK").click(function() {
    		var chartType = $("#chartType").val();
    		callAjax(chartType);
		});
    	$("#btnClear").click(function() {
				$("#chart").empty();
				$("#tbl").empty();
		});
    	
    	    	
    });// end of $(document).ready()---------------------
    
    
    function callAjax(chartType) {
		
    	switch (chartType) {
		case "gender": 
			$.ajax({
                url : "mybatisTest15JSON_gender.action",
                type : "GET",
                dataType : "JSON",
                success:function(json){
                   var resultArr = [];
                   
                   for(var i=0; i<json.length; i++){
                      var obj = { name : json[i].GENDER,
                               y: Number(json[i].PERCENTAGE)}; //y는 숫자타입을 넣어준다.
                      resultArr.push(obj); // 배열 속에 값 넣기
                   }
                   Highcharts.chart('chart', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'Percentage of gender, Employees'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                    enabled: true,
                                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                                    style: {
                                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                    }
                                }
                            }
                        },
                        series: [{
                            name: 'Percentages',
                            colorByPoint: true,
                            data: resultArr
                        }]
                    });
                   var v_data="";
                   $.each(json,function(entryIndex,entry){
                	   v_data += "<tr>"+
                	   			"<td>"+entry.GENDER+"</td>"+
                	   			"<td>"+entry.CNT+"</td>"+
                	   			"<td>"+entry.PERCENTAGE+"</td>"+
                	   			"<tr>";
                	   
                   });
                   var html = "<table id='tblGender'>"+
     				"<thead>"+
     					"<tr>성별</tr>"+
     					"<tr>인원수</tr>"+
     					"<tr>비율(%)</tr>"+
     					"</thead>"+
     					"<tbody>"+v_data+"</tbody>"
     			  "</table>"; 
     			  $("#tbl").html(html);
                },error: function(request, status, error){
                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }
             });
		break;
		case "ageline": 
			$.ajax({
				url:"mybatisTest15JSON_ageline.action",
				type : "GET",
	            dataType : "JSON",
	            success:function(json){
	            	var resultArr = [];
	            	for(var i=0;i<json.length;i++){
	            		var subArr=[json[i].AGELINE,Number(json[i].CNT)];	
	            		// 배열 속의 값을 넣기
	            		resultArr.push(subArr);//
	            	}
	            	/////////////////////////////////////////////////////
						            	
					Highcharts.chart('chart', {
					    chart: {
					        type: 'column'
					    },
					    title: {
					        text: 'World\'s largest cities per 2017'
					    },
					    subtitle: {
					        text: 'Source: <a href="http://en.wikipedia.org/wiki/List_of_cities_proper_by_population">Wikipedia</a>'
					    },
					    xAxis: {
					        type: 'category',
					        labels: {
					            rotation: -45,
					            style: {
					                fontSize: '13px',
					                fontFamily: 'Verdana, sans-serif'
					            }
					        }
					    },
					    yAxis: {
					        min: 0,
					        title: {
					            text: 'Population (millions)'
					        }
					    },
					    legend: {
					        enabled: false
					    },
					    tooltip: {
					        pointFormat: 'Population in 2017: <b>{point.y:.1f} millions</b>'
					    },
					    series: [{
					        name: 'Population',
					        data: resultArr,
					        dataLabels: {
					            enabled: true,
					            rotation: -90,
					            color: '#FFFFFF',
					            align: 'right',
					            format: '{point.y:.1f}', // one decimal
					            y: 10, // 10 pixels down from the top
					            style: {
					                fontSize: '13px',
					                fontFamily: 'Verdana, sans-serif'
					            }
					        }
					    }]
					});
	            	/////////////////////////////////////////////////////	            	
					 var v_data="";
	                   $.each(json,function(entryIndex,entry){
	                	   v_data += "<tr>"+
	                	   			"<td>"+entry.AGELINE+"</td>"+
	                	   			"<td>"+entry.CNT+"</td>"+
	                  	   			"</tr>";
	                	   
	                   });
	                   var html = "<table id='tblGender'>"+
	     				"<thead>"+
	     					"<tr>연령대</tr>"+
	     					"<tr>인원수</tr>"+
	     					"</thead>"+
	     					"<tbody>"+v_data+"</tbody>"
	     			  "</table>"; 
	     			  $("#tbl").html(html);
	            },error: function(request, status, error){
                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }
			});
		break;
		case "deptno":
 			
			$.ajax({ 		
				url:"mybatisTest15JSON_yearpay.action",
				dataType:"JSON",
				type:"GET",
				success:function(json){
					var resultArr = [];
					for(var i=0;i<json.length;i++){				
						 var obj ={ "name" : json[i].DEPARTMEMT_NAME,
		              	 		   "y": Number(json[i].YEARPAY),	              	 		  
		              			   "drilldown":json[i].DEPARTMENT_ID};     
		                resultArr.push(obj);
					}
					var resultEmpArr = [];
					for(var i=0;i<json.length;i++){				
						 var obj ={ "name" : json[i].EMPLOYEE_ID,
		              	 		   "y": Number(json[i].EMPYEARPAY),	              	 		  
		              			   "drilldown":json[i].DEPARTMENT_ID};     
						 resultEmpArr.push(obj);
					}
		                
					// Create the chart
					Highcharts.chart('chart', {
					    chart: {
					        type: 'column'
					    },
					    title: {
					        text: 'Browser market shares. January, 2018'
					    },
					    subtitle: {
					        text: 'Click the columns to view versions. Source: <a href="http://statcounter.com" target="_blank">statcounter.com</a>'
					    },
					    xAxis: {
					        type: 'category'
					    },
					    yAxis: {
					        title: {
					            text: 'Total percent market share'
					        }

					    },
					    legend: {
					        enabled: false
					    },
					    plotOptions: {
					        series: {
					            borderWidth: 0,
					            dataLabels: {
					                enabled: true,
					               /*  format: '{point.y:.1f}%' */
					            }
					        }
					    },

					    tooltip: {
					        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
					        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
					    },

					    "series": [
					        {
					            "name": "Yearpay",
					            "colorByPoint": true,
					            "data": resultArr
					        }
					    ],
					    "drilldown": {				                
							
					        "series": [
					            {
					                "name": "Chrome",
					                "id": "Chrome",
					                "data": [
					                    [
					                        "v65.0",
					                        0.1
					                    ],
					                    [
					                        "v64.0",
					                        1.3
					                    ],
					                    [
					                        "v63.0",
					                        53.02
					                    ],
					                    [
					                        "v62.0",
					                        1.4
					                    ],
					                    [
					                        "v61.0",
					                        0.88
					                    ],
					                    [
					                        "v60.0",
					                        0.56
					                    ],
					                    [
					                        "v59.0",
					                        0.45
					                    ],
					                    [
					                        "v58.0",
					                        0.49
					                    ],
					                    [
					                        "v57.0",
					                        0.32
					                    ],
					                    [
					                        "v56.0",
					                        0.29
					                    ],
					                    [
					                        "v55.0",
					                        0.79
					                    ],
					                    [
					                        "v54.0",
					                        0.18
					                    ],
					                    [
					                        "v51.0",
					                        0.13
					                    ],
					                    [
					                        "v49.0",
					                        2.16
					                    ],
					                    [
					                        "v48.0",
					                        0.13
					                    ],
					                    [
					                        "v47.0",
					                        0.11
					                    ],
					                    [
					                        "v43.0",
					                        0.17
					                    ],
					                    [
					                        "v29.0",
					                        0.26
					                    ]
					                ]
					            },
					            {
					                "name": "Firefox",
					                "id": "Firefox",
					                "data": [
					                    [
					                        "v58.0",
					                        1.02
					                    ],
					                    [
					                        "v57.0",
					                        7.36
					                    ],
					                    [
					                        "v56.0",
					                        0.35
					                    ],
					                    [
					                        "v55.0",
					                        0.11
					                    ],
					                    [
					                        "v54.0",
					                        0.1
					                    ],
					                    [
					                        "v52.0",
					                        0.95
					                    ],
					                    [
					                        "v51.0",
					                        0.15
					                    ],
					                    [
					                        "v50.0",
					                        0.1
					                    ],
					                    [
					                        "v48.0",
					                        0.31
					                    ],
					                    [
					                        "v47.0",
					                        0.12
					                    ]
					                ]
					            },
					            {
					                "name": "Internet Explorer",
					                "id": "Internet Explorer",
					                "data": [
					                    [
					                        "v11.0",
					                        6.2
					                    ],
					                    [
					                        "v10.0",
					                        0.29
					                    ],
					                    [
					                        "v9.0",
					                        0.27
					                    ],
					                    [
					                        "v8.0",
					                        0.47
					                    ]
					                ]
					            },
					            {
					                "name": "Safari",
					                "id": "Safari",
					                "data": [
					                    [
					                        "v11.0",
					                        3.39
					                    ],
					                    [
					                        "v10.1",
					                        0.96
					                    ],
					                    [
					                        "v10.0",
					                        0.36
					                    ],
					                    [
					                        "v9.1",
					                        0.54
					                    ],
					                    [
					                        "v9.0",
					                        0.13
					                    ],
					                    [
					                        "v5.1",
					                        0.2
					                    ]
					                ]
					            },
					            {
					                "name": "Edge",
					                "id": "Edge",
					                "data": [
					                    [
					                        "v16",
					                        2.6
					                    ],
					                    [
					                        "v15",
					                        0.92
					                    ],
					                    [
					                        "v14",
					                        0.4
					                    ],
					                    [
					                        "v13",
					                        0.1
					                    ]
					                ]
					            },
					            {
					                "name": "Opera",
					                "id": "Opera",
					                "data": [
					                    [
					                        "v50.0",
					                        0.96
					                    ],
					                    [
					                        "v49.0",
					                        0.82
					                    ],
					                    [
					                        "v12.1",
					                        0.14
					                    ]
					                ]
					            }
					        ]
					    }
					});
				},error: function(request, status, error){
                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }
				
			});
		break;
		}
    	
    	    	
    }// end of function callAjax(addrSearch)------------
    

</script>	

</head>
<body>

	<div align="center" style="margin-bottom: 100px;">
		<h2>차트그리기</h2>
		<br/><br/>
		
		<form name="searchFrm">
			
			<select name="chartType" id="chartType" style="height: 25px;">
				<option value="gender">성별</option>
				<option value="ageline">연령대</option>
				<option value="deptno">부서번호</option>
			</select>
			
			<button type="button" id="btnOK">확인</button>&nbsp;&nbsp;
			<button type="button" id="btnClear">초기화</button>
		</form>
	</div>
	
	<div id="chart" style="min-width: 300px; height: 400px; max-width: 600px; margin: 0 auto"></div>
	<div id="tbl" style="margin: 0 auto; width: 20%; border: 0px solid red;"></div><!-- 차트보기 -->
	
</body>
</html>
