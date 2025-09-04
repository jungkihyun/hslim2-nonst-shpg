package com.hslim2.nonstshpg.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    /**
     * 정적 리소스 핸들러 설정
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // CSS, JS, 이미지 등 정적 리소스 경로 설정
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/", "/resources/static/css/");
                
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/", "/resources/static/js/");

        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/", "/resources/static/images/");

    }

    /**
     * View Controller 설정
     */
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // 에러 페이지 등 단순 페이지 매핑
        registry.addViewController("/error").setViewName("error/error");
    }
}
