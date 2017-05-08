=begin
Authors: Marilyn Moya
         Silvia Valencia
         Yesica Acha
=end

Given (/^I have set a connection to application$/) do
  @http_connection = Rest_service.get_connection
end

When (/^I send a (PUT|POST) request to (.*?) with json$/) do |method, end_point, json_text|
  http_request = Rest_service.get_request(method, end_point)
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.body = json_text
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
  puts "-----------------------------------------------"
  puts @last_json
  puts "-----------------------------------------------"
end

When (/^I send a (GET|DELETE) request to (.*?)$/) do |method, end_point|
  http_request = Rest_service.get_request(method, end_point)
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
  puts "-----------------------------------------------"
  puts @last_json
  puts "-----------------------------------------------"
end

Then(/^the HTTP status code should be (\d+)$/) do |http_code|
  expect(@http_response.code).to eql(http_code)
end

Then (/^JSON should be equal to$/) do |json_text|
  expect(@last_json).to be_json_eql json_text
end

# Then (/^JSON should include$/) do |json_text|
#   # expect(@last_json).to include_json(json_text).at_path(0)
#   expect(@last_json).should include_json("""{ "Content":"item_name_UPDATED" }""").at_path(0)
# end

# Then(/^JSON should include "([^"]*)" equals to "([^"]*)"$/) do |key, value|
#   expect(@last_json).to be_json_eql(%("Content")).at_path("item_name_UPDATED")
# end

Then(/^the JSON response at (.*?) should be (.*?) string value$/) do |key, expected_value|
  actual_value = Json_Manager.getJSONvalue(@last_json, key)
  expect(actual_value).to eq(expected_value)
end

Then(/^the JSON response at (.*?) should be (.*?) integer value$/) do |key, expected_value|
  actual_value = Json_Manager.getJSONvalue(@last_json, key)
  expect(actual_value).to eq(expected_value.to_i)
end

Then(/^the JSON response at (.*?) should be (.*?) boolean value$/) do |key, expected_value|
  actual_value = Json_Manager.getJSONvalue(@last_json, key)
  expect(actual_value).to eq(expected_value == "true" ? true : false)
end

Then(/^the JSON response at (.*?) should be nil value$/) do |key|
  actual_value = Json_Manager.getJSONvalue(@last_json, key)
  expect(actual_value).to eq(nil)
end