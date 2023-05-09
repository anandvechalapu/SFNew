trigger MobileNumberTrigger on Student__c (before insert) 
{
    List<Id> studentIds = new List<Id>();
    for (Student__c stu :Trigger.new)
    {
        if(stu.Phone != null && stu.Mobile == null){
            studentIds.add(stu.Id);
        }
    }

    Map<Id, Student__c> studentMap = new Map<Id, Student__c> ([SELECT Id, Phone, Mobile FROM Student__c WHERE Id IN :studentIds]);

    for (Student__c stu :Trigger.new)
    {
        if (studentMap.containsKey(stu.Id)){
            stu.Mobile = studentMap.get(stu.Id).Phone;
        }
    }
}