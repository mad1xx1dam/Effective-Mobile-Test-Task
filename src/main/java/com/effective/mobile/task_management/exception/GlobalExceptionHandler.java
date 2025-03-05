package com.effective.mobile.task_management.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(UsernameNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ExceptionResponse handleUsernameNotFoundException(UsernameNotFoundException ex) {
        logException(ex, LogLevel.WARN);
        return buildExceptionResponse(ex);
    }

    private ExceptionResponse buildExceptionResponse(Exception ex) {
        return ExceptionResponse.builder()
                .message(ex.getMessage())
                .timestamp(LocalDateTime.now())
                .build();
    }

    private void logException(Exception ex, LogLevel logLevel) {
        String message = "%s: %s".formatted(ex.getClass().getSimpleName(), ex.getMessage());
        switch (logLevel) {
            case ERROR -> log.error(message, ex);
            case WARN -> log.warn(message, ex);
        }
    }

    private enum LogLevel {
        ERROR, WARN
    }
}
