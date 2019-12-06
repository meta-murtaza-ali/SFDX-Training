public class ApexBasicAssignment {
    public static List<Student__c> getStudentsList(String className){
        List<Student__c> studentList = new List<Student__c>(); 
        if(String.isNotBlank(className)){
            try{
                studentList = [SELECT Name FROM Student__c WHERE Class__r.Name =: className];
            }
            catch(Exception e){
                studentList = null;
            }
        }
        return studentList;
    }
    
    
    public static Map<String,List<Student__c>> mapClassAndStudents(){
        Map<String,List<Student__c>>classAndStudents = new Map<String,List<Student__c>>();
        List<Class__c>  listClass = [SELECT Name FROM Class__c];
        List<List<Student__c>> studentsId = new List<List<Student__c>>();
        for(Integer i=0; i < listClass.size(); i++){
            studentsId.add([SELECT Id ,Name FROM Student__c WHERE Class__r.Name =: listClass.get(i).Name]);
            classAndStudents.put(listClass.get(i).Name, studentsId.get(i));          
        }
        return classAndStudents;
    }
    
    public static Integer daysBetweenExcludingWeekends(DateTime startDate, DateTime endDate) {
        Integer numberOfDays = 0;
        if(startDate!=null && endDate!=null){
        if(startDate > endDate){
            DateTime temDate = endDate;
            endDate = startDate;
            startDate = temDate;
        }
        startDate = startDate.addDays(1);
        while (startDate < endDate) {
            if (startDate.formatGmt('E') != 'Sat' && startDate.formatGmt('E') != 'Sun') {
                numberOfDays++;
            }
            startDate = startDate.addDays(1);
        }
        }
        return numberOfDays;
    }
    
    public static List<String> GetAllsObject(){
        List<string> SObjectList = new List<string>();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            String name = objTyp.getDescribe().getName();
            SobjectList.add(name);
        }
        return SobjectList;
    }
}