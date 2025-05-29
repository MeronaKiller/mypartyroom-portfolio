package com.example.demo;

import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
@EnableAsync
public class MypartyroomApplication {

	public static void main(String[] args) {
		SpringApplication.run(MypartyroomApplication.class, args);
	}
	
	@Bean
	public FilterRegistrationBean<ConfigurableSiteMeshFilter> sitemeshFilter() {
	    FilterRegistrationBean<ConfigurableSiteMeshFilter> filterRegistrationBean = new FilterRegistrationBean<>();
	    filterRegistrationBean.setFilter(new SitemeshConfig());
	    filterRegistrationBean.addUrlPatterns("/*"); // 모든 URL 패턴에 적용
	    return filterRegistrationBean;
	}
}