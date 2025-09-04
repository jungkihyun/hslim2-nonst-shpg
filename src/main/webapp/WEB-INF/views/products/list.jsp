<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container my-4">
    <!-- 페이지 헤더 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>${pageTitle}</h2>
        <span class="text-muted">
            <c:choose>
                <c:when test="${totalProducts > 0}">
                    ${totalProducts}개 상품
                </c:when>
                <c:otherwise>
                    0개 상품
                </c:otherwise>
            </c:choose>
        </span>
    </div>

    <!-- 필터 및 검색 -->
    <div class="row mb-4">
        <div class="col-md-8">
            <!-- 카테고리 필터 -->
            <div class="btn-group" role="group">
                <a href="<c:url value='/products' />" 
                   class="${empty selectedCategory ? 'btn btn-success' : 'btn btn-outline-success'}">
                    전체
                </a>
                <c:forEach var="category" items="${categories}">
                    <a href="<c:url value='/products?category=${category.name().toLowerCase()}' />"
                       class="${selectedCategory == category ? 'btn btn-success' : 'btn btn-outline-success'}">${category.displayName}</a>
                </c:forEach>
            </div>
        </div>
        <div class="col-md-4">
            <!-- 검색 폼 -->
            <form action="<c:url value='/products' />" method="get" class="d-flex">
                <c:if test="${not empty selectedCategory}">
                    <input type="hidden" name="category" value="${selectedCategory.name().toLowerCase()}">
                </c:if>
                <input class="form-control me-2" type="search" name="keyword" 
                       value="${keyword}" placeholder="상품명 검색">
                <button class="btn btn-outline-secondary" type="submit">
                    <i class="bi bi-search"></i>
                </button>
            </form>
        </div>
    </div>

    <!-- 상품 목록 -->
    <div class="row g-4" id="products-container">
        <c:choose>
            <c:when test="${not empty products}">
                <c:forEach var="product" items="${products}">
                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="card product-card h-100 shadow-sm" data-product-id="${product.id}">
                            <img src="${product.imageUrl != null ? product.imageUrl : '/images/no-image.jpg'}" 
                                 class="card-img-top" alt="상품 이미지" 
                                 style="height: 200px; object-fit: cover;"
                                 loading="lazy">
                            <div class="card-body d-flex flex-column">
                                <h6 class="card-title">${product.name}</h6>
                                <c:if test="${not empty product.category}">
                                    <p class="text-muted small mb-1">${product.category.displayName}</p>
                                </c:if>
                                <c:if test="${not empty product.origin}">
                                    <p class="text-muted small mb-2">${product.origin}</p>
                                </c:if>
                                <p class="card-text fw-bold text-success mb-3">
                                    <fmt:formatNumber value="${product.price}" pattern="#,###" />원
                                </p>
                                <div class="mt-auto">
                                    <a href="<c:url value='/products/${product.id}' />" class="btn btn-outline-success btn-sm w-100">
                                        <i class="bi bi-eye"></i> 자세히 보기
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <!-- 상품이 없을 때 -->
                <div class="col-12">
                    <div class="text-center py-5">
                        <i class="bi bi-basket display-1 text-muted"></i>
                        <h5 class="mt-3 text-muted">
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    '${keyword}'에 대한 검색 결과가 없습니다
                                </c:when>
                                <c:otherwise>
                                    등록된 상품이 없습니다
                                </c:otherwise>
                            </c:choose>
                        </h5>
                        <p class="text-muted">
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    다른 검색어로 다시 시도해보세요.
                                </c:when>
                                <c:otherwise>
                                    곧 다양한 한살림 상품을 만나보실 수 있습니다.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <c:if test="${not empty keyword or not empty selectedCategory}">
                            <a href="<c:url value='/products' />" class="btn btn-success">전체 상품 보기</a>
                        </c:if>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 페이징 -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="상품 페이징" class="mt-5">
            <ul class="pagination justify-content-center">
                <!-- 이전 페이지 -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <c:choose>
                        <c:when test="${currentPage == 1}">
                            <span class="page-link">이전</span>
                        </c:when>
                        <c:otherwise>
                            <c:url var="prevUrl" value="/products">
                                <c:param name="page" value="${currentPage - 1}"/>
                                <c:param name="size" value="${size}"/>
                                <c:if test="${not empty selectedCategory}">
                                    <c:param name="category" value="${selectedCategory.name().toLowerCase()}"/>
                                </c:if>
                                <c:if test="${not empty keyword}">
                                    <c:param name="keyword" value="${keyword}"/>
                                </c:if>
                            </c:url>
                            <a class="page-link" href="${prevUrl}">이전</a>
                        </c:otherwise>
                    </c:choose>
                </li>

                <!-- 페이지 번호 -->
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="page-link">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <c:url var="pageUrl" value="/products">
                                    <c:param name="page" value="${i}"/>
                                    <c:param name="size" value="${size}"/>
                                    <c:if test="${not empty selectedCategory}">
                                        <c:param name="category" value="${selectedCategory.name().toLowerCase()}"/>
                                    </c:if>
                                    <c:if test="${not empty keyword}">
                                        <c:param name="keyword" value="${keyword}"/>
                                    </c:if>
                                </c:url>
                                <a class="page-link" href="${pageUrl}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </c:forEach>

                <!-- 다음 페이지 -->
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <c:choose>
                        <c:when test="${currentPage == totalPages}">
                            <span class="page-link">다음</span>
                        </c:when>
                        <c:otherwise>
                            <c:url var="nextUrl" value="/products">
                                <c:param name="page" value="${currentPage + 1}"/>
                                <c:param name="size" value="${size}"/>
                                <c:if test="${not empty selectedCategory}">
                                    <c:param name="category" value="${selectedCategory.name().toLowerCase()}"/>
                                </c:if>
                                <c:if test="${not empty keyword}">
                                    <c:param name="keyword" value="${keyword}"/>
                                </c:if>
                            </c:url>
                            <a class="page-link" href="${nextUrl}">다음</a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </nav>
    </c:if>

    <!-- 맨 위로 버튼 -->
    <button type="button" class="btn btn-success position-fixed bottom-0 end-0 m-3" 
            id="scrollToTop" style="display: none; z-index: 1000;">
        <i class="bi bi-arrow-up"></i>
    </button>
</div>
