trigger ClassTrigger on Class__c (before delete,after update) {
    if(Trigger.isDelete){
        if(Trigger.isBefore){
            ClassManager.beforeDeleteClass(Trigger.old);
        }
    }else if(Trigger.isAfter){
        if(Trigger.isUpdate){
            ClassManager.afterUpdateDeleteStudent(Trigger.New,Trigger.oldMap);
        }
            
    }
}
