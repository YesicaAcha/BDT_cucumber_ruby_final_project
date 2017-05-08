=begin
Authors: Marilyn Moya
         Silvia Valencia
         Yesica Acha
=end

Given (/^I have set a connection to application$/) do
  @http_connection = Rest_service.get_connection
end

When (/^I send a (PUT|POST) request to "(.*?)" with json$/) do |method, end_point, json_text|
  http_request = Rest_service.get_request(method, end_point)
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.body = json_text
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end

When (/^I send a (PUT) request to "(.*?)" with json format$/) do |method, end_point, json_text|
  http_request = Rest_service.get_request(method, end_point + JSON.parse(@last_json)["Id"].to_s + ".json")
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.body = json_text
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end

When (/^I send a (GET|DELETE) request to "(.*?)"$/) do |method, end_point|
  http_request = Rest_service.get_request(method, end_point)
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end

When (/^I send a (GET|DELETE) request to "(.*?)" in json format$/) do |method, end_point|
  http_request = Rest_service.get_request(method, end_point + JSON.parse(@last_json)["Id"].to_s + ".json")
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end


Then(/^the HTTP status code should be (\d+)$/) do |http_code|
  expect(@http_response.code).to eql(http_code)
end

Then (/^JSON should be equal to$/) do |json_text|
  expect(@last_json).to be_json_eql json_text
end
