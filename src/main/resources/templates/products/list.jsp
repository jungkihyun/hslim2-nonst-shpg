<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{layout}">
<head>
    <title th:text="${pageTitle}">상품 목록</title>
</head>
<body>
<main layout:fragment="content">
    <div class="container my-4">
        <!-- 페이지 헤더 -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 th:text="${pageTitle}">상품 목록</h2>
            <span class="text-muted" th:text="${#lists.size(products)} + '개 상품'">상품 수</span>
        </div>

        <!-- 필터 및 검색 -->
        <div class="row mb-4">
            <div class="col-md-8">
                <!-- 카테고리 필터 -->
                <div class="btn-group" role="group">
                    <a th:href="@{/products}" 
                       th:class="${selectedCategory == null} ? 'btn btn-success' : 'btn btn-outline-success'">
                        전체
                    </a>
                    <a th:each="category : ${categories}"
                       th:href="@{/products(category=${category.name().toLowerCase()})}"
                       th:class="${selectedCategory == category} ? 'btn btn-success' : 'btn btn-outline-success'"
                       th:text="${category.displayName}">카테고리</a>
                </div>
            </div>
            <div class="col-md-4">
                <!-- 검색 폼 -->
                <form th:action="@{/products}" method="get" class="d-flex">
                    <input type="hidden" th:if="${selectedCategory}" name="category" 
                           th:value="${selectedCategory.name().toLowerCase()}">
                    <input class="form-control me-2" type="search" name="keyword" 
                           th:value="${keyword}" placeholder="상품명 검색">
                    <button class="btn btn-outline-secondary" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>
        </div>

        <!-- 상품 목록 -->
        <div class="row g-4" th:if="${products != null and !products.empty}">
            <div class="col-6 col-md-4 col-lg-3" th:each="product : ${products}">
                <div class="card product-card h-100 shadow-sm">
                    <img th:src="${product.imageUrl != null ? product.imageUrl : '/images/no-image.jpg'}" 
                         class="card-img-top" alt="상품 이미지" style="height: 200px; object-fit: cover;">
                    <div class="card-body d-flex flex-column">
                        <h6 class="card-title" th:text="${product.name}">상품명</h6>
                        <p class="text-muted small mb-1" th:if="${product.category}" 
                           th:text="${product.category.displayName}">카테고리</p>
                        <p class="text-muted small mb-2" th:if="${product.origin}" th:text="${product.origin}">원산지</p>
                        <p class="card-text fw-bold text-success mb-3" 
                           th:text="${#numbers.formatInteger(product.price, 0, 'COMMA')} + '원'">가격</p>
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
        <div th:if="${products == null or products.empty}" class="text-center py-5">
            <i class="bi bi-basket display-1 text-muted"></i>
            <h5 class="mt-3 text-muted">검색 결과가 없습니다</h5>
            <p class="text-muted">다른 검색어로 다시 시도해보세요.</p>
            <a href="/products" class="btn btn-success">전체 상품 보기</a>
        </div>
    </div>
</main>
</body>
</html>
