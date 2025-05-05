package com.cengage.b2b.validations;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.BAD_REQUEST)
public class OrderPlacementException extends RuntimeException {

	 public OrderPlacementException(String message) {
	        super(message);
	    }

	    public OrderPlacementException(String message, Throwable cause) {
	        super(message, cause);
	    }
}
