trigger TeacherTrigger on Contact (before update) {
    TeacherManager.beforeUpdateTeacher(Trigger.New);
}
