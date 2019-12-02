trigger StudentTrigger on Student__c (before insert,after update,after insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            StudentManager.beforeInsertStudent(Trigger.New);
        }else if(Trigger.isAfter){
            StudentManager.afterUpdateInsertStudent(Trigger.New,null);
        }
    }else if(Trigger.isUpdate){
        if(Trigger.isAfter){
            StudentManager.afterUpdateInsertStudent(Trigger.New,Trigger.oldMap);
        }
    }

}
