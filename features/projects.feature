# Author: Silvia Valencia

@projects
Feature: Projects API methods
Project holds a number of items. Every Item in the system belongs to a Project. If an Item doesn’t have a Project assigned to it, it only displayed in the Inbox. Projects can be in hierarchy containing other projects.

The feature file will tests CRUD scenarios for Projects

Background:
Given I have set a connection to application

#************************************************************
# GET Scenarios
#************************************************************
Scenario: Verify the project information can be retrieved (GET)
Given I send a POST request to "/projects.json" with json
  """
    {
        "Content": "GET Test",
        "Icon": 4
    }
  """
When I send a GET request to "/projects/" in json format
Then the HTTP status code should be 200
    And the JSON response at "Content" should be "GET Test"
    And the JSON response at "ItemsCount" should be 0
    And the JSON response at "Icon" should be 4
    And the JSON response at "ItemType" should be 2
    And the JSON response at "ParentId" should be null
    And the JSON response at "Collapsed" should be false
    And the JSON response at "Children" should be []


#************************************************************
# POST Scenarios
#************************************************************
Scenario: Verify create project with valid name (POST)
Given I send a POST request to "/projects.json" with json
  """
    {
        "Content": "POST Test",
        "Icon": 4
    }
  """
Then the HTTP status code should be 200
    And the JSON response at "Content" should be "POST Test"
    And the JSON response at "ItemsCount" should be 0    
    And the JSON response at "Icon" should be 4
    And the JSON response at "ItemType" should be 2
    And the JSON response at "ParentId" should be null
    And the JSON response at "Collapsed" should be false
    And the JSON response at "Children" should be []


Scenario: Verify create project with empty name (POST Negative)
Given I send a POST request to "/projects.json" with json
  """
    {
        "Content": "",
        "Icon": 4
    }
  """
Then the HTTP status code should be 200
  And JSON should be equal to
    """  
		{
		  "ErrorMessage": "Too Short Project Name",
		  "ErrorCode": 305
		}
	"""

#************************************************************
# PUT Scenarios
#************************************************************
Scenario: Verify update project with valid name (PUT)
Given I send a POST request to "/projects.json" with json
  """
    {
        "Content": "PUT Test",
        "Icon": 4,
        "Collapsed": true
    }
  """
When I send a PUT request to "/projects/" with json format
  """
    {
        "Content": "PUT Test Updated",
        "Icon": 5,
        "Collapsed": false
    }
  """
Then the HTTP status code should be 200
    And the JSON response at "Content" should be "PUT Test Updated"
    And the JSON response at "Icon" should be 5
    And the JSON response at "Collapsed" should be false



Scenario: Verify update project with empty name (PUT negative)
Given I send a POST request to "/projects.json" with json
  """
    {
        "Content": "PUT Test",
        "Icon": 4,
        "Collapsed": true
    }
  """
When I send a PUT request to "/projects/" with json format
  """
    {
        "Content": "",
        "Icon": 4,
        "Collapsed": false
    }
  """
Then the HTTP status code should be 200
  And JSON should be equal to
    """  
		{
		  "ErrorMessage": "Too Short Project Name",
		  "ErrorCode": 305
		}
	"""
#There is bug: Status returned 500 Internal Server Error when sending a text as Icon, and no error for empty Content


#************************************************************
# DELETE Scenarios
#************************************************************
Scenario: Verify delete project (DELETE)
Given I send a POST request to "/projects.json" with json
  """
    {
        "Content": "DELETE Test",
        "Icon": 2
    }
  """
Then the HTTP status code should be 200
    And the JSON response at "Content" should be "DELETE Test"
    And the JSON response at "ItemsCount" should be 0
    And the JSON response at "Icon" should be 2
    And the JSON response at "ItemType" should be 2
    And the JSON response at "ParentId" should be null
	And the JSON response at "Collapsed" should be false    
    And the JSON response at "Children" should be []  


Scenario: Verify delete project (DELETE)
Given I send a POST request to "/projects.json" with json
  """
    {
        "Content": "DELETE Test",
        "Icon": 2
    }
  """
Then the HTTP status code should be 200
    And the JSON response at "Content" should be "DELETE Test"
    And the JSON response at "ItemsCount" should be 0
    And the JSON response at "Icon" should be 2
    And the JSON response at "ItemType" should be 2
    And the JSON response at "ParentId" should be null
	And the JSON response at "Collapsed" should be false    
    And the JSON response at "Children" should be []      