package com.myshop.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.test.model.MyBatisTestDAO;

public class MyShopService {
	@Autowired
	private MyBatisTestDAO dao;
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
	

}
