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

		String jsonResponse = '{{}}}';



		// Assertions to check if the Contact object was populated correctly
		System.assertEquals('test@example.com', cont.Email, 'Email does not match.');
		System.assertEquals('+123456789', cont.Phone, 'Phone does not match.');
		System.assertEquals(Date.valueOf('1990-01-01'), cont.Birthdate, 'Birthdate does not match.');
		System.assertEquals('123 Test St', cont.MailingStreet, 'MailingStreet does not match.');
		System.assertEquals('Test City', cont.MailingCity, 'MailingCity does not match.');
		System.assertEquals('12345', cont.MailingPostalCode, 'MailingPostalCode does not match.');
		System.assertEquals('TS', cont.MailingState, 'MailingState does not match.');
		System.assertEquals('Testland', cont.MailingCountry, 'MailingCountry does not match.');
	}



/*
	@IsTest
	static void testContactInsert() {
		Contact cont = new Contact(FirstName = 'Test', LastName = 'User');

		// Register the mock callout class
		Test.setMock(HttpCalloutMock.class, new DummyJSONCalloutMockGenerator());

		// As this is a future method, we need to enclose it in Test.startTest() and Test.stopTest() to ensure it's executed in the test context.
		Test.startTest();
		insert cont;
		Test.stopTest();

		// After the stopTest, the future method will have run. Now we can check if the contact was created correctly.
		cont = [
			SELECT Email, Phone, Birthdate, MailingStreet, MailingCity, MailingPostalCode, MailingState, MailingCountry
			FROM Contact
			WHERE Id = :cont.Id
		];
		System.assertEquals('test@example.com', cont.Email, 'Email does not match your value: ' + cont.Email);
		System.assertEquals('+123456789', cont.Phone, 'Phone does not match your value: ' + cont.Phone);
		System.assertEquals(
			cont.Birthdate,
			Date.valueOf('1990-01-01'),
			'Birthdate does not match your value: ' + cont.Birthdate
		);
	}
}
    */