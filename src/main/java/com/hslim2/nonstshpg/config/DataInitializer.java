package com.hslim2.nonstshpg.config;

import com.hslim2.nonstshpg.entity.Product;
import com.hslim2.nonstshpg.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final ProductRepository productRepository;

    @Override
    public void run(String... args) throws Exception {
        // 이미 데이터가 있으면 스킵
        if (productRepository.count() > 0) {
            log.info("Sample data already exists. Skipping initialization.");
            return;
        }

        log.info("Initializing sample data...");
        createSampleProducts();
        log.info("Sample data initialization completed.");
    }

    private void createSampleProducts() {
        // 채소 카테고리
        createProduct("유기농 상추", Product.Category.VEGETABLE, 
                3500, "충남 홍성", "신선하고 아삭한 유기농 상추");
        createProduct("무농약 배추", Product.Category.VEGETABLE, 
                4200, "강원 평창", "김치용으로 최적인 무농약 배추");
        createProduct("유기농 당근", Product.Category.VEGETABLE, 
                2800, "제주", "단맛이 좋은 유기농 당근");
        createProduct("친환경 브로콜리", Product.Category.VEGETABLE, 
                3200, "경기 여주", "영양이 풍부한 친환경 브로콜리");
        createProduct("유기농 시금치", Product.Category.VEGETABLE, 
                2500, "전남 나주", "철분이 풍부한 유기농 시금치");

        // 과일 카테고리  
        createProduct("친환경 사과", Product.Category.FRUIT, 
                8900, "경북 영주", "당도 높은 친환경 사과 (1kg)");
        createProduct("유기농 배", Product.Category.FRUIT, 
                12000, "전남 나주", "수분이 풍부한 유기농 배 (2개입)");
        createProduct("무농약 딸기", Product.Category.FRUIT, 
                6800, "충남 논산", "달콤한 무농약 딸기 (500g)");
        createProduct("친환경 바나나", Product.Category.FRUIT, 
                4500, "필리핀", "유기농 인증 바나나 (1송이)");
        createProduct("유기농 오렌지", Product.Category.FRUIT, 
                7200, "미국", "비타민C 풍부한 유기농 오렌지 (6개입)");

        // 곡물 카테고리
        createProduct("유기농 현미", Product.Category.GRAIN, 
                15000, "경기 이천", "100% 유기농 현미 (5kg)");
        createProduct("친환경 백미", Product.Category.GRAIN, 
                18000, "전남 해남", "맛있는 친환경 백미 (5kg)");
        createProduct("무농약 귀리", Product.Category.GRAIN, 
                8500, "강원 평창", "건강한 무농약 귀리 (1kg)");
        createProduct("유기농 퀴노아", Product.Category.GRAIN, 
                12000, "볼리비아", "슈퍼푸드 유기농 퀴노아 (500g)");

        // 가공식품 카테고리
        createProduct("전통 된장", Product.Category.PROCESSED, 
                8800, "전북 정읍", "3년 숙성 전통 된장 (1kg)");
        createProduct("유기농 간장", Product.Category.PROCESSED, 
                9500, "경기 화성", "유기농 콩으로 만든 간장 (900ml)");
        createProduct("천연 고추장", Product.Category.PROCESSED, 
                7200, "충남 서천", "매콤한 천연 고추장 (1kg)");
        createProduct("유기농 참기름", Product.Category.PROCESSED, 
                15000, "경북 안동", "고소한 유기농 참기름 (320ml)");

        // 유제품 카테고리
        createProduct("유기농 우유", Product.Category.DAIRY, 
                3200, "충남 아산", "신선한 유기농 우유 (900ml)");
        createProduct("무농약 요거트", Product.Category.DAIRY, 
                4500, "경기 안성", "프로바이오틱 요거트 (500g)");
        createProduct("자연치즈", Product.Category.DAIRY, 
                12000, "강원 횡성", "수제 자연치즈 (200g)");

        // 육류 카테고리
        createProduct("한우 불고기", Product.Category.MEAT, 
                28000, "충남 홍성", "1등급 한우 불고기용 (500g)");
        createProduct("자연방사 달걀", Product.Category.MEAT, 
                6500, "전북 고창", "자연방사 유정란 (20개입)");
        createProduct("무항생제 닭가슴살", Product.Category.MEAT, 
                9800, "전남 영암", "신선한 무항생제 닭가슴살 (1kg)");
    }

    private void createProduct(String name, Product.Category category, 
                             Integer price, String origin, String description) {
        Product product = Product.builder()
                .name(name)
                .category(category)
                .price(price)
                .origin(origin)
                .description(description)
                .imageUrl(null) // 실제 운영시에는 이미지 URL 설정
                .build();
        
        productRepository.save(product);
        log.debug("Created product: {}", name);
    }
}
