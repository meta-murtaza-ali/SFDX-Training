public class TeacherManager {
    public static List<Contact> beforeUpdateTeacher(List<Contact> triggerNew){
        Map<Id,Contact> teacherList = new Map<Id,Contact>([SELECT id FROM Contact WHERE id IN (SELECT Teacher__c FROM Teach__c WHERE Subject__c INCLUDES('Hindi')) AND id IN : triggerNew]);
        if(teacherList.size()>0){
            for(Contact teacher : triggerNew){
                if(teacherList.get(teacher.Id)!=null){
                    teacher.addError('NOT Allowed.');
                }
            }
        }
        return triggerNew;
    }
}