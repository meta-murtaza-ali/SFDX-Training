trigger ClassTrigger on Class__c (before delete,after update) {
    if(trigger.isDelete){
        if(trigger.isBefore){
            ClassManager.beforeDeleteClass();
        }
    }else if(trigger.isAfter){
        if(trigger.isUpdate){
            ClassManager.afterUpdateDeleteStudent(Trigger.New,Trigger.oldMap);
        }
            
    }
}
