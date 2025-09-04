package com.hslim2.nonstshpg.controller;

import com.hslim2.nonstshpg.dto.OrderForm;
import com.hslim2.nonstshpg.entity.CartItem;
import com.hslim2.nonstshpg.entity.User;
import com.hslim2.nonstshpg.service.CartService;
import com.hslim2.nonstshpg.service.OrderService;
import com.hslim2.nonstshpg.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;
    private final CartService cartService;
    private final ProductService productService;

    @GetMapping("/checkout")
    public String checkout(@AuthenticationPrincipal User user,
                           @RequestParam(required = false) Long productId,
                           @RequestParam(required = false, defaultValue = "1") Integer quantity,
                           Model model) {
        List<CartItem> items;
        if (productId != null) {
            items = List.of(new CartItem(user,
                    productService.getProductById(productId).orElseThrow(() -> new IllegalArgumentException("상품을 찾을 수 없습니다.")),
                    quantity));
            model.addAttribute("productId", productId);
            model.addAttribute("quantity", quantity);
        } else {
            items = cartService.getCartItems(user);
        }
        int totalPrice = items.stream().mapToInt(CartItem::getTotalPrice).sum();
        model.addAttribute("items", items);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("user", user);
        return "order/checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@AuthenticationPrincipal User user, OrderForm form,
                             @RequestParam(required = false) Long productId,
                             @RequestParam(required = false, defaultValue = "1") Integer quantity,
                             HttpSession session) {
        if (productId != null) {
            orderService.createOrderDirect(user, productId, quantity, form);
        } else {
            orderService.createOrderFromCart(user, form);
            session.setAttribute("cartCount", 0);
        }
        return "redirect:/orders";
    }

    @GetMapping("/orders")
    public String orders(@AuthenticationPrincipal User user, Model model) {
        model.addAttribute("orders", orderService.getOrders(user));
        return "orders/list";
    }
}