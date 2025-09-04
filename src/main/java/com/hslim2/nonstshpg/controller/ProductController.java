package com.hslim2.nonstshpg.controller;

import com.hslim2.nonstshpg.entity.Product;
import com.hslim2.nonstshpg.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @GetMapping("/products")
    public String products(@RequestParam(required = false) String category,
                          @RequestParam(required = false) String keyword,
                          Model model) {
        
        List<Product> products;
        String pageTitle = "전체 상품";

        if (category != null && !category.isEmpty()) {
            try {
                Product.Category categoryEnum = Product.Category.valueOf(category.toUpperCase());
                
                if (keyword != null && !keyword.trim().isEmpty()) {
                    products = productService.searchProductsByCategoryAndName(categoryEnum, keyword);
                    pageTitle = categoryEnum.getDisplayName() + " - " + keyword + " 검색 결과";
                } else {
                    products = productService.getProductsByCategory(categoryEnum);
                    pageTitle = categoryEnum.getDisplayName();
                }
                
                model.addAttribute("selectedCategory", categoryEnum);
            } catch (IllegalArgumentException e) {
                products = productService.getAllProducts();
                pageTitle = "전체 상품";
            }
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            products = productService.searchProducts(keyword);
            pageTitle = keyword + " 검색 결과";
        } else {
            products = productService.getAllProducts();
        }

        model.addAttribute("products", products);
        model.addAttribute("pageTitle", pageTitle);
        model.addAttribute("categories", Product.Category.values());
        model.addAttribute("keyword", keyword);
        
        return "products/list";
    }

    @GetMapping("/products/{id}")
    public String productDetail(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new IllegalArgumentException("상품을 찾을 수 없습니다."));
        
        model.addAttribute("product", product);
        return "products/detail";
    }

    @GetMapping("/search")
    public String search(@RequestParam String keyword, Model model) {
        return "redirect:/products?keyword=" + keyword;
    }
}
