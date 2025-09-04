/**
 * 로그인 페이지 JavaScript
 */

document.addEventListener('DOMContentLoaded', function() {
    initLoginForm();
});

/**
 * 로그인 폼 초기화
 */
function initLoginForm() {
    const loginForm = document.getElementById('loginForm');
    const submitButton = loginForm.querySelector('button[type="submit"]');
    
    loginForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // 버튼 비활성화 및 로딩 표시
        showLoadingSpinner(submitButton);
        
        // 폼 유효성 검사
        if (!validateLoginForm()) {
            hideLoadingSpinner(submitButton);
            return;
        }
        
        // 실제 폼 제출
        setTimeout(() => {
            loginForm.submit();
        }, 500);
    });
    
    // Enter 키 처리
    const inputs = loginForm.querySelectorAll('input');
    inputs.forEach((input, index) => {
        input.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                if (index === inputs.length - 1) {
                    // 마지막 입력 필드에서 Enter 시 폼 제출
                    loginForm.dispatchEvent(new Event('submit'));
                } else {
                    // 다음 입력 필드로 포커스 이동
                    inputs[index + 1].focus();
                }
            }
        });
    });
}

/**
 * 로그인 폼 유효성 검사
 */
function validateLoginForm() {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    
    // 이메일 검사
    if (!username) {
        showFieldError('username', '이메일을 입력해주세요.');
        return false;
    }
    
    if (!isValidEmail(username)) {
        showFieldError('username', '올바른 이메일 형식이 아닙니다.');
        return false;
    }
    
    // 비밀번호 검사
    if (!password) {
        showFieldError('password', '비밀번호를 입력해주세요.');
        return false;
    }
    
    if (password.length < 6) {
        showFieldError('password', '비밀번호는 최소 6자 이상이어야 합니다.');
        return false;
    }
    
    // 에러 메시지 제거
    clearFieldErrors();
    
    return true;
}

/**
 * 이메일 형식 검사
 */
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

/**
 * 필드 에러 표시
 */
function showFieldError(fieldId, message) {
    const field = document.getElementById(fieldId);
    const errorDiv = field.parentNode.querySelector('.invalid-feedback');
    
    field.classList.add('is-invalid');
    
    if (errorDiv) {
        errorDiv.textContent = message;
    } else {
        const newErrorDiv = document.createElement('div');
        newErrorDiv.className = 'invalid-feedback';
        newErrorDiv.textContent = message;
        field.parentNode.appendChild(newErrorDiv);
    }
    
    // 포커스 이동
    field.focus();
}

/**
 * 필드 에러 제거
 */
function clearFieldErrors() {
    const invalidFields = document.querySelectorAll('.is-invalid');
    invalidFields.forEach(field => {
        field.classList.remove('is-invalid');
    });
    
    const errorMessages = document.querySelectorAll('.invalid-feedback');
    errorMessages.forEach(error => {
        error.remove();
    });
}

/**
 * 소셜 로그인 (추후 확장용)
 */
function socialLogin(provider) {
    console.log(`${provider} 로그인 시도`);
    // TODO: 소셜 로그인 구현
}
