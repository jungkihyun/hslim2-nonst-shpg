# 한살림 비조합원 온라인 장보기 (Spring Boot + JSP)

비조합원을 위한 한살림 온라인 장보기 웹 앱입니다.
**Spring Boot + JSP** 기반으로 빠르게 시연 가능한 구조를 채택했으며, **HSQLDB(in-memory/file)** 를 사용해 설치 부담을 최소화했습니다.

## ✨ 주요 기능

* 메인 페이지: 한살림 브랜딩 랜딩, 카테고리 네비게이션, 추천 상품
* 회원가입/로그인: 간단 검증, 로그인/로그아웃
* 상품 검색: 키워드/카테고리 필터, 페이징
* 장바구니: 담기/삭제/수량 변경, 총액 계산
  *(필요 시: 주문/결제 UI, 추천, 친환경 마크 표시)*

---

## 🧱 기술 스택

* **Java**: 24 (JDK 24)
* **Spring Boot**: 3.x
* **View**: JSP (JSTL), Bootstrap 5 (CDN 또는 WebJars)
* **DB**: HSQLDB (in-memory / file)
* **Build**: Gradle (Wrapper 동봉)
* **Lombok**, **Devtools**, **Validation**, (선택: **Security**)

---

## 📦 사전 준비물 (Prerequisites)

* **JDK 24** 설치 및 환경변수 설정

    * Windows (PowerShell)

      ```powershell
      $env:JAVA_HOME="C:\Program Files\Java\jdk-24"
      $env:Path="$env:JAVA_HOME\bin;$env:Path"
      java -version
      ```
    * macOS/Linux

      ```bash
      export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home  # macOS 예시
      export PATH="$JAVA_HOME/bin:$PATH"
      java -version
      ```
* **Git**, **Gradle Wrapper**(동봉) → 별도 Gradle 설치 불필요

---

## 🚀 빠른 시작 (Quick Start)

```bash
# 1) 소스 받기
git clone <REPO_URL>
cd <PROJECT_ROOT>

# 2) 실행 (개발 모드)
./gradlew clean bootRun     # Windows: .\gradlew clean bootRun

# 3) 접속
# 기본 포트 8080 (application.yml에서 변경 가능)
open http://localhost:8080/
```

### 기본 URL

* 메인: `GET /`
* 로그인: `GET /login`  (선택: Spring Security 사용 시)
* 회원가입: `GET /signup`
* 검색: `GET /search?keyword=<키워드>&page=0&size=12`
* 장바구니: `GET /cart`

> 데모용 **계정/패스워드**가 있다면 아래 “환경 변수 & 시연 계정” 섹션에 기재하세요.

---

## ⚙️ 설정 (Configuration)

### application.yml (예시)

`src/main/resources/application.yml`

```yaml
server:
  port: 8080

spring:
  thymeleaf: # JSP 사용 시에는 미사용. 단, 혼용 안 함!
    enabled: false

  mvc:
    view:
      prefix: /WEB-INF/views/
      suffix: .jsp

  # HSQLDB: 개발(메모리) / 시연(파일) 중 택1
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
>
> 로 변경하고 `.data/` 폴더가 쓰기 가능해야 합니다.

---

## 📁 프로젝트 구조

```
src
 ├─ main
 │   ├─ java/com/hslim2/nonstshpg
 │   │   ├─ NonstShpgApplication.java
 │   │   ├─ config/            # Security, MVC, ResourceHandler 등
 │   │   ├─ controller/        # 웹 컨트롤러
 │   │   ├─ service/           # 비즈니스 로직
 │   │   ├─ repository/        # Spring Data JPA
 │   │   └─ entity/            # JPA 엔티티
 │   ├─ resources
 │   │   ├─ static/            # 정적자원(css, js, images, favicon.ico)
 │   │   └─ application.yml
 │   └─ webapp
 │       └─ WEB-INF/views/     # JSP (index.jsp, login.jsp 등)
 └─ test/java/...               # 테스트
```

> **정적 리소스 로딩 규칙**
> `src/main/resources/static/**` → 브라우저에서 `/css/**`, `/js/**`, `/images/**`, `/favicon.ico` 로 접근
> JSP에서 참조 예:
>
> ```jsp
> <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
> <img src="${pageContext.request.contextPath}/images/logo.png" alt="로고">
> ```

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

> **중요:** JSP 프로젝트에 Thymeleaf 의존성을 같이 넣지 않는 걸 권장합니다(혼용 시 뷰 리졸버 충돌 가능).

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
  java -jar build/libs/app.jar --server.port=9090 --spring.profiles.active=prod
  ```

---

## 🧑‍💻 개발 가이드

* 브랜치 전략: `main`(안정) / `feature/*`(기능) / `fix/*`(버그)
* 커밋 메시지 규칙: `feat: ~`, `fix: ~`, `docs: ~`, `refactor: ~`
* 코드 스타일: Lombok 적극 사용, Controller-DTO-Service-Entity 레이어 분리

---

## 🧯 트러블슈팅 (자주 만나는 오류)

* **CSS가 적용 안 됨 / MIME type text/html**
  → 경로를 `/resources/...` 가 아닌 `/css/...` 로.
  정적 파일은 `src/main/resources/static/**`.
  JSP:

  ```jsp
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
  ```

  브라우저에서 `http://localhost:8080/css/login.css` 열어 텍스트가 보이면 OK.

* **favicon.ico 404**
  → `src/main/resources/static/favicon.ico` 에 배치.
  필요 시 `<link rel="icon" href="/favicon.ico">` 추가.

* **Security가 정적 리소스 막음**
  → `SecurityFilterChain`에서 허용:

  ```java
  .requestMatchers("/", "/login", "/signup", "/css/**", "/js/**", "/images/**", "/favicon.ico").permitAll()
  .anyRequest().authenticated()
  ```

* **JSP 404 / View 못 찾음**
  → `spring.mvc.view.prefix=/WEB-INF/views/`, `suffix=.jsp` 확인.
  파일 위치 `src/main/webapp/WEB-INF/views/*.jsp`.

* **Lombok @Builder 사용 시 builder() 없음**
  → `@AllArgsConstructor` 추가 또는 생성자에 `@Builder` 부착,
  IntelliJ **Enable Annotation Processing** 체크.

---

## 🔐 (선택) 데모 계정 & 환경변수

* 데모 계정: `user@example.com / Passw0rd!` *(예시 – 실제 값 기입)*
* 관리자 계정: `admin@example.com / Admin123!` *(예시 – 실제 값 기입)*
* 환경 변수:

  ```
  HSQL_MODE=memory|file
  APP_BRAND=Hansalim
  ```

  *(실제 프로젝트에 맞춰 항목/예시값을 채워주세요)*

---

## 📜 라이선스

* 내부 경진대회 제출용(또는 MIT/Apache-2.0 등 선택)

---

# 📌 문서 완성을 위해 필요한 정보 (질문)

아래 항목 알려주시면 README를 **실제 값으로 채워서** 깔끔하게 마무리해 드릴게요.

1. **프로젝트 공식 이름/설명** (한 줄 & 두세 줄 버전)
2. **Git 저장소 URL** (현재 사용 중인 repo)
3. **기본 포트** (8080 유지인가요?)
4. **DB 모드** 기본: in-memory vs file (파일 경로가 있다면 명시)
5. **데모 계정** (이메일/비번) 및 **관리자 계정** 여부
6. **Security 적용 범위** (게스트로 볼 수 있는 페이지/로그인 필요한 페이지)
7. **주요 URL**(컨트롤러 경로) 확정본: `/`, `/login`, `/signup`, `/search`, `/cart`, `/products/{id}` 등
8. **의존성 확정** (JSP만 사용? WebJars/Bootstrap을 CDN으로 쓸지?)
9. **CI/CD 또는 배포 방식** (있다면: GitHub Actions, Docker 등)
10. **스크린샷/데모 영상 링크** (추후 README 하단에 배치)

이 10가지 알려주시면, 위 README를 **진짜 제출용 문서**로 바로 다듬어서 드릴게요.
