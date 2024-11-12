trigger JobApplicationTrigger on Job_Application__c (after insert, after update) {
    System.debug('Trigger executed');
    JobApplicationTriggerHandler handler = new JobApplicationTriggerHandler();
    handler.run();
    }
