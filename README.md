# JAPAN LIFE GUIDE — 일본 생활 행정 안내 기초 프로젝트

미나토구로 이사하는 외국인 주민을 위한 일본어 웹서비스입니다.
이번 전달물은 **절차 안내, 회원별 준비 체크리스트·일정, 계정 복구, 관리자와 커뮤니티 기능이 작동하는 버전**입니다.

## 이번에 작동하는 것

- Spring Boot 서버와 JSP 화면
- 미나토구 생활행정 안내 19개와 일본어·한국어·영어 번역
- 상황·준비 단계 필터, 빠른 분류, 페이지 나누기, 검색 결과 없음
- 준비 서류의 필수·조건부 구분, 진행 순서, 공식 링크·확인일
- 비공개 절차와 없는 절차 접근 시 404, 잘못된 입력 시 400
- Oracle용 테이블 생성·초기 데이터 SQL과 MyBatis 조회 코드
- Oracle 설정 전 확인용 H2 미리보기 모드
- BCrypt 비밀번호 해시를 사용하는 회원가입·로그인·로그아웃
- 로그인 회원의 절차 저장, 저장 시점 서류 사본 생성, 체크 상태·준비 상태 저장
- 월간 달력, 날짜별 일정 추가·완료 전환·삭제
- 저장한 안내와 최신 개정 번호 비교
- 이메일 인증 회원가입, 로그인 ID 찾기, 비밀번호 재설정
- 회원 정보와 비밀번호 변경
- 관리자 대시보드, 회원 상태·권한, 절차 공개 상태, 행정 콘텐츠·커뮤니티 관리
- 커뮤니티 목록·검색·페이지 나누기·이미지·댓글·좋아요·조회수·신고
- 개인정보 안내·이용약관·커뮤니티 운영 규칙 공개 페이지

아직 구현하지 않은 것: 회원 탈퇴, 커뮤니티 게시글 수정 화면, 관리자 다국어 콘텐츠 편집 화면, 커뮤니티 운영 이력입니다.
이메일 인증, 비밀번호 재설정, 로그인 ID 찾기는 개발용 Mailpit SMTP를 사용해 동작합니다.
개인 기록은 로그인 회원 ID 조건으로만 조회·수정합니다.

## 가장 빠르게 화면 보기

Java 17이 설치되어 있어야 합니다. 전달 패키지에 `app/japan-life-guide.war`가
있으면 `start-preview.cmd`를 더블클릭하세요.

콘솔에 `Started JapanLifeGuideApplication`이 나오면
<http://localhost:8081/procedures>를 여세요. 종료는 콘솔에서 Ctrl+C입니다.

미리보기는 **임시 H2 DB**를 사용하고, 화면 위에 Oracle 미연결 표시가 나옵니다.
서버를 끄면 임시 데이터가 사라집니다. 사용자님의 Oracle 테이블은 건드리지 않습니다.
화면 표시용 행정 내용은 공식 자료 기반 초기 안내이며 가상의 행정 요건이 아닙니다.

개인 프로젝트에서 이메일 인증을 테스트하려면 Mailpit을 사용합니다. Windows용
`mailpit.exe`를 프로젝트 폴더에 넣고 `start-mailpit.cmd`를 실행한 뒤,
<http://localhost:8025>에서 인증메일을 확인합니다. SMTP는 `localhost:1025`를
사용하며 외부 이메일 주소로 실제 발송하지 않습니다.

## Eclipse에서 소스 열기

1. ZIP을 풀거나 이 프로젝트 폴더를 사용합니다.
2. `File → Import → Maven → Existing Maven Projects`를 선택합니다.
3. `pom.xml`이 있는 `japan-life-guide` 폴더를 선택하고 Finish를 누릅니다.
4. 프로젝트 JRE를 Java 17로 설정합니다. 문자 인코딩은 UTF-8입니다.
5. 필요한 경우 프로젝트 우클릭 → `Maven → Update Project`를 실행합니다.
6. 프로젝트 우클릭 → `Run As → Maven build…`에서 Goals에
   `spring-boot:run`을 입력하고 실행합니다. 기본값은 미리보기입니다.

Spring Tools가 있다면 `JapanLifeGuideApplication.java`를 Spring Boot App으로,
없으면 Java Application으로 실행할 수도 있습니다. JSP 경로를 찾도록
실행 작업 디렉터리를 프로젝트 루트로 설정하세요.

이 프로젝트는 JSP를 위해 **WAR**로 빌드합니다. 실행 가능한 JAR로 바꾸지 마세요.
Tomcat은 프로젝트에 포함되어 있으며 별도 Tomcat 설치가 필요하지 않습니다.

## Oracle 연결 순서 — 사용자님이 SQL을 실행하시면 됩니다

### 1. 기존 접속 확인

SQL Developer에서 프로젝트용 일반 계정으로 접속하세요.
SYS/SYSTEM을 웹서비스 접속 계정으로 사용하지 마세요.
이 프로젝트는 계정 생성, 기존 테이블 삭제, 비밀번호 변경을 하지 않습니다.
새 계정이 필요하면 현재 권한과 사용 가능한 테이블스페이스를 확인한 뒤 별도로 만듭니다.

`sql/00_check_environment.sql`을 실행해 다음을 확인합니다.

- Oracle 실제 버전과 현재 계정
- 문자셋
- 같은 이름의 `JL_` 테이블·시퀀스가 이미 존재하는지

### 2. SQL을 순서대로 실행

SQL 파일은 UTF-8로 열고 **F5(스크립트 실행)**로 실행합니다.

1. `sql/01_create_tables.sql` — 테이블 25개, 시퀀스 17개, 제약조건과 인덱스
2. 위 스크립트에 오류가 없는지 확인
3. `sql/02_sample_data.sql` — 기본 전입 안내 2개와 연결 데이터
4. `sql/04_seed_translation_data.sql` — 기본 안내의 한국어·영어 번역
5. `sql/07_update_document_guidance.sql` — 서류 설명과 준비 방법
6. `sql/08_add_resident_procedures.sql` — 생활행정 안내 6개 추가
7. `sql/09_review_resident_procedure_documents.sql` — 추가 절차의 서류·번역 보완
8. Oracle에서 실행한 확장 SQL — 절차 9~19와 누락 문서 보완
9. `sql/03_verify.sql` — 데이터 확인

한 번에 실행하려면 `sql/install_all.sql`을 F5로 실행합니다. 나중에 데이터를
추가·수정할 때 사용할 안전한 주석 예제는 `sql/04_edit_examples.sql`, 자세한
설명은 `sql/README_SQL.md`에 있습니다.

통합 설치는 빈 계정에서 최초 한 번 실행하는 스크립트입니다. 재실행용 초기화 스크립트가 아닙니다.
중복 객체·기본키 오류가 나면 반복 실행하지 말고 오류를 확인하세요.
Oracle DDL은 자동 커밋되므로, 오류 후 생성된 객체를 확인해야 합니다.
앱 실행 시 Oracle SQL은 자동 실행되지 않습니다.

일본어는 NVARCHAR2와 N 문자열을 사용합니다. Oracle 11g에서는
IDENTITY 대신 시퀀스, 조회 페이지 나누기는 ROW_NUMBER를 사용합니다.

### 3. 접속 설정

`config/application-local.properties.example`을 같은 폴더의
`application-local.properties`로 복사합니다. 아래 값을 사용자님 환경에 맞게 수정합니다.

```properties
spring.datasource.url=jdbc:oracle:thin:@localhost:1521:XE
spring.datasource.username=실제_프로젝트_계정
spring.datasource.password=실제_비밀번호
```

위 URL은 로컬 XE의 예시입니다. 실제 호스트·포트·SID가 다르면 수정합니다.
서비스명 접속을 사용하는 환경은 `jdbc:oracle:thin:@//호스트:포트/서비스명` 형식입니다.
비밀번호 파일은 `.gitignore`로 제외됩니다. 공유용 ZIP에도 넣지 마세요.

### 4. Oracle 모드 실행

전달된 실행 파일은 `start-oracle.cmd`로 시작합니다.
Eclipse의 Maven Goals는 다음을 사용합니다.

```text
spring-boot:run -Dspring-boot.run.profiles=oracle,local
```

또는 Eclipse Java 실행 설정의 Program arguments에 다음을 넣습니다.

```text
--spring.profiles.active=oracle,local
```

작업 디렉터리가 프로젝트 루트여야 `config/application-local.properties`를 읽습니다.
파일 대신 `DB_URL`, `DB_USERNAME`, `DB_PASSWORD` 환경변수를 설정하고
`oracle` 프로필만 사용하는 방법도 있습니다.

연결 실패 시 H2로 자동 전환하지 않습니다. SQL과 접속 정보를 확인하세요.
화면 상단의 미리보기 표시가 사라졌는지, 목록이 조회되는지 확인합니다.

## 빌드와 테스트

프로젝트 루트에서 실행합니다. 첫 빌드는 라이브러리를 다운로드하므로 인터넷이 필요합니다.

```powershell
.\mvnw.cmd clean verify
java -jar target/japan-life-guide.war --spring.profiles.active=preview
```

소스를 수정해 다시 빌드하면 `target/japan-life-guide.war`가 갱신됩니다.
전달용 `app/japan-life-guide.war`는 최초 빌드 사본이므로 자동 갱신되지 않습니다.
수정한 버전은 위 명령으로 실행하거나 새 WAR를 app 폴더에 복사하세요.

테스트는 H2 Oracle 모드에서 수행하며 실제 Oracle 검증을 대체하지 않습니다. 회원가입·로그인·개인
체크리스트의 HTTP 흐름도 preview 서버에서 확인하지만, 임시 H2 데이터는 서버 종료 시 사라집니다.
실제 검증 결과는 `docs/verification.md`에 기록합니다.

## 사용한 구성

| 항목 | 선택 |
|---|---|
| Java | 17 |
| Spring Boot | 3.5.16 |
| 화면 | JSP + JSTL, HTML/CSS/JavaScript |
| DB 접근 | MyBatis Starter 3.0.5 |
| Oracle 드라이버 | ojdbc8 19.30.0.0 |
| Oracle SQL 대상 | 로컬에서 발견한 11.2 설치 경로에 맞춘 문법 |
| 빌드 | Maven 3.9.11, WAR |

Oracle XE 서비스가 실행 중인 것은 확인했으나 계정으로 연결한 검증은 별도입니다.
Java 17·JDBC·오래된 Oracle XE의 실제 접속 호환성은 사용자님의 DB에서 확인해야 합니다.
Oracle의 현재 JDBC 호환표에 11g 조합이 등재되어 있다고 주장하지 않습니다.

## 파일을 읽는 순서

1. `docs/design.md` — 범위·화면·다음 구현 순서
2. `docs/database.md` — 테이블 관계·컬럼 규칙
3. `sql/01_create_tables.sql` — 실제 DB 구조
4. `ProcedureController.java` → `ProcedureService.java` → `ProcedureMapper.xml`
5. `src/main/webapp/WEB-INF/views/procedures` — 목록·상세 JSP
6. `docs/sources.md` — 행정·기술 출처와 확인 한계

## 자주 생기는 문제

- 포트 사용 중: 실행 인자에 `--server.port=8082`를 추가하고 해당 주소로 접속합니다.
- `ORA-00955`: 동일 이름 객체가 이미 있습니다. 기존 데이터를 지우지 말고 확인합니다.
- `ORA-00942`: SQL을 실행한 계정과 앱 접속 계정, 테이블 생성 결과를 확인합니다.
- `ORA-01017`: 사용자명·비밀번호를 확인합니다.
- `ORA-12505` / `ORA-12514`: SID와 서비스명 형식이 실제 DB와 맞는지 확인합니다.
- 한글·일본어 깨짐: SQL 파일 인코딩 UTF-8 및 Eclipse 인코딩 설정을 확인합니다.
- 화면 500: Eclipse 콘솔의 첫 오류를 확인합니다. 브라우저에는 비밀번호나 내부 오류를 노출하지 않습니다.
- 라이브러리 다운로드 실패: 인터넷 연결·Maven 저장소 접근·Eclipse Maven 설정을 확인합니다.

이 서비스는 미나토구 공식 서비스가 아닙니다. 취업처가 미나토구여도 다른 구에 거주하면
거주지의 안내를 확인해야 합니다. 개별 조건에 대한 최종 판단과 접수는 해당 기관이 합니다.
