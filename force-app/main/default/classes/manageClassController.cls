public class manageClassController {
    public Id classId{get;set;}
    public Class__c selectedClass{get;set;}
    public boolean Render{get;set;}
   
    public manageClassController(){
        Render = false;
    }
    public List<Class__c> getClasses(){
       List<Class__c> classes = [Select Name,Class_Teacher__r.Name,Max_Size__c,Number_Of_Students__c from class__c];
        return classes;
    }
    public void editClasses(){
        selectedClass = [Select Name,Class_Teacher__r.Name,Max_Size__c,Number_Of_Students__c from class__c where Id=:classId];
        render= true;
    }
   
    public void deleteClass(){
        selectedClass = [Select Name,Class_Teacher__r.Name,Max_Size__c,Number_Of_Students__c from class__c where Id=:classId];
        render=false;
        delete selectedClass;
    }
   
    public void updateClass(){
        update selectedClass;
        render=false;
    }
   
}