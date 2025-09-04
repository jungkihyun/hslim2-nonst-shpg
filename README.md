---

# 한살림 비조합원 온라인 장보기 (Spring Boot + JSP)

비조합원을 위한 한살림 온라인 장보기 웹 애플리케이션입니다.
**Spring Boot + JSP** 기반으로 빠르게 시연 가능한 구조를 채택했으며, **HSQLDB(in-memory/file)** 를 사용해 설치 부담을 최소화했습니다.

## ✨ 주요 기능

* 메인 페이지: 한살림 브랜딩 랜딩, 카테고리 네비게이션, 추천 상품
* 회원가입/로그인: 간단 검증, 로그인/로그아웃
* 상품 검색: 키워드/카테고리 필터, 페이징
* 장바구니: 담기/삭제/수량 변경, 총액 계산
  *(게스트도 장바구니 담기와 바로구매 가능)*

---

## 🧱 기술 스택

* **Java**: 24 (JDK 24)
* **Spring Boot**: 3.5.5
* **View**: JSP (JSTL), Bootstrap 5 (CDN)
* **DB**: HSQLDB (in-memory / file)
* **Build**: Gradle (Wrapper 동봉)
* **Lombok**, **Devtools**, **Validation**, (선택: **Security**)

---

## 📦 사전 준비물 (Prerequisites)

* **JDK 24** 설치 및 환경변수 설정
* **Git**, **Gradle Wrapper**(동봉) → 별도 Gradle 설치 불필요

```powershell
# Windows (PowerShell)
$env:JAVA_HOME="C:\Program Files\Java\jdk-24"
$env:Path="$env:JAVA_HOME\bin;$env:Path"
java -version
```

```bash
# macOS/Linux
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
java -version
```

---

## 🚀 빠른 시작 (Quick Start)

```bash
# 1) 소스 받기
git clone https://github.com/jungkihyun/hslim2-nonst-shpg.git
cd hslim2-nonst-shpg

# 2) 실행 (개발 모드)
./gradlew clean bootRun     # Windows: .\gradlew clean bootRun

# 3) 접속
open http://localhost:1986/
```

### 기본 URL

* 메인: `GET /`
* 로그인: `GET /login`
* 회원가입: `GET /signup`
* 검색: `GET /search?keyword=<키워드>&page=0&size=12`
* 장바구니: `GET /cart`

---

## ⚙️ 설정 (Configuration)

### application.yml (예시)

`src/main/resources/application.yml`

```yaml
server:
  port: 1986   # 기본 포트

spring:
  mvc:
    view:
      prefix: /WEB-INF/views/
      suffix: .jsp

  datasource:
    url: jdbc:hsqldb:mem:hansalim;DB_CLOSE_DELAY=-1
    username: sa
    password:

  jpa:
    hibernate:
      ddl-auto: update
    properties:
      hibernate.format_sql: true
      hibernate.jdbc.time_zone: Asia/Seoul

logging:
  level:
    org.hibernate.SQL: warn
```

> **파일 DB 모드**로 쓰려면:
>
> ```
> spring.datasource.url: jdbc:hsqldb:file:./.data/hansalimdb
> ```

---

## 📁 프로젝트 구조

```
src
 ├─ main
 │   ├─ java/com/hslim2/nonstshpg
 │   │   ├─ NonstShpgApplication.java
 │   │   ├─ config/
 │   │   ├─ controller/
 │   │   ├─ service/
 │   │   ├─ repository/
 │   │   └─ entity/
 │   ├─ resources
 │   │   ├─ static/            # 정적자원(css, js, images, favicon.ico)
 │   │   └─ application.yml
 │   └─ webapp
 │       └─ WEB-INF/views/     # JSP (index.jsp, login.jsp 등)
 └─ test/java/...
```

---

## 🔩 필수 의존성 (build.gradle – 발췌)

```gradle
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-validation'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    runtimeOnly   'org.hsqldb:hsqldb'

    // JSP & JSTL
    implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
    implementation 'org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1'

    // (선택) 보안
    implementation 'org.springframework.boot:spring-boot-starter-security'
    testImplementation 'org.springframework.security:spring-security-test'

    // 기타
    compileOnly   'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

---

## 🧪 테스트

```bash
./gradlew test
```

---

## 🧰 빌드 & 배포

* 실행 JAR 빌드:

  ```bash
  ./gradlew clean bootJar
  java -jar build/libs/*.jar
  ```

* 포트/프로파일:

  ```bash
  java -jar build/libs/app.jar --server.port=1986 --spring.profiles.active=prod
  ```

---

## 🧑‍💻 개발 가이드

* 브랜치 전략: `main`(안정) / `feature/*`(기능) / `fix/*`(버그)
* 커밋 메시지 규칙: `feat: ~`, `fix: ~`, `docs: ~`, `refactor: ~`
* 코드 스타일: Lombok 적극 사용, Controller-DTO-Service-Entity 레이어 분리

---

## 🔐 보안 & 접근 권한

* 게스트: 메인, 검색, 장바구니 담기/바로구매 가능
* 로그인 필요: 주문 내역, 개인 정보 수정

---

## 📜 라이선스

* 내부 경진대회 제출용

---

## 📷 스크린샷 & 데모

* 별도 제출 (경진대회 제출 자료에 포함)

---