package com.japanlife.controller;

import jakarta.servlet.http.HttpServletRequest;
import java.util.Map;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class RequestExceptionHandler {

    @ExceptionHandler(IllegalArgumentException.class)
    public Object invalidRequest(HttpServletRequest request) {
        String accept = request.getHeader("Accept");
        if (accept != null && accept.contains(MediaType.APPLICATION_JSON_VALUE)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Map.of("error", "Bad Request", "message", "Invalid request parameters"));
        }
        ModelAndView result = new ModelAndView("error/page");
        result.setStatus(HttpStatus.BAD_REQUEST);
        result.addObject("statusCode", 400);
        result.addObject("errorTitleKey", "error.badRequest.title");
        result.addObject("errorDescriptionKey", "error.badRequest.description");
        return result;
    }
}
