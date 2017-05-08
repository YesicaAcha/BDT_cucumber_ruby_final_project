require 'json'

module Json_Manager
	def Json_Manager.getJSONvalue (json_text, key)
	      json = JSON.parse json_text
	      return json[key]
	end
end