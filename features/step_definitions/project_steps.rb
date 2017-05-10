# author: Silvia Valencia

# After method to delete the project created in the test
After ('@delete_project') do
  steps %{
    When I send a DELETE request to "/projects/" in json format 
  }
end