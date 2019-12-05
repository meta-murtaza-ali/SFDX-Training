@isTest
private class TestApexBasicAssignment {
    private static String testDataSetup(){
        List<Student__c> studList = new List<Student__c>();
        Class__c cls1 = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='New',Max_Size__c=5);
        insert cls1;
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        studList.add(std1);
        studList.add(std2);
        insert studList;
        return cls1.Name;
    }
    @isTest static void testGetStudentList_WithClassName(){
        String className = testDataSetup();
        List<Student__c> stdList = ApexBasicAssignment.getStudentsList(className);
        System.assertEquals(2, stdList.size(),'The Student Size must be 2');
    }
    @isTest static void testGetStudentList_WithEmptyClass(){
        List<Student__c> stdList = ApexBasicAssignment.getStudentsList('');
        System.assertNotEquals(null, stdList,'Student List size must be null');
        System.assertEquals(0, stdList.size(),'Student List size must be 0');
    }
    @isTest static void testmapClassAndStudents_WithRecords(){
        testDataSetup();
        Map<String,List<Student__c>> mapOfStudents = ApexBasicAssignment.mapClassAndStudents();
        System.assertEquals(1,mapOfStudents.size());
    }
    @isTest static void testmapClassAndStudents_WithoutRecords(){
        Map<String,List<Student__c>> mapOfStudents = ApexBasicAssignment.mapClassAndStudents();
        System.assertEquals(0,mapOfStudents.size());
    }
    @isTest static void testGetAllObjects(){
        List<String> sObjectList = ApexBasicAssignment.GetAllsObject();
        System.assertNotEquals(null,sObjectList);
        System.assertEquals(true,sObjectList.size()>0);  
    }
    
    @isTest static void testdaysBetweenExcludingWeekends_WithDatesHavingWeekends(){
        Integer numOfDays = ApexBasicAssignment.daysBetweenExcludingWeekends(Date.newInstance(2019, 12, 05), Date.newInstance(2019, 12, 10));
        System.assertEquals(2, numOfDays);
    }
    @isTest static void testdaysBetweenExcludingWeekends_WithoutDates(){
        Integer numOfDays = ApexBasicAssignment.daysBetweenExcludingWeekends(null, null);
        System.assertEquals(0, numOfDays);
    }
    @isTest static void testdaysBetweenExcludingWeekends_WithDatesWithoutWeekends(){
        Integer numOfDays = ApexBasicAssignment.daysBetweenExcludingWeekends(Date.newInstance(2019, 12, 13), Date.newInstance(2019, 12, 09));
        System.assertEquals(3, numOfDays);
    }
}