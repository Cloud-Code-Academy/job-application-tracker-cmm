@IsTest
public with sharing class ApplicationCreationCalloutTest {
	// This test method will test the getDummyJSONUserFromId future method with a mock HTTP response.
	@IsTest
	static void testPostApplication() {
		// Register the mock callout class
		Test.setMock(HttpCalloutMock.class, new PositionMockCalloutGenerator());

		// As this is a future method, we need to enclose it in Test.startTest() and Test.stopTest() to ensure it's executed in the test context.
		Test.startTest();
		ApplicationCreationCallout.getJobs(); // Call the method
		Test.stopTest();

		List<Job_Application__c> jobApplications = [SELECT Id,Name,External_Id__c,Description__c FROM Job_Application__c];
		System.assertEquals(jobApplications.size(),1, 'Positions created should be 1.');
		System.assertEquals(jobApplications[0].Name, 'Senior Salesforce Developer','Title does not match');
		System.assertEquals(jobApplications[0].External_Id__c,'111222333','Exteranl Id does not match.');
		System.assertEquals(jobApplications[0].Description__c, 'blech','Description does not match');
		}
	}