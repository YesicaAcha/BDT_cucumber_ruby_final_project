#Add the library for HTTP
require 'net/http'

module Rest_service
  HTTP_TIMEOUT_FOR_RESPONSE = 180
  
  #
  # This method set up a connection 
  #
  def Rest_service.get_connection
      http_connection = nil
      http_connection = Net::HTTP.new($app_host)      
      http_connection.read_timeout = HTTP_TIMEOUT_FOR_RESPONSE
      return http_connection
  end

  #
  # Gets a request based on the method and the url sent as parameters
  # method: POST, PUT, DELETE or GET
  # url : e.g. '/users', '/projects'
  #
  def Rest_service.get_request(method, url)
    request = nil   
    url =  $app_root + url
   
    case method
      when "POST"
        request = Net::HTTP::Post.new(url)
      when "PUT"
        request = Net::HTTP::Put.new(url)
      when "DELETE"
        request = Net::HTTP::Delete.new(url)
      when "GET"
        request = Net::HTTP::Get.new(url)
    end

   request.basic_auth($app_user,$app_pass)  
   return request
  end

  #
  # Executes the request
  # Return que se creo para el http connection y http request
  #
  def Rest_service.execute_request(http_connection, http_request)
    http_response = http_connection.request(http_request)
    return http_response
  end

end