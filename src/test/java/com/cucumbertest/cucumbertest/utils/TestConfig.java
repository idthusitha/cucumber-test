package com.cucumbertest.cucumbertest.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource(value = { "classpath:application.properties" })
public class TestConfig {

	@Value("${application.url}")
	private String applicationURL;

	/// Port
	@Value("${server.port}")
	private String applicationPort;

	/// Getters and Setters

	public String getApplicationURL() {
		System.out.println("==========================> http://" + applicationURL + ":" + applicationPort + "/");
		return "http://" + applicationURL + ":" + applicationPort + "/";
	}

}