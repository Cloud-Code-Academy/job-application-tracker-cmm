public with sharing class ApplicationCreationCallout {
    @TestVisible // Allows test class to see this method. Since it is private, it would not be visible otherwise.
    private static void createApplicationsFromJson(String jsonResponse) {
        // Deserialize the JSON string into map of primitive data types.
        Map<String,Object> jsonMap = (Map<String,Object>) JSON.deserializeUntyped(jsonResponse);
        List<Object> applications = (List<Object>) jsonMap.get('jobs');
        List<Job_Application__c> applicationRecords = new List<Job_Application__c>();
        Map<String,String> idToCompanyName = new Map<String, String>();
            if(!applications.isEmpty()) {
                for(Object applicationItem : applications) {
                    Map<String,Object> applicationMap = (Map<String,Object>) applicationItem;
                    Job_Application__c applicationRecord = new Job_Application__c();
                    String externalId = String.valueOf(applicationMap.get('id'));
                    applicationRecord.External_Id__c = externalId;
                    applicationRecord.Name = String.valueOf(applicationMap.get('title'));
                    applicationRecord.Position_Title__c = String.valueOf(applicationMap.get('title'));
                    applicationRecord.URL__c = String.valueOf(applicationMap.get('link'));
                    applicationRecord.Location__c = String.valueOf(applicationMap.get('location'));
                    String salary = String.valueOf(applicationMap.get('salary'));
                    if(salary != null) {
                        applicationRecord.Salary__c = Integer.valueOf(salary);
                    }
                    applicationRecord.Status__c = 'Saved';
                    applicationRecords.add(applicationRecord);
                    //idToCompanyName.put(externalId,String.valueOf(applicationMap.get('company')));
                }
            Database.upsert(applicationRecords,Job_Application__c.External_Id__c);
        }
/*
    List<Job_Application__c> appsWithoutAccounts = [SELECT External_Id__c,Id FROM Job_Application__c WHERE Company_Name__c = '' ];
    System.debug(appsWithoutAccounts);
    Map<Id,Account> appIdToAccountMap = new Map<Id,Account>();
    List<Account> accountsToCreate = new List<Account>();
    for (Job_Application__c application : appsWithoutAccounts) {
            Account acc = new Account(Name = idToCompanyName.get(application.External_Id__c));
            appIdToAccountMap.put(application.Id,acc);
            accountsToCreate.add(acc);
        }
    insert accountsToCreate;
    System.debug(accountsToCreate);
    
    List<Job_Application__c> appsToUpdate = new List<Job_Application__c>();
    for(Job_Application__c application : appsWithoutAccounts) {
        application.Company_Name__c = appIdToAccountMap.get(application.Id).Id;
        appsToUpdate.add(application);
    }
    update appsToUpdate;
    */
}

    @future(callout = true)
    public static void getJobs() {
        Map<String,String> keywordMap = new Map<String,String>();
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL. Use direct URL or for best practices use Named Credential.
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
            createApplicationsFromJson(responseBody);
        }

    }

}