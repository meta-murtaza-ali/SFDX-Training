trigger PopulatesMyCounts on Student__c (after insert,before update,after update) {
     List<Class__c> clas = new List<Class__c>();
    if(Trigger.isInsert){
        for(Class__c cla : [SELECT My_Count__c FROM Class__c WHERE id IN (SELECT Class__c FROM Student__c WHERE id IN:Trigger.New)]){
            if(cla.My_Count__c==null){
                cla.My_Count__c=1;
            }else{
              cla.My_Count__c++; 
            }
            clas.add(cla);        
        }   
    }
    else if(Trigger.isUpdate){
        if(Trigger.isBefore){
            for(Class__c cla : [SELECT My_Count__c FROM Class__c WHERE id IN (SELECT Class__c FROM Student__c WHERE id IN:Trigger.old)]){
                cla.My_Count__c--;
          		clas.add(cla);
            }
        }
        if(Trigger.isAfter){
          for(Class__c cla : [SELECT My_Count__c FROM Class__c WHERE id IN (SELECT Class__c FROM Student__c WHERE id IN:Trigger.New)]){
                cla.My_Count__c++;
          		clas.add(cla);
            }  
        }
    }
    upsert clas;

}