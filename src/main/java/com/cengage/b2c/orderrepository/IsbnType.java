package com.cengage.b2c.orderrepository;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cengage.b2b.validations.OrderPlacementException;
import com.cengage.b2c.placeOrderApplication.OrderPlacementControllerB2C;
import com.cengage.restActions.BaseClass;
import com.cengage.restActions.OrderWorkFlow;
import com.cengage.restActions.placeOrderOutline;

import jakarta.validation.Valid;


public enum IsbnType {
	
	physical,
	digital,
	bundle,
	other;
}

