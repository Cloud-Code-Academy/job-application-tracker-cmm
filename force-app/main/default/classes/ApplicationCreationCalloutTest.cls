@IsTest
public with sharing class ApplicationCreationCalloutTest {
	// This test method will test the getDummyJSONUserFromId future method with a mock HTTP response.
	@IsTest
	static void testPostApplicationNewAccount() {
		// Register the mock callout class
		Test.setMock(HttpCalloutMock.class, new ApplicationMockCalloutGenerator());

		// As this is a future method, we need to enclose it in Test.startTest() and Test.stopTest() to ensure it's executed in the test context.
		Test.startTest();
		ApplicationCreationCallout.getJobs(); // Call the method
		Test.stopTest();

		Account acc = [SELECT Id FROM Account WHERE Name = 'V2'];

		List<Job_Application__c> jobApplications = [SELECT Id,Name,External_Id__c,Salary__c,Location__c,Company_Name__c FROM Job_Application__c];
		System.assertEquals(1,jobApplications.size(), 'Positions created should be 1.');
		System.assertEquals('Senior Salesforce Developer',jobApplications[0].Name,'Title does not match');
		System.assertEquals('111222333',jobApplications[0].External_Id__c,'External Id does not match.');
		System.assertEquals(60000,jobApplications[0].Salary__c,'Salary does not match');
		System.assertEquals('Columbus, OH',jobApplications[0].Location__c,'Location does not match');
		System.assertEquals(acc.Id,jobApplications[0].Company_Name__c,'Account is not correct.');
		}


		@IsTest
		static void testPostApplicationExistingAccount() {
			// Register the mock callout class
			Test.setMock(HttpCalloutMock.class, new ApplicationMockCalloutGenerator());

			//Create account
			Account acc = new Account(Name='V2');
			insert acc;

			//Query user
			User owner = [SELECT Id FROM User WHERE LastName = 'Applicant'];
	
			// As this is a future method, we need to enclose it in Test.startTest() and Test.stopTest() to ensure it's executed in the test context.
			Test.startTest();
			ApplicationCreationCallout.getJobs(); // Call the method
			Test.stopTest();
	
			List<Account> accountList = [SELECT Id FROM Account WHERE Name = 'V2'];
			
			List<Job_Application__c> jobApplications = [SELECT Id,Name,External_Id__c,Salary__c,Location__c,Company_Name__c,OwnerId FROM Job_Application__c];
			System.assertEquals(1,accountList.size(),'No additional accounts should have been created.');
			System.assertEquals(1,jobApplications.size(), 'Positions created should be 1.');
			System.assertEquals('Senior Salesforce Developer',jobApplications[0].Name,'Title does not match');
			System.assertEquals('111222333',jobApplications[0].External_Id__c,'External Id does not match.');
			System.assertEquals(60000,jobApplications[0].Salary__c,'Salary does not match');
			System.assertEquals(owner.Id,jobApplications[0].OwnerId,'Owner does not match');
			System.assertEquals('Columbus, OH',jobApplications[0].Location__c,'Location does not match');
			System.assertEquals(accountList[0].Id,jobApplications[0].Company_Name__c,'Account is not correct.');
			}
		}