<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header text-center bg-success text-white">
                    <h4><i class="bi bi-person-plus"></i> 회원가입</h4>
                    <p class="mb-0">한살림 온라인 장보기에 오신 것을 환영합니다</p>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/signup' />" method="post" id="signupForm" class="needs-validation" novalidate>
                        <!-- 이메일 -->
                        <div class="mb-3">
                            <label for="email" class="form-label">이메일 <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="${signupDto.email != null ? signupDto.email : ''}"
                                   placeholder="example@email.com" required>
                            <c:if test="${fieldErrors != null && fieldErrors.email != null}">
                                <div class="invalid-feedback d-block">${fieldErrors.email}</div>
                            </c:if>
                            <div class="valid-feedback">
                                사용 가능한 이메일입니다.
                            </div>
                        </div>

                        <!-- 비밀번호 -->
                        <div class="mb-3">
                            <label for="password" class="form-label">비밀번호 <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="6자 이상 입력해주세요" required minlength="6">
                            <c:if test="${fieldErrors != null && fieldErrors.password != null}">
                                <div class="invalid-feedback d-block">${fieldErrors.password}</div>
                            </c:if>
                            <div class="form-text">영문, 숫자 조합으로 6자 이상 입력해주세요.</div>
                        </div>

                        <!-- 비밀번호 확인 -->
                        <div class="mb-3">
                            <label for="passwordConfirm" class="form-label">비밀번호 확인 <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm"
                                   placeholder="비밀번호를 다시 입력해주세요" required>
                            <c:if test="${fieldErrors != null && fieldErrors.passwordConfirm != null}">
                                <div class="invalid-feedback d-block">${fieldErrors.passwordConfirm}</div>
                            </c:if>
                        </div>

                        <!-- 이름 -->
                        <div class="mb-3">
                            <label for="name" class="form-label">이름 <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="${signupDto.name != null ? signupDto.name : ''}"
                                   placeholder="실명을 입력해주세요" required>
                            <c:if test="${fieldErrors != null && fieldErrors.name != null}">
                                <div class="invalid-feedback d-block">${fieldErrors.name}</div>
                            </c:if>
                        </div>

                        <!-- 연락처 -->
                        <div class="mb-4">
                            <label for="phone" class="form-label">연락처 <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" id="phone" name="phone"
                                   value="${signupDto.phone != null ? signupDto.phone : ''}"
                                   placeholder="010-0000-0000" required pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}">
                            <c:if test="${fieldErrors != null && fieldErrors.phone != null}">
                                <div class="invalid-feedback d-block">${fieldErrors.phone}</div>
                            </c:if>
                            <div class="form-text">'-'를 포함하여 입력해주세요. (예: 010-1234-5678)</div>
                        </div>

                        <!-- 약관 동의 -->
                        <div class="mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                <label class="form-check-label" for="agreeTerms">
                                    <a href="#" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#termsModal">이용약관</a> 및 
                                    <a href="#" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#privacyModal">개인정보처리방침</a>에 동의합니다. 
                                    <span class="text-danger">*</span>
                                </label>
                            </div>
                        </div>

                        <!-- 가입하기 버튼 -->
                        <button type="submit" class="btn btn-success w-100 mb-3">
                            <i class="bi bi-check-circle"></i> 가입하기
                        </button>

                        <!-- 로그인 링크 -->
                        <div class="text-center">
                            <span class="text-muted">이미 계정이 있으신가요?</span>
                            <a href="<c:url value='/login' />" class="text-decoration-none">로그인</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
