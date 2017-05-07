# Author: Yesica Acha

@api_test @smoke
Feature: Smoke Test for todo.ly REST API for endpoints:
	* /user.json
	* /projects.json 
	* /items.json    
	* /filters.json
	Validates the correct status code is returned

Scenario Outline: Smoke tests for todo.ly REST API 

Given I have set a connection to application
When I send a GET request to <endpoint>
Then the HTTP status code should be 200

Examples: 
| endpoint       |
| /user.json     |
| /projects.json |
| /items.json    |
| /filters.json  |