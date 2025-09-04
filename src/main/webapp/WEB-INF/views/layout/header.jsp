<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <!-- Brand -->
        <a class="navbar-brand" href="<c:url value='/' />">
            <i class="bi bi-house-heart"></i>
            한살림
        </a>

        <!-- Toggle button for mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation items -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <!-- Left menu -->
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${requestURI == '/' || requestURI == '/index' ? 'active' : ''}" 
                       href="<c:url value='/' />">
                        <i class="bi bi-house me-1"></i>홈
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="productsDropdown" role="button" 
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-grid me-1"></i>상품
                    </a>
                    <ul class="dropdown-menu shadow">
                        <li><a class="dropdown-item" href="<c:url value='/products' />">
                            <i class="bi bi-list-ul me-2"></i>전체 상품
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="<c:url value='/products?category=vegetable' />">
                            <i class="bi bi-tree me-2"></i>채소
                        </a></li>
                        <li><a class="dropdown-item" href="<c:url value='/products?category=fruit' />">
                            <i class="bi bi-apple me-2"></i>과일
                        </a></li>
                        <li><a class="dropdown-item" href="<c:url value='/products?category=grain' />">
                            <i class="bi bi-grain me-2"></i>곡물
                        </a></li>
                        <li><a class="dropdown-item" href="<c:url value='/products?category=processed' />">
                            <i class="bi bi-box me-2"></i>가공식품
                        </a></li>
                        <li><a class="dropdown-item" href="<c:url value='/products?category=dairy' />">
                            <i class="bi bi-cup me-2"></i>유제품
                        </a></li>
                        <li><a class="dropdown-item" href="<c:url value='/products?category=meat' />">
                            <i class="bi bi-egg me-2"></i>육류
                        </a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">
                        <i class="bi bi-info-circle me-1"></i>한살림 소개
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">
                        <i class="bi bi-telephone me-1"></i>고객센터
                    </a>
                </li>
            </ul>

            <!-- Search form -->
            <div class="d-flex me-3">
                <form class="search-container" action="<c:url value='/products' />" method="get">
                    <input class="form-control" type="search" name="keyword" 
                           placeholder="상품명을 검색하세요" aria-label="Search" value="${param.keyword}">
                    <button class="btn btn-outline-success" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>

            <!-- Right menu -->
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${pageContext.request.userPrincipal != null}">
                        <!-- 로그인 상태 -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle me-1"></i>
                                ${sessionScope.user != null ? sessionScope.user.name : pageContext.request.userPrincipal.name}님
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow">
                                <li><a class="dropdown-item" href="<c:url value='/mypage' />">
                                    <i class="bi bi-person me-2"></i>마이페이지
                                </a></li>
                                <li><a class="dropdown-item" href="<c:url value='/orders' />">
                                    <i class="bi bi-box-seam me-2"></i>주문내역
                                </a></li>
                                <li><a class="dropdown-item" href="<c:url value='/cart' />">
                                    <i class="bi bi-cart me-2"></i>장바구니
                                    <c:if test="${not empty sessionScope.cartCount and sessionScope.cartCount > 0}">
                                        <span class="badge bg-danger rounded-pill ms-1">${sessionScope.cartCount}</span>
                                    </c:if>
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="<c:url value='/logout' />">
                                    <i class="bi bi-box-arrow-right me-2"></i>로그아웃
                                </a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- 비로그인 상태 -->
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/login' />">
                                <i class="bi bi-box-arrow-in-right me-1"></i>로그인
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/signup' />">
                                <i class="bi bi-person-plus me-1"></i>회원가입
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
                
                <!-- 장바구니 (항상 표시) -->
                <li class="nav-item">
                    <a class="nav-link position-relative" href="<c:url value='/cart' />">
                        <i class="bi bi-cart2"></i>
                        <c:if test="${not empty sessionScope.cartCount and sessionScope.cartCount > 0}">
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${sessionScope.cartCount > 99 ? '99+' : sessionScope.cartCount}
                            </span>
                        </c:if>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- 네비게이션 간격 보정 -->
<div style="height: 80px;"></div>
