package com.hslim2.nonstshpg.repository;

import com.hslim2.nonstshpg.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    
    List<Product> findByCategory(Product.Category category);
    Page<Product> findByCategory(Product.Category category, Pageable pageable);

    @Query("SELECT p FROM Product p WHERE p.name LIKE %:keyword%")
    Page<Product> searchByName(@Param("keyword") String keyword, Pageable pageable);
    
    @Query("SELECT p FROM Product p WHERE p.category = :category AND p.name LIKE %:keyword%")
    Page<Product> searchByCategoryAndName(@Param("category") Product.Category category,
                                          @Param("keyword") String keyword,
                                          Pageable pageable);
}
