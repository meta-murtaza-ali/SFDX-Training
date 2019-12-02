trigger TeacherTrigger on Contact (before update) {
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            TeacherManager.beforeUpdateTeacher(Trigger.New);
        }
    }
}
