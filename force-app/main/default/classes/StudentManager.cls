public class StudentManager {
    public static List<Student__c> beforeInsertStudent(List<Student__c> triggerNew){
        List<Id> classId = new List<Id>();
    for(Student__c student : triggerNew){
        classId.add(student.class__c);
    }
    Map<Id,Decimal> count = new Map<Id,Decimal>();
    Map<Id,Class__c> record = new Map<Id,Class__c>([SELECT Name,Max_Size__c,Number_Of_Students__c FROM Class__c WHERE Id=:classId]);
    for(Student__c std : triggerNew)
    {
        Class__c clas = record.get(std.class__c);
        Decimal numberOfStudent = clas.Number_Of_Students__c;
        Decimal maxSize = clas.Max_Size__c;
        count.put(clas.Id, numberOfStudent);
        if((count.get(clas.Id) + 1) > maxSize)
        {
            std.addError('Not Insert Student Because Maximium Limit is Reach.');
        }
        else
        {
            count.put(clas.Id,numberOfStudent+1);
        }
    }
        return triggerNew;
    }
    
    public static void afterUpdateInsertStudent(List<Student__c> triggerNew,Map<Id,Student__c> triggerOldMap){
      Set<Id> classId = new Set<Id>();
    for(Student__c stu : triggerNew){
        classId.add(Stu.class__c);
    }
    if(Trigger.IsUpdate){
        for(Student__c stu : triggerOldMap.values()){
            classId.add(Stu.class__c);
        }
    }
    
    Map<Id, Class__c> classMap = new Map<Id, Class__c>([SELECT Id, My_Count__c FROM Class__c WHERE Id In :classId]);
	if(Trigger.isInsert) {
       for(Student__c student : triggerNew) {
       		Class__c classSelected = classMap.get(student.Class__c);
       		classSelected.My_Count__c = classSelected.My_Count__c == null ? 1 : classSelected.My_Count__c+1;
            classMap.put(classSelected.Id, classSelected);
       }
    }
    else if(Trigger.isUpdate){
        for(Student__c student : triggerNew) {
            if(student.class__c != triggerOldMap.get(student.Id).class__c) {
             	Class__c classSelected = classMap.get(student.Class__c);  
                classSelected.My_Count__c = classSelected.My_Count__c == null ? 1 : classSelected.My_Count__c+1;
                classMap.put(classSelected.Id, classSelected);
                classSelected = classMap.get(triggerOldMap.get(student.Id).class__c);
                classSelected.My_Count__c = classSelected.My_Count__c == null ? 0 : (classSelected.My_Count__c > 0 ? classSelected.My_Count__c-1 : 0);
                classMap.put(classSelected.Id, classSelected);
            }
        }
    }
    update classMap.values();  
    }
}