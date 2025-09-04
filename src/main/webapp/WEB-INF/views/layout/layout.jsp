<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${pageTitle != null ? pageTitle : '한살림 온라인 장보기'}</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

    <!-- 공통 CSS -->
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet">
    
    <!-- 페이지별 CSS -->
    <c:if test="${not empty pageJs}">
        <c:set var="pageCss" value="${fn:replace(pageJs, '.js', '.css')}" />
        <link href="<c:url value='/resources/css/${pageCss}' />" rel="stylesheet">
    </c:if>
</head>

<body>
    <!-- Header -->
    <header>
        <jsp:include page="header.jsp" />
    </header>

    <!-- Alert Messages -->
    <div class="container mt-3">
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <span>${message}</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <span>${error}</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
    </div>

    <!-- Content -->
    <main>
        <jsp:include page="../${contentPage}" />
    </main>

    <!-- Footer -->
    <jsp:include page="footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- 공통 JS -->
    <script src="<c:url value='/resources/js/common.js' />"></script>
    
    <!-- 페이지별 JS -->
    <c:if test="${not empty pageJs}">
        <script src="<c:url value='/resources/js/${pageJs}' />"></script>
    </c:if>
</body>
</html>
