show user;
---- ==== *** Spring myBatisTest *** ==== ----

create table spring_mybatistest
(no         number
,name       varchar2(20)
,email      varchar2(30)
,tel        varchar2(20)
,addr       varchar2(200)
,writeday   date default sysdate
,constraint PK_spring_mybatistest_no primary key(no)
);

create sequence seq_mybatistest
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


select *
from spring_mybatistest
order by no desc;

/*
insert into spring_mybatistest(no, name, email, tel, addr, writeday)
values(seq_mybatistest.nextval, '홍길동'||seq_mybatistest.nextval, 'hongkd@gmail.com', '010-234-5678', '서울시 종로구 인사동', default);
*/

select no,name,email,tel,addr,to_char(writeday,'yyyy-mm-dd hh24:mi:ss') AS writeday 
from spring_mybatistest
where no =1;

-- /mybatistest/mybatisTest10.action --

alter table spring_mybatistest
add birthday varchar2(20 *);

select no,name,email,tel,addr,to_char(writeday,'yyyy-mm-dd hh24:mi:ss') AS writeday 
    ,birthday
from spring_mybatistest
order by no desc;

insert into spring_mybatistest(no, name, email, tel, addr, writeday,birthday)
values(seq_mybatistest.nextval, '홍석화'||seq_mybatistest.nextval, 'hongsh@gmail.com', '010-1234-5678', '경기도 과천시 부촌동', default,'1992-01-01');

commit;


			select no,name,email,tel,addr,to_char(writeday,'yyyy-mm-dd hh24:mi:ss') AS writeday
				  ,nvl(birthday,' ') AS birthday				   
			from spring_mybatistest
			where addr like '%'|| '서울시' ||'%'
			order by no desc;

-------- == 권한 주기 == -------------------
 grant select on departments to myorauser;
 grant select on employees to myorauser;
------- == 권한 뺏기 == -----------------
revoke select on departments to myorauser;

select *
from hr.departments;

select *
from hr.employees;



 ---- 성별을 알려주는 함수 만들기 ----
 create or replace function func_gender(p_jubun IN varchar2 ) -- IN : in 모드 값을 읽어오는것, 생략 가능 (<-> out 모드)
 return varchar2
 is 
  v_gender varchar2(10);
 begin
     if substr(p_jubun,7,1) in ('1','3') then v_gender := '남'; 
     else v_gender := '여';
     end if;
    return v_gender;
 end func_gender;

select func_gender('9204222222222'),func_gender('9204221222222')
from dual;
--- 나이를 구하는 함수 만들기 ---

 create or replace function func_age(p_jubun IN varchar2 ) -- IN : in 모드 값을 읽어오는것, 생략 가능 (<-> out 모드)
 return number
 is 
  v_birthyear number(4);
 begin
    if substr(p_jubun,7,1) in ('1','2') then v_birthyear := 1900+to_number(substr(p_jubun,1,2));
    else v_birthyear := 2000 + to_number(substr(p_jubun,1,2));   
    end if;
    return (extract(year from sysdate) - v_birthyear +1);
 end func_age;

select func_age('9204222222222'), func_age('1106102589632')
from dual;

select sysdate
from dual;
-- 
 create or replace function func_yearpay(p_employee_id IN hr.employees.employee_id%type)
 return number
 is 
v_yearpay number;
begin
    select nvl(salary+salary*commission_pct,salary)*12 into v_yearpay
    from hr.employees
    where employee_id = p_employee_id;
    
    return v_yearpay;
end func_yearpay;


select *
from hr.employees;

-- 부서번호 부서명 사원번호 사원명 주민번호 성별 나이 연봉

select B.department_id AS department_id ,department_name,employee_id,first_name ||' '|| last_name AS name, jubun,func_age(jubun) AS age,func_gender(jubun) AS gender
      ,func_yearpay(employee_id) AS yearpay
from hr.employees A Left join hr.departments B
on A.department_id  = B.department_id
where 1=1
and nvl(B.department_id,-9999)=10
and func_gender(jubun) = '여';

--mbtest12()
--distinct : 중복 제거 
select distinct nvl(department_id,-9999) AS department_id
from hr.employees
order by department_id;

select to_date('2018-02-19','yyyy-mm-dd')-sysdate|| ' 일')  AS 일자   
from dual;

select distinct job_id
from hr.employees;


select job_id,employee_id,first_name ||' '|| last_name AS name, jubun,func_age(jubun) AS age,func_gender(jubun) AS gender
      ,func_yearpay(employee_id) AS yearpay
from hr.employees 
where job_id='PU_CLERK';

 ------** 차트 그리기 **------
  
  
  select func_gender(jubun) AS gender,count(*) AS cnt
         ,round(count(*)/(select count(*) from hr.employees) * 100) AS percentage
  from hr.employees
  group by func_gender(jubun);
 
  select decode(trunc(func_age(jubun),-1),0,'10대미만'
                                           ,trunc(func_age(jubun),-1)||'대') AS AGELINE
         ,count(*) AS CNT
  from hr.employees
  group by trunc(func_age(jubun),-1)
  order by trunc(func_age(jubun),-1);
 
 
  select A.department_id AS DEPARTMENT_ID,B.department_name AS DEPARTMEMT_NAME, trunc(avg(func_yearpay(employee_id))) AS YEARPAY
  from hr.employees A left join hr.departments B
  on A.department_id = B.department_id
  group by A.department_id,B.department_name; 


 select employee_id,department_id,func_yearpay(employee_id)
  from hr.employees;
  
  
  
  ---------------------------------------------------------------------------
    ----- ***** Mybatis 에서 프로시저 호출해서 사용하기 ***** -------
---------------------------------------------------------------------------
select no ,name, email ,tel, addr, writeday, birthday
from spring_mybatistest
order by no desc;

desc spring_mybatistest;


create or replace procedure pcd_spring_mybatistest_insert
(p_name     IN  spring_mybatistest.name%type
,p_email    IN  spring_mybatistest.email%type
,p_tel      IN  spring_mybatistest.tel%type
,p_addr     IN  spring_mybatistest.addr%type
)
is
begin
      insert into spring_mybatistest(no, name, email, tel, addr) 
      values(seq_mybatistest.nextval, p_name, p_email, p_tel, p_addr);
end pcd_spring_mybatistest_insert;



--------------------------------------------------------------------------------------------------

select E.employee_id , E.first_name || ' ' || E.last_name as ENAME,
        case when substr(E.jubun, 7, 1) in ('1','3') then '남' else '여' end as GENDER , 
        extract(year from sysdate) - ( to_number(substr(E.jubun, 1, 2)) + 
                                       case when substr(E.jubun, 7, 1) in('1','2') then 1900 else 2000 end
                                      ) as AGE,
        D.department_name , E.job_id,
        ltrim( to_char( nvl(E.salary + (E.salary * E.commission_pct), E.salary)*12, '999,999,999') ) ||'원' as YEARSAL
from hr.employees E left join hr.departments D
on E.department_id = D.department_id
where E.employee_id = 101;
----------------------------------------------------------------------------------------

create or replace procedure pcd_employees_select
( p_employee_id       IN      hr.employees.employee_id%type  -- p_employee_id   IN   VARCHAR2    <===  이렇게 해도 나온다. //검색하고자 하는 사원번호
 ,cur_employee_info   OUT     SYS_REFCURSOR) -- cur_employee_inf 하단의 정보가 담겨져 있는 곳 , 웹상에서 뿌려준다
is
begin
  OPEN cur_employee_info FOR 
  select E.employee_id , E.first_name || ' ' || E.last_name as ENAME,
            case when substr(E.jubun, 7, 1) in ('1','3') then '남' else '여' end as GENDER , 
            extract(year from sysdate) - ( to_number(substr(E.jubun, 1, 2)) + 
                                           case when substr(E.jubun, 7, 1) in('1','2') then 1900 else 2000 end
                                          ) as AGE,
            D.department_name , E.job_id,
            ltrim( to_char( nvl(E.salary + (E.salary * E.commission_pct), E.salary)*12, '999,999,999') ) ||'원' as YEARSAL
  from hr.employees E left join hr.departments D
  on E.department_id = D.department_id
  where E.employee_id = p_employee_id;
end pcd_employees_select;
----------------------------------------------------------------------------------------------------
create or replace procedure pcd_employees_select2
( p_department_id       IN      hr.employees.department_id%type 
 ,cur_employee_info     OUT     SYS_REFCURSOR)
is
begin
  OPEN cur_employee_info FOR 
  select E.employee_id , E.first_name || ' ' || E.last_name as ENAME,
            case when substr(E.jubun, 7, 1) in ('1','3') then '남' else '여' end as GENDER , 
            extract(year from sysdate) - ( to_number(substr(E.jubun, 1, 2)) + 
                                           case when substr(E.jubun, 7, 1) in('1','2') then 1900 else 2000 end
                                          ) as AGE,
            D.department_name , E.job_id,
            ltrim( to_char( nvl(E.salary + (E.salary * E.commission_pct), E.salary)*12, '999,999,999') ) ||'원' as YEARSAL
  from hr.employees E left join hr.departments D
  on E.department_id = D.department_id
  where E.department_id = p_department_id
  order by employee_id asc;
end pcd_employees_select2;

---------------------------------------------------------------------------------------------


------ ***** JOB 스케줄러 ***** ------

/*
  잡스케줄러라?
  ==>> 지정된 시간에 특정없무 (프로시져)
*/


----- *** sys작업 시작 *** -----
--- HR 에게 JOB 스케줄러를 실행 할 수 있도록 권한을 부여한다.

grant create any job to hr;

select value -- *
from v$parameter
where name like '%job%';

-- value = 4
/*
    ** 여기에 나오는 job_queue_processes 의 value값은 job을 몇개 까지 만들어 줄 수 있는지 그 갯수를 말한다.
       기본값은 4인데 이 값이 0이면 JOB을 만들 수 가 없으므로 주의를 요한다
       JOB 의 갯수를 10개로 늘리고 싶으면 아래처럼 10개 까지 늘려본다.
*/

alter system set job_queue_processes = 10;
-- value = 4
----- *** sys작업 끝 *** -----
create table tbl_jobtest_movieinfo
(
movieseq        varchar2(100) not null -- 시퀀스
,moviename      varchar2(100) not null -- 영화이름
,moviecontents  varchar2(4000) not null -- 영화 내용
,opendate       date   not null -- 영화 개봉일
,enddate        date   not null -- 영화 종료일
,delayNumber    number(1) default 0 --종료를 연장한 횟수(0 : 연장없음, 1 : 1회 연장 , 2 : 2회연장 ...)
,updateDate     date -- 종료날짜를 연장하기로 한 날짜
,constraint PK_tbl_jobtest_movieinfo primary key(movieseq)
);

create sequence seq_tbl_jobtest_movieinfo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- > 종료일지가 현재일자와 같아지면 자동적으로 영화를 삭제한다.

/*
    영화종료일이 현재일을 지나서 과거 일자가 되었더라면 
    (예 : 영화종료일 2019-01-17 , 현재일자 2019-01-18)
    그 영화는 자동적으로 tbl_jobtest_movieinfo 테이블에서 tbl_jobtest_movieinfo_old 테이블로 
    이전(insert)시키고 tbl_jobtest_movieinfo 에서는 삭제(delete)하도록 한다.
*/


create table tbl_jobtest_movieinfo_old
(inputseq      number               not null -- 시퀀스
,inputdate     date default sysdate not null -- 이관된 날짜
,movieseq      varchar2(100)        not null -- 영화시퀀스
,moviename     varchar2(100)        not null -- 영화이름
,moviecontents varchar2(4000)       not null -- 영화 내용
,opendate      date                 not null -- 영화 개봉일
,enddate       date                 not null -- 영화 종료일
,delayNumber   number(1) default 0 --종료를 연장한 횟수(0 : 연장없음, 1 : 1회 연장 , 2 : 2회연장 ...)
,updateDate    date -- 종료날짜를 연장하기로 한 날짜
,constraint PK_tbl_jobtest_movieinfo_old primary key(inputseq)
);

create sequence seq_tbl_jobtest_movieinfo_old
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select inputseq,movieseq,moviename,moviecontents,
      to_char(opendate,'yyyy-mm-dd hh24:mi:ss') AS opendate
      ,to_char(enddate,'yyyy-mm-dd hh24:mi:ss') AS enddate
      ,delayNumber,to_char(updateDate,'yyyy-mm-dd hh24:mi:ss') AS updateDate
from tlb_jobtest_movieinfo;

select movieseq,inputdate,moviename,moviecontents
      ,to_char(opendate,'yyyy-mm-dd hh24:mi:ss') AS opendate
      ,to_char(enddate,'yyyy-mm-dd hh24:mi:ss') AS enddate
      ,delayNumber,to_char(updateDate,'yyyy-mm-dd hh24:mi:ss') AS updateDate
from tlb_jobtest_movieinfo_old;


--- 테이블 tbl_jobtest_movieinfo 에 insert 하는 프로시져 생성 --
create or replace procedure pcd_jobtest_movieinfo_insert
(p_moviename        IN tbl_jobtest_movieinfo.moviename%type
,p_moviecontents    IN tbl_jobtest_movieinfo.moviecontents%type
,p_opendate         IN tbl_jobtest_movieinfo.opendate%type
,p_enddate          IN tbl_jobtest_movieinfo.enddate%type
)is 
v_seq number;
begin
    select seq_tbl_jobtest_movieinfo.nextval into v_seq
    from dual;
    
    insert into tbl_jobtest_movieinfo(movieseq,moviename,moviecontents,opendate,enddate)
    values(v_seq||'-'||to_char(sysdate,'yyyy-mm-dd'),p_moviename,p_moviecontents,p_opendate,p_enddate);
    
    commit;
end pcd_jobtest_movieinfo_insert;


exec pcd_jobtest_movieinfo_insert('스파이더맨','스파이더맨이 뉴욕을 구한다',to_date('2019-01-17 10:00:00','yyyy-mm-dd hh24:mi:ss'),to_Date('2019-01-18 10:41:00','yyyy-mm-dd hh24:mi:ss'));
exec pcd_jobtest_movieinfo_insert('신과함께','차태현이 지옥간다',to_date('2019-01-17 10:00:00','yyyy-mm-dd hh24:mi:ss'),to_Date('2019-01-18 10:41:00','yyyy-mm-dd hh24:mi:ss'));
exec pcd_jobtest_movieinfo_insert('보헤미안 랩소디','스파이더맨이 뉴욕을 구한다',to_date('2019-01-17 10:00:00','yyyy-mm-dd hh24:mi:ss'),to_Date('2019-01-18 10:43:00','yyyy-mm-dd hh24:mi:ss'));
exec pcd_jobtest_movieinfo_insert('베놈','스파이더맨이 뉴욕을 구한다',to_date('2019-01-17 10:44:00','yyyy-mm-dd hh24:mi:ss'),to_Date('2019-01-18 10:44:00','yyyy-mm-dd hh24:mi:ss'));
exec pcd_jobtest_movieinfo_insert('뷰티인사이드','매일 얼굴이 바뀐다',to_date('2019-01-17 10:44:00','yyyy-mm-dd hh24:mi:ss'),to_Date('2019-01-18 10:44:00','yyyy-mm-dd hh24:mi:ss'));
exec pcd_jobtest_movieinfo_insert('코코','매일 얼굴이 바뀐다',to_date('2019-01-17 10:44:00','yyyy-mm-dd hh24:mi:ss'),to_Date('2019-01-18 10:44:00','yyyy-mm-dd hh24:mi:ss'));
exec pcd_jobtest_movieinfo_insert('코코','매일 얼굴이 바뀐다',to_date('2019-01-17 10:45:00','yyyy-mm-dd hh24:mi:ss'),to_Date('2019-01-18 10:44:00','yyyy-mm-dd hh24:mi:ss'));
exec pcd_jobtest_movieinfo_insert('아쿠아맨','매일 얼굴이 바뀐다',to_date('2019-01-17 10:45:00','yyyy-mm-dd hh24:mi:ss'),to_Date('2019-01-17 10:56:00','yyyy-mm-dd hh24:mi:ss'));
exec pcd_jobtest_movieinfo_insert('말모이','매일 얼굴이 바뀐다',to_date('2019-01-17 10:45:00','yyyy-mm-dd hh24:mi:ss'),to_Date('2019-01-17 10:55:00','yyyy-mm-dd hh24:mi:ss'));
-----**** 업무(JOB) 생성하기 => 반드시 프로시저로 작성해야한다!!*****------
/*
    영화종료일이 현재일을 지나서 과거 일자가 되었더라면 
    (예 : 영화종료일 2019-01-17 , 현재일자 2019-01-18)
    그 영화는 자동적으로 tbl_jobtest_movieinfo 테이블에서 tbl_jobtest_movieinfo_old 테이블로 
    이전(insert)시키고 tbl_jobtest_movieinfo 에서는 삭제(delete)하도록 한다.
*/

create or replace procedure pcd_jobtest_insertdelete
is 
begin
    
    insert into tbl_jobtest_movieinfo_old(inputseq,inputdate,movieseq,moviename,moviecontents,opendate,enddate,delaynumber,updateDate)
    select  seq_tbl_jobtest_movieinfo_old.nextval,sysdate,movieseq,moviename,moviecontents,opendate,enddate,delaynumber,updateDate
    from tbl_jobtest_movieinfo
    where enddate < sysdate;
    -- where to_char(enddate,'yyyy-mm-dd') < to_char(sysdate,'yyyy-mm-dd')
    
    delete from tbl_jobtest_movieinfo
    where enddate < sysdate;
    -- where to_char(enddate,'yyyy-mm-dd') < to_char(sysdate,'yyyy-mm-dd')
end pcd_jobtest_insertdelete;

    ----- ***** JOB Scheduler 생성하기 *****-----
    --JOB 등록하기
    -- 여기서는 프로시저 pcd_jobtest_insertdelete 를 job으로 설정하도록 한다
        declare 
            jobno number;
        begin 
            sys.DBMS_JOB.SUBMIT(
                job => jobno
                ,what => 'HR.PCD_JOBTEST_INSERTDELETE;'
                ,next_date => to_date('2019-01-18 10:38','yyyy-mm-dd hh24:mi:ss')
                ,interval => 'SYSDATE + 1/(24*60)'
                ,no_parse => true  -- parse 프로시져가 실행될때 문법을 검사해준다 no_parse는 문법을 검사하지않겠다
            );
        end; 
    
    
    
    
--* job : 실행할 job number   기본적으로 1부터 들어옴.
--* what - 실행할 PL/SQL 프로시저(procedure) 명 혹은 psm 문장의 sequence
--* next_date - job을 언제 처음 시작할 것인지 지정한다. date type으로 evaluate되는 문자열 입력(SYSDATE)
--* interval - job을 수행한 후, 다음 실행시간까지의 시간을 지정한다. 
--                위 셋팅 'SYSDATE + 1/(24*60)' 은 1분마다 실행한다.
--* no_parse - true 이면 submit시에 job을 parsing하지 않는다.


--  job queue 정보 조회
 SELECT * FROM USER_JOBS;


-- 몇분이 지난후 아래를 실행해본다.
select moviename,moviecontents
      ,to_char(opendate,'yyyy-mm-dd hh24:mi:ss') AS opendate
      ,to_char(enddate,'yyyy-mm-dd hh24:mi:ss') AS enddate
      ,delayNumber,to_char(updateDate,'yyyy-mm-dd hh24:mi:ss') AS updateDate
from tbl_jobtest_movieinfo;


select inputseq, to_char(inputdate, 'yyyy-mm-dd hh24:mi:ss') as inputdate,
       movieseq, moviename, moviecontents, 
       to_char(opendate, 'yyyy-mm-dd hh24:mi:ss') as opendate,
       to_char(enddate, 'yyyy-mm-dd hh24:mi:ss') as enddate,
       delaynumber,
       to_char(updatedate, 'yyyy-mm-dd hh24:mi:ss') as updatedate
from tbl_jobtest_movieinfo_old;


-- JOB 정지하기 --  여기서  숫자 1은 job 의 번호 임.  
SELECT * FROM USER_JOBS;
SELECT job FROM USER_JOBS;

execute dbms_job.broken(3, true);
commit;


-- 정지된 JOB 재시작하기 --  여기서  숫자 1은 job 의 번호 임.  
SELECT * FROM USER_JOBS;

SELECT job FROM USER_JOBS;

execute dbms_job.broken(3, false);
commit;


-- JOB 삭제하기 --  여기서  숫자 1은 job 의 번호 임.  
SELECT job FROM USER_JOBS;

execute dbms_job.remove(1);
commit;

-- JOB 지금 바로 실행하기 -- 여기서  숫자 1은 job 의 번호 임.  
SELECT job FROM USER_JOBS;

execute dbms_job.run(1);
commit;

-- JOB 변경 next_date  -- 여기서  숫자 1은 job 의 번호 임.  
SELECT job FROM USER_JOBS;

execute dbms_job.next_date(1, trunc(sysdate)+1+1/24/60);
commit;



**** job Interval 설정
ex)
SYSDATE+7 : 7일에 한번 씩 job 수행
SYSDATE+1/24 : 1시간에 한번 씩 job 수행
SYSDATE+30/ : 30초에 한번 씩 job 수행(24: 시간 당, 1440(24x60):분 당, 86400(24x60x60):초 당 )
TRUNC(SYSDATE, 'MI')+8/24 : 최초 job 수행시간이 12:29분 일 경우 매시 12:29분에 job 수행
TRUNC(SYSDATE+1) : 매일 밤 12시에 job 수행
TRUNC(SYSDATE+1)+3/24 : 매일 오전 3시 job 수행
NEXT_DAY(TRUNC(SYSDATE),'MONDAY')+15/25 : 매주 월요일 오후 3시 정각에 job 수행
TRUNC(LAST_DAY(SYSDATE))+1 : 매월 1일 밤 12시에 job 수행
TRUNC(LAST_DAY(SYSDATE))+1+8/24+30/1440 : 매월 1일 오전 8시 30분