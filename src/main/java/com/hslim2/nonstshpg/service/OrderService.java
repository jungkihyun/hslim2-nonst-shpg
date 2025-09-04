package com.hslim2.nonstshpg.service;

import com.hslim2.nonstshpg.dto.OrderForm;
import com.hslim2.nonstshpg.entity.*;
import com.hslim2.nonstshpg.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final CartService cartService;
    private final ProductService productService;

    @Transactional
    public Order createOrderFromCart(User user, OrderForm form) {
        List<CartItem> cartItems = cartService.getCartItems(user);
        Order order = buildOrder(user, cartItems, form);
        orderRepository.save(order);
        cartService.clearCart(user);
        return order;
    }

    @Transactional
    public Order createOrderDirect(User user, Long productId, int quantity, OrderForm form) {
        Product product = productService.getProductById(productId)
                .orElseThrow(() -> new IllegalArgumentException("상품을 찾을 수 없습니다."));
        CartItem temp = new CartItem(user, product, quantity);
        Order order = buildOrder(user, List.of(temp), form);
        return orderRepository.save(order);
    }

    public List<Order> getOrders(User user) {
        return orderRepository.findByUser(user);
    }

    private Order buildOrder(User user, List<CartItem> items, OrderForm form) {
        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(form.getReceiverName());
        order.setReceiverPhone(form.getReceiverPhone());
        order.setReceiverAddress(form.getReceiverAddress());
        order.setPaymentMethod(form.getPaymentMethod());
        for (CartItem item : items) {
            OrderItem oi = new OrderItem();
            oi.setOrder(order);
            oi.setProduct(item.getProduct());
            oi.setQuantity(item.getQuantity());
            oi.setPrice(item.getProduct().getPrice());
            order.getItems().add(oi);
        }
        return order;
    }
}