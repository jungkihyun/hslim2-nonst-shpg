package com.hslim2.nonstshpg.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        
        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            
            model.addAttribute("statusCode", statusCode);
            model.addAttribute("contentPage", "error/error.jsp");
            model.addAttribute("pageTitle", "오류가 발생했습니다");
            
            if (statusCode == HttpStatus.NOT_FOUND.value()) {
                log.warn("404 Error: {}", request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI));
                model.addAttribute("errorMessage", "요청하신 페이지를 찾을 수 없습니다.");
            } else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                log.error("500 Error: {}", request.getAttribute(RequestDispatcher.ERROR_EXCEPTION));
                model.addAttribute("errorMessage", "서버 내부 오류가 발생했습니다.");
            } else if (statusCode == HttpStatus.FORBIDDEN.value()) {
                log.warn("403 Error: Access denied to {}", request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI));
                model.addAttribute("errorMessage", "접근 권한이 없습니다.");
            } else {
                log.error("Error {}: {}", statusCode, request.getAttribute(RequestDispatcher.ERROR_MESSAGE));
                model.addAttribute("errorMessage", "오류가 발생했습니다.");
            }
        } else {
            model.addAttribute("statusCode", 500);
            model.addAttribute("errorMessage", "알 수 없는 오류가 발생했습니다.");
        }
        
        return "layout/layout";
    }
}
