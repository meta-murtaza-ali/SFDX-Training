@isTest
public class TestApexBasicAssignment {
    @isTest static void testGetStudentList(){
        Class__c cls1 = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='New',Max_Size__c=5);
        insert cls1;
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        insert std1;
        insert std2;
        List<Student__c> stdList = ApexBasicAssignment.getStudentsList(cls1.Name);
        System.assertEquals(2, stdList.size());
    }
    
    @isTest static void testmapClassAndStudents(){
        Class__c cls1 = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='New',Max_Size__c=5);
        insert cls1;
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        insert std1;
        insert std2;
        Map<String,List<Student__c>> listOfStudent = ApexBasicAssignment.mapClassAndStudents();
        System.assertEquals(1,listOfStudent.size());
    }
    
    @isTest static void testGetAllObjects(){
        List<String> sObjectList = ApexBasicAssignment.GetAllsObject();
        System.assertEquals(614,sObjectList.size());
    }
    
    @isTest static void testdaysBetweenExcludingWeekends(){
        Integer numOfDays = ApexBasicAssignment.daysBetweenExcludingWeekends(Date.newInstance(2019, 11, 11), Date.newInstance(2019, 11, 16));
        System.assertEquals(4, numOfDays);
    }
}