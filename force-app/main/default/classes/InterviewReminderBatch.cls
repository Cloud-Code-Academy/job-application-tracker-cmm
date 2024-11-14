public class InterviewReminderBatch implements Database.Batchable<SObject>, Schedulable {
    private static final Integer Days_Before_Interview = 1;
    public Database.QueryLocator start(Database.BatchableContext context){
    // Query products with expiry dates in the next 3 days
            Date tomorrow = Date.today().addDays(Days_Before_Interview);
            String subject = 'Interview';
            String query = 'SELECT ActivityDate, WhoId, RelatedTo, Owner, WhatId FROM Event ' +
                           + 'WHERE ActivityDate.date() = :tomorrow';
    return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext context, List<Event> interviews){
            List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
    
            for(Event interview : interviews){
    // Create an email message for each interview
                String[] toAddresses;
                toAddresses.add(interview.WhoId);            
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(toAddresses);
                email.setSubject('Interview Reminder');
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