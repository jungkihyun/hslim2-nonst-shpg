package com.hslim2.nonstshpg.config;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hslim2.nonstshpg.entity.Product;
import com.hslim2.nonstshpg.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

import java.io.InputStream;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final ProductRepository productRepository;
    private final ObjectMapper objectMapper;

    @Override
    public void run(String... args) throws Exception {
        if (productRepository.count() > 0) {
            log.info("Sample data already exists. Skipping initialization.");
            return;
        }

        log.info("Initializing sample data from JSON...");
        loadProductsFromJson();
        log.info("Sample data initialization completed.");
    }

    private void loadProductsFromJson() {
        try {
            Resource resource = new ClassPathResource("static/data/products.json");
            try (InputStream is = resource.getInputStream()) {
                JsonNode root = objectMapper.readTree(is).get("products");
                if (root != null && root.isArray()) {
                    for (JsonNode node : root) {
                        String productCode = node.path("productCode").asText();

                        Product product = Product.builder()
                                .name(node.path("productName").asText())
                                .description(node.path("description").asText(null))
                                .price(node.path("price").asInt())
                                .category(mapCategory(node.path("categoryCode").asText()))
                                .origin(null)
                                .imageUrl(buildImageUrl(productCode, node.path("imagePath").asText()))
                                .build();

                        productRepository.save(product);
                        log.debug("Created product: {}", product.getName());
                    }
                }
            }
        } catch (Exception e) {
            log.error("Failed to load products.json", e);
        }
    }

    private String buildImageUrl(String productCode, String imagePath) {
        if (imagePath == null || imagePath.isBlank()) {
            return null;
        }
        String basePath = imagePath.startsWith("/") ? imagePath : "/" + imagePath;
        return basePath + "/" + productCode + "_main.jpg";
    }

    private Product.Category mapCategory(String categoryCode) {
        if (categoryCode == null || categoryCode.length() < 2) {
            return Product.Category.PROCESSED;
        }
        String prefix = categoryCode.substring(0, 2);
        return switch (prefix) {
            case "05" -> Product.Category.VEGETABLE;
            case "06" -> Product.Category.MEAT;
            case "10" -> Product.Category.GRAIN;
            case "07", "08", "09", "13" -> Product.Category.PROCESSED;
            default -> Product.Category.PROCESSED;
        };
    }
}
