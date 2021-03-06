package com.test.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MyBatisTestDAO implements InterMyBatisTestDAO{
	// ※ 의존객체주입(DI : Dependency Injection) 
		//  ==> 스프링 프레임워크는 객체를 관리해주는 컨테이너를 제공해주고 있다.
		//      스프링 컨테이너는 bean으로 등록되어진 MyBatisTestDAO 클래스 객체가 사용되어질때, (service 단에서 MyBatisTestDAO를 불러올 때 )
		//      MyBatisTestDAO 클래스의 인스턴스 객체변수(의존객체)인 SqlSessionTemplate sqlsession 에 
		//      자동적으로 bean 으로 등록되어 생성되어진 SqlSessionTemplate sqlsession 객체를  
		//      MyBatisTestDAO 클래스의 인스턴스 변수 객체로 사용되어지게끔 넣어주는 것을 의존객체주입(DI : Dependency Injection)이라고 부른다. 
		//      이것이 바로 IoC(Inversion of Control == 제어의 역전) 인 것이다.
		//      즉, 개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것에서 탈피하여 스프링은 컨테이너에 객체를 담아 두고, 
		//      필요할 때에 컨테이너로부터 객체를 가져와 사용할 수 있도록 하고 있다. 
		//      스프링은 객체의 생성 및 생명주기를 관리할 수 있는 기능을 제공하고 있으므로, 더이상 개발자에 의해 객체를 생성 및 소멸하도록 하지 않고
		//      객체 생성 및 관리를 스프링 프레임워크가 가지고 있는 객체 관리기능을 사용하므로 Inversion of Control == 제어의 역전 이라고 부른다.  
		//      그래서 스프링 컨테이너를 IoC 컨테이너라고도 부른다.
		
		//  === 느슨한 결합 ===
		//      스프링 컨테이너가 MyBatisTestDAO 클래스 객체에서 SqlSessionTemplate sqlsession 클래스 객체를 사용할 수 있도록 
		//      만들어주는 것을 "느슨한 결합" 이라고 부른다.
		//      느스한 결합은 MyBatisTestDAO 객체가 메모리에서 삭제되더라도 SqlSessionTemplate sqlsession 객체는 메모리에서 동시에 삭제되는 것이 아니라 남아 있다.

	@Autowired 
	private SqlSessionTemplate sqlsession; 
	//@Autowired : 자동결합
	//@Autowired 를 써줌으로써 스프링 컨테이너가 자동적으로 =new SqlSessionTemplate 를 넣어준다.

	public int mbtest1() {
		// JDBC 설정 , Connection... 기타 등등 의 작업이 필요없다.
		int n = sqlsession.insert("testdb.mbtest1"); // sql의 위치, XML 파일중의 DB가 testdb 인 곳중에
		
		return n;
	}
	
	// private MyBatisTestDAO dao = new MyBatisTestDAO();
		// === 단단한 결합(개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것) ===
		//    ==> MyBatisTestService 객체가 메모리에서 삭제 되어지면 MyBatisTestDAO dao 객체는 멤버변수이므로 메모리에서 자동적으로 삭제되어진다.
	
	@Override
	public int mbtest2(String name) {
		int n = sqlsession.update("examdb.mbtest2", name);
		
		return n;
	}

	@Override
	public int mbtest3(MyBatisTestVO vo) {
		int n = sqlsession.insert("testdb.mbtest3", vo);
		
		return n;
	}

	@Override
	public int mbtest4(MemberVO mvo) {
		int n = sqlsession.insert("testdb.mbtest4", mvo);
		// 의존객체인 sqlsession 에 부탁한다
		return n;

	}
	
	@Override
	public int mbtest5(HashMap<String, String> map) {
		int n = sqlsession.insert("testdb.mbtest5", map); //namesapce.id
		return n;
	}

	@Override
	public String mbtest6(int no) {
		String name = sqlsession.selectOne("testdb.mbtest6",no);
		return name;
	}

	@Override
	public MemberVO mbtest7(int no) {
		MemberVO mvo = sqlsession.selectOne("testdb.mbtest7", no);
		return mvo;
	}

	@Override
	public List<MemberVO> mbtest8(String addr) {
		List<MemberVO> memberList = sqlsession.selectList("testdb.mbtest8", addr);
		return memberList;
	}

	@Override
	public List<MemberVO2> mbtest9(String addr) {
		List<MemberVO2> memberList = sqlsession.selectList("testdb.mbtest9", addr);
		return memberList;
	}

	@Override
	public List<MemberVO2> mbtest9_2(String addr) {
		List<MemberVO2> memberList = sqlsession.selectList("testdb.mbtest9_2", addr);
		return memberList;
	}

	public List<HashMap<String, String>> mbtest10(String addr) {
		List<HashMap<String, String>> memberMapList= sqlsession.selectList("testdb.mbtest10", addr);
		return memberMapList;
	}

	public List<HashMap<String, String>> mbtest11(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> memberList = sqlsession.selectList("testdb.mbtest11", paraMap);
		return memberList;
	}


	@Override
	public List<Integer> mbtest12_deptno() {
		List<Integer> deptnoList = sqlsession.selectList("testdb.mbtest12_deptno");
		return deptnoList;
	}

	
	@Override
	public List<HashMap<String, String>> mbtest12(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> empList = sqlsession.selectList("testdb.mbtest12",paraMap);
		return empList;
	}
	
	@Override
	public String test1(String inputDay) {
		String dday = sqlsession.selectOne("dailyTest.test1", inputDay);
		return dday;
	}

	@Override
	public List<HashMap<String, String>> mbtest13(String addrSearch) {
		List<HashMap<String, String>>  memberList = sqlsession.selectList("testdb.mbtest13",addrSearch);
		return memberList;
	}

	@Override
	public List<String> test2_jobid() {
		List<String> jobIdList = sqlsession.selectList("dailyTest.test2");
		return jobIdList;
	}

	@Override
	public List<HashMap<String, String>> test2_2(String searchJogId) {
		 List<HashMap<String, String>>memberList = sqlsession.selectList("dailyTest.test2_2",searchJogId);
		return memberList;
	}

	@Override
	public List<HashMap<String, String>> mbtest14(HashMap<String, Object> paraMap) {
		List<HashMap<String, String>> empList = sqlsession.selectList("testdb.mbtest14",paraMap);
		return empList;
	}

	@Override
	public List<HashMap<String, String>> mbtest15_gender() {
		List<HashMap<String, String>> genderList= sqlsession.selectList("testdb.mbtest15_gender");
		return genderList;
	}


	@Override
	public List<HashMap<String, String>> mbtest15_ageline() {
		 List<HashMap<String, String>> agelineList = sqlsession.selectList("testdb.mbtest15_ageline"); 
		return agelineList;
	}

	@Override
	public List<HashMap<String, Object>> mbtest15_yearpay() {
		List<HashMap<String, Object>> yearpayList = sqlsession.selectList("testdb.mbtest15_yearpay"); 
		return yearpayList;
	}

	public HashMap<String, Object> mbtest15_empYearpay(String deaprtment_id) {
		HashMap<String, Object> empYearpayList = sqlsession.selectOne("testdb.mbtest15_empYearpay",deaprtment_id);
		return empYearpayList;
	}

	// ==== Mybatis에서 Procedure를 사용하여 insert 하기 ====
	public void mbtest17(HashMap<String, String> paraMap) {
		sqlsession.insert("testdb.mbtest17",paraMap);
		
	}

	// ***** 사원번호를 입력받아서 Mybatis에서 Procedure 를 사용하여 한명의 사원정보 select 하기 ***** //
	@Override
	public ArrayList<EmployeeVO> mbtest18(HashMap<String, Object> paraMap) {
		sqlsession.selectOne("testdb.mbtest18",paraMap);
		// select 되어진 결과물 (cursor)를 다시 paraMap 에 넣어주어야 한다 => Object
		
		ArrayList<EmployeeVO>  employeeInfoList = (ArrayList<EmployeeVO>)paraMap.get("EMPLOYEEINFO");
		// HashMap의 키값은 Mybatis(xml)에서 해줘야 한다
		// => ArrayList<EmployeeVO>  employeeInfoList = (ArrayList<EmployeeVO>)paraMap.get("EMPLOYEEINFO"); 이 결과물을 다시 service 단으로 넘긴다.
		
		
		// 일반적인 select 쿼리인 경우는 selectOne() 메소드의 결과물을 리턴해주면 되지만
		// 프로시저를 사용하여 OUT 타입 변수로 결과를 리턴받을 경우엔 selectOne() 의 결과로는 아무것도 리턴되지 않는다.
		// 프로시저를 사용할 경우에는 selectOne() 메소드를 호출할때 넘겨준 파라미터인 
		// HashMap<String, Object> paraMap 에 select 되어진 결과물을 담아서 넘겨준다!!!!!
		return employeeInfoList;
	}

	@Override
	public ArrayList<EmployeeVO> mbtest19(HashMap<String, Object> paraMap) {
		sqlsession.selectOne("testdb.mbtest19",paraMap);
		// select 되어진 결과물 (cursor)를 다시 paraMap 에 넣어주어야 한다 => Object
		
		ArrayList<EmployeeVO>  employeeInfoList = (ArrayList<EmployeeVO>)paraMap.get("EMPLOYEEINFO");
		// HashMap의 키값은 Mybatis(xml)에서 해줘야 한다
		// => ArrayList<EmployeeVO>  employeeInfoList = (ArrayList<EmployeeVO>)paraMap.get("EMPLOYEEINFO"); 이 결과물을 다시 service 단으로 넘긴다.
		
		
		// 일반적인 select 쿼리인 경우는 selectOne() 메소드의 결과물을 리턴해주면 되지만
		// 프로시저를 사용하여 OUT 타입 변수로 결과를 리턴받을 경우엔 selectOne() 의 결과로는 아무것도 리턴되지 않는다.
		// 프로시저를 사용할 경우에는 selectOne() 메소드를 호출할때 넘겨준 파라미터인 
		// HashMap<String, Object> paraMap 에 select 되어진 결과물을 담아서 넘겨준다!!!!!
		return employeeInfoList;
	}
	


	
}
