public with sharing class PositionMockCalloutGenerator implements HttpCalloutMock {
	public HTTPResponse respond(HTTPRequest req) {
		// Create a fake response
		HttpResponse res = new HttpResponse();
		res.setHeader('Content-Type', 'application/json');

		// Check if the request is a POST request
		if (req.getMethod() == 'POST') {
			// Return a success response for the POST request
			res.setBody('{"totalCount": "1","jobs": [{"title":"Senior Salesforce Developer","id":"111222333"}]}');
		}
		res.setStatusCode(200);
		return res;
	}
}