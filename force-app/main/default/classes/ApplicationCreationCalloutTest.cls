@IsTest
public with sharing class ApplicationCreationCalloutTest {
	// This test method will test the getDummyJSONUserFromId future method with a mock HTTP response.
	@IsTest
	static void testPostApplication() {
		// Register the mock callout class
		Test.setMock(HttpCalloutMock.class, new ApplicationMockCalloutGenerator());

		// As this is a future method, we need to enclose it in Test.startTest() and Test.stopTest() to ensure it's executed in the test context.
		Test.startTest();
		ApplicationCreationCallout.getJobs(); // Call the method
		Test.stopTest();

		List<Job_Application__c> jobApplications = [SELECT Id,Name,External_Id__c,Salary__c,Location__c FROM Job_Application__c];
		System.assertEquals(1,jobApplications.size(), 'Positions created should be 1.');
		System.assertEquals('Senior Salesforce Developer',jobApplications[0].Name,'Title does not match');
		System.assertEquals('111222333',jobApplications[0].External_Id__c,'External Id does not match.');
		System.assertEquals(jobApplications[0].Salary__c, 60000,'Salary does not match');
		System.assertEquals('Columbus, OH',jobApplications[0].Location__c,'Location does not match');
		}
	}