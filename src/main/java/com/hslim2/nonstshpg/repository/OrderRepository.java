package com.hslim2.nonstshpg.repository;

import com.hslim2.nonstshpg.entity.Order;
import com.hslim2.nonstshpg.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);
}