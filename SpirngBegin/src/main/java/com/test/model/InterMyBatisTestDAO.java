package com.test.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface InterMyBatisTestDAO {
	
	int mbtest1();
	
	int mbtest2(String name);
	
	int mbtest3(MyBatisTestVO vo);
	
	int mbtest4(MemberVO mvo);
	
	int mbtest5(HashMap<String, String> map);
	
	String mbtest6(int no);
	
	MemberVO mbtest7(int no);
	
	List<MemberVO> mbtest8(String addr);
	
	List<MemberVO2> mbtest9(String addr);
	
	List<MemberVO2> mbtest9_2(String addr);
	
	List<HashMap<String, String>> mbtest10(String addr);

	List<Integer> mbtest12_deptno();

	List<HashMap<String, String>>mbtest12(HashMap<String,String>paraMap);
	
	
	List<HashMap<String, String>> mbtest13(String addrSearch);
	
	List<HashMap<String, String>> mbtest14(HashMap<String, Object> paraMap);

	String test1(String inputDay); 
	
	List<String> test2_jobid();
	
	List<HashMap<String, String>> test2_2(String searchJogId);
	
	List<HashMap<String,String>> mbtest15_gender();
	
	List<HashMap<String, String>> mbtest15_ageline();
	List<HashMap<String, Object>> mbtest15_yearpay();
	
	// ==== Mybatis에서 Procedure를 사용하여 insert 하기 ====
	void mbtest17(HashMap<String, String> paraMap);

	// ***** 사원번호를 입력받아서 Mybatis에서 Procedure 를 사용하여 한명의 사원정보 select 하기 ***** //
	ArrayList<EmployeeVO> mbtest18(HashMap<String, Object> paraMap);

	// ***** 부서번호를 입력받아서 Mybatis 에서 Procedure 를 사용하여 해당부서의 사원들의 정보 select 하기 ***** //
	ArrayList<EmployeeVO> mbtest19(HashMap<String, Object> paraMap);
}
