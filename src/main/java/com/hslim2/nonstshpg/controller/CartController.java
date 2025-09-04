package com.hslim2.nonstshpg.controller;

import com.hslim2.nonstshpg.entity.CartItem;
import com.hslim2.nonstshpg.entity.User;
import com.hslim2.nonstshpg.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    @GetMapping
    public String cartList(@AuthenticationPrincipal User user, Model model) {
        List<CartItem> cartItems = cartService.getCartItems(user);
        Integer totalPrice = cartService.getTotalPrice(user);
        
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalPrice", totalPrice);
        
        return "cart/list";
    }

    @PostMapping("/add")
    public String addToCart(@AuthenticationPrincipal User user,
                           @RequestParam Long productId,
                           @RequestParam Integer quantity,
                           RedirectAttributes redirectAttributes) {
        try {
            cartService.addToCart(user, productId, quantity);
            redirectAttributes.addFlashAttribute("message", "장바구니에 상품이 추가되었습니다.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        
        return "redirect:/products/" + productId;
    }

    @PostMapping("/update/{cartItemId}")
    public String updateCartItem(@PathVariable Long cartItemId,
                                @RequestParam Integer quantity,
                                RedirectAttributes redirectAttributes) {
        try {
            cartService.updateCartItemQuantity(cartItemId, quantity);
            if (quantity <= 0) {
                redirectAttributes.addFlashAttribute("message", "상품이 장바구니에서 삭제되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("message", "수량이 변경되었습니다.");
            }
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        
        return "redirect:/cart";
    }

    @PostMapping("/remove/{cartItemId}")
    public String removeFromCart(@PathVariable Long cartItemId,
                                RedirectAttributes redirectAttributes) {
        try {
            cartService.removeFromCart(cartItemId);
            redirectAttributes.addFlashAttribute("message", "상품이 장바구니에서 삭제되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "삭제 중 오류가 발생했습니다.");
        }
        
        return "redirect:/cart";
    }
}
