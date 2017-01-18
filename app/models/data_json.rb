class DataJson
	#指导接口详情
	def self.get_details(url)
		require 'uri'
		require 'net/http'
		require 'net/https' 
	    require 'json' 
	    url ="http://139.196.38.11:5555/date_api/" + "#{url}"
	    response = Net::HTTP.get_response(URI(URI.escape(url))) #RestClient.get(url1)
	    JSON.parse(response.body.force_encoding("UTF-8"))
	end

	#指导接口列表
	def self.get_list
		require 'uri'
		require 'net/http'
		require 'net/https' 
	    require 'json' 
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

	def self.get_data(url)
		require 'uri'
		require 'net/http'
		require 'net/https' 
	  require 'json' 
	   #  date = [
    #     'QPF雷达回波'/ 'QPF'
    #     'http://61.152.122.112:8080/api/v1/qpfs/locate?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=121.834&lat=30.123', 
    #     #'世界城市预报'/'世界城市预报'
		  #   'http://61.152.122.112:8080/api/v1/world_forecasts/query?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&city_name=%E4%B8%9C%E4%BA%AC',
			 #  #'天气预报'/上海当天天气预报 and 根据坐标匹配城市查询 and 根据城市名称查询
			 #  'http://61.152.122.112:8080/api/v1/weather_forecasts/today?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe', 
			 #  'http://61.152.122.112:8080/api/v1/weather_forecasts/locate?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=115.834&lat=28.123',
			 #  'http://61.152.122.112:8080/api/v1/weather_forecasts/query?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&city_name=%E5%8C%97%E4%BA%AC', 
			 #  #'天气预警'/上海区县预警查询 and 上海市实时预警查询 and 上海社区预警查询
			 #  'http://61.152.122.112:8080/api/v1/warnings/district?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&unit=%E9%87%91%E5%B1%B1',
			 #  'http://61.152.122.112:8080/api/v1/warnings/city?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe', 
			 #  'http://61.152.122.112:8080/api/v1/warnings/community?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&unit=%E4%BA%94%E8%A7%92%E5%9C%BA%E8%A1%97%E9%81%93',
	   #       #'格点数据'/24小时格点预报 and 500米精细化实况 
			 #  'http://61.152.122.112:8080/api/v1/grid_forecasts?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=121.834&lat=32.123', ##
			 #  'http://61.152.122.112:8080/api/v1/grid_lives/locate?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=121.834&lat=31.123',
    #      #'气象报告'/'短时预报查询'
	   #   'http://61.152.122.112:8080/api/v1/weather_reports/three_hour?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe', 
	   #       #'空气质量数据'/上海空气质量实况 and 上海空气质量预报 and 上海过去12小时空气质量实况 and 全国空气质量实况
	   #   'http://61.152.122.112:8080/api/v1/aqi?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe',##
	   #   'http://61.152.122.112:8080/api/v1/aqi/forecast?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe', 
	   #   'http://61.152.122.112:8080/api/v1/aqi/history?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe',
	   #   'http://61.152.122.112:8080/api/v1/aqi/query?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&city_name=%E5%8C%97%E4%BA%AC', 
    #        #'自动站'/上海10区县主站实时数据 and 上海自动站实时数据[10分钟间隔] and 上海自动站实时数据[5分钟间隔] and 定位城市最近小时数据
		  #  'http://61.152.122.112:8080/api/v1/auto_stations/master?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe',
		  #  'http://61.152.122.112:8080/api/v1/auto_stations?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe',## 
		  #  'http://61.152.122.112:8080/api/v1/stable_stations?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe',
		  #  'http://61.152.122.112:8080/api/v1/auto_stations/locate_nation_wide?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=115.2342&lat=32.234', 
				# ]
    response = Net::HTTP.get_response(URI(URI.escape(url))) #RestClient.get(url1)
    JSON.parse(response.body.force_encoding("UTF-8"))
	end
end