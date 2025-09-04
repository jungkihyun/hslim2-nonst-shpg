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

    private void validateUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("로그인이 필요합니다.");
        }
    }

    public void addToCart(User user, Long productId, Integer quantity) {
        validateUser(user);
        if (quantity == null || quantity <= 0) {
            throw new IllegalArgumentException("수량은 1개 이상이어야 합니다.");
        }

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
        validateUser(user);
        return cartItemRepository.findByUser(user);
    }

    public void updateCartItemQuantity(User user, Long cartItemId, Integer quantity) {
        validateUser(user);
        CartItem cartItem = cartItemRepository.findByIdAndUser(cartItemId, user)
                .orElseThrow(() -> new IllegalArgumentException("장바구니 항목을 찾을 수 없습니다."));

        if (quantity == null || quantity <= 0) {
            cartItemRepository.delete(cartItem);
        } else {
            cartItem.setQuantity(quantity);
            cartItemRepository.save(cartItem);
        }
    }

    public void removeFromCart(User user, Long cartItemId) {
        validateUser(user);
        CartItem cartItem = cartItemRepository.findByIdAndUser(cartItemId, user)
                .orElseThrow(() -> new IllegalArgumentException("장바구니 항목을 찾을 수 없습니다."));
        cartItemRepository.delete(cartItem);
    }

    public void clearCart(User user) {
        validateUser(user);
        List<CartItem> cartItems = cartItemRepository.findByUser(user);
        cartItemRepository.deleteAll(cartItems);
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
