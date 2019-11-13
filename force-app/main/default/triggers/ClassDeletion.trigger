trigger ClassDeletion on Class__c (before delete) {
    List<Class__c>cla = [SELECT id,(SELECT id FROM Students__r WHERE Sex__c='FEMALE')  FROM Class__c WHERE id IN :Trigger.old];
    for(Class__c c:cla){
        if(c.Students__r.size() > 1){
            Trigger.oldMap.get(c.Id).addError(
            'Cannot delete Class Because there are more than 1 Female Student.');
    }
        }
    
    }