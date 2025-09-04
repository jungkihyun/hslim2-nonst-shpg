<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container my-4">
  <h2 class="mb-4">주문/결제</h2>

  <div class="mb-4">
    <table class="table">
      <thead>
      <tr><th>상품</th><th>수량</th><th>가격</th><th>합계</th></tr>
      </thead>
      <tbody>
      <c:forEach var="item" items="${items}">
        <tr>
          <td>${item.product.name}</td>
          <td>${item.quantity}</td>
          <td><fmt:formatNumber value="${item.product.price}" pattern="#,###"/>원</td>
          <td><fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/>원</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
    <div class="text-end">
      총 합계: <fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원
    </div>
  </div>

  <form action="<c:url value='/checkout'/>" method="post" class="row g-3">
    <c:if test="${not empty productId}">
      <input type="hidden" name="productId" value="${productId}"/>
      <input type="hidden" name="quantity" value="${quantity}"/>
    </c:if>

    <div class="col-md-6">
      <label class="form-label">받는사람 이름</label>
      <input type="text" class="form-control" name="receiverName" id="receiverName">
    </div>
    <div class="col-md-6">
      <label class="form-label">연락처</label>
      <input type="text" class="form-control" name="receiverPhone" id="receiverPhone">
    </div>
    <div class="col-12">
      <div class="form-check mb-2">
        <input class="form-check-input" type="checkbox" id="sameAsBuyer">
        <label class="form-check-label" for="sameAsBuyer">구매자와 동일</label>
      </div>
    </div>
    <div class="col-12">
      <label class="form-label">주소</label>
      <input type="text" class="form-control" name="receiverAddress">
    </div>
    <div class="col-12">
      <label class="form-label">결제수단</label>
      <select class="form-select" name="paymentMethod" id="paymentMethod">
        <option value="BANK">무통장입금</option>
        <option value="CARD">카드결제</option>
        <option value="EASY">간편결제</option>
      </select>
      <div class="mt-2" id="paymentInfo"></div>
    </div>
    <div class="col-12 text-end">
      <button type="submit" class="btn btn-success">주문완료</button>
    </div>
  </form>
</div>

<script>
  document.getElementById('sameAsBuyer')?.addEventListener('change', function() {
    if(this.checked){
      document.getElementById('receiverName').value='${user.name}';
      document.getElementById('receiverPhone').value='${user.phone}';
    }
  });

  document.getElementById('paymentMethod')?.addEventListener('change', function() {
    const info=document.getElementById('paymentInfo');
    if(this.value==='BANK'){
      info.textContent='구매 후 입력하신 휴대폰번호로 가상계좌가 발급됩니다.';
    } else if(this.value==='CARD'){
      info.innerHTML='<button type="button" class="btn btn-outline-secondary btn-sm me-2">국민카드</button>'+
              '<button type="button" class="btn btn-outline-secondary btn-sm">신한카드</button>';
    } else if(this.value==='EASY'){
      info.innerHTML='<button type="button" class="btn btn-warning btn-sm me-2">카카오페이</button>'+
              '<button type="button" class="btn btn-success btn-sm">네이버페이</button>';
    } else {
      info.textContent='';
    }
  });
</script>