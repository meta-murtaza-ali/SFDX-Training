@isTest(seealldata=false)
public class TestDeleteStudents {
    @isTest static void testPositive(){
        Class__c cls = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='New');
        insert cls;
        List<Student__c> studnt = new List<Student__c>();
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        studnt.add(std1);
        studnt.add(std2);
        insert studnt;
        Class__c clss = [SELECT Custom_Status__c FROM Class__c WHERE id=:cls.Id];
        clss.Custom_Status__c = 'Reset';
        update(clss);
        Class__c clas = [SELECT Number_Of_Students__c FROM Class__c WHERE id=:cls.id];
        System.assertEquals(0, clas.Number_Of_Students__c);
    }
    
    @isTest static void testNegative(){
        Class__c cls = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='Reset');
        insert cls;
        List<Student__c> studnt = new List<Student__c>();
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        studnt.add(std1);
        studnt.add(std2);
        insert studnt;
        Class__c clss = [SELECT Custom_Status__c,Name FROM Class__c WHERE id=:cls.Id];
        clss.Name = 'NKG';
        update(clss);
        Class__c clas = [SELECT Number_Of_Students__c FROM Class__c WHERE id=:cls.id];
        System.assertEquals(2, clas.Number_Of_Students__c);
    }
}