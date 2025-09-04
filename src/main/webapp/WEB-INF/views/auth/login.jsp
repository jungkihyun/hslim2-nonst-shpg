<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-header text-center bg-success text-white">
                    <h4><i class="bi bi-box-arrow-in-right"></i> 로그인</h4>
                    <p class="mb-0">한살림 온라인 장보기에 오신 것을 환영합니다</p>
                </div>
                <div class="card-body p-4">
                    <!-- 오류 메시지 -->
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-triangle me-2"></i>
                            이메일 또는 비밀번호가 올바르지 않습니다.
                        </div>
                    </c:if>
                    
                    <!-- 로그아웃 메시지 -->
                    <c:if test="${param.logout != null}">
                        <div class="alert alert-success">
                            <i class="bi bi-check-circle me-2"></i>
                            성공적으로 로그아웃되었습니다.
                        </div>
                    </c:if>

                    <form action="<c:url value='/login' />" method="post" id="loginForm">
                        <!-- 이메일 -->
                        <div class="mb-3">
                            <label for="email" class="form-label">이메일 <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   placeholder="example@email.com" required autofocus>
                        </div>

                        <!-- 비밀번호 -->
                        <div class="mb-4">
                            <label for="password" class="form-label">비밀번호 <span class="text-danger">*</span></label>
                            <div class="position-relative">
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="비밀번호를 입력하세요" required>
                                <button type="button" class="btn btn-link position-absolute end-0 top-50 translate-middle-y" 
                                        id="togglePassword" style="border: none; background: none;">
                                    <i class="bi bi-eye" id="toggleIcon"></i>
                                </button>
                            </div>
                        </div>

                        <!-- 로그인 유지 -->
                        <div class="mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMe" name="remember-me">
                                <label class="form-check-label" for="rememberMe">
                                    로그인 상태 유지
                                </label>
                            </div>
                        </div>

                        <!-- 로그인 버튼 -->
                        <button type="submit" class="btn btn-success w-100 mb-3">
                            <i class="bi bi-box-arrow-in-right"></i> 로그인
                        </button>
                    </form>

                    <hr>

                    <!-- 링크들 -->
                    <div class="text-center">
                        <div class="mb-2">
                            <span class="text-muted">계정이 없으신가요?</span>
                            <a href="<c:url value='/signup' />" class="text-decoration-none">회원가입</a>
                        </div>
                        <div class="mb-2">
                            <a href="#" class="text-muted text-decoration-none small">
                                비밀번호를 잊으셨나요?
                            </a>
                        </div>
                        <div>
                            <a href="<c:url value='/' />" class="text-muted text-decoration-none small">
                                <i class="bi bi-house me-1"></i>메인으로 돌아가기
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// 비밀번호 보기/숨기기 토글
document.getElementById('togglePassword').addEventListener('click', function() {
    const passwordInput = document.getElementById('password');
    const toggleIcon = document.getElementById('toggleIcon');
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleIcon.className = 'bi bi-eye-slash';
    } else {
        passwordInput.type = 'password';
        toggleIcon.className = 'bi bi-eye';
    }
});

// 폼 제출 시 로딩 상태
document.getElementById('loginForm').addEventListener('submit', function() {
    const submitBtn = this.querySelector('button[type="submit"]');
    const originalText = submitBtn.innerHTML;
    
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>로그인 중...';
    
    // 5초 후 원래 상태로 복구 (타임아웃 방지)
    setTimeout(() => {
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalText;
    }, 5000);
});
</script>
