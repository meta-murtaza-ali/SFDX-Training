/**
 * ApexBasicAssignment
 */
 
public class ApexBasicAssignment {
    /**
     * This method returns Student List for a particular Class. 
     */
	public static List<Student__c> getStudentsList(String className){
        List<Student__c> studentList = [SELECT Name FROM Student__c WHERE Class__r.Name =: className];
        return studentList;
    }
    /**
     * This method returns Map between Class and related Students.
     */
    public static Map<String,List<Student__c>> mapClassAndStudents(){
        Map<String,List<Student__c>>classAndStudents = new Map<String,List<Student__c>>();
        List<Class__c>  listClass = [SELECT Name FROM Class__c];
        for(Class__c cls : listClass)
		{
            List<Student__c> studentsList = [SELECT Id ,Name FROM Student__c WHERE Class__r.Name =: cls.Name];
            classAndStudents.put(cls.Name, studentsList);          
        }
        return classAndStudents;
    }
    /**
     * This method return working days between given two date.
     */
    public static Integer daysBetweenExcludingWeekends(DateTime startDate, DateTime endDate) {
        Integer numberOfDays = 0;
        while (startDate < endDate) {
            if (startDate.formatGmt('E') != 'Sat' && startDate.formatGmt('E') != 'Sun') {
                System.debug(startDate.formatGmt('E'));
                numberOfDays++;
            }
            startDate = startDate.addDays(1);
        }
        return numberOfDays;
    }
    /**
     * This return list of all schema objects.
     */
    public static List<String> getAllsObject(){
        List<String> SObjectList = new List<String>();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            String name = objTyp.getDescribe().getName();
            SobjectList.add(name);
        }
        return SobjectList;
    }
}