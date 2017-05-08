# Author: Yesica Acha

@api_test @users
Feature: Test User API methods
User Object stores basic information of the User itself, and some settings that closely belongs to the user like Timezone.
User API Methods
  * Create User
  * Get User
  * Update User
  * Delete User

Background:
Given I have set a connection to application

#=============================================
# Create User scenarios
#=============================================

@delete_user
Scenario: Validates create user with valid required information
When I send a POST request to "/user.json" to create a new user with json
  """
    {
        "Email": "test.user.todoly2@gmail.com",
        "FullName": "Test User",
        "Password": "Control123"
    }
  """
  And I keep the JSON response at "Id" as "USER_ID"
  And I keep the JSON response at "DefaultProjectId" as "DEFAULT_PROJECT_ID"
Then the HTTP status code should be 200
  And the JSON response should be:
      """
        {
          "Id": %{USER_ID},
          "Email": "test.user.todoly2@gmail.com",
          "Password": null,
          "FullName": "Test User",
          "TimeZone": 0,
          "IsProUser": false,
          "DefaultProjectId": %{DEFAULT_PROJECT_ID},
          "AddItemMoreExpanded": false,
          "EditDueDateMoreExpanded": false,
          "ListSortType": 0,
          "FirstDayOfWeek": 0,
          "NewTaskDueDate": -1,
          "TimeZoneId": "Pacific Standard Time"
        }
      """

Scenario: Validates create user with invalid email
When I send a POST request to "/user.json" with json
  """
    {
        "Email": "use123r.com",
        "FullName": "Joe Blow",
        "Password": "pASswoRd"
    }
  """
Then the HTTP status code should be 200
  And JSON should be equal to
    """
      {
        "ErrorMessage": "Invalid Email Address",
        "ErrorCode": 307
      }
    """ 

#=============================================
# Get User scenarios
#=============================================

Scenario: Validates get extended information of a current authenticated user
When I send a GET request to "/user.json"
Then the HTTP status code should be 200
    And JSON should be equal to
      """
      {
        "Id": 588382,
        "Email": "test.user.todoly@gmail.com",
        "Password": null,
        "FullName": "Test User",
        "TimeZone": 0,
        "IsProUser": false,
        "DefaultProjectId": 3647032,
        "AddItemMoreExpanded": false,
        "EditDueDateMoreExpanded": false,
        "ListSortType": 0,
        "FirstDayOfWeek": 0,
        "NewTaskDueDate": -1,
        "TimeZoneId": "Pacific Standard Time"
      }
      """

#=============================================
# Update User scenarios
#=============================================
@delete_user
Scenario: Validates updates the current authenticated user based on the input parameters
Given I sent a POST request to "/user.json" to create a new user with json
  """
    {
        "Email": "user.to.update@gmail.com",
        "FullName": "User to Update",
        "Password": "Control123"
    }
  """
When I send a PUT request to "/user/0.json" with json
  """
    {
      "FullName": "New user fullname",
      "TimeZoneId": "Venezuela Standard Time"
    }
  """
  And I keep the JSON response at "Id" as "USER_ID"
  And I keep the JSON response at "DefaultProjectId" as "DEFAULT_PROJECT_ID"
Then the HTTP status code should be 200
  And the JSON response should be:
      """
        {
          "Id": %{USER_ID},
          "Email": "user.to.update@gmail.com",
          "Password": null,
          "FullName": "New user fullname",
          "TimeZone": 0,
          "IsProUser": false,
          "DefaultProjectId": %{DEFAULT_PROJECT_ID},
          "AddItemMoreExpanded": false,
          "EditDueDateMoreExpanded": false,
          "ListSortType": 0,
          "FirstDayOfWeek": 0,
          "NewTaskDueDate": -1,
          "TimeZoneId": "Venezuela Standard Time"
        }
      """

@delete_user
Scenario: Validates update the current authenticated user with invalid input data
Given I sent a POST request to "/user.json" to create a new user with json
  """
    {
        "Email": "user.to.update@gmail.com",
        "FullName": "User to Update",
        "Password": "Control123"
    }
  """
When I send a PUT request to "/user/0.json" with json
  """
    {
      "Email": "New user fullname"
    }
  """
Then the HTTP status code should be 200
  And the JSON response should be:
      """
        {
          "ErrorMessage": "Invalid input Data",
          "ErrorCode": 302
        }
      """



#=============================================
# Delete User scenarios
#=============================================
Scenario: Validates deletes the current authenticated user
Given I sent a POST request to "/user.json" to create a new user with json
  """
    {
        "Email": "user.to.delete@gmail.com",
        "FullName": "User to Delete",
        "Password": "Control123"
    }
  """
When I send a DELETE request to "/user/0.json"
  And I keep the JSON response at "Id" as "USER_ID"
  And I keep the JSON response at "DefaultProjectId" as "DEFAULT_PROJECT_ID"
Then the HTTP status code should be 200
  And the JSON response should be:
      """
        {
          "Id": %{USER_ID},
          "Email": "user.to.delete@gmail.com",
          "Password": null,
          "FullName": "User to Delete",
          "TimeZone": 0,
          "IsProUser": false,
          "DefaultProjectId": %{DEFAULT_PROJECT_ID},
          "AddItemMoreExpanded": false,
          "EditDueDateMoreExpanded": false,
          "ListSortType": 0,
          "FirstDayOfWeek": 0,
          "NewTaskDueDate": -1,
          "TimeZoneId": "Pacific Standard Time"
        }
      """