# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all 
User.create!(phone: '13813813811', password: 'qwertyuiop', 
	         password_confirmation: 'qwertyuiop',authentication_token:'qwertyuiop')
Admin.destroy_all
Admin.create!(email: 'admin@example.com', password: 'password', 
	          password_confirmation: 'password', authentication_token:'qwertyuiop1')

Appointment.destroy_all
appointments = Appointment.create!([
									{ range: 'one_month', user_id: 1 }, 
									{ range: 'one_year', user_id: 1 }

								   ])
AppointmentItem.destroy_all
appointment_items = AppointmentItem.create!([
											  { appointment_id: 1, interface_document_id: 1 ,range: 'one_month',}, 
											  { interface_document_id: 1, appointment_id: 1 ,range: 'two_month',}
											 ])

StatisInfo.destroy_all
statis_infos = StatisInfo.create!([
								   { user_id: 1, interface_document_id: 1 }, 
								   { interface_document_id: 1, user_id: 1 }
								  ])

UserInfo.destroy_all
user_infos = UserInfo.create!([
							  { name: "张三丰", user_id: 1, nickname: "上海气象下属公司", address: "上海松江区路XX号", sex: "male" }, 
							  { name: "张XX", user_id: 2, nickname: "上海气象下属公司XXX", address: "上海松江区XX路XX号", sex: "male"  }
							 ])

InterfaceDocument.destroy_all
interface_documents = InterfaceDocument.create!([
	 { title: 'QPF雷达回波', description: 'QPF', site: 'http://61.152.122.112:8080/api/v1/qpfs/locate?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=121.834&lat=30.123' }, 
	 
	 { title: '世界城市预报', description: '世界城市预报', site: 'http://61.152.122.112:8080/api/v1/world_forecasts/query?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&city_name=%E4%B8%9C%E4%BA%AC' },
	 
	 { title: '天气预报', description: '上海当天天气预报', site: 'http://61.152.122.112:8080/api/v1/weather_forecasts/today?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe' }, 
	 { title: '天气预报', description: '根据坐标匹配城市查询', site: 'http://61.152.122.112:8080/api/v1/weather_forecasts/locate?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=115.834&lat=28.123' },
	 { title: '天气预报', description: '根据城市名称查询', site: 'http://61.152.122.112:8080/api/v1/weather_forecasts/query?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&city_name=%E5%8C%97%E4%BA%AC' }, 
	 
	 { title: '天气预警', description: '上海区县预警查询', site: 'http://61.152.122.112:8080/api/v1/warnings/district?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&unit=%E9%87%91%E5%B1%B1' },
	 { title: '天气预警', description: '上海市实时预警查询', site: 'http://61.152.122.112:8080/api/v1/warnings/city?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe' }, 
	 { title: '天气预警', description: '上海社区预警查询', site: 'http://61.152.122.112:8080/api/v1/warnings/community?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&unit=%E4%BA%94%E8%A7%92%E5%9C%BA%E8%A1%97%E9%81%93' },
     
	 { title: '格点数据', description: '24小时格点预报', site: 'http://61.152.122.112:8080/api/v1/grid_forecasts?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=121.834&lat=32.123' }, ##
	 { title: '格点数据', description: '500米精细化实况', site: 'http://61.152.122.112:8080/api/v1/grid_lives/locate?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=121.834&lat=31.123' },

	 { title: '气象报告', description: '短时预报查询', site: 'http://61.152.122.112:8080/api/v1/weather_reports/three_hour?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe'}, 

	 { title: '空气质量数据', description: '上海空气质量实况', site: 'http://61.152.122.112:8080/api/v1/aqi?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe' },##
	 { title: '空气质量数据', description: '上海空气质量预报', site: 'http://61.152.122.112:8080/api/v1/aqi/forecast?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe' }, 
	 { title: '空气质量数据', description: '上海过去12小时空气质量实况', site: 'http://61.152.122.112:8080/api/v1/aqi/history?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe' },
	 { title: '空气质量数据', description: '全国空气质量实况', site: 'http://61.152.122.112:8080/api/v1/aqi/query?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&city_name=%E5%8C%97%E4%BA%AC' }, 

	 { title: '自动站', description: '上海10区县主站实时数据', site: 'http://61.152.122.112:8080/api/v1/auto_stations/master?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe' },
	 { title: '自动站', description: '上海自动站实时数据[10分钟间隔]', site: 'http://61.152.122.112:8080/api/v1/auto_stations?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe' },## 
	 { title: '自动站', description: '上海自动站实时数据[5分钟间隔]', site: 'http://61.152.122.112:8080/api/v1/stable_stations?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe' },
	 { title: '气象云', description: '定位城市最近小时数据', site: 'http://61.152.122.112:8080/api/v1/auto_stations/locate_nation_wide?appid=bFLKk0uV7IZvzcBoWJ1j&appkey=mXwnhDkYIG6S9iOyqsAW7vPVQ5ZxBe&lon=115.2342&lat=32.234' }, 
												])