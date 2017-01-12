class DataJson
	def self.get 
		require 'uri'
		require 'net/http'
		require 'net/https' 
	    require 'json'  
	    response = Net::HTTP.get_response(URI('http://139.196.38.11:5555/adviser_api.json')) 
	    date = JSON.parse(response.body.force_encoding("UTF-8"))['apis'][0]['requests']
	    puts "**********""#{date}"

	end
end