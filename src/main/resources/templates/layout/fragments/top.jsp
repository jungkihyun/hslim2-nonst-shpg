<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org" xmlns:sec="http://www.w3.org/1999/xhtml">

<th:block th:fragment="topbarFragment">

  <!-- Topbar -->
  <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">


    <!-- Header -->
    <header>
      <nav class="navbar navbar-expand-lg bg-white shadow-sm">
        <div class="container">
          <a class="navbar-brand" th:href="@{/static}">
            <i class="bi bi-basket"></i> 한살림
          </a>

          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="mainNav">
            <!-- 검색 폼 -->
            <form class="d-flex mx-auto" th:action="@{/search}" method="get" style="width: 300px;">
              <input class="form-control me-2" type="search" name="keyword"
                     placeholder="상품명을 입력하세요" aria-label="Search">
              <button class="btn btn-outline-success" type="submit">
                <i class="bi bi-search"></i>
              </button>
            </form>

            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                  카테고리
                </a>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" th:href="@{/templates/products?category=vegetable}">채소</a></li>
                  <li><a class="dropdown-item" th:href="@{/templates/products?category=fruit}">과일</a></li>
                  <li><a class="dropdown-item" th:href="@{/templates/products?category=grain}">곡물</a></li>
                  <li><a class="dropdown-item" th:href="@{/templates/products?category=processed}">가공식품</a></li>
                  <li><a class="dropdown-item" th:href="@{/templates/products?category=dairy}">유제품</a></li>
                  <li><a class="dropdown-item" th:href="@{/templates/products?category=meat}">육류</a></li>
                </ul>
              </li>

              <!-- 로그인된 사용자 메뉴 -->
              <div sec:authorize="isAuthenticated()">
                <li class="nav-item">
                  <a class="nav-link" th:href="@{/templates/cart}">
                    <i class="bi bi-cart"></i> 장바구니
                  </a>
                </li>
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    <span sec:authentication="name"></span>님
                  </a>
                  <ul class="dropdown-menu">
                    <li>
                      <form th:action="@{/logout}" method="post" class="dropdown-item p-0">
                        <button type="submit" class="btn btn-link dropdown-item">로그아웃</button>
                      </form>
                    </li>
                  </ul>
                </li>
              </div>

              <!-- 비로그인 사용자 메뉴 -->
              <div sec:authorize="!isAuthenticated()">
                <li class="nav-item"><a class="nav-link" th:href="@{/login}">로그인</a></li>
                <li class="nav-item"><a class="nav-link" th:href="@{/signup}">회원가입</a></li>
              </div>
            </ul>
          </div>
        </div>
      </nav>
    </header>

  </nav>

</th:block>
</html>