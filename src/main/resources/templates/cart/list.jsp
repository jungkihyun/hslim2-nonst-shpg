<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{layout}">
<head>
    <title>장바구니</title>
</head>
<body>
<main layout:fragment="content">
    <div class="container my-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-cart"></i> 장바구니</h2>
            <a th:href="@{/products}" class="btn btn-outline-success">
                <i class="bi bi-plus"></i> 상품 더 담기
            </a>
        </div>

        <!-- 장바구니 아이템들 -->
        <div th:if="${cartItems != null and !cartItems.empty}">
            <div class="row">
                <div class="col-md-8">
                    <!-- 장바구니 아이템 목록 -->
                    <div class="card mb-3" th:each="item : ${cartItems}">
                        <div class="card-body">
                            <div class="row align-items-center">
                                <!-- 상품 이미지 -->
                                <div class="col-3 col-md-2">
                                    <img th:src="${item.product.imageUrl != null ? item.product.imageUrl : '/images/no-image.jpg'}" 
                                         class="img-fluid rounded" alt="상품 이미지" style="height: 80px; object-fit: cover;">
                                </div>
                                
                                <!-- 상품 정보 -->
                                <div class="col-6 col-md-5">
                                    <h6 class="mb-1" th:text="${item.product.name}">상품명</h6>
                                    <p class="text-muted small mb-0" th:if="${item.product.origin}" 
                                       th:text="${item.product.origin}">원산지</p>
                                    <p class="text-success fw-bold mb-0" 
                                       th:text="${#numbers.formatInteger(item.product.price, 0, 'COMMA')} + '원'">단가</p>
                                </div>
                                
                                <!-- 수량 조절 -->
                                <div class="col-3 col-md-3">
                                    <form th:action="@{/cart/update/{id}(id=${item.id})}" method="post" class="d-flex align-items-center">
                                        <button type="submit" name="quantity" th:value="${item.quantity - 1}" 
                                                class="btn btn-outline-secondary btn-sm" th:disabled="${item.quantity <= 1}">
                                            <i class="bi bi-dash"></i>
                                        </button>
                                        <span class="mx-2 fw-bold" th:text="${item.quantity}">수량</span>
                                        <button type="submit" name="quantity" th:value="${item.quantity + 1}" 
                                                class="btn btn-outline-secondary btn-sm">
                                            <i class="bi bi-plus"></i>
                                        </button>
                                    </form>
                                </div>
                                
                                <!-- 소계 및 삭제 -->
                                <div class="col-12 col-md-2 mt-2 mt-md-0">
                                    <div class="d-flex flex-column align-items-end">
                                        <p class="fw-bold mb-2" 
                                           th:text="${#numbers.formatInteger(item.totalPrice, 0, 'COMMA')} + '원'">소계</p>
                                        <form th:action="@{/cart/remove/{id}(id=${item.id})}" method="post">
                                            <button type="submit" class="btn btn-outline-danger btn-sm"
                                                    onclick="return confirm('정말 삭제하시겠습니까?')">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 주문 요약 -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">주문 요약</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-3">
                                <span>상품 수량:</span>
                                <span th:text="${#lists.size(cartItems)} + '개 상품'">상품 수량</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span>총 상품 금액:</span>
                                <span th:text="${#numbers.formatInteger(totalPrice, 0, 'COMMA')} + '원'">총 금액</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span>배송비:</span>
                                <span class="text-success">무료</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-4">
                                <strong>총 결제 금액:</strong>
                                <strong class="text-success h5" th:text="${#numbers.formatInteger(totalPrice, 0, 'COMMA')} + '원'">총 결제 금액</strong>
                            </div>
                            
                            <!-- 주문하기 버튼 (임시로 알림만) -->
                            <button type="button" class="btn btn-success w-100" 
                                    onclick="alert('주문 기능은 준비중입니다!')">
                                <i class="bi bi-credit-card"></i> 주문하기
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 장바구니가 비어있을 때 -->
        <div th:if="${cartItems == null or cartItems.empty}" class="text-center py-5">
            <i class="bi bi-cart-x display-1 text-muted"></i>
            <h4 class="mt-3 text-muted">장바구니가 비어있습니다</h4>
            <p class="text-muted">원하는 상품을 장바구니에 담아보세요.</p>
            <a href="/products" class="btn btn-success btn-lg mt-3">
                <i class="bi bi-basket"></i> 쇼핑하러 가기
            </a>
        </div>
    </div>
</main>
</body>
</html>
