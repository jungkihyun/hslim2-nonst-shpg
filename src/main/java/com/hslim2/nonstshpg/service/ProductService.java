package com.hslim2.nonstshpg.service;

import com.hslim2.nonstshpg.entity.Product;
import com.hslim2.nonstshpg.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }

    public List<Product> getProductsByCategory(Product.Category category) {
        return productRepository.findByCategory(category);
    }

    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts();
        }
        return productRepository.searchByName(keyword.trim());
    }

    public List<Product> searchProductsByCategoryAndName(Product.Category category, String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getProductsByCategory(category);
        }
        return productRepository.searchByCategoryAndName(category, keyword.trim());
    }

    // 메인 페이지용 추천 상품 (임시로 최근 등록 순으로 지정된 개수만큼)
    public List<Product> getFeaturedProducts() {
        return getFeaturedProducts(8);
    }
    
    public List<Product> getFeaturedProducts(int limit) {
        List<Product> allProducts = productRepository.findAll();
        return allProducts.stream()
                .sorted((p1, p2) -> p2.getCreatedAt().compareTo(p1.getCreatedAt()))
                .limit(limit)
                .toList();
    }
}
