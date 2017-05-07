@api_test @smoke
Feature: Smoke Test API

Scenario Outline: test
Given I have set a connection to application
When I send a GET request to <endpoint>
Then I expect HTTP code 200
Examples: 
| endpoint       |
| /user.json     |
| /projects.json |
| /filters.json  |
| /items.json    |