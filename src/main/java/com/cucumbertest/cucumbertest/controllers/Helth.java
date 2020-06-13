package com.cucumbertest.cucumbertest.controllers;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Helth {

	@RequestMapping(method = { RequestMethod.GET }, value = { "/version" })
	public String getVersion(HttpServletResponse response) {
		response.setStatus(HttpServletResponse.SC_OK);
		return "1.0";
	}

	@RequestMapping(method = { RequestMethod.GET }, value = { "/health" })
	public String health(HttpServletResponse response) {
		response.setStatus(HttpServletResponse.SC_OK);
		return "200";
	}
}
