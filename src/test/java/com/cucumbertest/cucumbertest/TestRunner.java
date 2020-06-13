package com.cucumbertest.cucumbertest;

import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(features = "src/test/resources/features", plugin = { "pretty", "json:target/cucumber-report.json",
		"html:build/test-results/test-report", })
public class TestRunner {
}
