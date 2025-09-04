package com.hslim2.nonstshpg.config;

import com.hslim2.nonstshpg.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * 로그인 성공 시 사용자 정보를 세션에 저장하는 핸들러
 */
@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        // 인증된 사용자 정보를 직접 가져와 세션에 저장
        User user = (User) authentication.getPrincipal();

        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // 메인 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/");
    }
}