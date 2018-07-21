install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")
install.packages("data.table")
install.packages("dplyr")

library(rJava)
library(DBI)
library(RJDBC)
library(data.table)
library(dplyr)
## java + db 커넥션
drv <- JDBC(  
  
"oracle.jdbc.driver.OracleDriver",
"C:\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\jdbc\\lib\\ojdbc6.jar"
)

## R 커넥션 
conn <- dbConnect(drv,
"jdbc:oracle:thin:@localhost:1521:xe",
"hr",
"oracle")

tab <- dbGetQuery(conn, "SELECT * FROM TAB")

## 대소문자구분
View(tab) 

tname <- tab$TNAME
tname

# COUNTRIES -> cnt
# DEPARTMENTS -> dep
# EMPLOYEES -> emp
# EMP_DETAILS_VIEW -> empd
# JOBS -> job
# JOB_HISTORY -> jobn
# LOCATIONS -> loc
# REGIONS -> reg

cnt <- data.frame(dbGetQuery(conn, "SELECT * FROM COUNTRIES"))
cnt <- data.frame(dbGetQuery(conn, "SELECT * FROM DEPARTMENTS"))
cnt <- data.frame(dbGetQuery(conn, "SELECT * FROM EMPLOYEES"))
cnt <- data.frame(dbGetQuery(conn, "SELECT * FROM EMP_DETAILS_VIEW"))
cnt <- data.frame(dbGetQuery(conn, "SELECT * FROM JOBS"))
cnt <- data.frame(dbGetQuery(conn, "SELECT * FROM JOB_HISTORY"))
cnt <- data.frame(dbGetQuery(conn, "SELECT * FROM LOCATIONS"))
cnt <- data.frame(dbGetQuery(conn, "SELECT * FROM REGIONS"))

View(cnt)
tname <- tab$TNAME
tname
cnt %>%
    select(everything()) %>%
    slice(1:3)

  # EMPLOYEE_ID
  # FIRST_NAME
  # LAST_NAME
  # EMAIL
  # PHONE_NUMBER
  # HIRE_DATE
  # JOB_ID
  # SALARY
  # COMMISSION_PCT
  # MANAGER_ID
  # DEPARTMENT_ID


  ## 문제 1 사원의 First Name 과 Last Name 을
  ## 붙여서 Name 으로 된 컬럼을 추가하시오
  ## 단, 이름 간격은 띄울것. ex) James Dean

cnt %>% mutate(paste(FIRST_NAME, LAST_NAME))

# paste("James", "Dean") : 문자열 결합 함수

  ## 문제 2. SALARY 는 연봉(달러)을 말합니다.
  ## 경리부에서 매달 지급하는 월급여를 
  ## 알려달라고 하여 MONTH_SAL 이라는 컬럼을
  ## 추가 시켜주세요.

cnt %>% mutate( MONTH_SAL = SALARY/12)


  ## 문제 3. 경리부에서 급여가 20000불 이상인
  ## 사원의 목록을 NAME, EMPLOYEE_ID, SALARY 
  ## 만 보여주세요. : 139p

cnt %>% select(LAST_NAME, EMPLOYEE_ID, SALARY)%>%
filter(SALARY >= 20000)

  ## 문제 4. 경리부에서 급여가 7000불 이하인
  ## 사원에게 보너스로 급여의 10%를 더 지급하
  ## 겠다고 합니다. 이번달에 보너스가 추가된
  ## 대상자의 목록을 NAME, EMPLOYEE_ID, SALARY
  ## 만 보여주세요.


 
  ## 문제 5. 직원중에서 성(LAST_NAME) 에 e  또는
  ## o 가 포함된 직원을 출력하시오.

ceo_sal <- apply(emp %>%
          select(SALARY), 2, MAX)
ceo_sal

str(scores)
scores %>%
 filter(Stu_ID %% 2=1 & gender=='M' & Math>=90 & Science>=90) %>%
 slice(1:3)
