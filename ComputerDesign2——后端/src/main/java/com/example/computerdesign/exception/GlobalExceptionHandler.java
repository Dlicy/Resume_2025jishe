package com.example.computerdesign.exception;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

  @ExceptionHandler(IllegalArgumentException.class)
  public ResponseEntity<?> handleIllegalArgumentException(IllegalArgumentException e) {
    return ResponseEntity.badRequest().body(
            Map.of("success", false, "message", e.getMessage())
    );
  }

  @ExceptionHandler(Exception.class)
  public ResponseEntity<?> handleGeneralException(Exception e) {
    return ResponseEntity.internalServerError().body(
            Map.of("success", false, "message", "服务器内部错误")
    );
  }
}