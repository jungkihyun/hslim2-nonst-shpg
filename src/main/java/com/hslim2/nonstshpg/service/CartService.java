package com.hslim2.nonstshpg.service;

import com.hslim2.nonstshpg.entity.CartItem;
import com.hslim2.nonstshpg.entity.Product;
import com.hslim2.nonstshpg.entity.User;
import com.hslim2.nonstshpg.repository.CartItemRepository;
import com.hslim2.nonstshpg.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CartService {

    private final CartItemRepository cartItemRepository;
    private final ProductRepository productRepository;

    public void addToCart(User user, Long productId, Integer quantity) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new IllegalArgumentException("상품을 찾을 수 없습니다."));

        Optional<CartItem> existingCartItem = cartItemRepository.findByUserAndProduct(user, product);

        if (existingCartItem.isPresent()) {
            // 이미 장바구니에 있는 상품이면 수량 증가
            CartItem cartItem = existingCartItem.get();
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
            cartItemRepository.save(cartItem);
        } else {
            // 새로운 상품이면 장바구니에 추가
            CartItem cartItem = new CartItem(user, product, quantity);
            cartItemRepository.save(cartItem);
        }
    }

    public List<CartItem> getCartItems(User user) {
        return cartItemRepository.findByUser(user);
    }

    public void updateCartItemQuantity(Long cartItemId, Integer quantity) {
        CartItem cartItem = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니 항목을 찾을 수 없습니다."));
        
        if (quantity <= 0) {
            cartItemRepository.delete(cartItem);
        } else {
            cartItem.setQuantity(quantity);
            cartItemRepository.save(cartItem);
        }
    }

    public void removeFromCart(Long cartItemId) {
        cartItemRepository.deleteById(cartItemId);
    }

    public Integer getTotalPrice(User user) {
        List<CartItem> cartItems = getCartItems(user);
        return cartItems.stream()
                .mapToInt(CartItem::getTotalPrice)
                .sum();
    }

    public int getCartItemCount(User user) {
        List<CartItem> cartItems = getCartItems(user);
        return cartItems.stream()
                .mapToInt(CartItem::getQuantity)
                .sum();
    }
}
