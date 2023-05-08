package com.example.my.common;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class CommonExceptionHandler {
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResDTO<?> handleMethodArgumentNotValidException(MethodArgumentNotValidException exception) {
        // key에 필드명, value에 에러 메시지
        Map<String, String> errorMap = new HashMap<>();

        // 익셉션에서 에러 리스트를 찾아서 가공해줌.
        exception.getBindingResult().getFieldErrors().forEach(fieldError -> {
            errorMap.put(fieldError.getField(), fieldError.getDefaultMessage());
        });
        return ResDTO.builder()
                .code(-1)
                .message("잘못된 요청입니다.")
                .data(errorMap)
                .build();
    }
    
}
