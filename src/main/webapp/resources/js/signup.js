/**
 * 회원가입 페이지 JavaScript
 */

document.addEventListener('DOMContentLoaded', function() {
    initSignupForm();
});

/**
 * 회원가입 폼 초기화
 */
function initSignupForm() {
    const signupForm = document.getElementById('signupForm');
    const submitButton = signupForm.querySelector('button[type="submit"]');
    
    // 실시간 유효성 검사
    initRealTimeValidation();
    
    // 폼 제출 처리
    signupForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // 버튼 비활성화 및 로딩 표시
        showLoadingSpinner(submitButton);
        
        // 폼 유효성 검사
        if (!validateSignupForm()) {
            hideLoadingSpinner(submitButton);
            return;
        }
        
        // 실제 폼 제출
        setTimeout(() => {
            signupForm.submit();
        }, 500);
    });
}

/**
 * 실시간 유효성 검사 초기화
 */
function initRealTimeValidation() {
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    const passwordConfirm = document.getElementById('passwordConfirm');
    const name = document.getElementById('name');
    const phone = document.getElementById('phone');
    
    // 이메일 중복 체크 (디바운싱 적용)
    const debouncedEmailCheck = debounce(checkEmailDuplicate, 500);
    email.addEventListener('blur', function() {
        const emailValue = this.value.trim();
        if (emailValue && isValidEmail(emailValue)) {
            debouncedEmailCheck(emailValue);
        }
    });
    
    // 비밀번호 실시간 검사
    password.addEventListener('input', function() {
        validatePassword(this.value);
        // 비밀번호 확인 재검사
        if (passwordConfirm.value) {
            validatePasswordConfirm();
        }
    });
    
    // 비밀번호 확인 검사
    passwordConfirm.addEventListener('input', validatePasswordConfirm);
    
    // 이름 입력 제한 (한글, 영문만)
    name.addEventListener('input', function() {
        const value = this.value;
        const koreanEnglishOnly = /^[가-힣a-zA-Z\s]*$/;
        if (!koreanEnglishOnly.test(value)) {
            this.value = value.replace(/[^가-힣a-zA-Z\s]/g, '');
        }
        validateName();
    });
    
    // 전화번호 자동 하이픈 추가
    phone.addEventListener('input', function() {
        let value = this.value.replace(/\D/g, ''); // 숫자만 남김
        if (value.length >= 3 && value.length <= 7) {
            value = value.replace(/(\d{3})(\d+)/, '$1-$2');
        } else if (value.length >= 8) {
            value = value.replace(/(\d{3})(\d{4})(\d+)/, '$1-$2-$3');
        }
        this.value = value;
        validatePhone();
    });
}

/**
 * 회원가입 폼 전체 유효성 검사
 */
function validateSignupForm() {
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();
    const passwordConfirm = document.getElementById('passwordConfirm').value.trim();
    const name = document.getElementById('name').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const agreeTerms = document.getElementById('agreeTerms').checked;
    
    let isValid = true;
    
    // 이메일 검사
    if (!email) {
        showFieldError('email', '이메일을 입력해주세요.');
        isValid = false;
    } else if (!isValidEmail(email)) {
        showFieldError('email', '올바른 이메일 형식이 아닙니다.');
        isValid = false;
    }
    
    // 비밀번호 검사
    if (!password) {
        showFieldError('password', '비밀번호를 입력해주세요.');
        isValid = false;
    } else if (!isValidPassword(password)) {
        showFieldError('password', '비밀번호는 영문, 숫자 조합으로 6자 이상이어야 합니다.');
        isValid = false;
    }
    
    // 비밀번호 확인 검사
    if (!passwordConfirm) {
        showFieldError('passwordConfirm', '비밀번호 확인을 입력해주세요.');
        isValid = false;
    } else if (password !== passwordConfirm) {
        showFieldError('passwordConfirm', '비밀번호가 일치하지 않습니다.');
        isValid = false;
    }
    
    // 이름 검사
    if (!name) {
        showFieldError('name', '이름을 입력해주세요.');
        isValid = false;
    } else if (name.length < 2) {
        showFieldError('name', '이름은 2자 이상 입력해주세요.');
        isValid = false;
    }
    
    // 전화번호 검사
    if (!phone) {
        showFieldError('phone', '연락처를 입력해주세요.');
        isValid = false;
    } else if (!isValidPhone(phone)) {
        showFieldError('phone', '올바른 연락처 형식이 아닙니다.');
        isValid = false;
    }
    
    // 약관 동의 검사
    if (!agreeTerms) {
        showErrorMessage('이용약관 및 개인정보처리방침에 동의해주세요.');
        document.getElementById('agreeTerms').focus();
        isValid = false;
    }
    
    return isValid;
}

/**
 * 이메일 중복 체크
 */
function checkEmailDuplicate(email) {
    ajaxRequest('/api/auth/check-email', 'POST', { email: email },
        function(response) {
            if (response.available) {
                showFieldSuccess('email', '사용 가능한 이메일입니다.');
            } else {
                showFieldError('email', '이미 사용 중인 이메일입니다.');
            }
        },
        function(status, error) {
            console.error('이메일 중복 체크 실패:', error);
        }
    );
}

/**
 * 비밀번호 유효성 검사
 */
function validatePassword(password) {
    const field = document.getElementById('password');
    
    if (!password) {
        return false;
    }
    
    if (!isValidPassword(password)) {
        showFieldError('password', '영문, 숫자 조합으로 6자 이상 입력해주세요.');
        return false;
    }
    
    showFieldSuccess('password', '사용 가능한 비밀번호입니다.');
    return true;
}

/**
 * 비밀번호 확인 검사
 */
function validatePasswordConfirm() {
    const password = document.getElementById('password').value;
    const passwordConfirm = document.getElementById('passwordConfirm').value;
    
    if (!passwordConfirm) {
        return false;
    }
    
    if (password !== passwordConfirm) {
        showFieldError('passwordConfirm', '비밀번호가 일치하지 않습니다.');
        return false;
    }
    
    showFieldSuccess('passwordConfirm', '비밀번호가 일치합니다.');
    return true;
}

/**
 * 이름 유효성 검사
 */
function validateName() {
    const name = document.getElementById('name').value.trim();
    
    if (!name) {
        return false;
    }
    
    if (name.length < 2) {
        showFieldError('name', '이름은 2자 이상 입력해주세요.');
        return false;
    }
    
    const koreanEnglishOnly = /^[가-힣a-zA-Z\s]+$/;
    if (!koreanEnglishOnly.test(name)) {
        showFieldError('name', '한글 또는 영문으로만 입력해주세요.');
        return false;
    }
    
    clearFieldError('name');
    return true;
}

/**
 * 전화번호 유효성 검사
 */
function validatePhone() {
    const phone = document.getElementById('phone').value.trim();
    
    if (!phone) {
        return false;
    }
    
    if (!isValidPhone(phone)) {
        showFieldError('phone', '올바른 연락처 형식으로 입력해주세요.');
        return false;
    }
    
    clearFieldError('phone');
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
 * 비밀번호 형식 검사
 */
function isValidPassword(password) {
    // 최소 6자, 영문과 숫자 조합
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{6,}$/;
    return passwordRegex.test(password);
}

/**
 * 전화번호 형식 검사
 */
function isValidPhone(phone) {
    const phoneRegex = /^01[0-9]-\d{3,4}-\d{4}$/;
    return phoneRegex.test(phone);
}

/**
 * 필드 에러 표시
 */
function showFieldError(fieldId, message) {
    const field = document.getElementById(fieldId);
    field.classList.add('is-invalid');
    field.classList.remove('is-valid');
    
    // 기존 에러 메시지 제거
    const existingError = field.parentNode.querySelector('.invalid-feedback:not(.d-block)');
    if (existingError) {
        existingError.remove();
    }
    
    // 새 에러 메시지 추가
    const errorDiv = document.createElement('div');
    errorDiv.className = 'invalid-feedback';
    errorDiv.textContent = message;
    field.parentNode.appendChild(errorDiv);
}

/**
 * 필드 성공 표시
 */
function showFieldSuccess(fieldId, message) {
    const field = document.getElementById(fieldId);
    field.classList.add('is-valid');
    field.classList.remove('is-invalid');
    
    // 기존 메시지들 제거
    const existingFeedback = field.parentNode.querySelectorAll('.invalid-feedback:not(.d-block), .valid-feedback:not(.d-block)');
    existingFeedback.forEach(fb => fb.remove());
    
    // 성공 메시지 추가
    const successDiv = document.createElement('div');
    successDiv.className = 'valid-feedback';
    successDiv.textContent = message;
    field.parentNode.appendChild(successDiv);
}

/**
 * 필드 에러 제거
 */
function clearFieldError(fieldId) {
    const field = document.getElementById(fieldId);
    field.classList.remove('is-invalid', 'is-valid');
    
    const feedback = field.parentNode.querySelectorAll('.invalid-feedback:not(.d-block), .valid-feedback:not(.d-block)');
    feedback.forEach(fb => fb.remove());
}

/**
 * 디바운스 함수
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}
