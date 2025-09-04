package com.hslim2.nonstshpg.controller;

import com.hslim2.nonstshpg.entity.Product;
import com.hslim2.nonstshpg.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final ResourcePatternResolver resourcePatternResolver;

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

        model.addAttribute("contentPage", "products/list.jsp");

        return "layout/layout";
    }

    @GetMapping("/products/{id}")
    public String productDetail(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new IllegalArgumentException("상품을 찾을 수 없습니다."));

        List<String> detailImages = new ArrayList<>();
        String mainImageUrl = product.getImageUrl();
        if (mainImageUrl != null) {
            String filename = mainImageUrl.substring(mainImageUrl.lastIndexOf('/') + 1);
            int idx = filename.indexOf('_');
            if (idx > -1) {
                String code = filename.substring(0, idx);
                try {
                    Resource[] resources = resourcePatternResolver.getResources(
                            "classpath:/static/data/images/" + code + "/" + code + "_contents*.jpg");
                    for (Resource resource : resources) {
                        detailImages.add("/data/images/" + code + "/" + resource.getFilename());
                    }
                } catch (IOException e) {
                    // ignore missing detail images
                }
            }
        }

        
        model.addAttribute("product", product);
        model.addAttribute("detailImages", detailImages);
        model.addAttribute("pageTitle", product.getName());
        model.addAttribute("contentPage", "products/detail.jsp");

        return "layout/layout";
    }

    @GetMapping("/search")
    public String search(@RequestParam String keyword, Model model) {
        return "redirect:/products?keyword=" + keyword;
    }

    private List<String> loadProductImages(Product product) {
        if (product.getImageUrl() == null) {
            return List.of();
        }
        try {
            String imageUrl = product.getImageUrl();
            int lastSlash = imageUrl.lastIndexOf('/');
            String dirPath = imageUrl.substring(0, lastSlash);
            String resourcePath = "static" + dirPath;
            File directory = new ClassPathResource(resourcePath).getFile();
            String[] names = directory.list((dir, name) -> name.endsWith(".jpg") || name.endsWith(".png"));
            if (names == null) {
                return List.of(imageUrl);
            }
            Arrays.sort(names, (a, b) -> {
                boolean aMain = a.contains("_main");
                boolean bMain = b.contains("_main");
                if (aMain && !bMain) return -1;
                if (!aMain && bMain) return 1;
                return a.compareTo(b);
            });
            return Arrays.stream(names)
                    .map(name -> dirPath + "/" + name)
                    .collect(Collectors.toList());
        } catch (IOException e) {
            return List.of(product.getImageUrl());
        }
    }
}
