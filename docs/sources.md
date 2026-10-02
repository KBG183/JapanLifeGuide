# 확인한 출처

확인일: 2026-09-28. 행정 내용은 핵심 항목을 재서술했습니다.
구청의 공식 서비스가 아니며 전입신고를 대신 접수하지 않습니다.

## 행정 안내

1. [미나토구 전입신고 상세](https://www.city.minato.tokyo.jp/shibamadosa/kurashi/todokede/hikkoshi/tennyu.html)
   - 표시 갱신일: 2026-07-02.
   - 해외/국내 전입의 서류, 조건부 항목, 신고 창구, 기한을 확인.
   - 직접 페이지 요청은 한 차례 403이었으나, 검색 도구에서 같은 공식 URL의
     상세 본문을 확인했습니다. 실시간 원본과 검색 색인 시점이 다를 수 있습니다.
   - 개인별 모든 예외를 자동 판정하지 않으며, 상세 원문 링크를 제공합니다.
2. [미나토구 쉬운 일본어 이사 안내](https://www.city.minato.tokyo.jp/easyjp/moving/residentregistration/moving.html)
   - 표시 갱신일: 2020-10-01. 직접 본문 확인.
   - 해외·국내 전입의 구분 및 쉬운 설명을 대조.
   - 오래된 간략 안내이므로 조건 차이가 있으면 더 새로운 상세 페이지를 우선합니다.
3. [미나토구 영어 이사 안내](https://www.city.minato.tokyo.jp/easyjp/en/moving/residentregistration/moving.html)
   - 표시 갱신일: 2024-03-28. 직접 본문 확인, 보조 대조 자료.

## 콘텐츠 적용 범위

- 미나토구에 실제 거주지를 옮기는 외국인 주민의 기본적인 본인 신고를 대상으로 합니다.
- 대리 신고, 카드를 아직 받지 않은 경우, 특수한 세대 구성 등의 판정 기능은 없습니다.
- 필요한 행정 문서의 사진·번호·PIN을 입력하는 기능은 없습니다.
- 창구의 개별 주소와 지도 좌표는 검증 전이라 등록하지 않았습니다.
- 단계 설명은 공식 정보에 근거해 이 프로젝트가 정리한 준비 순서입니다.
- 확인일은 출처를 확인한 날짜이며 내용이 미래에도 동일하다는 보증이 아닙니다.

## 지역 선정 배경

- [도쿄도 2021년 경제센서스](https://www.toukei.metro.tokyo.lg.jp/ecensus/kzsensuska/2021/ka21tf0310.pdf)
- [구별 산업 통계](https://www.city.toshima.lg.jp/documents/47021/3-1-r5.pdf)

2021년 정보통신업 사업체·종사자 집적에 근거해 미나토구를 선정했습니다.
회사 수와 사업체 수, 정보통신업 전체와 소프트웨어 개발, 근무지와 거주지는 다릅니다.
외국인 개발자 인원 순위를 확정한 자료는 아닙니다.

## 기술 구성

- [Spring Boot 3.5 Servlet/JSP 문서](https://docs.spring.io/spring-boot/3.5/reference/web/servlet.html)
  - JSP를 실행 가능한 WAR로 구성하는 근거.
- [MyBatis Spring Boot Starter 공식 문서](https://mybatis.org/spring-boot-starter/mybatis-spring-boot-autoconfigure/)
  - Starter 3.0 계열의 Spring Boot 3.2~3.5, Java 17 호환표 확인.
- [Oracle JDBC FAQ](https://www.oracle.com/database/technologies/faq-jdbc.html)
  - Java 17 사용 가능한 19.x ojdbc8 계열 확인. 현재 표에서 오래된 11g XE와의
    조합이 보장되는 것은 아니므로 실제 접속 테스트를 별도 완료해야 합니다.
- 배포 의존성은 Maven Central에서 다운로드했습니다.

버전은 이 프로젝트가 선택한 고정 버전입니다. 모든 구성의 최신 버전이라는 뜻은 아닙니다.
