package com.hslim2.nonstshpg.repository;

import com.hslim2.nonstshpg.entity.CartItem;
import com.hslim2.nonstshpg.entity.Product;
import com.hslim2.nonstshpg.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    
    List<CartItem> findByUser(User user);
    
    Optional<CartItem> findByUserAndProduct(User user, Product product);
    
    void deleteByUserAndProduct(User user, Product product);
}
