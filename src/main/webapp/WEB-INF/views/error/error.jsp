<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="text-center py-5">
                <!-- 오류 아이콘 -->
                <div class="mb-4">
                    <c:choose>
                        <c:when test="${statusCode == 404}">
                            <i class="bi bi-exclamation-triangle display-1 text-warning"></i>
                        </c:when>
                        <c:when test="${statusCode == 403}">
                            <i class="bi bi-shield-x display-1 text-danger"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-exclamation-circle display-1 text-danger"></i>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 오류 코드 -->
                <h1 class="display-4 fw-bold text-dark mb-3">
                    <c:out value="${statusCode}" default="오류" />
                </h1>

                <!-- 오류 메시지 -->
                <h4 class="text-muted mb-4">
                    <c:out value="${errorMessage}" default="알 수 없는 오류가 발생했습니다." />
                </h4>

                <!-- 상세 설명 -->
                <div class="mb-4">
                    <c:choose>
                        <c:when test="${statusCode == 404}">
                            <p class="text-muted">
                                요청하신 페이지가 존재하지 않거나 이동되었을 수 있습니다.<br>
                                URL을 다시 확인해주시거나 메인 페이지로 이동해주세요.
                            </p>
                        </c:when>
                        <c:when test="${statusCode == 403}">
                            <p class="text-muted">
                                이 페이지에 접근할 권한이 없습니다.<br>
                                로그인이 필요하거나 관리자 권한이 필요할 수 있습니다.
                            </p>
                        </c:when>
                        <c:when test="${statusCode == 500}">
                            <p class="text-muted">
                                서버에서 오류가 발생했습니다.<br>
                                잠시 후 다시 시도해주시거나 관리자에게 문의해주세요.
                            </p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">
                                일시적인 오류가 발생했습니다.<br>
                                페이지를 새로고침하거나 잠시 후 다시 시도해주세요.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 액션 버튼들 -->
                <div class="d-flex flex-column flex-sm-row gap-3 justify-content-center">
                    <a href="<c:url value='/' />" class="btn btn-success btn-lg">
                        <i class="bi bi-house me-2"></i>메인으로 이동
                    </a>
                    
                    <button onclick="history.back()" class="btn btn-outline-secondary btn-lg">
                        <i class="bi bi-arrow-left me-2"></i>이전 페이지
                    </button>

                    <c:if test="${statusCode == 403}">
                        <a href="<c:url value='/login' />" class="btn btn-outline-primary btn-lg">
                            <i class="bi bi-box-arrow-in-right me-2"></i>로그인
                        </a>
                    </c:if>
                </div>

                <!-- 도움말 링크 -->
                <div class="mt-5">
                    <small class="text-muted">
                        문제가 계속 발생한다면 
                        <a href="#" class="text-decoration-none">고객센터</a>로 문의해주세요.
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.btn-lg {
    padding: 0.75rem 2rem;
}

@media (max-width: 576px) {
    .display-1 {
        font-size: 4rem;
    }
    
    .display-4 {
        font-size: 2.5rem;
    }
    
    .btn-lg {
        padding: 0.75rem 1.5rem;
        font-size: 1rem;
    }
}
</style>
