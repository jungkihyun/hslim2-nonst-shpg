package com.hslim2.nonstshpg.controller;

import com.hslim2.nonstshpg.dto.SignupDto;
import com.hslim2.nonstshpg.service.ProductService;
import com.hslim2.nonstshpg.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MainController {
    
    private final ProductService productService;
    private final UserService userService;
    
    /**
     * 메인 페이지
     */
    @GetMapping({"/", "/index"})
    public String index(Model model) {
        // 레이아웃 설정
        model.addAttribute("contentPage", "index.jsp");
        model.addAttribute("pageTitle", "한살림 비조합원 온라인 장보기");
        model.addAttribute("pageJs", "index.js");
        
        // 추천 상품 조회 (최대 8개)
        try {
            var featuredProducts = productService.getFeaturedProducts(8);
            model.addAttribute("featuredProducts", featuredProducts);
        } catch (Exception e) {
            log.error("추천 상품 조회 실패", e);
            model.addAttribute("featuredProducts", null);
        }
        
        return "layout/layout";
    }
    
    /**
     * 로그인 페이지
     */
    @GetMapping("/login")
    public String loginForm(Model model) {
        model.addAttribute("contentPage", "auth/login.jsp");
        model.addAttribute("pageTitle", "로그인");
        model.addAttribute("pageJs", "login.js");
        
        return "layout/layout";
    }
    
    /**
     * 회원가입 페이지
     */
    @GetMapping("/signup")
    public String signupForm(Model model) {
        model.addAttribute("contentPage", "auth/signup.jsp");
        model.addAttribute("pageTitle", "회원가입");
        model.addAttribute("pageJs", "signup.js");
        model.addAttribute("signupDto", new SignupDto());
        
        return "layout/layout";
    }
    
    /**
     * 회원가입 처리
     */
    @PostMapping("/signup")
    public String signup(@Valid @ModelAttribute SignupDto signupDto,
                        BindingResult bindingResult,
                        Model model,
                        RedirectAttributes redirectAttributes) {
        
        log.debug("회원가입 요청: {}", signupDto);
        
        // 유효성 검사 실패 시
        if (bindingResult.hasErrors()) {
            log.debug("회원가입 유효성 검사 실패: {}", bindingResult.getAllErrors());
            
            model.addAttribute("contentPage", "auth/signup.jsp");
            model.addAttribute("pageTitle", "회원가입");
            model.addAttribute("pageJs", "signup.js");
            model.addAttribute("signupDto", signupDto);
            model.addAttribute("fieldErrors", bindingResult.getFieldErrors()
                .stream()
                .collect(java.util.stream.Collectors.toMap(
                    error -> error.getField(),
                    error -> error.getDefaultMessage(),
                    (existing, replacement) -> existing
                )));
            
            return "layout/layout";
        }
        
        try {
            // 회원가입 처리
            userService.signup(signupDto);
            
            log.info("회원가입 성공: {}", signupDto.getEmail());
            redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다. 로그인해주세요.");
            
            return "redirect:/login";
            
        } catch (IllegalArgumentException e) {
            log.warn("회원가입 실패 - 중복: {}", e.getMessage());
            
            model.addAttribute("contentPage", "auth/signup.jsp");
            model.addAttribute("pageTitle", "회원가입");
            model.addAttribute("pageJs", "signup.js");
            model.addAttribute("signupDto", signupDto);
            model.addAttribute("error", e.getMessage());
            
            return "layout/layout";
            
        } catch (Exception e) {
            log.error("회원가입 처리 중 오류 발생", e);
            
            model.addAttribute("contentPage", "auth/signup.jsp");
            model.addAttribute("pageTitle", "회원가입");
            model.addAttribute("pageJs", "signup.js");
            model.addAttribute("signupDto", signupDto);
            model.addAttribute("error", "회원가입 중 오류가 발생했습니다. 다시 시도해주세요.");
            
            return "layout/layout";
        }
    }
}
