/*trigger accountTrigger on Account (before update) {
List<Contact> contacts = [SELECT id, salutation, firstname, lastname
FROM Contact WHERE accountId IN :Trigger.new];    
for(Contact c: contacts) {
System.debug('Contact Id[' + c.Id + '], FirstName[' + c.firstname + '],LastName[' + c.lastname +']');
c.Description=c.salutation + ' ' + c.firstName + ' ' + c.lastname;
}
update contacts;
}*/

/*trigger accountTrigger on Account (before delete, before insert, before update) {
    List<Opportunity> opptysClosedLostWon = [SELECT id, name, closedate, stagename FROM Opportunity
                                             WHERE accountId IN :Trigger.newMap.keySet() and (StageName='Closed Lost' OR StageName='Closed Won')];
    for(Opportunity oppObj : opptysClosedLostWon){
        if(oppObj.StageName == 'Closed Lost'){
            System.debug('Do Some Logic Here...');
        }else if(oppObj.StageName == 'Closed Won'){
            System.debug('Do Some Logic Here...');
        }
        
    }
}*/
trigger accountTrigger on Account (before insert,before update,before delete,after delete, after insert, after update) {
    if(Trigger.isBefore){
        if(Trigger.isUpdate || Trigger.isInsert){
            AccountManager.accountTriggerOnBeforeUpdate(Trigger.New,false);
        }
        else if(Trigger.isDelete){
            AccountManager.accountTriggerOnBeforeUpdate(Trigger.old,true);
        }
    }
    if(Trigger.isAfter){
        AccountManager.accountTriggerOnAfterUpdateInertDelete(Trigger.isDelete?Trigger.old:Trigger.New);
    }    
}