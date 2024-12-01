trigger JobApplicationTrigger on Job_Application__c (before insert, after insert, after update) {
    System.debug('Trigger executed');
    JobApplicationTriggerHandler handler = new JobApplicationTriggerHandler();
    handler.run();
    
    if (Trigger.isBefore) {
        // Handle the logic before insert or update
        if (Trigger.isInsert || Trigger.isUpdate) {
            TaxCalculationHandler.calculateTaxesAndTakeHomePay(Trigger.new);
        }
    }

    if (Trigger.isAfter) {
        // Handle the logic after insert or update
        if (Trigger.isInsert || Trigger.isUpdate) {
            System.debug('Trigger executed');
            JobApplicationTriggerHandler handler = new JobApplicationTriggerHandler();
            handler.run();
        }
    }
}