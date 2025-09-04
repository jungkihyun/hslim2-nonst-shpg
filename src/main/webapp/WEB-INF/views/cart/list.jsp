<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container my-4">
  <h2 class="mb-4">장바구니</h2>

  <c:choose>
    <c:when test="${not empty cartItems}">
      <div class="table-responsive">
        <table class="table align-middle">
          <thead>
          <tr>
            <th>상품</th>
            <th style="width: 150px;">수량</th>
            <th>가격</th>
            <th>합계</th>
            <th></th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="item" items="${cartItems}">
            <tr>
              <td>
                <div class="d-flex align-items-center">
                  <img src="${item.product.imageUrl != null ? item.product.imageUrl : '/images/no-image.jpg'}"
                       alt="상품 이미지" class="me-2" style="width: 60px; height: 60px; object-fit: cover;">
                  <div>
                    <a href="<c:url value='/products/${item.product.id}'/>" class="text-decoration-none">${item.product.name}</a>
                    <c:if test="${not empty item.product.origin}">
                      <p class="text-muted small mb-0">${item.product.origin}</p>
                    </c:if>
                  </div>
                </div>
              </td>
              <td>
                <form action="<c:url value='/cart/update/${item.id}'/>" method="post" class="d-flex">
                  <input type="number" name="quantity" value="${item.quantity}" min="0" class="form-control form-control-sm me-2">
                  <button type="submit" class="btn btn-outline-success btn-sm">변경</button>
                </form>
              </td>
              <td><fmt:formatNumber value="${item.product.price}" pattern="#,###" />원</td>
              <td><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" />원</td>
              <td>
                <form action="<c:url value='/cart/remove/${item.id}'/>" method="post">
                  <button type="submit" class="btn btn-outline-danger btn-sm">삭제</button>
                </form>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>

      <div class="text-end mt-4">
        <h4>총 금액: <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</h4>
      </div>
    </c:when>
    <c:otherwise>
      <div class="text-center py-5">
        <i class="bi bi-cart display-1 text-muted"></i>
        <h5 class="mt-3 text-muted">장바구니가 비어 있습니다.</h5>
        <a href="<c:url value='/products'/>" class="btn btn-success mt-3">상품 보러가기</a>
      </div>
    </c:otherwise>
  </c:choose>
</div>