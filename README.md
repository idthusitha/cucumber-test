# Cucumber Test


Acceptance test ensures that the right things are built. Automated acceptance testing is one of the principles of Extreme programming. Cucumber tries to address the area of acceptance testing. Cucumber allows collaboration between business stakeholder and development team to express the business outcomes. Cucumber has its own ubiquitous language and adheres to syntax rules known as Gherkin. We will take a look at how cucumber fits in with Selenium ecosystem. It is a Business Readable, Domain Specific Language that lets you describe software’s behavior without detailing how that behavior is implemented. These are the following constructs of the Gherkin language.


* Given : This indicates the prior state of the system. For example, a user must be logged in to perform activities within the site.
* When : This is the specific activity carried out or the functionality tested.
* Then: This is our assert/verification scenario which is the result we expect out of the testing.



### Run test
	git clone https://github.com/idthusitha/cucumber-test.git
	cd {{ WORKSPACE }}/cucumber-test 
	gradle clean build


### Cucumber feature report link

	file://{{ WORKSPACE }}/cucumber-test/target/html/cucumber-html-reports/overview-features.html
	
![Test Image 1](https://github.com/idthusitha/cucumber-test/blob/master/doc/cucumber_report.png)


### Cucumber Steps Definition report link

![Test Image 1](https://github.com/idthusitha/cucumber-test/blob/master/doc/steps_definitions.png)
	


### Basic report link
	file://{{ WORKSPACE }}/cucumber-test/build/reports/tests/test/index.html