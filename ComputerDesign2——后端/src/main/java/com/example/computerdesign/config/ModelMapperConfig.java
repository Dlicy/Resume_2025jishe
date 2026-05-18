package com.example.computerdesign.config;

import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ModelMapperConfig {
    @Bean
    public ModelMapper modelMapper() {
        ModelMapper modelMapper = new ModelMapper();
        // 可选的自定义配置
        modelMapper.getConfiguration()
                .setSkipNullEnabled(true);
        return modelMapper;
    }
}