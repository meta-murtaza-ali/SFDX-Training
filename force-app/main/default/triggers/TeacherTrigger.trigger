trigger TeacherTrigger on Contact (before update) {
    if(trigger.isUpdate){
        if(trigger.isBefore){
            TeacherManager.beforeUpdateTeacher(Trigger.New);
        }
    }
}