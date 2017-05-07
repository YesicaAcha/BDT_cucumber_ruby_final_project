@api_test
Feature: Test API item actions

# Scenario: Get an item by ID

# Given I have set a connection to application
# When I send a GET request to /items/9874451.json
# Then the HTTP status code should be 200
#   # And JSON should include "Content" equals to "item_name_UPDATED"
# And JSON should include 
#   """       
#       {
#         "Content":"item_name_UPDATED"
#       }      
#   """

# #Scenario: Create an item

# Given I have set a connection to application
# When I send a POST request to /items.json with json
#   """       
#       {
#       	"Content":"new_item_name"
#       }      
#   """
# Then the HTTP status code should be 200
# #falta verificacion


# Scenario: Update an item

# Given I have set a connection to application
# When I send a PUT request to /items/9874451.json with json
#   """       
#       {
#       	"Content":"item_name_UPDATED"
#       }      
#   """
# Then the HTTP status code should be 200
# #falta verificacion


# Scenario: Delete an item

# Given I have set a connection to application
# When I send a DELETE request to /items/9875245.json
# Then the HTTP status code should be 200
# #falta verificacion

#-----------------------------------------------------------------
# Negative tests
#-----------------------------------------------------------------

# Scenario: Create an item with an invalid project id

# Given I have set a connection to application
# When I send a POST request to /items.json with json
#   """       
#     {
#       "Content":"wrong",
#       "ProjectId":"456",
#       "DueDate":""
#     }     
#   """
# Then the HTTP status code should be 200
#   And JSON should be equal to
#   """  
#     {
#       "ErrorMessage": "Invalid Project Id",
#       "ErrorCode": 304
#     }
#   """  
# Scenario: Update an item with an invalid Parent Item Id

# Given I have set a connection to application
# When I send a PUT request to /items/9874451.json with json
#   """       
#     {
#      "ParentId": 6666,
#     }
#   """
# Then the HTTP status code should be 200
# And JSON should be equal to
# """
#   {
#     "ErrorMessage": "Invalid Parent Item Id",
#     "ErrorCode": 303
#   }
# """