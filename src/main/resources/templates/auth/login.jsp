<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{layout}">
<head>
    <title>로그인</title>
</head>
<body>
<main layout:fragment="content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow">
                    <div class="card-header text-center bg-success text-white">
                        <h4><i class="bi bi-box-arrow-in-right"></i> 로그인</h4>
                        <p class="mb-0">한살림 온라인 장보기</p>
                    </div>
                    <div class="card-body p-4">
                        <!-- 로그인 에러 메시지 -->
                        <div th:if="${param.error}" class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle"></i>
                            이메일 또는 비밀번호가 올바르지 않습니다.
                        </div>

                        <!-- 로그아웃 메시지 -->
                        <div th:if="${param.logout}" class="alert alert-success" role="alert">
                            <i class="bi bi-check-circle"></i>
                            로그아웃되었습니다.
                        </div>

                        <form th:action="@{/login}" method="post">
                            <!-- 이메일 -->
                            <div class="mb-3">
                                <label for="username" class="form-label">이메일</label>
                                <input type="email" class="form-control" id="username" name="username" 
                                       placeholder="이메일을 입력하세요" required>
                            </div>

                            <!-- 비밀번호 -->
                            <div class="mb-4">
                                <label for="password" class="form-label">비밀번호</label>
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="비밀번호를 입력하세요" required>
                            </div>

                            <!-- 로그인 버튼 -->
                            <button type="submit" class="btn btn-success w-100 mb-3">
                                <i class="bi bi-box-arrow-in-right"></i> 로그인
                            </button>

                            <!-- 회원가입 링크 -->
                            <div class="text-center">
                                <span class="text-muted">아직 계정이 없으신가요?</span>
                                <a th:href="@{/signup}" class="text-decoration-none">회원가입</a>
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
