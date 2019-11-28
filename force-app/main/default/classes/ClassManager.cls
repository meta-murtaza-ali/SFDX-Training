public class ClassManager {
    public static List<Class__c> beforeDeleteClass()
    {
        List<Class__c> cla = [SELECT id,(SELECT id FROM Students__r WHERE Sex__c='FEMALE')  FROM Class__c WHERE id IN :Trigger.old];
        for(Class__c c:cla)
        {
            if(c.Students__r.size() > 1)
            {
                Trigger.oldMap.get(c.Id).addError(
                    'Cannot delete Class Because there are more than 1 Female Student.');
            }
            
        }
        return cla;
    }
    
    public static List<Class__c> afterUpdateDeleteStudent(List<Class__c> triggerNew,Map<Id,Class__c> triggerOldMap){
        List<Student__c> deleteStudents = new List<Student__c>();   
        for(Class__c classRecord : triggerNew){
            if(triggerOldMap.get(classRecord.Id).Custom_Status__c !='Reset' && classRecord.Custom_Status__c=='Reset' ){
                for(Student__c studentRecord : [SELECT id FROM Student__c WHERE Class__c=:classRecord.Id]){
                    deleteStudents.add(studentRecord);
                }
            }
        }  
        if(deleteStudents.size()>0){
            delete deleteStudents;
        }
        return triggerNew;
        
    }
}