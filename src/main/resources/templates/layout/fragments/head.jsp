<!DOCTYPE html>
<html lagn="ko" xmlns:th="http://www.thymeleaf.org">

<!-- Head -->
<th:block th:fragment="headFragment">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- 공통 CSS -->
    <style>
      .navbar-brand {
        font-weight: bold;
        color: #28a745 !important;
      }
      .product-card {
        transition: transform 0.2s;
      }
      .product-card:hover {
        transform: translateY(-2px);
      }
      footer {
        background-color: #f8f9fa;
        border-top: 1px solid #dee2e6;
      }
      .hero-section {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: white;
      }
    </style>

  </head>
</th:block>
</html>