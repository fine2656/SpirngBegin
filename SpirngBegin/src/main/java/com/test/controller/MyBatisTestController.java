package com.test.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.tools.ant.taskdefs.condition.Http;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.test.model.EmployeeVO;
import com.test.model.MemberVO;
import com.test.model.MemberVO2;
import com.test.model.MyBatisTestVO;
import com.test.service.MyBatisTestService;

/*
사용자 웹브라우저 요청(View)  ==> DispatcherServlet ==> @Controller 클래스 <==>> Service단(핵심업무로직단, business logic단) <==>> Model단[Repository](DAO, DTO) <==>> myBatis <==>> DB(오라클)           
(http://...  *.action)                                  |
       ↑                                              |
       |                                              ↓
       |                                           View단(.jsp)
       -----------------------------------------------| 
                                                       
Service(서비스)단 객체를 업무 로직단(비지니스 로직단)이라고 부른다.
Service(서비스)단 객체가 하는 일은 Model단에서 작성된 데이터베이스 관련 여러 메소드들 중 관련있는것들만을 모아 모아서
하나의 트랜잭션 처리 작업이 이루어지도록 만들어주는 객체이다.
여기서 업무라는 것은 데이터베이스와 관련된 처리 업무를 말하는 것으로 Model 단에서 작성된 메소드를 말하는 것이다.
이 서비스 객체는 @Controller 단에서 넘겨받은 어떤 값을 가지고 Model 단에서 작성된 여러 메소드를 호출하여 실행되어지도록 해주는 것이다.
실행되어진 결과값을 @Controller 단으로 넘겨준다.
*/

@Controller

/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 MyBatisTestController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다.  */
public class MyBatisTestController {


	//※ 의존객체주입(DI : Dependency Injection) 
	//  ==> 스프링 프레임워크는 객체를 관리해주는 컨테이너를 제공해주고 있다.
//	      스프링 컨테이너는 bean으로 등록되어진 MyBatisTestController 클래스 객체가 사용되어질때, 
//	      MyBatisTestController 클래스의 인스턴스 객체변수(의존객체)인 MyBatisTestService service 에 
//	      자동적으로 bean 으로 등록되어 생성되어진 MyBatisTestService service 객체를  
//	      MyBatisTestController 클래스의 인스턴스 변수 객체로 사용되어지게끔 넣어주는 것을 의존객체주입(DI : Dependency Injection)이라고 부른다. 
//	      이것이 바로 IoC(Inversion of Control == 제어의 역전) 인 것이다.
//	      즉, 개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것에서 탈피하여 스프링은 컨테이너에 객체를 담아 두고, 
//	      필요할 때에 컨테이너로부터 객체를 가져와 사용할 수 있도록 하고 있다. 
//	      스프링은 객체의 생성 및 생명주기를 관리할 수 있는 기능을 제공하고 있으므로, 더이상 개발자에 의해 객체를 생성 및 소멸하도록 하지 않고
//	      객체 생성 및 관리를 스프링 프레임워크가 가지고 있는 객체 관리기능을 사용하므로 Inversion of Control == 제어의 역전 이라고 부른다.  
//	      그래서 스프링 컨테이너를 IoC 컨테이너라고도 부른다.

	//  === 느슨한 결합 ===
//	      스프링 컨테이너가 MyBatisTestController 클래스 객체에서 MyBatisTestService 클래스 객체를 사용할 수 있도록 
//	      만들어주는 것을 "느슨한 결합" 이라고 부른다.
//	      느스한 결합은 MyBatisTestController 객체가 메모리에서 삭제되더라도 MyBatisTestService service 객체는 메모리에서 동시에 삭제되는 것이 아니라 남아 있다.
	
	@Autowired
	private MyBatisTestService service; //서비스단 생성 후 서비스단과 연결한다. 
	
	@RequestMapping(value="/mybatistest/mybatisTest1.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest1(HttpServletRequest req) {
		// private MyBatisTestService service = new MyBatisTestService();
		// === 단단한 결합(개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것) ===
		//    ==> MyBatisTestController 객체가 메모리에서 삭제 되어지면 MyBatisTestService service 객체는 멤버변수이므로 메모리에서 자동적으로 삭제되어진다.
		
		int n = service.mbtest1();
		String msg ="";
		if(n==1) {
			msg="데이터 입력 성공!";
		}else {
			msg="데이터 입력 실패!";

		}
		req.setAttribute("msg", msg);
		return "mybatistTest1";// View 단
	}
	
	
	
	@RequestMapping(value="/mybatistest/mybatisTest2.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest2(HttpServletRequest req) {
		// private MyBatisTestService service = new MyBatisTestService();
		// === 단단한 결합(개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것) ===
		//    ==> MyBatisTestController 객체가 메모리에서 삭제 되어지면 MyBatisTestService service 객체는 멤버변수이므로 메모리에서 자동적으로 삭제되어진다.
		
		String name = "엄정화";
		int n = service.mbtest2(name);
		String msg ="";
		if(n==1) {
			msg="개인 데이터 변경 성공!";
		}else {
			msg="데이터 입력 실패!";

		}
		req.setAttribute("msg", msg);
		return "mybatistTest2";// View 단
	}
	
	// form 을 띄어주는 페이지는 대부분 GET 방식이다.
	// 하지만 파일을 추가하는 form 은 POST 방식이다.
	@RequestMapping(value="/mybatistest/mybatisTest3.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest3() {
		// 글쓰기 form 페이지를 띄우려고 한다.
		
		return "register/mybatisTest3AddForm";// View 단
		// /WEB-INF/views/register/mybatistTest3AddForm.jsp
	}
	
	@RequestMapping(value="/mybatistest/mybatisTest3End.action",method= {RequestMethod.POST}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest3End(HttpServletRequest req) {
		//1. form 에서 들어온 값 받기
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String addr = req.getParameter("addr");
		String tel = req.getParameter("tel");
		
		// 2. DTO(vO) 에 넣어준다
		MyBatisTestVO vo = new MyBatisTestVO();  
		vo.setName(name);
		vo.setEmail(email);
		vo.setAddr(addr);
		vo.setTel(tel);
		
		// 3. Service 단으로 생성된 DTO(VO)를 넘긴다.
		int n = service.mbtest3(vo);

		String msg ="";
		if(n==1) {
			msg="회원가입성공!";
		}else {
			msg="회원가입실패!";
		}
		
		req.setAttribute("msg", msg);
		return "register/mybatisTest3AddEnd";// View 단
		// /WEB-INF/views/register/mybatistTest3AddForm.jsp
	}
	
	
	@RequestMapping(value="/mybatistest/mybatisTest4.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest4() {
		// 글쓰기 form 페이지를 띄우려고 한다.
		
		return "register/mybatisTest4AddForm";// View 단
		// /WEB-INF/views/register/mybatisTest4AddForm.jsp
	}
	
	
	@RequestMapping(value="/mybatistest/mybatisTest4End.action",method= {RequestMethod.POST}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest4End(MemberVO mvo,HttpServletRequest req) {		
		// **** form 에서 넘어오는 name 의 값과 
				//      DB 의 컬럼명과 DTO(VO)의 get과 set다음에 나오는 메소드명(첫글자는 대문자)이
				//      동일할 경우 위처럼 파라미터명에 MemberVO mvo 와 같이 넣어주기만 하면
				//      form에 입력된 값들이 자동적으로  MemberVO mvo 에 입력되어지므로  		
				
				// 1. form 에서 넘어온 값 받기위하여 
				//    사용하였던 req.getParameter("name"); 이러한 작업이 
				//    필요없다.
						
				// 2. DTO(VO)에 넣어주는 작업도 필요없다.
		
		// 3. Service 단으로 생성된 DTO(VO)를 넘긴다.
		int n = service.mbtest4(mvo);

		String msg ="";
		if(n==1) {
			msg="회원가입성공!";
		}else {
			msg="회원가입실패!";			
		}
		req.setAttribute("msg", msg);
		return "register/mybatisTest4AddEnd";// View 단
		// /WEB-INF/views/register/mybatisTest4AddEnd.jsp
	}
	
	
	@RequestMapping(value="/mybatistest/mybatisTest5.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest5() {
		// 글쓰기 form 페이지를 띄우려고 한다.
		
		return "register/mybatisTest5AddForm";// View 단
		// /WEB-INF/views/register/mybatisTest5AddForm.jsp
	}
	
	
	@RequestMapping(value="/mybatistest/mybatisTest5End.action",method= {RequestMethod.POST}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest5End(HttpServletRequest req) {		

				
		// 1. form 에서 넘어온 값 받기위하여 
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String addr = req.getParameter("addr");
		String tel = req.getParameter("tel");
						
		// 2.HashMap에 넣어주는 작업도 필요없다.
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("NAME", name);
		map.put("EMAIL", email);
		map.put("ADDR", addr);
		map.put("TEL", tel);

		// 3. Service 단으로 생성된 HashMap을 넘긴다.
		int n = service.mbtest5(map);

		String msg ="";
		if(n==1) {
			msg="회원가입성공!";
		}else {
			msg="회원가입실패!";			
		}
		req.setAttribute("msg", msg);
		return "register/mybatisTest5AddEnd";// View 단
		// /WEB-INF/views/register/mybatisTest5AddEnd.jsp
	}
	
	
	// === *** HttpServletRequest 사용 *** === 
	@RequestMapping(value="/mybatistest/mybatisTest6.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest6() {
		
		// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
		
		return "search/mybatisTest6SearchForm";// View 단
		// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
	}
	
	@RequestMapping(value="/mybatistest/mybatisTest6End.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest6End(HttpServletRequest req) {		
		
		String str_no = "";
		try {
			//1. 검색어를 받아온다
			str_no = req.getParameter("no");
			int no = Integer.parseInt(str_no);
			//2. Service 단으로 검색어를 넘긴다.
			String name = service.mbtest6(no);
			String result = null;
			if(name != null) {
				result  = name;
			}else {
				result = "검색하시려는 번호 "+no+"에 일치하는 데이터가 없습니다.";
			}
			req.setAttribute("result", result);
			return "search/mybatisTest6SearchEnd";
			
		} catch (NumberFormatException e) {
			req.setAttribute("str_no",str_no);
			
			return "search/mybatisTest6SearchError";
		}		
	}
	
	// === *** Model 사용 *** === 
	@RequestMapping(value="/mybatistest/mybatisTest6_2.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest6_2() {
		
		// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
		
		return "search/mybatisTest6SearchForm_2";// View 단
		// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
	}
	
	@RequestMapping(value="/mybatistest/mybatisTest6End_2.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
	public String mybatisTest6End_2(HttpServletRequest req,Model model) {		
		
		String str_no = "";
		try {
			//1. 검색어를 받아온다
			str_no = req.getParameter("no");
			int no = Integer.parseInt(str_no);
			//2. Service 단으로 검색어를 넘긴다.
			String name = service.mbtest6(no);
			String result = null;
			if(name != null) {
				result  = name;
			}else {
				result = "검색하시려는 번호 "+no+"에 일치하는 데이터가 없습니다.";
			}
			// Model 객체에 넣어준다.
			
			// Model 객체를 이용해서 view 단으로 Data 전달하기
			// Model 객체란 DB 에서 얻어온 결과 물을 담는 저장용 객체이다.
			// => 저장소
			model.addAttribute("result",result);
			
			return "search/mybatisTest6SearchEnd_2";
			
		}catch (NumberFormatException e) {
			
			model.addAttribute("str_no",str_no);
						
			return "search/mybatisTest6SearchError_2";
		}		
	}
	
	// === *** ModelAndView 사용 *** === 
		@RequestMapping(value="/mybatistest/mybatisTest6_3.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
		public String mybatisTest6_3() {
			
			// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
			
			return "search/mybatisTest6SearchForm_3";// View 단
			// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
		}
		
		@RequestMapping(value="/mybatistest/mybatisTest6End_3.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
		public ModelAndView mybatisTest6End_3(HttpServletRequest req, ModelAndView mv) {		
			
			String str_no = "";
			try {
				str_no = req.getParameter("no");
				int no = Integer.parseInt(str_no);
				//2. Service 단으로 검색어를 넘긴다.
				String name = service.mbtest6(no);
				String result = null;

				if(name != null) {
					result  = name;
				}else {
					result = "검색하시려는 번호 "+no+"에 일치하는 데이터가 없습니다.";					
				}
				// ModelAndView 객체를 사용하여 데이터와 뷰를 동시에 설정이 가능하다.
					
				mv.addObject("result",result);
				// 모든 객체를 담을수가 있다. mv.addObject(키값,) 
				// 1. 뷰로 보낼 데이터 값
				
				mv.setViewName("search/mybatisTest6SearchEnd_3"); // 뷰단을 지정해준다
				// 2. 뷰의 이름을 지정한다.
			} catch (NumberFormatException e) {
				
				mv.addObject("str_no",str_no);
				mv.setViewName("search/mybatisTest6SearchError_3");
				// 뷰로 보낼 데이터 값
			}	
			return mv;
		}
		
		
		///////////////////////////////////////////////////////////////////////////////////
			// 한행 가져오기 
		
		@RequestMapping(value="/mybatistest/mybatisTest7.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
		public String mybatisTest7() {
					
					// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
					
		return "search/mybatisTest7SearchForm";// View 단
					// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
		}
		
		@RequestMapping(value="/mybatistest/mybatisTest7End.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
		public String mybatisTest7End(HttpServletRequest req) {		
			
			String str_no = "";
			
			try {
				str_no = req.getParameter("no");
				int no = Integer.parseInt(str_no);
				//2. Service 단으로 검색어를 넘긴다.
				MemberVO mvo = service.mbtest7(no);
				req.setAttribute("mvo", mvo);
				req.setAttribute("no", no);
				String result = null;
				
				return "search/mybatisTest7SearchEnd";
			} catch (NumberFormatException e) {
				req.setAttribute("str_no", str_no);
				return "search/mybatisTest7SearchError";
			}	
		}
		
		/////////////////////////////////////////////////////////////////////////////////
		
		// === *** ModelAndView 사용 *** === 
				@RequestMapping(value="/mybatistest/mybatisTest7_2.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
				public ModelAndView mybatisTest7_2(ModelAndView mav) {
					
					// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
					
					mav.setViewName("search/mybatisTest7SearchForm_2");// View 단
					// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
					return mav;
				}
				
				@RequestMapping(value="/mybatistest/mybatisTest7End_2.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
				public ModelAndView mybatisTest7End_2(HttpServletRequest req,ModelAndView mav) {		
					
					String str_no = "";
					
					try {
						str_no = req.getParameter("no");
						int no = Integer.parseInt(str_no);
						//2. Service 단으로 검색어를 넘긴다.
						
						MemberVO mvo = service.mbtest7(no);
						
						mav.addObject("mvo",mvo);
						mav.addObject("no",no);

						mav.setViewName("search/mybatisTest7SearchEnd_2");							
						
					} catch (NumberFormatException e) {
						mav.addObject("str_no", str_no);
						mav.setViewName("search/mybatisTest7SearchError_2");
					}	
					return mav;
				}
				
       ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				
				// 다중 행 리스트 가져오기
				@RequestMapping(value="/mybatistest/mybatisTest8.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
				public String mybatisTest8() {
					
					// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
					
					return "search/mybatisTest8SearchForm";// View 단
					// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
				}
				
				@RequestMapping(value="/mybatistest/mybatisTest8End.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
				public String mybatisTest8End(HttpServletRequest req) {							
						
					String addr = req.getParameter("addr");								
						//2. Service 단으로 검색어를 넘긴다.
						List<MemberVO> memberList = service.mbtest8(addr);
						req.setAttribute("memberList", memberList);
						req.setAttribute("addr", addr);
						
						
						return "search/mybatisTest8SearchEnd";
					
						
				}
	///////////////////////////////////////////////////////////////////////////////////////////////////////
				
				// 컬럼명과 VO의 이름이 다른 경우
				@RequestMapping(value="/mybatistest/mybatisTest9.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
				public String mybatisTest9() {
					
					// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
					
					return "search/mybatisTest9SearchForm";// View 단
					// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
				}
				
				@RequestMapping(value="/mybatistest/mybatisTest9End.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
				public String mybatisTest9End(HttpServletRequest req) {							
						
					String addr = req.getParameter("addr");								
						//2. Service 단으로 검색어를 넘긴다.
						List<MemberVO2> memberList = service.mbtest9(addr);
						req.setAttribute("memberList", memberList);
						req.setAttribute("addr", addr);
					
						
						return "search/mybatisTest9SearchEnd";
					
						
				}			

	///////////////////////////////////////////////////////////////////////////////////////////////////////
				// 컬럼명과 VO의 이름이 다른 경우
				@RequestMapping(value="/mybatistest/mybatisTest9_2.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
				public String mybatisTest9_2() {
					
					// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
					
					return "search/mybatisTest9SearchForm_2";// View 단
					// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
				}
				
				@RequestMapping(value="/mybatistest/mybatisTest9End_2.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
				public String mybatisTest9End_2(HttpServletRequest req) {							
						
					String addr = req.getParameter("addr");								
						//2. Service 단으로 검색어를 넘긴다.
						List<MemberVO2> memberList = service.mbtest9_2(addr);
						req.setAttribute("memberList", memberList);
						req.setAttribute("addr", addr);
					
						
						return "search/mybatisTest9SearchEnd_2";
					
						
				}

				///////////////////////////////////////////////////////////////////////////////////////////////////////
							// 컬럼명과 VO의 이름이 다른 경우
							@RequestMapping(value="/mybatistest/mybatisTest10.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String mybatisTest10() {
								
								// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
								
								return "search/mybatisTest10SearchForm";// View 단
								// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
							}
							
							@RequestMapping(value="/mybatistest/mybatisTest10End.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String mybatisTest10End(HttpServletRequest req) {							
									
								String addr = req.getParameter("addr");								
									//2. Service 단으로 검색어를 넘긴다.
									List<HashMap<String,String>> memberMapList = service.mbtest10(addr);
									req.setAttribute("memberMapList", memberMapList);
									req.setAttribute("addr", addr);
									return "search/mybatisTest10SearchEnd";										
							}			
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							@RequestMapping(value="/mybatistest/mybatisTest11.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String mybatisTest11(HttpServletRequest req) {
								
								String colName = req.getParameter("colName");// sql 에서 select 해올 이름
								String searchWord = req.getParameter("searchWord");
								String startday = req.getParameter("startday");
								String endday = req.getParameter("endday");
								
								if(searchWord != null && !searchWord.trim().isEmpty()) { // url 주소창에서 집적 쓰는것 방지
									// 파라미터값을 해쉬맵에 넣어준다.
									HashMap<String,String> paraMap = new HashMap<String,String>(); 
									
									paraMap.put("COLNAME", colName);
									paraMap.put("SEARCHWORD",searchWord);
									paraMap.put("STARTDAY",startday);
									paraMap.put("ENDDAY",endday);
									
								    List<HashMap<String,String>> memberList = service.mbtest11(paraMap); // service:의존객체 
								    										    
								    req.setAttribute("memberList", memberList);
								    req.setAttribute("colName", colName);
								    req.setAttribute("searchWord",searchWord);
								    req.setAttribute("count", memberList.size());
								    //파라미터 결과는 컨트롤러, 셀렉트 되어진 결과물은 xml											
								}										
								// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
								return "search/mybatisTest11SearchForm";// View 단
								// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
							}
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							// 부서에 있는 사원 정보 가져오기
							@RequestMapping(value="/mybatistest/mybatisTest12.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String mybatisTest12(HttpServletRequest req) {
								
								List<Integer> deptnoList = service.mbtest12_deptno();
								
																		
								String deapartment_id = req.getParameter("department_id");// sql 에서 select 해올 이름
								String gender = req.getParameter("gender");
								
								HashMap<String,String> paraMap = new HashMap<String,String>();
								paraMap.put("DEAPARTMENT_ID", deapartment_id);
								paraMap.put("GENDER", gender);
								
								
								List<HashMap<String,String>> empList = service.mbtest12(paraMap);
								
								req.setAttribute("deptnoList",deptnoList);
								req.setAttribute("empList",empList);
								req.setAttribute("deapartment_id", deapartment_id); // 검색어 유지시키기 위해서
								req.setAttribute("gender", gender); // 검색어 유지시키기 위해서
								
								// 검색조건에 맞는 데이트럴 찾기위해 Search 하는 form 페이지를 띄운다.
								return "search/mybatisTest12SearchForm";// View 단
								// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
							}
			  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							// 부서에 있는 사원 정보 가져오기 (ModelAndView)
							@RequestMapping(value="/mybatistest/mybatisTest12_2.action",method= {RequestMethod.GET}) 
							public ModelAndView mybatisTest12_2(HttpServletRequest req,ModelAndView mav) {
								
					
								List<Integer> deptnoList = service.mbtest12_deptno();
								
																		
								String deapartment_id = req.getParameter("department_id");// sql 에서 select 해올 이름
								String gender = req.getParameter("gender");
								
								HashMap<String,String> paraMap = new HashMap<String,String>();
								paraMap.put("DEAPARTMENT_ID", deapartment_id);
								paraMap.put("GENDER", gender);
																		
								List<HashMap<String,String>> empList = service.mbtest12(paraMap);

								mav.addObject("paraMap",paraMap);
								mav.addObject("empList",empList);
								mav.addObject("deptnoList",deptnoList);
								mav.addObject("deapartment_id",deapartment_id);
								mav.addObject("gender",gender);
								mav.setViewName("search/mybatisTest12SearchForm_2");// View 단
								// /WEB-INF/views/register/mybatisTest6SearchForm.jsp
								return mav;
							}
			/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							/////////////////////////////////////// == AJAX == ////////////////////////////////////////
							// 부서에 있는 사원 정보 가져오기 
							@RequestMapping(value="/mybatistest/mybatisTest13.action",method= {RequestMethod.GET}) 
							public String mybatisTest13(HttpServletRequest req) {
								

								return "search/mybatisTest13SearchForm";
							}
							@RequestMapping(value="/mybatistest/mybatisTest13JSON.action",method= {RequestMethod.GET}) 
							public String mybatisTest13JSON(HttpServletRequest req) {
								String addrSearch = req.getParameter("addrSearch");
								JSONArray jsonArr = new JSONArray(); // []
								
								if(addrSearch != null && !addrSearch.trim().isEmpty()) { //검색어가 있는 경우.
									List<HashMap<String,String>> memberList = service.mbtest13(addrSearch);
									if(memberList != null && memberList.size()>0) {
										for(HashMap<String,String> map : memberList) {
											JSONObject jsonobject = new JSONObject();
											jsonobject.put("NO",map.get("NO")); // map.get("NO" : xml 의 키값 ,NO : 우리가 넘겨줄 json키값
											jsonobject.put("NAME",map.get("NAME"));
											jsonobject.put("EMAIl",map.get("EMAIl"));
											jsonobject.put("TEL",map.get("TEL"));
											jsonobject.put("ADDR",map.get("ADDR"));
											jsonobject.put("WRITEDAY",map.get("WRITEDAY"));
											jsonobject.put("BIRTHDAY",map.get("BIRTHDAY"));
											
											jsonArr.put(jsonobject);
										}
									}
									String str_jsonArr = jsonArr.toString();
									req.setAttribute("str_jsonArr", str_jsonArr);
								}										
								return "search/mybatisTest13SearchJSON";
							}
							
		 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							
							@RequestMapping(value="/test/test1.action",method= {RequestMethod.GET}) 
							public String test1(HttpServletRequest req) {
								String inputDay = req.getParameter("inputDay");
								if(inputDay !=null) {
									String dday = service.test1(inputDay);
									
									req.setAttribute("dday", dday);
									req.setAttribute("inputDay", inputDay);
									return "test/test1";
								}
								return "test/test1";
							}

							
				/////////////////////////////////////// == AJAX == ////////////////////////////////////////
							// 부서에 있는 사원 정보 가져오기 (ModelAndView)
							@RequestMapping(value="/mybatistest/mybatisTest13_2.action",method= {RequestMethod.GET}) 
							public String mybatisTest13_2(HttpServletRequest req) {										

								return "search/mybatisTest13SearchForm_2";
							}
							// ==> jackson JSON 라이브러리와 @ResponseBody 사용하여 JSON 을 파싱하기 === //
							/* @ResponseBody 란?
							     메소드에 @ResponseBody Annotation이 되어 있으면 return 되는 값은 View 단을 통해서 출력되는 것이 아니라 
							   HTTP Response Body에 바로 직접 쓰여지게 된다. 
								
						   !!! 그리고 jackson JSON 라이브러리를 사용할때 주의해야할 점은!!!!! 
							     메소드의 리턴타입은 행이 1개 일경우                          HashMap<K,V>       이거나            Map<K,V>   이고 
								                         행이 2개 이상일 경우           List<HashMap<K,V>>      이거나   List<Map<K,V>>  이어야 한다.
								                         그런데 행이 2개 이상일 경우  ArrayList<HashMap<K,V>> 이거나   ArrayList<Map<K,V>> 이면 안된다.!!!
							     
							     이와같이 jackson JSON 라이브러리를 사용할때의 장점은 View 단이 필요없게 되므로 간단하게 작성하는 장점이 있다. 
							*/	
							@RequestMapping(value="/mybatistest/mybatisTest13JSON_2.action",method= {RequestMethod.GET}) 
							@ResponseBody
							public List<HashMap<String,Object>> mybatisTest13JSON_2(HttpServletRequest req) {
								String addrSearch = req.getParameter("addrSearch");										
								List<HashMap<String,Object>> mapList = new ArrayList<HashMap<String,Object>>();
								// JSONArray 와 똑같다.
								
								if(addrSearch != null && !addrSearch.trim().isEmpty()) { //검색어가 있는 경우.
									List<HashMap<String,String>> memberList = service.mbtest13(addrSearch);
									if(memberList != null && memberList.size()>0) {
										for(HashMap<String,String> membermap : memberList) {
											HashMap<String,Object> map = new HashMap<String,Object>();
											map.put("NO",membermap.get("NO")); // map.get("NO" : xml 의 키값 ,NO : 우리가 넘겨줄 json키값
											map.put("NAME",membermap.get("NAME"));
											map.put("EMAIl",membermap.get("EMAIl"));
											map.put("TEL",membermap.get("TEL"));
											map.put("ADDR",membermap.get("ADDR"));
											map.put("WRITEDAY",membermap.get("WRITEDAY"));
											map.put("BIRTHDAY",membermap.get("BIRTHDAY"));
											
											mapList.add(map);
										}
									}
								}
								return mapList;
							}
							
							// === testdb.xml 파일에 foreach를 사용하는 예제
							@RequestMapping(value="/mybatistest/mybatisTest14.action",method= {RequestMethod.GET}) 
							public String mybatisTest14(HttpServletRequest req) {										
								
								List<Integer> deptnoList = service.mbtest12_deptno();
								req.setAttribute("deptnoList",deptnoList);
								return "search/mybatisTest14SearchForm";
							}
							// ==> jackson JSON 라이브러리와 @ResponseBody 사용하여 JSON 을 파싱하기 === //
							/* @ResponseBody 란?
							     메소드에 @ResponseBody Annotation이 되어 있으면 return 되는 값은 View 단을 통해서 출력되는 것이 아니라 
							   HTTP Response Body에 바로 직접 쓰여지게 된다. 
								
						   !!! 그리고 jackson JSON 라이브러리를 사용할때 주의해야할 점은!!!!! 
							     메소드의 리턴타입은 행이 1개 일경우                          HashMap<K,V>       이거나            Map<K,V>   이고 
								                         행이 2개 이상일 경우           List<HashMap<K,V>>      이거나   List<Map<K,V>>  이어야 한다.
								                         그런데 행이 2개 이상일 경우  ArrayList<HashMap<K,V>> 이거나   ArrayList<Map<K,V>> 이면 안된다.!!!
							     
							     이와같이 jackson JSON 라이브러리를 사용할때의 장점은 View 단이 필요없게 되므로 간단하게 작성하는 장점이 있다. 
							*/	
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////
							
	/*						예제2. employee테이블의 JOB_ID컬럼List를 뷰단에 <select><option>안에 설정하고 선택시 해당 JOB_ID를 가진 사원을 출력하세여.
							조건1)jackson JSON 라이브러리와 @ResponseBody 사용하여 JSON 을 파싱하기
							조건2)수업시간에 사용한 "dataResultMap3" resultMap사용
							-------------------------------------------------
							일련번호   부서번호   부서명   사원번호   사원명   주민번호   성별   나이   연봉
							-------------------------------------------------
							*/
							@RequestMapping(value="/test/test2.action",method= {RequestMethod.GET}) 
							public String test2(HttpServletRequest req){
								
								List<String> jobId = service.test2_jobid();								
								req.setAttribute("jobId", jobId);
								
								return "/test/test2";								
								
							}
							@RequestMapping(value="/test/testJSON.action",method= {RequestMethod.GET}) 
							@ResponseBody
							public List<HashMap<String,Object>> testJSON(HttpServletRequest req) {
								String searchJobId = req.getParameter("optionVal");										
								List<HashMap<String,Object>> memberSearch = new ArrayList<HashMap<String,Object>>();
								// JSONArray 와 똑같다.
								
								if(searchJobId != null && !searchJobId.trim().isEmpty()) { //검색어가 있는 경우.
									List<HashMap<String,String>> memberList = service.test2_2(searchJobId);
									
									if(memberList != null && memberList.size()>0) {
										for(HashMap<String,String> membermap : memberList) {
											HashMap<String,Object> map = new HashMap<String,Object>();
											map.put("job_id",membermap.get("job_id")); // map.get("NO" : xml 의 키값 ,NO : 우리가 넘겨줄 json키값
											map.put("employee_id",membermap.get("employee_id"));
											map.put("name",membermap.get("name"));
											map.put("jubun",membermap.get("jubun"));
											map.put("age",membermap.get("age"));
											map.put("gender",membermap.get("gender"));
											map.put("yearpay",membermap.get("yearpay"));
											
											memberSearch.add(map);
										}
									}
								}
								return memberSearch;
							}
							
							
							
							@RequestMapping(value="/mybatistest/mybatisTest14JSON.action",method= {RequestMethod.GET})
							@ResponseBody
							public List<HashMap<String,Object>> mybatisTest14JSON(HttpServletRequest req) {
								String deptnoesStr = req.getParameter("deptnoesStr");
								String[] deptnoArr = deptnoesStr.split(","); // 문자열을 쪼갠다.
								
								for(int i=0;i<deptnoArr.length;i++) {
									System.out.println("==> 확인용 deptnoArr"+deptnoArr[i]);
								}
								
								String gender = req.getParameter("gender");
								String ageline = req.getParameter("ageline");
								
								HashMap<String,Object> paraMap = new HashMap<String,Object>();
								paraMap.put("DEPTNOARR", deptnoArr);
								paraMap.put("GENDER", gender);
								paraMap.put("AGELINE", ageline);
								
								List<HashMap<String,String>> empList = service.mbtest14(paraMap);
								// 받아올값이 String 이지만 넘겨줄 형태는 Object 이다.
								List<HashMap<String,Object>> resultMapList = new ArrayList<HashMap<String,Object>>(); 
								 //JSON 이지만 @ResponseBody 이기 때문에 서비스에도 	List<HashMap<String,Object>> 로 넘겨야한다. return 되어질 타입
								 //JOSNArray의 역할을 한다.
								
								for(HashMap<String, String> empMap : empList ) {
									HashMap<String,Object> resultMap = new HashMap<String,Object>();//JSONObject 와 같다.
									resultMap.put("DEPARTMENT_ID",empMap.get("DEPARTMENT_ID"));
									resultMap.put("DEPARTMENT_NAME",empMap.get("DEPARTMENT_NAME"));
									resultMap.put("EMPLOYEE_ID",empMap.get("EMPLOYEE_ID"));
									resultMap.put("NAME",empMap.get("NAME"));
									resultMap.put("JUBUN",empMap.get("JUBUN"));
									resultMap.put("AGE",empMap.get("AGE"));
									resultMap.put("GENDER",empMap.get("GENDER"));
									resultMap.put("YEARPAY",empMap.get("YEARPAY"));
									resultMapList.add(resultMap);
								}								
								
								return resultMapList;
							}
							// ====== 차트 그리기 (AJAX). 성별 퍼센티지 ======
							
							@RequestMapping(value="/mybatistest/mybatisTest15.action",method= {RequestMethod.GET})
							public String mybatisTest15() {
								
								
								return "chart/mybatisTest15";
							}
							@RequestMapping(value="/mybatistest/mybatisTest15JSON_gender.action",method= {RequestMethod.GET})
							@ResponseBody
							public List<HashMap<String,Object>> mybatisTest15JSON_gender() {
								//HashMap<String,Object>: 하나의 행이다 
								//List<HashMap<String,Object>> 은 여러개의 행을 받아 오겠다는 것이고,
								//@ResponseBody 를 쓰게되면 알아서 배열 형태인 [{},{}]로 변경해준다.
								
								List<HashMap<String,Object>> resultMapList = new ArrayList<HashMap<String,Object>>();
								List<HashMap<String,String>> genderList = service.mbtest15_gender();
								
								for(HashMap<String,String> map : genderList) {
									HashMap<String,Object> resultMap = new HashMap<String,Object>();
									resultMap.put("GENDER",map.get("GENDER"));
									resultMap.put("CNT",map.get("CNT"));
									resultMap.put("PERCENTAGE",map.get("PERCENTAGE"));
									resultMapList.add(resultMap);
								}
								return resultMapList;
							}
							@RequestMapping(value="/mybatistest/mybatisTest15JSON_ageline.action",method= {RequestMethod.GET})
							@ResponseBody
							public List<HashMap<String,Object>> mybatisTest15JSON_ageline() {
								//HashMap<String,Object>: 하나의 행이다 
								//List<HashMap<String,Object>> 은 여러개의 행을 받아 오겠다는 것이고,
								//@ResponseBody 를 쓰게되면 알아서 배열 형태인 [{},{}]로 변경해준다.
								
								List<HashMap<String,Object>> resultMapList = new ArrayList<HashMap<String,Object>>();
								List<HashMap<String,String>> agelineList = service.mbtest15_ageline();
								
								for(HashMap<String,String> map : agelineList) {
									HashMap<String,Object> resultMap = new HashMap<String,Object>();
									resultMap.put("AGELINE",map.get("AGELINE"));
									resultMap.put("CNT",map.get("CNT"));
									resultMapList.add(resultMap);
								}
								return resultMapList;
							}
							@RequestMapping(value="/mybatistest/mybatisTest15JSON_yearpay.action",method= {RequestMethod.GET})
							@ResponseBody
							public List<HashMap<String,Object>> mybatisTest15JSON_yearpay() {
								//HashMap<String,Object>: 하나의 행이다 
								//List<HashMap<String,Object>> 은 여러개의 행을 받아 오겠다는 것이고,
								//@ResponseBody 를 쓰게되면 알아서 배열 형태인 [{},{}]로 변경해준다.
								
								List<HashMap<String,Object>> yearpayList = service.mbtest15_yearpay();
														
										
								for(int i=0; i<yearpayList.size();i++) {
									HashMap<String,Object> empYearpay = service.mbtest15_empYearpay((String)yearpayList.get(0).get("DEPARTMENT_ID"));		
									
									yearpayList.add(empYearpay);
								}
								

								return yearpayList;
							}
							
							
							/////////////////////////////////// Final Project ////////////////////////////////////////////
							@RequestMapping(value="/mybatistest/review.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String review(HttpServletRequest req) {

								return "fianl/review";// View 단
							}
							@RequestMapping(value="/mybatistest/myEdit.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String myEdit(HttpServletRequest req) {

								return "fianl/myEdit";// View 단
							}
							@RequestMapping(value="/mybatistest/myReservation.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String myReservation(HttpServletRequest req) {

								return "fianl/myReservation";// View 단
							}
							@RequestMapping(value="/mybatistest/myReservationCancelDetail.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String myReservationCancelDetail(HttpServletRequest req) {

								return "fianl/myReservationCancelDetail";// View 단
							}
							
							@RequestMapping(value="/mybatistest/myReservationDetail.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String myReservationDetail(HttpServletRequest req) {

								return "fianl/myReservationDetail";// View 단
							}
							
							
							@RequestMapping(value="/mybatistest/myCoupon.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String myCoupon(HttpServletRequest req) {

								return "fianl/myCoupon";// View 단
							}
							@RequestMapping(value="/mybatistest/myReservationScheduleDetail.action",method= {RequestMethod.GET}) //url=/mybatistest/mybatisTest1.cation
							public String myReservationScheduleDetail(HttpServletRequest req) {

								return "fianl/myReservationScheduleDetail";// View 단
							}
							
							

				/////////////////////////////////////////////////////////////////////////////////////
				// **** Mybatis 에서 Procedure 사용하기 **** //
				
				
				// ***** Mybatis 에서 Procedure 를 사용하여 insert 하기 ***** //
				// VO를 사용하지 않고 HashMap 을 사용하여  DB에 insert 하도록 하겠다. ***
				@RequestMapping(value="/mybatistest/mybatisTest17.action", method={RequestMethod.GET})       
				public String mybatisTest17() {
				
				// 글쓰기 form 페이지를 띄우려고 한다.
				return "register/mybatisTest17AddForm";
				//   /WEB-INF/views/register/mybatisTest17AddForm.jsp 를 파일을 생성한다.
				}


				@RequestMapping(value="/mybatistest/mybatisTest17End.action", method={RequestMethod.POST})       
				public String mybatisTest17End(HttpServletRequest req) {
					
					// 1. form 에서 넘어온 값 받기
					String name = req.getParameter("name");
					String email = req.getParameter("email");
					String tel = req.getParameter("tel");
					String addr = req.getParameter("addr");
					
					// 2. HashMap으로 저장시킨다. 
					HashMap<String, String> paraMap = new HashMap<String, String>();
					
					paraMap.put("NAME",name);
					paraMap.put("EMAIL",email);
					paraMap.put("TEL",tel);
					paraMap.put("ADDR",addr);
					
					// 3. Service 단으로 HashMap 을 넘긴다.
					String msg = "";
					
					// 프로시져는 n값을 리턴을 해주지 않는다 =>try catch문으로 오류 검출해야한다.
					try {
						service.mbtest17(paraMap);
						msg = "회원가입 성공!!";
						req.setAttribute("msg", msg);
						return "register/mybatisTest17AddEnd";
					} catch(Exception e) {
						msg = "회원가입 실패!!";
						req.setAttribute("msg", msg);
						
						return "register/mybatisTest17AddEnd";
					} 
				}
				
				

				// ***** 사원번호를 입력받아서 Mybatis 에서 Procedure 를 사용하여 한명의 사원정보 select 하기 ***** //
					@RequestMapping(value="/mybatistest/mybatisTest18.action", method={RequestMethod.GET})       
					public String mybatisTest18(HttpServletRequest req) {
					
						// 1. form 에서 넘어온 값 받기
						String employee_id = req.getParameter("employee_id");
						
						// 2. HashMap으로 저장시킨다. (반드시 서비스단으로 보내야할 변수의 갯수가 1개 이더라도 HashMap 으로 만들어서 넘겨야 한다.!!!!)
						HashMap<String, Object> paraMap = new HashMap<String, Object>(); // !!!! Object 로 해야 한다. !!!!
						paraMap.put("EMPLOYEE_ID", employee_id);
						// in 모드일 때 한개의 값을 보내지만, out으로 받아오는 값은 여러개일 수 있으므로 반드시 HashMap으로 넘겨줘야한다!
						// 받아오는 값이 어떠한 값이 올지 모르기 때문에 Object로 받아와야 한다!
														
						// 3. Service 단으로 HashMap 을 넘기는데 그 결과값은 반드시 VO의 List 로 받아와야 한다.!!!!!
						// => List에는 한개의 값도 담을 수 있기 때문에 모든 것에 호환되기 위해(cursor는 행이 복수개가 나올수 있다) List로 받아와야 한다.
						ArrayList<EmployeeVO> employeeInfoList = service.mbtest18(paraMap);
												
					    req.setAttribute("employeeInfoList", employeeInfoList);
					    req.setAttribute("employee_id", employee_id);
					
					    return "search/mybatisTest18Search";
					}
					
					// ***** 부서번호를 입력받아서 Mybatis 에서 Procedure 를 사용하여 해당부서의 사원들의 정보 select 하기 ***** //
					@RequestMapping(value="/mybatistest/mybatisTest19.action", method={RequestMethod.GET})       
					public String mybatisTest19(HttpServletRequest req) {
					
						// 1. form 에서 넘어온 값 받기
						String department_id = req.getParameter("department_id");
						
						// 2. HashMap으로 저장시킨다. (반드시 서비스단으로 보내야할 변수의 갯수가 1개 이더라도 HashMap 으로 만들어서 넘겨야 한다.!!!!)
						HashMap<String, Object> paraMap = new HashMap<String, Object>(); // !!!! Object 로 해야 한다. !!!!
						paraMap.put("DEPARTMENT_ID", department_id);
						// in 모드일 때 한개의 값을 보내지만, out으로 받아오는 값은 여러개일 수 있으므로 반드시 HashMap으로 넘겨줘야한다!
						// 받아오는 값이 어떠한 값이 올지 모르기 때문에 Object로 받아와야 한다!
														
						// 3. Service 단으로 HashMap 을 넘기는데 그 결과값은 반드시 VO의 List 로 받아와야 한다.!!!!!
						// => List에는 한개의 값도 담을 수 있기 때문에 모든 것에 호환되기 위해(cursor는 행이 복수개가 나올수 있다) List로 받아와야 한다.
						ArrayList<EmployeeVO> employeeInfoList = service.mbtest19(paraMap);
												
					    req.setAttribute("employeeInfoList", employeeInfoList);
					    req.setAttribute("department_id", department_id);
					
					    return "search/mybatisTest19Search";
					}




							
}


