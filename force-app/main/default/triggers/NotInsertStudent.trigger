trigger NotInsertStudent on Student__c (before insert) {
    for(Student__c student:Trigger.New){
        Class__c cla = [SELECT Max_Size__c,Number_Of_Students__c FROM Class__c WHERE ID=:student.Class__c];
        if(cla.Max_Size__c == cla.Number_Of_Students__c){
            student.addError('Not Insert Student Because Maximium Limit is Reach.');
        }
    }
}