# author: Yesica Acha

When (/^I (?:send|sent) a (POST) request to "(.*?)" to create a new user with json$/) do |method, end_point, json_text|
  
  # Parse json to get fullname and username to save it in user class
  parsed_json = JSON.parse(json_text)

  # Set email and password in the new user
  $app_user = parsed_json["Email"]
  $app_pass = parsed_json["Password"]
  
  http_request = Rest_service.get_request(method, end_point)
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.body = json_text
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end


# After method to delete a user created for the test
After ('@delete_user') do
  steps %{
    When I send a DELETE request to "/user/0.json"
  }

  configuration = load_app_config_file('env.yml')

   # Reset configuration parameters
  $app_user = configuration['app']['admin_user']
  $app_pass = configuration['app']['admin_pass']

end
