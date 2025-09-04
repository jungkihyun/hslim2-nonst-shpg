<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      xmlns:sec="http://www.thymeleaf.org/extras/spring-security"
      layout:decorate="~{layout}">
<head>
    <title th:text="${product.name}">상품 상세</title>
</head>
<body>
<main layout:fragment="content">
    <div class="container my-4">
        <!-- 뒤로가기 버튼 -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a th:href="@{/}">홈</a></li>
                <li class="breadcrumb-item"><a th:href="@{/products}">상품</a></li>
                <li class="breadcrumb-item active" th:text="${product.name}">상품명</li>
            </ol>
        </nav>

        <div class="row">
            <!-- 상품 이미지 -->
            <div class="col-md-6">
                <img th:src="${product.imageUrl != null ? product.imageUrl : '/images/no-image.jpg'}" 
                     class="img-fluid rounded shadow" alt="상품 이미지" style="width: 100%; max-height: 400px; object-fit: cover;">
            </div>

            <!-- 상품 정보 -->
            <div class="col-md-6">
                <div class="ps-md-4">
                    <!-- 카테고리 배지 -->
                    <span class="badge bg-success mb-2" th:if="${product.category}" 
                          th:text="${product.category.displayName}">카테고리</span>
                    
                    <!-- 상품명 -->
                    <h2 class="mb-3" th:text="${product.name}">상품명</h2>
                    
                    <!-- 가격 -->
                    <div class="mb-3">
                        <span class="h3 text-success fw-bold" 
                              th:text="${#numbers.formatInteger(product.price, 0, 'COMMA')} + '원'">가격</span>
                    </div>

                    <!-- 원산지 -->
                    <div class="mb-3" th:if="${product.origin}">
                        <strong>원산지:</strong> 
                        <span th:text="${product.origin}">원산지</span>
                    </div>

                    <!-- 상품 설명 -->
                    <div class="mb-4" th:if="${product.description}">
                        <h5>상품 설명</h5>
                        <p class="text-muted" th:text="${product.description}">상품 설명</p>
                    </div>

                    <!-- 장바구니 추가 폼 (로그인 시에만) -->
                    <div sec:authorize="isAuthenticated()">
                        <form th:action="@{/cart/add}" method="post" class="mb-4">
                            <input type="hidden" name="productId" th:value="${product.id}">
                            
                            <div class="row align-items-center">
                                <div class="col-4">
                                    <label for="quantity" class="form-label">수량</label>
                                    <select class="form-select" id="quantity" name="quantity">
                                        <option value="1" selected>1개</option>
                                        <option value="2">2개</option>
                                        <option value="3">3개</option>
                                        <option value="4">4개</option>
                                        <option value="5">5개</option>
                                        <option value="10">10개</option>
                                    </select>
                                </div>
                                <div class="col-8">
                                    <label class="form-label">&nbsp;</label>
                                    <button type="submit" class="btn btn-success w-100">
                                        <i class="bi bi-cart-plus"></i> 장바구니 담기
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- 비로그인 시 로그인 안내 -->
                    <div sec:authorize="!isAuthenticated()">
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle"></i>
                            장바구니에 담으려면 <a th:href="@{/login}">로그인</a>이 필요합니다.
                        </div>
                    </div>

                    <!-- 버튼들 -->
                    <div class="d-flex gap-2">
                        <a th:href="@{/products}" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> 상품 목록으로
                        </a>
                        <a th:href="@{/products(category=${product.category.name().toLowerCase()})}" 
                           class="btn btn-outline-success" th:if="${product.category}">
                            <span th:text="${product.category.displayName}">카테고리</span> 더보기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
