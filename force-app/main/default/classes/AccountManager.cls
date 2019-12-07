public class AccountManager {
    public static void accountTriggerOnBeforeUpdate(List<Account> triggerNew,Boolean isDelete){
        List<Opportunity> opptysClosedLostWon = [SELECT id, name, closedate, stagename FROM Opportunity
                                                 WHERE accountId IN :triggerNew and (StageName='Closed Lost' OR StageName='Closed Won')];
        for(Opportunity oppObj : opptysClosedLostWon){
            if(oppObj.StageName == 'Closed Lost'){
                System.debug('Do Some Logic Here...');
            }else if(oppObj.StageName == 'Closed Won'){
                System.debug('Do Some Logic Here...');
            }
            
        }
        if(!isDelete){
            List<Contact> contacts = [SELECT id, salutation, firstname, lastname
                                      FROM Contact WHERE accountId IN :triggerNew];    
            for(Contact c: contacts) {
                System.debug('Contact Id[' + c.Id + '], FirstName[' + c.firstname + '],LastName[' + c.lastname +']');
                c.Description=c.salutation + ' ' + c.firstName + ' ' + c.lastname;
            }
            update contacts;
        }
    }
    
    public static void accountTriggerOnAfterUpdateInertDelete(List<Account> triggerNew){
        System.debug('Total Number of SOQL Queries allowed in this Apex code context: ' + Limits.getLimitQueries());
        
        System.debug('Total Number of records that can be queried in this Apex code context: ' +  Limits.getLimitDmlRows());
        
        System.debug('Total Number of DML statements allowed in this Apex code context: ' +  Limits.getLimitDmlStatements());
        
        System.debug('Total Number of CPU usage time (in ms) allowed in this Apex code context: ' + Limits.getLimitCpuTime());
        
        // Query the Opportunity object
        
        List<Opportunity> opptys =
            
            [SELECT id, description, name, accountid, closedate, stagename FROM Opportunity WHERE accountId IN:
             triggerNew];
        
        
        System.debug('1. Number of Queries used in this Apex code so far: ' + Limits.getQueries());
        
        System.debug('2. Number of rows queried in this Apex code so far: ' + Limits.getDmlRows());
        
        System.debug('3. Number of DML statements used so far: ' + Limits.getDmlStatements());
        
        System.debug('4. Amount of CPU time (in ms) used so far: ' + Limits.getCpuTime());
        
        //Proactively determine if there are too many Opportunities to update and avoid governor limits
        
        if(Limits.getQueryRows()>Limits.getLimitDMLRows()) {
            
            throw new System.LimitException('Too Many Rows');
            
        }
        else{
            
            System.debug('Continue processing. Not going to hit DML governor limits');
            
            System.debug('Going to update ' + opptys.size() + ' opportunities and governor limits will allow ' + Limits.getLimitDmlStatements() );
            
            System.debug('Number of DML statements used so far: ' + Limits.getDmlStatements());            
            for(Opportunity o: opptys){                
                o.description = 'testing';            
            }    
            
            update opptys;
            
            System.debug('Final number of DML statements used so far: ' + Limits.getDmlStatements());
            
            System.debug('Final heap size: ' + Limits.getHeapSize());
            
        }
    }
}