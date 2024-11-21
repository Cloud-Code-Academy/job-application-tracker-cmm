public with sharing class ApplicationMockCalloutGenerator implements HttpCalloutMock {
	public HTTPResponse respond(HTTPRequest req) {
		// Create a fake response
		HttpResponse res = new HttpResponse();
		res.setHeader('Content-Type', 'application/json');

		// Check if the request is a POST request
		if (req.getMethod() == 'POST') {
			// Return a success response for the POST request
			res.setBody('{"totalCount": "1","jobs": [{"company":"V2","updated":"2024-11-15T00:00:00.0000000","title":"Senior Salesforce Developer","id":"111222333","snippet":"blech","url":"https://google.com"}]}');
		}
		res.setStatusCode(200);
		return res;
	}
}