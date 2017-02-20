# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all 
User.create!(phone: '13813813811', password: 'qwertyuiop', 
	         password_confirmation: 'qwertyuiop',authentication_token:'qwertyuiop',
             email: '13813813811@qq.com', name: '测试联系人', company_name: '测试公司'
	         )
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
							  { name: "张三丰", user_id: 1, nickname: "上海气象下属公司", address: "上海松江区路XX号"}, 
							  { name: "张XX", user_id: 2, nickname: "上海气象下属公司XXX", address: "上海松江区XX路XX号"}
							 ])

InterfaceSort.destroy_all
interface_sorts = InterfaceSort.create!([
	{ id: 1, title: '雷达数据'},
	{ id: 2, title: '天气预报'},
	{ id: 3, title: '预警数据'},
	{ id: 4, title: '格点数据'},
	{ id: 5, title: '气象报告'},
	{ id: 6, title: '空气质量数据'},
	{ id: 7, title: '自动站数据'}
	])
InterfaceDocument.destroy_all
interface_documents = InterfaceDocument.create!([
	{ title: 'QPF雷达回波', description: '根据经纬度获取对应地区的QPF雷达回波的数据内容', api_type: 'qpfs_locate', site: 'http://61.152.122.112:8080/api/v1/qpfs/locate?', interface_sort_id: 1}, 
	 
	{ title: '世界城市预报', description: '根据城市名称获取对应城市的天气数据内容', api_type: 'world_forecasts_query', site: 'http://61.152.122.112:8080/api/v1/world_forecasts/query?' , interface_sort_id: 2},
	 
	{ title: '上海当天天气预报', description: '获取上海当天的天气预报数据内容，比如风向、风速范围、温度范围及天气情况', api_type: 'weather_forecasts_today', site: 'http://61.152.122.112:8080/api/v1/weather_forecasts/today?' , interface_sort_id: 2}, 
	{ title: '根据坐标匹配城市查询当天的天气预报', description: '根据经纬度获取对应城市的一段时间内的天气预报的数据内容', api_type: 'weather_forecasts_locate', site: 'http://61.152.122.112:8080/api/v1/weather_forecasts/locate?' , interface_sort_id: 2},
	{ title: '根据城市名称查询当天的天气预报', description: '根据城市名称获取对应城市一周的天气预报的数据内容', api_type: 'weather_forecasts_query', site: 'http://61.152.122.112:8080/api/v1/weather_forecasts/query?' , interface_sort_id: 2}, 
	  
	{ title: '上海区县预警查询', description: '上海区县预警查询', api_type: 'warnings_district', site: 'http://61.152.122.112:8080/api/v1/warnings/district?' , interface_sort_id: 3},
	{ title: '上海市实时预警查询', description: '上海市实时预警查询', api_type: 'warnings_city', site: 'http://61.152.122.112:8080/api/v1/warnings/city?' , interface_sort_id: 3}, 
	{ title: '上海社区预警查询', description: '上海社区预警查询', api_type: 'warnings_community', site: 'http://61.152.122.112:8080/api/v1/warnings/community?' , interface_sort_id: 3},
     
	{ title: '24小时格点预报', description: '24小时格点预报', api_type: 'grid_forecasts', site: 'http://61.152.122.112:8080/api/v1/grid_forecasts?' , interface_sort_id: 4}, ##
	{ title: '500米精细化实况', description: '500米精细化实况', api_type: 'grid_lives_locate', site: 'http://61.152.122.112:8080/api/v1/grid_lives/locate?' , interface_sort_id: 4},

	{ title: '短时预报查询', description: '获取上海即时的天气情况的数据内容', api_type: 'weather_reports_three_hour', site: 'http://61.152.122.112:8080/api/v1/weather_reports/three_hour?', interface_sort_id: 5}, 

	{ title: '上海空气质量实况', description: '获取上海空气质量实况', api_type: 'aqi', site: 'http://61.152.122.112:8080/api/v1/aqi?' , interface_sort_id: 6},##
	{ title: '上海空气质量预报', description: '获取上海一段时间范围的空气质量的数据内容', api_type: 'aqi_forecast', site: 'http://61.152.122.112:8080/api/v1/aqi/forecast?' , interface_sort_id: 6}, 
	{ title: '上海过去12小时空气质量实况', description: '获取上海过去12小时空气质量实况数据内容', api_type: 'aqi_history', site: 'http://61.152.122.112:8080/api/v1/aqi/history?' , interface_sort_id: 6},
	{ title: '全国空气质量实况', description: '根据经纬度获取对应城市的空气质量的数据内容', api_type: 'aqi_query', site: 'http://61.152.122.112:8080/api/v1/aqi/query?' , interface_sort_id: 6}, 

	{ title: '上海10区县主站实时数据', description: '获取上海10区县主站实时数据内容', api_type: 'auto_stations_master', site: 'http://61.152.122.112:8080/api/v1/auto_stations/master?' , interface_sort_id: 7},
	{ title: '上海自动站实时数据[10分钟间隔]', description: '获取上海自动站每10分钟间隔的实时数据', api_type: 'auto_stations', site: 'http://61.152.122.112:8080/api/v1/auto_stations?' , interface_sort_id: 7},## 
	{ title: '上海自动站实时数据[5分钟间隔]', description: '获取上海自动站每5分钟间隔的实时数据', api_type: 'stable_stations', site: 'http://61.152.122.112:8080/api/v1/stable_stations?' , interface_sort_id: 7},
	{ title: '定位城市最近小时数据', description: '根据经纬度获取对应城市最近一小时的自动站的数据内容', api_type: 'auto_stations_locate_nation_wide', site: 'http://61.152.122.112:8080/api/v1/auto_stations/locate_nation_wide?' , interface_sort_id: 7}, 
												])