package com.cucumbertest.cucumbertest.controllers;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Helth {

	@RequestMapping(method = { RequestMethod.GET }, value = "/version", produces = "application/json")
	public String getVersion(HttpServletResponse response) {
		response.setStatus(HttpServletResponse.SC_OK);
		return "1.0";
	}

	@RequestMapping(value = "/health", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<?> saveCustomerData(HttpServletResponse response) {
		response.setStatus(HttpServletResponse.SC_OK);
		return ResponseEntity.ok("200 OK");
	}
}
