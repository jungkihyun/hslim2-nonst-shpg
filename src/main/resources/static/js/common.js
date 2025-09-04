/**
 * 공통 JavaScript 함수들
 */

// 페이지 로딩 시 실행
document.addEventListener('DOMContentLoaded', function() {
    // Bootstrap 툴팁 초기화
    initTooltips();
    
    // 알림 메시지 자동 숨김
    autoHideAlerts();
    
    // 폼 유효성 검사 초기화
    initFormValidation();
});

/**
 * Bootstrap 툴팁 초기화
 */
function initTooltips() {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    if (tooltipTriggerList.length > 0) {
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => 
            new bootstrap.Tooltip(tooltipTriggerEl));
    }
}

/**
 * 알림 메시지 자동 숨김 (5초 후)
 */
function autoHideAlerts() {
    const alerts = document.querySelectorAll('.alert:not(.alert-permanent)');
    alerts.forEach(alert => {
        setTimeout(() => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 5000);
    });
}

/**
 * 폼 유효성 검사 초기화
 */
function initFormValidation() {
    const forms = document.querySelectorAll('.needs-validation');
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    });
}

/**
 * 로딩 스피너 표시
 */
function showLoadingSpinner(element) {
    const originalContent = element.innerHTML;
    element.setAttribute('data-original-content', originalContent);
    element.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>로딩중...';
    element.disabled = true;
}

/**
 * 로딩 스피너 숨김
 */
function hideLoadingSpinner(element) {
    const originalContent = element.getAttribute('data-original-content');
    if (originalContent) {
        element.innerHTML = originalContent;
        element.removeAttribute('data-original-content');
    }
    element.disabled = false;
}

/**
 * Ajax 요청 공통 함수
 */
function ajaxRequest(url, method, data, successCallback, errorCallback) {
    const xhr = new XMLHttpRequest();
    xhr.open(method, url);
    xhr.setRequestHeader('Content-Type', 'application/json');
    
    // CSRF 토큰 추가
    const csrfToken = document.querySelector('meta[name="_csrf"]');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]');
    if (csrfToken && csrfHeader) {
        xhr.setRequestHeader(csrfHeader.content, csrfToken.content);
    }
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                if (successCallback) {
                    successCallback(JSON.parse(xhr.responseText));
                }
            } else {
                if (errorCallback) {
                    errorCallback(xhr.status, xhr.responseText);
                }
            }
        }
    };
    
    xhr.send(data ? JSON.stringify(data) : null);
}

/**
 * 성공 메시지 표시
 */
function showSuccessMessage(message) {
    showMessage(message, 'success');
}

/**
 * 에러 메시지 표시
 */
function showErrorMessage(message) {
    showMessage(message, 'danger');
}

/**
 * 메시지 표시 공통 함수
 */
function showMessage(message, type) {
    // 기존 메시지 제거
    const existingAlerts = document.querySelectorAll('.alert.dynamic-alert');
    existingAlerts.forEach(alert => alert.remove());
    
    // 새 메시지 생성
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show dynamic-alert`;
    alertDiv.innerHTML = `
        <span>${message}</span>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    // 컨테이너에 추가
    const container = document.querySelector('.container');
    if (container) {
        container.insertBefore(alertDiv, container.firstChild);
    }
    
    // 5초 후 자동 제거
    setTimeout(() => {
        if (alertDiv.parentNode) {
            alertDiv.remove();
        }
    }, 5000);
}

/**
 * 확인 다이얼로그
 */
function confirmDialog(message, callback) {
    if (confirm(message)) {
        if (callback) callback();
    }
}

/**
 * 숫자를 천단위 콤마로 포맷
 */
function formatNumber(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

/**
 * 폼 데이터를 객체로 변환
 */
function formToObject(form) {
    const formData = new FormData(form);
    const object = {};
    formData.forEach((value, key) => {
        object[key] = value;
    });
    return object;
}

/**
 * URL 파라미터 가져오기
 */
function getUrlParameter(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// 전역 에러 핸들러
window.addEventListener('error', function(e) {
    console.error('Global error:', e.error);
});
