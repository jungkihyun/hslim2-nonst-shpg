<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container py-5">
  <div class="row g-5">
    <div class="col-md-6">
      <img src="${product.imageUrl != null ? product.imageUrl : '/images/no-image.jpg'}"
           class="img-fluid rounded shadow-sm" alt="${product.name}">
    </div>
    <div class="col-md-6">
      <h2 class="fw-bold mb-3">${product.name}</h2>
      <c:if test="${not empty product.category}">
        <p class="text-muted mb-1">${product.category.displayName}</p>
      </c:if>
      <c:if test="${not empty product.origin}">
        <p class="text-muted mb-3">${product.origin}</p>
      </c:if>
      <h4 class="text-success fw-bold mb-4">
        <fmt:formatNumber value="${product.price}" pattern="#,###" />원
      </h4>
      <c:if test="${not empty product.description}">
        <p class="mb-4">${product.description}</p>
      </c:if>
      <div class="d-flex gap-2 align-items-center">
        <a href="<c:url value='/products' />" class="btn btn-outline-success">
          <i class="bi bi-arrow-left"></i> 목록으로
        </a>
        <form id="addToCartForm" action="<c:url value='/cart/add'/>" method="post" class="d-flex gap-2">
          <input type="hidden" name="productId" value="${product.id}">
          <input type="number" name="quantity" value="1" min="1" class="form-control" style="width:80px;">
          <button type="submit" class="btn btn-success">
            <i class="bi bi-cart-plus"></i> 장바구니
          </button>
          <button type="button" id="buyNowBtn" class="btn btn-warning">
            <i class="bi bi-lightning-fill"></i> 바로구매
          </button>
        </form>
      </div>
    </div>
  </div>

  <c:if test="${not empty detailImages}">
    <div class="mt-5">
      <c:forEach var="img" items="${detailImages}">
        <img src="${img}" class="img-fluid mb-3" alt="${product.name}">
      </c:forEach>
    </div>
  </c:if>
</div>
<script src="/js/product-detail.js"></script>