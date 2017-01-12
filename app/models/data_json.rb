class DataJson
	#指导接口详情
    def self.get_details(url)
    	require 'uri'
		require 'net/http'
		require 'net/https' 
	    require 'json' 
	    url = "http://139.196.38.11:5555/date_api/" + "#{url}"
	    url1 = url.strip.force_encoding("UTF-8")
	    response = Net::HTTP.get_response(URI(url1)) #RestClient.get(url1)
	    JSON.parse(response.body.force_encoding("UTF-8"))
    end

    #指导接口列表
    def self.get_list
    	# require 'uri'
		# require 'net/http'
		# require 'net/https' 
	    # require 'json' 
	    response = Net::HTTP.get_response(URI('http://139.196.38.11:5555/date_api/index.json')) 
	    JSON.parse(response.body.force_encoding("UTF-8"))
    end

	# def self.get
	# 	require 'uri'
	# 	require 'net/http'
	# 	require 'net/https' 
	#     require 'json'  
	#     response = Net::HTTP.get_response(URI('http://139.196.38.11:5555/adviser_api.json')) 
	#     date = JSON.parse(response.body.force_encoding("UTF-8"))['apis'][0]['requests']
	#     puts "**********""#{date}"

	# end
end