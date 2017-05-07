@api_test
Feature: Test API create user

Scenario: Validate invalid email

Given I have set a connection to application
When I send a POST request to /user.json with json
"""
    {
  		"UserObject": {
    		"Email": "use123r@email.com",
    		"FullName": "Joe Blow",
    		"Password": "pASswoRd"
	 	}
	}
"""

Then I expect HTTP code 200
	And I expect JSON equal to
	      """
	      {
	       "ErrorMessage": "Invalid Email Address",
	       "ErrorCode": 307
	      }
	      """ 

Scenario: Get user
Given I have set a connection to application
When I send a GET request to /user.json
Then I expect HTTP code 200
    And I expect JSON equal to
      """
      {
  	    "Id": 548715,
        "Email": "yesica.7887@gmail.com",
        "Password": null,
        "FullName": "Adriana Acha",
        "TimeZone": 0,
        "IsProUser": false,
        "DefaultProjectId": 3421494,
        "AddItemMoreExpanded": false,
        "EditDueDateMoreExpanded": false,
        "ListSortType": 0,
        "FirstDayOfWeek": 0,
        "NewTaskDueDate": -1,
        "TimeZoneId": "Pacific Standard Time"
      }
      """