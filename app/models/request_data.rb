class RequestData
	#请求气象数据
	def self.get_data(params, interface)
    appid = "bFLKk0uV7IZvzcBoWJ1j"
    appkey = "mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe"
    url = "#{interface.site}appid=#{appid}&appkey=#{appkey}"
    params.each do |key, value| 
      # url << "&" << key << "=" << value if key == "lon" || key == "lat" || key == "city_name" || key == "unit"
      url << "&" << key << "=" << value if  key.in?(["lon", "lat", "city_name", "unit"]) && value.blank?.!
    end
    @api_dates = DataJson.get_data(url) 
	end

  #创建统计信息
	def self.create_statis_info(interface, user_id)
		interface.update(frequency: interface.frequency + 1) #记录访问次数
    # interface.ceate_statis_info(user_id, interface.id)#创建统计信息
	end
end