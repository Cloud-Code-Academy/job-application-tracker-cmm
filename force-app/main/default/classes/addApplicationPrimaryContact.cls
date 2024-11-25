public with sharing class addApplicationPrimaryContact {
        public static void addPrimaryContactToJobApplications(List<Job_Application__c> jobApps) {            //Set<Id> accountIds = new Set<Id>();
            Map<Id,Id> appIdToAccountMap = new Map<Id,Id>();
            for (Job_Application__c jobApp : jobApps) {
                if(jobApp.Company_Name__c != null) {
                    appIdToAccountMap.put(jobApp.Id,jobApp.Company_Name__c);
                    }
                }

            List<Contact> contactMap = [SELECT AccountId FROM Contact WHERE AccountId = :appIdToAccountMap.values()];
            
            Map<Id,Contact> acctToContactId = new Map<Id,Contact>();

            for (Contact con : contactMap) {
                if(!acctToContactId.keySet().contains(con.AccountId)) {
                    acctToContactId.put(con.AccountId,con);
                    }
            }

            for (Job_Application__c jobApp : jobApps) {
                if(jobApp.Company_Name__c != null && acctToContactId.containskey(jobApp.Company_Name__r.Id)) {
                   jobApp.Primary_Contact__c = acctToContactId.get(jobApp.Company_Name__r.Id).Id;
            }
        }
    }
}