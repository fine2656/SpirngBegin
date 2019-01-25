package com.test.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.model.EmployeeVO;
import com.test.model.InterMyBatisTestDAO;
import com.test.model.MemberVO;
import com.test.model.MemberVO2;
import com.test.model.MyBatisTestDAO;
import com.test.model.MyBatisTestVO;

@Service
public class MyBatisTestService {
	
	@Autowired
	private MyBatisTestDAO dao;
	@Autowired
	private InterMyBatisTestDAO idao;
	
	// dao 가 이미 bean 으로 등록 해 주었고 , Autowird 어 결합 되어 있어 느슨한 결합으로 Autowired 해준다
	
	// ※ 의존객체주입(DI : Dependency Injection) 
		//  ==> 스프링 프레임워크는 객체를 관리해주는 컨테이너를 제공해주고 있다.
		//      스프링 컨테이너는 bean으로 등록되어진 MyBatisTestService 클래스 객체가 사용되어질때, 
		//      MyBatisTestService 클래스의 인스턴스 객체변수(의존객체)인 MyBatisTestDAO dao 에 
		//      자동적으로 bean 으로 등록되어 생성되어진 MyBatisTestDAO dao 객체를  
		//      MyBatisTestService 클래스의 인스턴스 변수 객체로 사용되어지게끔 넣어주는 것을 의존객체주입(DI : Dependency Injection)이라고 부른다. 
		//      이것이 바로 IoC(Inversion of Control == 제어의 역전) 인 것이다.
		//      즉, 개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것에서 탈피하여 스프링은 컨테이너에 객체를 담아 두고, 
		//      필요할 때에 컨테이너로부터 객체를 가져와 사용할 수 있도록 하고 있다. 
		//      스프링은 객체의 생성 및 생명주기를 관리할 수 있는 기능을 제공하고 있으므로, 더이상 개발자에 의해 객체를 생성 및 소멸하도록 하지 않고
		//      객체 생성 및 관리를 스프링 프레임워크가 가지고 있는 객체 관리기능을 사용하므로 Inversion of Control == 제어의 역전 이라고 부른다.  
		//      그래서 스프링 컨테이너를 IoC 컨테이너라고도 부른다.
		
		//  === 느슨한 결합 ===
		//      스프링 컨테이너가 MyBatisTestService 클래스 객체에서 MyBatisTestDAO 클래스 객체를 사용할 수 있도록 
		//      만들어주는 것을 "느슨한 결합" 이라고 부른다.
		//      느스한 결합은 MyBatisTestService 객체가 메모리에서 삭제되더라도 MyBatisTestDAO dao 객체는 메모리에서 동시에 삭제되는 것이 아니라 남아 있다.
	
	public int mbtest1() {
		int n = dao.mbtest1();
				
		return n;
	}
	
	public int mbtest2(String name) {		
		int n = dao.mbtest2(name);
		return n;
		
	}

	public int mbtest3(MyBatisTestVO vo) {
		int n = dao.mbtest3(vo);
		
		return n;
	}

	public int mbtest4(MemberVO mvo) {
		int n = dao.mbtest4(mvo);
		return n;
	}

	public int mbtest5(HashMap<String, String> map) {
		int n = dao.mbtest5(map);
		return n;
	}

	public String mbtest6(int no) {
		String name = dao.mbtest6(no);
		return name;
	}
	
	public MemberVO mbtest7(int no) {
		MemberVO mvo = dao.mbtest7(no);
		return mvo;
	}

	public List<MemberVO> mbtest8(String addr) {
		List<MemberVO> memberList = dao.mbtest8(addr);
		return memberList;
	}
	
	public List<MemberVO2> mbtest9(String addr) {
		List<MemberVO2> memberList = dao.mbtest9(addr);
		return memberList;
	}
	
	public List<MemberVO2> mbtest9_2(String addr) {
		List<MemberVO2> memberList = dao.mbtest9_2(addr);
		return memberList;
	}

	public List<HashMap<String, String>> mbtest10(String addr) {
		List<HashMap<String, String>> memberMapList= dao.mbtest10(addr);
		return memberMapList;
	}

	public List<HashMap<String, String>> mbtest11(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> memberList = dao.mbtest11(paraMap);
		return memberList;
	}

	public List<Integer> mbtest12_deptno() {
		List<Integer> deptnoList = dao.mbtest12_deptno();
		return deptnoList;
	}

	public List<HashMap<String, String>> mbtest12(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> empList = dao.mbtest12(paraMap);
		return empList;
	}

	public String test1(String inputDay) {
		String dday = dao.test1(inputDay);
		return dday;
	}

	public List<HashMap<String, String>> mbtest13(String addrSearch) {
		List<HashMap<String, String>> memberList = dao.mbtest13(addrSearch);
		return memberList;
	}

	public List<String> test2_jobid() {
		List<String> jobId = dao.test2_jobid();
		return jobId;
	}

	public List<HashMap<String, String>> test2_2(String searchJogId) {
		List<HashMap<String, String>> memberList = dao.test2_2(searchJogId);
		return memberList;
	}

	public List<HashMap<String, String>> mbtest14(HashMap<String, Object> paraMap) {
		List<HashMap<String, String>>  empList = dao.mbtest14(paraMap);
		return empList;
	}
	public List<HashMap<String, String>> mbtest15_gender() {
		List<HashMap<String, String>> genderList= dao.mbtest15_gender();
		return genderList;
	}
	public List<HashMap<String, String>> mbtest15_ageline() {
		List<HashMap<String, String>> agelineList= dao.mbtest15_ageline();
		return agelineList;
	}
	public List<HashMap<String, Object>> mbtest15_yearpay() {
		List<HashMap<String, Object>> yearpayList= dao.mbtest15_yearpay();
		return yearpayList;
	}

	public HashMap<String, Object> mbtest15_empYearpay(String deaprtment_id) {
		HashMap<String, Object> yearpayList= dao.mbtest15_empYearpay(deaprtment_id);
		return yearpayList;
	}
	// ==== Mybatis에서 Procedure를 사용하여 insert 하기 ====
	public void mbtest17(HashMap<String, String> paraMap) {
		idao.mbtest17(paraMap);// 프로시저를 실행한다.(insert)
		
	}
	
	// ***** 사원번호를 입력받아서 Mybatis에서 Procedure 를 사용하여 한명의 사원정보 select 하기 ***** //
	public ArrayList<EmployeeVO> mbtest18(HashMap<String, Object> paraMap) {
		ArrayList<EmployeeVO>  employeeInfoList = idao.mbtest18(paraMap);
		return employeeInfoList;
	}
	// ***** 부서번호를 입력받아서 Mybatis 에서 Procedure 를 사용하여 해당부서의 사원들의 정보 select 하기 ***** //
	public ArrayList<EmployeeVO> mbtest19(HashMap<String, Object> paraMap) {
		ArrayList<EmployeeVO>  employeeInfoList = idao.mbtest19(paraMap);
		return employeeInfoList;
	}
	
	
}
