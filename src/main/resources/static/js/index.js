/**
 * 메인 페이지 JavaScript
 */

document.addEventListener('DOMContentLoaded', function() {
    initMainPage();
    initScrollAnimations();
    initParallaxEffects();
    initCounterAnimation();
});

/**
 * 메인 페이지 초기화
 */
function initMainPage() {
    // 상품 카드 이벤트 초기화
    initProductCards();
    
    // 카테고리 카드 이벤트 초기화
    initCategoryCards();
    
    // 스크롤 이벤트 초기화
    initScrollEvents();
    
    // 부드러운 스크롤 초기화
    initSmoothScroll();
    
    // 로딩 애니메이션 초기화
    initLoadingAnimations();
}

/**
 * 상품 카드 이벤트 초기화
 */
function initProductCards() {
    const productCards = document.querySelectorAll('.product-card');
    
    productCards.forEach((card, index) => {
        // 지연된 애니메이션 적용
        setTimeout(() => {
            card.classList.add('animate-on-scroll');
        }, index * 100);
        
        // 호버 효과 개선
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-12px) scale(1.02)';
            this.style.transition = 'all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
        
        // 상품 클릭 추적
        card.addEventListener('click', function(e) {
            if (!e.target.closest('a')) {
                const productId = this.getAttribute('data-product-id');
                trackProductInteraction('view', productId);
                
                // 부드러운 페이지 전환 효과
                this.style.opacity = '0.8';
                setTimeout(() => {
                    window.location.href = `/products/${productId}`;
                }, 200);
            }
        });
    });
}

/**
 * 카테고리 카드 이벤트 초기화
 */
function initCategoryCards() {
    const categoryCards = document.querySelectorAll('.category-card');
    
    categoryCards.forEach((card, index) => {
        // 지연된 애니메이션
        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, index * 50);
        
        // 고급 호버 효과
        card.addEventListener('mouseenter', function() {
            const icon = this.querySelector('.category-icon');
            icon.style.transform = 'rotate(5deg) scale(1.1)';
            icon.style.transition = 'transform 0.3s ease';
        });
        
        card.addEventListener('mouseleave', function() {
            const icon = this.querySelector('.category-icon');
            icon.style.transform = 'rotate(0deg) scale(1)';
        });
        
        // 카테고리 클릭 추적
        card.addEventListener('click', function() {
            const categoryName = this.querySelector('h6').textContent;
            trackCategoryClick(categoryName);
            
            // 로딩 효과
            this.classList.add('loading');
        });
    });
}

/**
 * 스크롤 이벤트 초기화
 */
function initScrollEvents() {
    let ticking = false;
    
    window.addEventListener('scroll', function() {
        if (!ticking) {
            requestAnimationFrame(function() {
                handleScrollEffects();
                ticking = false;
            });
            ticking = true;
        }
    });
}

/**
 * 스크롤 효과 처리
 */
function handleScrollEffects() {
    const scrolled = window.pageYOffset;
    const rate = scrolled * -0.5;
    
    // Parallax 효과 (hero section)
    const heroSection = document.querySelector('.hero-section');
    if (heroSection) {
        heroSection.style.transform = `translateY(${rate}px)`;
    }
    
    // 스크롤 위치에 따른 네비게이션 스타일 변경
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        if (scrolled > 100) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    }
    
    // 스크롤 인디케이터 숨김
    const scrollIndicator = document.querySelector('.scroll-indicator');
    if (scrollIndicator) {
        scrollIndicator.style.opacity = Math.max(0, 1 - scrolled / 300);
    }
}

/**
 * 스크롤 애니메이션 초기화
 */
function initScrollAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animated');
                
                // 특별한 애니메이션이 필요한 요소들
                if (entry.target.classList.contains('feature-card')) {
                    animateFeatureCard(entry.target);
                } else if (entry.target.classList.contains('stat-item')) {
                    animateCounter(entry.target);
                }
            }
        });
    }, observerOptions);
    
    // 애니메이션 대상 요소들 관찰
    const animationTargets = document.querySelectorAll(`
        .feature-card,
        .category-card,
        .product-card,
        .about-content,
        .stat-item,
        .section-badge
    `);
    
    animationTargets.forEach((target, index) => {
        target.classList.add('animate-on-scroll');
        target.style.transitionDelay = `${index * 0.1}s`;
        observer.observe(target);
    });
}

/**
 * 특성 카드 애니메이션
 */
function animateFeatureCard(card) {
    const icon = card.querySelector('.icon-circle');
    if (icon) {
        setTimeout(() => {
            icon.style.transform = 'scale(1.1) rotate(360deg)';
            icon.style.transition = 'transform 0.6s ease';
            
            setTimeout(() => {
                icon.style.transform = 'scale(1) rotate(0deg)';
            }, 600);
        }, 200);
    }
}

/**
 * 카운터 애니메이션
 */
function animateCounter(statItem) {
    const counterElement = statItem.querySelector('h4');
    if (!counterElement) return;

    // Ensure counter is visible when animation begins
    counterElement.style.opacity = '1';
    counterElement.style.transform = 'translateY(0)';
    
    const target = parseInt(counterElement.textContent.replace(/[^0-9]/g, ''));
    const increment = target / 30;
    let current = 0;
    
    const updateCounter = () => {
        current += increment;
        if (current < target) {
            counterElement.textContent = Math.floor(current) + '+';
            requestAnimationFrame(updateCounter);
        } else {
            counterElement.textContent = target + '+';
        }
    };
    
    updateCounter();
}

/**
 * Parallax 효과 초기화
 */
function initParallaxEffects() {
    const parallaxElements = document.querySelectorAll('.hero-floating-card');
    
    window.addEventListener('mousemove', function(e) {
        const mouseX = e.clientX / window.innerWidth;
        const mouseY = e.clientY / window.innerHeight;
        
        parallaxElements.forEach(element => {
            const speed = element.getAttribute('data-speed') || 2;
            const x = (mouseX - 0.5) * speed;
            const y = (mouseY - 0.5) * speed;
            
            element.style.transform = `translate(${x}px, ${y}px)`;
        });
    });
}

/**
 * 카운터 애니메이션 초기화
 */
function initCounterAnimation() {
    const counters = document.querySelectorAll('.stat-item h4');
    
    counters.forEach(counter => {
        counter.style.opacity = '0';
        counter.style.transform = 'translateY(20px)';
    });
}

/**
 * 부드러운 스크롤 초기화
 */
function initSmoothScroll() {
    const smoothScrollLinks = document.querySelectorAll('a[href^="#"]');
    
    smoothScrollLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            
            if (targetElement) {
                const headerOffset = 80;
                const elementPosition = targetElement.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                
                window.scrollTo({
                    top: offsetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });
}

/**
 * 로딩 애니메이션 초기화
 */
function initLoadingAnimations() {
    // 페이지 로드 시 순차적으로 요소들 표시
    const elements = document.querySelectorAll('.hero-content > *');
    
    elements.forEach((element, index) => {
        element.style.opacity = '0';
        element.style.transform = 'translateY(30px)';
        
        setTimeout(() => {
            element.style.opacity = '1';
            element.style.transform = 'translateY(0)';
            element.style.transition = 'all 0.6s ease';
        }, index * 200 + 500);
    });
}

/**
 * 상품 상호작용 추적
 */
function trackProductInteraction(action, productId) {
    console.log(`Product ${action}:`, productId);
    
    // Google Analytics 이벤트 전송
    if (typeof gtag !== 'undefined') {
        gtag('event', action === 'view' ? 'view_item' : 'select_item', {
            item_id: productId,
            content_type: 'product',
            source: 'main_page'
        });
    }
    
    // 사용자 행동 분석을 위한 데이터 수집
    collectUserBehavior({
        action: action,
        productId: productId,
        timestamp: Date.now(),
        scrollPosition: window.pageYOffset,
        viewport: {
            width: window.innerWidth,
            height: window.innerHeight
        }
    });
}

/**
 * 카테고리 클릭 추적
 */
function trackCategoryClick(categoryName) {
    console.log('Category clicked:', categoryName);
    
    if (typeof gtag !== 'undefined') {
        gtag('event', 'category_select', {
            category_name: categoryName,
            source: 'main_page'
        });
    }
    
    collectUserBehavior({
        action: 'category_click',
        category: categoryName,
        timestamp: Date.now()
    });
}

/**
 * 사용자 행동 데이터 수집
 */
function collectUserBehavior(data) {
    try {
        let behaviors = JSON.parse(sessionStorage.getItem('userBehaviors') || '[]');
        behaviors.push(data);
        
        // 최대 50개까지만 저장
        if (behaviors.length > 50) {
            behaviors = behaviors.slice(-50);
        }
        
        sessionStorage.setItem('userBehaviors', JSON.stringify(behaviors));
    } catch (error) {
        console.error('Failed to collect user behavior:', error);
    }
}

/**
 * 이미지 지연 로딩
 */
function initLazyLoading() {
    const images = document.querySelectorAll('img[loading="lazy"]');
    
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src || img.src;
                    img.classList.remove('lazy');
                    imageObserver.unobserve(img);
                }
            });
        });
        
        images.forEach(img => {
            imageObserver.observe(img);
        });
    }
}

/**
 * 성능 최적화를 위한 디바운스 함수
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
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

// 페이지 언로드 시 사용자 행동 데이터 전송
window.addEventListener('beforeunload', function() {
    const behaviors = sessionStorage.getItem('userBehaviors');
    if (behaviors && navigator.sendBeacon) {
        navigator.sendBeacon('/api/analytics/behavior', behaviors);
    }
});

// 성능 모니터링
window.addEventListener('load', function() {
    setTimeout(() => {
        if ('performance' in window) {
            const perfData = performance.getEntriesByType('navigation')[0];
            console.log('Page load time:', perfData.loadEventEnd - perfData.loadEventStart, 'ms');
        }
    }, 0);
});
