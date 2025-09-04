<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Hero Section -->
<section class="hero-section">
    <div class="hero-overlay"></div>
    <div class="container position-relative">
        <div class="row min-vh-100 align-items-center">
            <div class="col-lg-6">
                <div class="hero-content text-white">
                    <div class="hero-badge mb-3">
                        <span class="badge bg-white text-success px-3 py-2 rounded-pill">
                            <i class="bi bi-leaf me-2"></i>친환경 유기농
                        </span>
                    </div>
                    <h1 class="hero-title display-4 fw-bold mb-4">
                        <span class="text-white">건강한 밥상,</span><br>
                        <span class="text-white">한살림과 함께</span>
                    </h1>
                    <p class="hero-subtitle lead mb-4 text-light">
                        비조합원도 쉽게 이용할 수 있는<br>
                        한살림 온라인 장보기 서비스
                    </p>
                    <div class="hero-buttons d-flex flex-wrap gap-3">
                        <a href="<c:url value='/products' />" class="btn btn-success btn-lg px-4 py-3 rounded-pill">
                            <i class="bi bi-basket me-2"></i>쇼핑 시작하기
                        </a>
                        <a href="#about" class="btn btn-outline-light btn-lg px-4 py-3 rounded-pill">
                            <i class="bi bi-play-circle me-2"></i>한살림 소개
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 d-none d-lg-block">
                <div class="hero-image-container">
                    <div class="hero-floating-card">
                        <div class="card border-0 shadow-lg">
                            <div class="card-body p-4">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="rounded-circle bg-success p-2 me-3" style="border-radius: 25% !important;">
                                        <i class="bi bi-check text-white"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">신선한 유기농 채소</h6>
                                        <small class="text-muted d-block">당일 배송 가능</small>
                                        <small class="text-muted">비조합원도 간편 주문</small>
                                    </div>
                                </div>
                                <div class="progress" style="height: 6px;">
                                    <div class="progress-bar bg-success" style="width: 95%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Scroll Down Indicator -->
        <div class="scroll-indicator">
            <a href="#features" class="text-white text-decoration-none">
                <i class="bi bi-chevron-down"></i>
            </a>
        </div>
    </div>
</section>

<!-- Features Section -->
<section id="features" class="py-5 bg-light">
    <div class="container">
        <div class="row text-center mb-5">
            <div class="col-12">
                <h2 class="display-6 fw-bold text-dark mb-3">왜 한살림인가요?</h2>
                <p class="lead text-muted">건강하고 안전한 먹거리를 위한 한살림의 약속</p>
            </div>
        </div>
        
        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="feature-card text-center h-100">
                    <div class="feature-icon mb-4">
                        <div class="icon-circle bg-success bg-gradient">
                            <i class="bi bi-shield-check text-white"></i>
                        </div>
                    </div>
                    <h5 class="fw-bold mb-3">안전한 먹거리</h5>
                    <p class="text-muted">철저한 품질관리와<br>유기농 인증으로<br>안전을 보장합니다</p>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-3">
                <div class="feature-card text-center h-100">
                    <div class="feature-icon mb-4">
                        <div class="icon-circle bg-primary bg-gradient">
                            <i class="bi bi-truck text-white"></i>
                        </div>
                    </div>
                    <h5 class="fw-bold mb-3">신선한 배송</h5>
                    <p class="text-muted">산지에서 바로<br>신선한 상태로<br>빠른 배송 서비스</p>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-3">
                <div class="feature-card text-center h-100">
                    <div class="feature-icon mb-4">
                        <div class="icon-circle bg-warning bg-gradient">
                            <i class="bi bi-heart text-white"></i>
                        </div>
                    </div>
                    <h5 class="fw-bold mb-3">생산자와 함께</h5>
                    <p class="text-muted">농민과 소비자가<br>함께 만드는<br>지속가능한 농업</p>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-3">
                <div class="feature-card text-center h-100">
                    <div class="feature-icon mb-4">
                        <div class="icon-circle bg-info bg-gradient">
                            <i class="bi bi-globe text-white"></i>
                        </div>
                    </div>
                    <h5 class="fw-bold mb-3">환경을 생각하는</h5>
                    <p class="text-muted">친환경 포장재 사용<br>지구를 생각하는<br>지속가능한 소비</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Categories Section -->
<section class="py-5">
    <div class="container">
        <div class="row text-center mb-5">
            <div class="col-12">
                <h2 class="display-6 fw-bold text-dark mb-3">카테고리별 쇼핑</h2>
                <p class="lead text-muted">원하는 상품을 카테고리별로 쉽게 찾아보세요</p>
            </div>
        </div>
        
        <div class="row g-4">
            <div class="col-6 col-md-4 col-lg-2">
                <a href="<c:url value='/products?category=vegetable' />" class="text-decoration-none">
                    <div class="category-card h-100">
                        <div class="category-image">
                            <div class="category-icon bg-success bg-gradient">
                                <i class="bi bi-tree text-white"></i>
                            </div>
                        </div>
                        <div class="category-content">
                            <h6 class="fw-bold mb-1">채소</h6>
                            <small class="text-muted">신선한 유기농 채소</small>
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-6 col-md-4 col-lg-2">
                <a href="<c:url value='/products?category=fruit' />" class="text-decoration-none">
                    <div class="category-card h-100">
                        <div class="category-image">
                            <div class="category-icon bg-warning bg-gradient">
                                <i class="bi bi-apple text-white"></i>
                            </div>
                        </div>
                        <div class="category-content">
                            <h6 class="fw-bold mb-1">과일</h6>
                            <small class="text-muted">달콤한 제철 과일</small>
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-6 col-md-4 col-lg-2">
                <a href="<c:url value='/products?category=grain' />" class="text-decoration-none">
                    <div class="category-card h-100">
                        <div class="category-image">
                            <div class="category-icon bg-secondary bg-gradient">
                                <i class="bi bi-feather text-white"></i>
                            </div>
                        </div>
                        <div class="category-content">
                            <h6 class="fw-bold mb-1">곡물</h6>
                            <small class="text-muted">건강한 잡곡류</small>
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-6 col-md-4 col-lg-2">
                <a href="<c:url value='/products?category=processed' />" class="text-decoration-none">
                    <div class="category-card h-100">
                        <div class="category-image">
                            <div class="category-icon bg-primary bg-gradient">
                                <i class="bi bi-box text-white"></i>
                            </div>
                        </div>
                        <div class="category-content">
                            <h6 class="fw-bold mb-1">가공식품</h6>
                            <small class="text-muted">자연 그대로의 맛</small>
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-6 col-md-4 col-lg-2">
                <a href="<c:url value='/products?category=dairy' />" class="text-decoration-none">
                    <div class="category-card h-100">
                        <div class="category-image">
                            <div class="category-icon bg-info bg-gradient">
                                <i class="bi bi-cup text-white"></i>
                            </div>
                        </div>
                        <div class="category-content">
                            <h6 class="fw-bold mb-1">유제품</h6>
                            <small class="text-muted">신선한 유제품</small>
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-6 col-md-4 col-lg-2">
                <a href="<c:url value='/products?category=meat' />" class="text-decoration-none">
                    <div class="category-card h-100">
                        <div class="category-image">
                            <div class="category-icon bg-danger bg-gradient">
                                <i class="bi bi-egg text-white"></i>
                            </div>
                        </div>
                        <div class="category-content">
                            <h6 class="fw-bold mb-1">육류</h6>
                            <small class="text-muted">건강한 축산물</small>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- Featured Products Section -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row align-items-center mb-5">
            <div class="col-md-8">
                <h2 class="display-6 fw-bold text-dark mb-2">이번 주 추천 상품</h2>
                <p class="text-muted mb-0">엄선된 신선한 상품들을 만나보세요</p>
            </div>
            <div class="col-md-4 text-md-end">
                <a href="<c:url value='/products' />" class="btn btn-outline-success btn-lg">
                    전체 상품 보기 <i class="bi bi-arrow-right ms-2"></i>
                </a>
            </div>
        </div>
        
        <div class="row g-4" id="featured-products">
            <c:choose>
                <c:when test="${not empty featuredProducts}">
                    <c:forEach var="product" items="${featuredProducts}" varStatus="status">
                        <div class="col-6 col-md-4 col-lg-3">
                            <div class="product-card h-100" data-product-id="${product.id}">
                                <div class="product-image">
                                    <img src="${product.imageUrl != null ? product.imageUrl : '/images/no-image.jpg'}" 
                                         alt="${product.name}" loading="lazy">
                                    <div class="product-overlay">
                                        <a href="<c:url value='/products/${product.id}' />" 
                                           class="btn btn-white btn-sm rounded-pill">
                                            <i class="bi bi-eye me-1"></i>자세히 보기
                                        </a>
                                    </div>
                                    <c:if test="${status.index < 3}">
                                        <div class="product-badge">
                                            <span class="badge bg-danger">인기</span>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="product-content">
                                    <div class="product-category">
                                        <c:if test="${not empty product.category}">
                                            <span class="badge bg-light text-muted">${product.category.displayName}</span>
                                        </c:if>
                                    </div>
                                    <h6 class="product-title">${product.name}</h6>
                                    <c:if test="${not empty product.origin}">
                                        <p class="product-origin">${product.origin}</p>
                                    </c:if>
                                    <div class="product-price">
                                        <span class="price-current">
                                            <fmt:formatNumber value="${product.price}" pattern="#,###" />원
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <div class="empty-state">
                            <i class="bi bi-basket display-1 text-muted mb-3"></i>
                            <h5 class="text-muted">등록된 상품이 없습니다</h5>
                            <p class="text-muted">곧 다양한 한살림 상품을 만나보실 수 있습니다</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<!-- About Section -->
<section id="about" class="py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <div class="about-content">
                    <div class="section-badge mb-3">
                        <span class="badge bg-success text-white px-3 py-2">ABOUT HANSALIM</span>
                    </div>
                    <h2 class="display-6 fw-bold text-dark mb-4">
                        30년 이상의<br>
                        <span class="text-success">신뢰와 경험</span>
                    </h2>
                    <p class="lead text-muted mb-4">
                        한살림은 1986년부터 생산자와 소비자가 함께 만들어온 
                        생활협동조합입니다. 건강한 먹거리, 생태농업, 
                        지역 공동체를 지향합니다.
                    </p>
                    <div class="about-stats row g-3 mb-4">
                        <div class="col-4">
                            <div class="stat-item text-center">
                                <h4 class="fw-bold text-success">30+</h4>
                                <small class="text-muted">년의 역사</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stat-item text-center">
                                <h4 class="fw-bold text-success">2000+</h4>
                                <small class="text-muted">생산농가</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stat-item text-center">
                                <h4 class="fw-bold text-success">70만+</h4>
                                <small class="text-muted">조합원</small>
                            </div>
                        </div>
                    </div>
                    <a href="#" class="btn btn-success btn-lg">
                        한살림 더 알아보기 <i class="bi bi-arrow-right ms-2"></i>
                    </a>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="about-image">
                    <div class="image-placeholder bg-light rounded-3 p-5 text-center">
                        <img src="/images/hslim.jpg" alt="한살림 농가 이미지" class="img-fluid rounded-3">
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="py-5 bg-success text-white">
    <div class="container text-center">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <h2 class="display-6 fw-bold mb-3">지금 시작해보세요!</h2>
                <p class="lead mb-4">
                    건강한 먹거리로 가족의 건강을 지키고,<br>
                    지속가능한 농업을 함께 만들어가요
                </p>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="<c:url value='/products' />" class="btn btn-light btn-lg px-4 py-3">
                        <i class="bi bi-basket me-2"></i>쇼핑하기
                    </a>
                    <a href="<c:url value='/signup' />" class="btn btn-outline-light btn-lg px-4 py-3">
                        <i class="bi bi-person-plus me-2"></i>회원가입
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
