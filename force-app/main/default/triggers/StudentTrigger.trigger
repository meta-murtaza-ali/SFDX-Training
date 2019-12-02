trigger StudentTrigger on Student__c (before insert) {
    if(trigger.isInsert){
        if(trigger.isBefore){
            StudentManager.beforeInsertStudent(Trigger.New);
        }else if(trigger.isAfter){
            StudentManager.afterUpdateInsertStudent(Trigger.New,null);
        }
    }else if(trigger.isUpdate){
        if(trigger.isAfter){
            StudentManager.afterUpdateInsertStudent(Trigger.New,Trigger.oldMap);
        }
    }

}
