/**
 * Email On Changing Stage Of Opportunity.
 */
public class EmailOnChangingOpportunity {
    // Send Email Notification.
    public static void sendEmailNotification(List<Opportunity> opportunityObj){
        EmailTemplate emailTemplate = [SELECT Id FROM EmailTemplate WHERE Name = 'Opportunity Change'];
        Map<Id,User> mapOfOppAndEmail = new Map<Id,User>([SELECT email FROM user WHERE id IN (SELECT ownerId FROM opportunity WHERE id IN :opportunityObj)]);
        Messaging.SingleEmailMessage [] emails = new Messaging.SingleEmailMessage[]{};
            for(Opportunity oppObj :opportunityObj){
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.setTemplateID(emailTemplate.Id); 
                //message.setWhatId(oppObj.StageName); 
                message.setTargetObjectId(oppObj.OwnerId); 
                message.setSenderDisplayName('Company Support'); 
                message.setReplyTo('no-reply@company.com');
                message.setUseSignature(false); 
                message.setBccSender(false); 
                message.setSaveAsActivity(false);
                message.setToAddresses(new List<String> {mapOfOppAndEmail.get(oppObj.OwnerId).Email });
                emails.add(message);
            }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
        
        if (results[0].success) 
        {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' +  results[0].errors[0].message);
        }
    }
}