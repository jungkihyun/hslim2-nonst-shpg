<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{layout}">
<head>
    <title>회원가입</title>
</head>
<body>
<main layout:fragment="content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header text-center bg-success text-white">
                        <h4><i class="bi bi-person-plus"></i> 회원가입</h4>
                        <p class="mb-0">한살림 온라인 장보기에 오신 것을 환영합니다</p>
                    </div>
                    <div class="card-body p-4">
                        <form th:action="@{/signup}" th:object="${signupDto}" method="post">
                            <!-- 이메일 -->
                            <div class="mb-3">
                                <label for="email" class="form-label">이메일 <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" th:field="*{email}" 
                                       th:class="${#fields.hasErrors('email')} ? 'form-control is-invalid' : 'form-control'"
                                       placeholder="example@email.com">
                                <div class="invalid-feedback" th:if="${#fields.hasErrors('email')}" th:errors="*{email}"></div>
                            </div>

                            <!-- 비밀번호 -->
                            <div class="mb-3">
                                <label for="password" class="form-label">비밀번호 <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="password" th:field="*{password}"
                                       th:class="${#fields.hasErrors('password')} ? 'form-control is-invalid' : 'form-control'"
                                       placeholder="6자 이상 입력해주세요">
                                <div class="invalid-feedback" th:if="${#fields.hasErrors('password')}" th:errors="*{password}"></div>
                            </div>

                            <!-- 비밀번호 확인 -->
                            <div class="mb-3">
                                <label for="passwordConfirm" class="form-label">비밀번호 확인 <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="passwordConfirm" th:field="*{passwordConfirm}"
                                       th:class="${#fields.hasErrors('passwordConfirm')} ? 'form-control is-invalid' : 'form-control'"
                                       placeholder="비밀번호를 다시 입력해주세요">
                                <div class="invalid-feedback" th:if="${#fields.hasErrors('passwordConfirm')}" th:errors="*{passwordConfirm}"></div>
                            </div>

                            <!-- 이름 -->
                            <div class="mb-3">
                                <label for="name" class="form-label">이름 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="name" th:field="*{name}"
                                       th:class="${#fields.hasErrors('name')} ? 'form-control is-invalid' : 'form-control'"
                                       placeholder="실명을 입력해주세요">
                                <div class="invalid-feedback" th:if="${#fields.hasErrors('name')}" th:errors="*{name}"></div>
                            </div>

                            <!-- 연락처 -->
                            <div class="mb-4">
                                <label for="phone" class="form-label">연락처 <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="phone" th:field="*{phone}"
                                       th:class="${#fields.hasErrors('phone')} ? 'form-control is-invalid' : 'form-control'"
                                       placeholder="010-0000-0000">
                                <div class="invalid-feedback" th:if="${#fields.hasErrors('phone')}" th:errors="*{phone}"></div>
                            </div>

                            <!-- 가입하기 버튼 -->
                            <button type="submit" class="btn btn-success w-100 mb-3">
                                <i class="bi bi-check-circle"></i> 가입하기
                            </button>

                            <!-- 로그인 링크 -->
                            <div class="text-center">
                                <span class="text-muted">이미 계정이 있으신가요?</span>
                                <a th:href="@{/login}" class="text-decoration-none">로그인</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
