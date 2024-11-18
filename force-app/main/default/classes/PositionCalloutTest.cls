@IsTest
public with sharing class PositionCalloutTest {
	// This test method will test the getDummyJSONUserFromId future method with a mock HTTP response.
	@IsTest
	static void testPostPosition() {
		// Register the mock callout class
		Test.setMock(HttpCalloutMock.class, new PositionMockCalloutGenerator());

		// As this is a future method, we need to enclose it in Test.startTest() and Test.stopTest() to ensure it's executed in the test context.
		Test.startTest();
		PositionCallout.getJobs(); // Call the method
		Test.stopTest();

		String jsonResponse = '{"totalCount":1,"jobs":[{"title":"Senior Salesforce Developer","location":"Portland, OR","snippet":"&nbsp;...business? Do you enjoy being a part of a technology team that <b>develops </b>strategic solutions and supports new technology implementations...&nbsp;&nbsp;...Opportunity: \r\n \r\n Our IT Department is looking for a Senior <b>Salesforce </b>Developer to join our team to help "}]}';
		List<Job_Position__c> positionsToCheck = createPositionsFromJson(jsonResponse);
		System.assertEquals(positionsToCheck[0].Name = 'Senior Salesforce Developer','Title does not match');
		System.assertEquals(positionsToCheck[0].Title = 'Portland,OR','Location does not match');
	}
}