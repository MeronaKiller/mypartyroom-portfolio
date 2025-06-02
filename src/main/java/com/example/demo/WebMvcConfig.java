package com.example.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setOrder(1);
        
        System.out.println("🔧 JSP ViewResolver 설정 완료: prefix=/WEB-INF/views/, suffix=.jsp");
        
        return resolver;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
        
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/", "/WEB-INF/views/css/");
        
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/", "/WEB-INF/views/js/");
        
        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/", "/WEB-INF/views/images/");
        
        System.out.println("🔧 정적 리소스 핸들러 설정 완료");
    }
}