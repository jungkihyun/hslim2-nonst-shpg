/**
 * 상품 목록 페이지 JavaScript
 */

document.addEventListener('DOMContentLoaded', function() {
    initProductsList();
});

/**
 * 상품 목록 페이지 초기화
 */
function initProductsList() {
    // 상품 카드 이벤트 초기화
    initProductCards();
    
    // 검색 기능 초기화
    initSearchFunction();
    
    // 스크롤 관련 기능 초기화
    initScrollFeatures();
    
    // 필터 기능 초기화
    initFilterButtons();
}

/**
 * 상품 카드 이벤트 초기화
 */
function initProductCards() {
    const productCards = document.querySelectorAll('.product-card');
    
    productCards.forEach(card => {
        // 호버 효과
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
            this.style.boxShadow = '0 8px 25px rgba(0,0,0,0.15)';
            this.style.transition = 'all 0.3s ease';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = '';
        });
        
        // 상품 클릭 추적
        card.addEventListener('click', function(e) {
            // 링크 클릭이 아닐 때만 추적
            if (!e.target.closest('a')) {
                const productId = this.getAttribute('data-product-id');
                trackProductView(productId);
            }
        });
    });
}

/**
 * 검색 기능 초기화
 */
function initSearchFunction() {
    const searchForm = document.querySelector('form[action*="products"]');
    const searchInput = searchForm?.querySelector('input[name="keyword"]');
    
    if (searchForm && searchInput) {
        // 검색 폼 제출 처리
        searchForm.addEventListener('submit', function(e) {
            const query = searchInput.value.trim();
            
            if (query.length > 0 && query.length < 2) {
                e.preventDefault();
                showErrorMessage('검색어는 2자 이상 입력해주세요.');
                searchInput.focus();
                return;
            }
            
            // 검색어가 있으면 로딩 표시
            if (query) {
                const submitButton = this.querySelector('button[type="submit"]');
                showLoadingSpinner(submitButton);
            }
        });
        
        // 검색 입력 자동완성 (추후 구현)
        let searchTimeout;
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const query = this.value.trim();
            
            if (query.length >= 2) {
                searchTimeout = setTimeout(() => {
                    showSearchSuggestions(query);
                }, 300);
            } else {
                hideSearchSuggestions();
            }
        });
        
        // 검색 입력창 포커스 아웃 시 자동완성 숨김
        searchInput.addEventListener('blur', function() {
            setTimeout(hideSearchSuggestions, 200);
        });
    }
}

/**
 * 스크롤 관련 기능 초기화
 */
function initScrollFeatures() {
    const scrollToTopBtn = document.getElementById('scrollToTop');
    
    if (scrollToTopBtn) {
        // 스크롤 위치에 따른 맨 위로 버튼 표시/숨김
        window.addEventListener('scroll', throttle(function() {
            if (window.pageYOffset > 300) {
                scrollToTopBtn.style.display = 'block';
            } else {
                scrollToTopBtn.style.display = 'none';
            }
        }, 100));
        
        // 맨 위로 버튼 클릭
        scrollToTopBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
    
    // 무한 스크롤 (추후 구현 예정)
    initInfiniteScroll();
}

/**
 * 필터 버튼 기능 초기화
 */
function initFilterButtons() {
    const filterButtons = document.querySelectorAll('.btn-group a');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            // 현재 활성화된 버튼이면 클릭 방지
            if (this.classList.contains('btn-success')) {
                e.preventDefault();
                return;
            }
            
            // 로딩 효과
            const originalText = this.textContent;
            this.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>' + originalText;
        });
    });
}

/**
 * 검색 제안 표시
 */
function showSearchSuggestions(query) {
    // Ajax로 검색 제안 가져오기 (추후 구현)
    console.log('검색 제안 요청:', query);
    
    // TODO: 서버에서 검색 제안 데이터 가져와서 표시
    // ajaxRequest('/api/products/suggestions', 'GET', {query: query}, ...)
}

/**
 * 검색 제안 숨김
 */
function hideSearchSuggestions() {
    const suggestionsContainer = document.getElementById('search-suggestions');
    if (suggestionsContainer) {
        suggestionsContainer.style.display = 'none';
    }
}

/**
 * 무한 스크롤 초기화 (추후 구현)
 */
function initInfiniteScroll() {
    let loading = false;
    let hasMore = true;
    let currentPage = 1;
    
    window.addEventListener('scroll', throttle(function() {
        if (loading || !hasMore) return;
        
        // 페이지 하단에 거의 도달했을 때
        if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 1000) {
            loadMoreProducts();
        }
    }, 100));
}

/**
 * 추가 상품 로드 (무한 스크롤용)
 */
function loadMoreProducts() {
    // TODO: 추가 상품 로드 구현
    console.log('추가 상품 로드');
}

/**
 * 상품 조회 추적
 */
function trackProductView(productId) {
    console.log('상품 조회:', productId);
    
    // 분석 도구로 전송
    if (typeof gtag !== 'undefined') {
        gtag('event', 'view_item', {
            'item_id': productId,
            'content_type': 'product'
        });
    }
}

/**
 * 필터 적용 추적
 */
function trackFilterApply(filterType, filterValue) {
    console.log('필터 적용:', filterType, filterValue);
    
    if (typeof gtag !== 'undefined') {
        gtag('event', 'filter_apply', {
            'filter_type': filterType,
            'filter_value': filterValue
        });
    }
}

/**
 * 스로틀링 함수
 */
function throttle(func, limit) {
    let inThrottle;
    return function() {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

/**
 * 상품 정렬 (추후 구현)
 */
function sortProducts(sortBy) {
    const container = document.getElementById('products-container');
    const products = Array.from(container.children);
    
    products.sort((a, b) => {
        // 정렬 로직 구현
        switch (sortBy) {
            case 'name':
                return a.querySelector('.card-title').textContent.localeCompare(
                    b.querySelector('.card-title').textContent
                );
            case 'price':
                const priceA = parseInt(a.querySelector('.text-success').textContent.replace(/[^0-9]/g, ''));
                const priceB = parseInt(b.querySelector('.text-success').textContent.replace(/[^0-9]/g, ''));
                return priceA - priceB;
            default:
                return 0;
        }
    });
    
    // 재배치
    products.forEach(product => container.appendChild(product));
}

/**
 * 로컬 스토리지에 검색 기록 저장
 */
function saveSearchHistory(query) {
    if (!query.trim()) return;
    
    try {
        let history = JSON.parse(localStorage.getItem('searchHistory') || '[]');
        
        // 중복 제거
        history = history.filter(item => item !== query);
        
        // 최신 검색어를 맨 앞에 추가
        history.unshift(query);
        
        // 최대 10개까지만 저장
        history = history.slice(0, 10);
        
        localStorage.setItem('searchHistory', JSON.stringify(history));
    } catch (e) {
        console.error('검색 기록 저장 실패:', e);
    }
}

/**
 * 검색 기록 가져오기
 */
function getSearchHistory() {
    try {
        return JSON.parse(localStorage.getItem('searchHistory') || '[]');
    } catch (e) {
        console.error('검색 기록 로드 실패:', e);
        return [];
    }
}
