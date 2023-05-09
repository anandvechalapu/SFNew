Apex Class:

public with sharing class EditStudentRecordController {

    //Declare student SObject
    public Student__c student {get; set;}
    
    //Declare a map to hold the errors
    public Map<String, String> errors {get; set;}

    //Declare a boolean to track if the record is valid
    public Boolean isValid {get; set;}

    //Constructor
    public EditStudentRecordController(){
        //Instantiate the student object
        student = new Student__c();
        //Instantiate the errors map
        errors = new Map<String, String>();
        //Set isValid to true initially
        isValid = true;
    }

    //Method to handle the record update
    @AuraEnabled
    public void updateRecord(){
        //Perform any validation checks
        validateRecord();

        //If the record is valid
        if(isValid){
            //Try to update the record
            try{
                //Update the student record
                update student;
            }
            //Catch any exceptions
            catch(DmlException ex){
                //Set isValid to false
                isValid = false;
                //Add the error to the errors map
                errors.put('error', ex.getMessage());
            }
        }
    }

    //Method to perform any validation checks
    private void validateRecord(){
        //Check if the student name is blank
        if(String.isBlank(student.Name)){
            //Set isValid to false
            isValid = false;
            //Add the error to the errors map
            errors.put('nameError', 'The student name cannot be blank');
        }

        //Check if the student ID is blank
        if(String.isBlank(student.Student_ID__c)){
            //Set isValid to false
            isValid = false;
            //Add the error to the errors map
            errors.put('idError', 'The student ID cannot be blank');
        }

        //Check if the student grade is blank
        if(String.isBlank(student.Grade__c)){
            //Set isValid to false
            isValid = false;
            //Add the error to the errors map
            errors.put('gradeError', 'The student grade cannot be blank');
        }
    }
}