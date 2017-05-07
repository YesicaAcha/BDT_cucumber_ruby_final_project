@api_test
Feature: Test API item actions

Scenario: Get an item by ID

Given I have set a connection to application
When I send a GET request to /items/9874451.json
Then I expect HTTP code 200
#falta verificacion


Scenario: Create an item

Given I have set a connection to application
When I send a POST request to /items.json with json
  """       
      {
      	"Content":"new_item_name"
      }      
  """
Then I expect HTTP code 200
#falta verificacion


Scenario: Update an item

Given I have set a connection to application
When I send a PUT request to /items/9874451.json with json
  """       
      {
      	"Content":"item_name_UPDATED"
      }      
  """
Then I expect HTTP code 200
#falta verificacion


Scenario: Delete an item

Given I have set a connection to application
When I send a DELETE request to /items/9875245.json
Then I expect HTTP code 200
#falta verificacion