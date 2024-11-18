public with sharing class PositionCallout {
    @TestVisible // Allows test class to see this method. Since it is private, it would not be visible otherwise.
    private static void createPositionsFromJson(String jsonResponse) {
        // Deserialize the JSON string into map of primitive data types.
        Map<String,Object> jsonMap = (Map<String,Object>) JSON.deserializeUntyped(jsonResponse);
        List<Object> positions = (List<Object>) jsonMap.get('jobs');
        List<Job_Position__c> positionRecords = new List<Job_Position__c>();
            if(!positions.isEmpty()) {
                for(Object positionItem : positions) {
                    Map<String,Object> positionMap = (Map<String,Object>) positionItem;
                    Job_Position__c positionRecord = new Job_Position__c();
                    positionRecord.External_Id__c = String.valueof(positionMap.get('id'));
                    positionRecord.Name = String.valueof(positionMap.get('title'));
                    /*positionRecord.Description__c = String.valueof(positionMap.get('snippet'));
                    positionRecord.Date_Posted__c = Date.valueof(positionMap.get('datecreatedfrom'));
                    positionRecord.Salary__c = Integer.valueof(positionMap.get('salary'));*/
                    positionRecords.add(positionRecord);
                }
            Database.upsert(positionRecords,Job_Position__c.External_Id__c);
        }
    }
    
    @future(callout = true)
    public static void getJobs() {
        Map<String,String> keywordMap = new Map<String,String>();
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL. Use direct URL or for best practices use Named Credential.
        //request.setEndpoint('callout:JoobleUser');
        request.setEndpoint('https://jooble.org/api/e5d2ae19-17e9-4c4a-aa0f-6f1946d66fb2');
        //Set header
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Set the HTTP method to POST.
        request.setMethod('POST');
        //Set the body of th request.
        request.setBody('{"keywords":"Salesforce Developer"}');
        System.debug(request);
        // Send the HTTP request and get the response.
        Http http = new Http();
        HttpResponse response = http.send(request);
        String responseBody = response.getBody();
        System.debug(responseBody);
        Integer statusCode = response.getStatusCode();
        System.debug(statusCode);
        if(statusCode >= 200 && statusCode <= 299) {
            createPositionsFromJson(responseBody);
        }

    }

}