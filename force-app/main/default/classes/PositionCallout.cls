public with sharing class PositionCallout {
    @future(callout = true)

    public static void getJobs(String keyword) {
		// Create HTTP request to send.
		HttpRequest request = new HttpRequest();
		// Set the endpoint URL. Use direct URL or for best practices use Named Credential.
		request.setEndpoint('callout:Jooble/'+'?keywords='+keyword);
		// Set the HTTP method to POST.
		request.setMethod('POST');
		// Send the HTTP request and get the response.
		Http http = new Http();
		HttpResponse response = http.send(request);
		String responseBody = response.getBody();
		Integer statusCode = response.getStatusCode();
		System.debug(statusCode);

        if(statusCode >= 200 && statusCode <= 299) {
            Map<String,Object> jsonMap = (Map<String,Object>) JSON.deserializeUntyped(responseBody); 
        }
    }
}