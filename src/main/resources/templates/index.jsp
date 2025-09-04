<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{layout}">
<head>
    <title>한살림 비조합원 온라인 장보기</title>
</head>
<body>
<main layout:fragment="content">
    <div class="container my-4">
        <!-- Hero Banner -->
        <section class="hero-section p-5 rounded text-center mb-5">
            <h1 class="display-5 fw-bold mb-3">비조합원도 쉽게 이용하는</h1>
            <h2 class="display-6 mb-4">한살림 온라인 장보기</h2>
            <p class="lead mb-4">건강한 먹거리, 간편하게 주문하세요</p>
            <a href="/products" class="btn btn-light btn-lg">
                <i class="bi bi-basket"></i> 지금 바로 시작하기
            </a>
        </section>

        <!-- 주요 상품 영역 -->
        <section>
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold">추천 상품</h3>
                <a href="/products" class="btn btn-outline-success">전체보기</a>
            </div>
            
            <div class="row g-4" th:if="${featuredProducts != null and !featuredProducts.empty}">
                <div class="col-6 col-md-3" th:each="product : ${featuredProducts}">
                    <div class="card product-card h-100 shadow-sm">
                        <img th:src="${product.imageUrl != null ? product.imageUrl : '/images/no-image.jpg'}" 
                             class="card-img-top" alt="상품 이미지" style="height: 200px; object-fit: cover;">
                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title" th:text="${product.name}">상품명</h6>
                            <p class="text-muted small mb-2" th:if="${product.origin}" th:text="${product.origin}">원산지</p>
                            <p class="card-text fw-bold text-success mb-3" th:text="${#numbers.formatInteger(product.price, 0, 'COMMA')} + '원'">가격</p>
                            <div class="mt-auto">
                                <a th:href="@{/products/{id}(id=${product.id})}" class="btn btn-outline-success btn-sm w-100">
                                    <i class="bi bi-eye"></i> 자세히 보기
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 상품이 없을 때 -->
            <div th:if="${featuredProducts == null or featuredProducts.empty}" class="text-center py-5">
                <i class="bi bi-basket display-1 text-muted"></i>
                <h5 class="mt-3 text-muted">등록된 상품이 없습니다.</h5>
                <p class="text-muted">곧 다양한 한살림 상품을 만나보실 수 있습니다.</p>
            </div>
        </section>

        <!-- 카테고리 섹션 -->
        <section class="mt-5">
            <h3 class="fw-bold mb-4 text-center">카테고리별 쇼핑</h3>
            <div class="row g-3">
                <div class="col-4 col-md-2">
                    <a href="/products?category=vegetable" class="text-decoration-none">
                        <div class="card text-center p-3 h-100 category-card">
                            <i class="bi bi-tree display-4 text-success"></i>
                            <p class="mt-2 mb-0 fw-bold">채소</p>
                        </div>
                    </a>
                </div>
                <div class="col-4 col-md-2">
                    <a href="/products?category=fruit" class="text-decoration-none">
                        <div class="card text-center p-3 h-100 category-card">
                            <i class="bi bi-apple display-4 text-warning"></i>
                            <p class="mt-2 mb-0 fw-bold">과일</p>
                        </div>
                    </a>
                </div>
                <div class="col-4 col-md-2">
                    <a href="/products?category=grain" class="text-decoration-none">
                        <div class="card text-center p-3 h-100 category-card">
                            <i class="bi bi-grain display-4 text-secondary"></i>
                            <p class="mt-2 mb-0 fw-bold">곡물</p>
                        </div>
                    </a>
                </div>
                <div class="col-4 col-md-2">
                    <a href="/products?category=processed" class="text-decoration-none">
                        <div class="card text-center p-3 h-100 category-card">
                            <i class="bi bi-box display-4 text-primary"></i>
                            <p class="mt-2 mb-0 fw-bold">가공식품</p>
                        </div>
                    </a>
                </div>
                <div class="col-4 col-md-2">
                    <a href="/products?category=dairy" class="text-decoration-none">
                        <div class="card text-center p-3 h-100 category-card">
                            <i class="bi bi-cup display-4 text-info"></i>
                            <p class="mt-2 mb-0 fw-bold">유제품</p>
                        </div>
                    </a>
                </div>
                <div class="col-4 col-md-2">
                    <a href="/products?category=meat" class="text-decoration-none">
                        <div class="card text-center p-3 h-100 category-card">
                            <i class="bi bi-egg display-4 text-danger"></i>
                            <p class="mt-2 mb-0 fw-bold">육류</p>
                        </div>
                    </a>
                </div>
            </div>
        </section>
    </div>
</main>

<style>
.category-card:hover {
    background-color: #f8f9fa;
    transform: translateY(-2px);
    transition: all 0.2s;
}
</style>
</body>
</html>
