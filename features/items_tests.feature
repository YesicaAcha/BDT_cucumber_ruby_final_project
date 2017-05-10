@api_test
Feature: Test API item actions

Scenario: Get an item by ID

Given I have set a connection to application
And I send a POST request to "/items.json" with json
  """       
      {
        "Content":"item_to_get_details"
      }      
  """
When I send a GET request to "/items/" in json format
Then the HTTP status code should be 200
And the JSON response at "Content" should be "item_to_get_details"
And the JSON response at "Checked" should be false

Scenario: Create an item

Given I have set a connection to application
When I send a POST request to "/items.json" with json
  """       
      {
        "Content":"new_item_name"
      }      
  """
Then the HTTP status code should be 200
And the JSON response at "Content" should be "new_item_name"
And the JSON response at "Collapsed" should be false
And the JSON response at "Checked" should be false
And the JSON response at "ProjectId" should be null


Scenario: Update an item

Given I have set a connection to application
And I send a POST request to "/items.json" with json
  """       
      {
        "Content":"item_to_update"
      }      
  """
When I send a PUT request to "/items/" with json format
  """       
      {
        "Content":"item_updated",
        "Checked":true
      }      
  """
Then the HTTP status code should be 200
And the JSON response at "Content" should be "item_updated"
And the JSON response at "Collapsed" should be false
And the JSON response at "Checked" should be true
And the JSON response at "ProjectId" should be null


Scenario: Delete an item

Given I have set a connection to application
And I send a POST request to "/items.json" with json
  """       
      {
        "Content":"item_to_be_deleted"
      }      
  """
When I send a DELETE request to "/items/" in json format
Then the HTTP status code should be 200
And the JSON response at "Content" should be "item_to_be_deleted"
And the JSON response at "Checked" should be false
And the JSON response at "Deleted" should be true

#-----------------------------------------------------------------
# Negative tests
#-----------------------------------------------------------------

Scenario: Create an item with an invalid project id

Given I have set a connection to application
When I send a POST request to "/items.json" with json
  """       
    {
      "Content":"wrong",
      "ProjectId":"456",
      "DueDate":""
    }     
  """
Then the HTTP status code should be 200
  And JSON should be equal to
  """  
    {
      "ErrorMessage": "Invalid Project Id",
      "ErrorCode": 304
    }
  """  


Scenario: Update an item with an invalid Parent Item Id

Given I have set a connection to application
And I send a POST request to "/items.json" with json
  """       
      {
        "Content":"item_to_fail_in_update_action"
      }      
  """
When I send a PUT request to "/items/" with json format
  """       
    {
     "ParentId": 6666,
    }
  """
Then the HTTP status code should be 200
And JSON should be equal to
"""
  {
    "ErrorMessage": "Invalid Parent Item Id",
    "ErrorCode": 303
  }
"""