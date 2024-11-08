public class InterviewReminderBatch implements Database.Batchable<SObject>, Schedulable {
    private static final Integer Days_Before_Interview = 1;
    public Database.QueryLocator start(Database.BatchableContext context){
    // Query products with expiry dates in the next 3 days
            Date tomorrow = Date.today().addDays(Days_Before_Interview);
            String query = 'SELECT Id, Applicant__c, Interview_Date__c FROM Applicant__c ' +
                           'WHERE Expiry_Date__c = :tomorrow';
    return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext context, List<Interview__c> interviews){
            List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
    
            for(Interview__c interview : interviews){
    // Create an email message for each interview
                String[] toAddresses;
                toAddresses.add(interview.Applicant__r.Email);            
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(toAddresses);
                email.setSubject('Product Expiry Reminder');
                email.setPlainTextBody('Test');
                emailsToSend.add(email);
    }
    // Send the emails
            Messaging.sendEmail(emailsToSend);
    }

    public void finish(Database.BatchableContext context){
        // Perform any post-processing logic if needed
        }

    public void execute(SchedulableContext context){
    // Implement the scheduling logic here
            InterviewReminderBatch batchJob = new InterviewReminderBatch();
            Database.executeBatch(batchJob);
    }
    }