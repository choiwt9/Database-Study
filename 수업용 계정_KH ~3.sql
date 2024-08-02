-- ━━━━???━━━━ 수업용 계정 접속 후 아래 SQL문을 작성해주세요 ━━━━???━━━━
--============================================================================--
-- [1] '240724' 문자열을 '2024년 7월 24일'로 표현해보기

select to_char(to_date('240724'), 'yyyy "년" fmmm "월" dd"일"')
from dual;

--fm을 앞에 붙이면 0을 제거
-- [2] 본인이 태어난 지 며칠째인지 확인해보기 (현재날짜 - 생년월일)

select ceil(sysdate - TO_DATE('93/10/15'))
from dual;

-- [3] 다음 문장을 바꿔보기
-- bElIVe iN YoURseLF.      -->  Belive in yourself.
select concat(upper(substr('bElIVe iN YoURseLF.', 1, 1)),lower(substr('bElIVe iN YoURseLF.', 2)))
from dual;
-- [4] 생일이 7월이후인 사원들의 입사월별 사원 수 조회 (아래와 같이 출력)
/*
------------------------------------------------------------
    생월     |   입사월   |   입사 사원수|
         7월 |       4월 |          2명|
         7월 |       9월 |          1명|
         ...
         9월 |       6월 |          1명|
------------------------------------------------------------
*/
select lpad(substr(emp_no, 3, 2) || '월', 8) "생월",
lpad(EXTRACT(MONTH from hire_date)|| '월', 8) as "입사월"
,lpad(count(*) || '명', 5) "입사 사원수"
from employee
where to_number(substr(emp_no, 3, 2)) >= 7
group by substr(emp_no, 3, 2), EXTRACT(MONTH from hire_date)
order by 생월, 2;
-- [5] 영업부서 사원의 사번, 사원명, 부서명, 직급명 조회
select emp_id, emp_name, dept_title, job_name
from employee
join department on (dept_code = dept_id)
join job using (job_code)
where dept_title like '%영업%';
