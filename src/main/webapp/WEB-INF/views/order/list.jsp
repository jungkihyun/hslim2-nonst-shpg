<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container my-4">
  <h2 class="mb-4">주문내역</h2>

  <c:choose>
    <c:when test="${not empty orders}">
      <table class="table">
        <thead>
        <tr><th>주문일시</th><th>상품정보</th><th>결제수단</th><th>총금액</th></tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
          <tr>
            <td><fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td>
              <c:forEach var="item" items="${order.items}">
                ${item.product.name} (${item.quantity}개)<br/>
              </c:forEach>
            </td>
            <td>${order.paymentMethod}</td>
            <td><fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/>원</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise>
      <div class="text-center py-5">
        <p class="text-muted">주문 내역이 없습니다.</p>
      </div>
    </c:otherwise>
  </c:choose>
</div>