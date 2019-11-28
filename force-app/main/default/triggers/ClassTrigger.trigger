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
        
    /*List<AggregateResult> stdRecord = [SELECT class__c,count(Name) FROM Student__c WHERE Sex__c = 'FEMALE' Group By class__c Having count(Name)>1];
    for(Class__c classId : Trigger.old){
        if(stdRecord.get ==classId){
            
        }
    }*/
    
    }