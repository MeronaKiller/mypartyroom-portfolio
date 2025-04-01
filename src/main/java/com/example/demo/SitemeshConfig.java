package com.example.demo;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SitemeshConfig extends ConfigurableSiteMeshFilter {
    
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("*", "/default.jsp");
        // 제외할 폴더와 문서
        builder.addExcludedPath("/admin/*");
        // 필요한 경우 다른 경로도 추가
    }
}