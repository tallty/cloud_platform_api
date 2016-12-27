# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
User.create!(email: 'user@example.com', phone: '13813813811', password: 'qwertyuiop', 
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

InterfaceDocument.destroy_all
interface_documents = InterfaceDocument.create!([
												 { title: '气象云', description: '气象云接口...' }, 
												 { title: '气象云XX', description: '气象云接口XX...' }
												])

UserInfo.destroy_all
user_infos = UserInfo.create!([
							  { name: "张三丰", user_id: 1, nickname: "上海气象下属公司", address: "上海松江区XX路XX号", sex: "male" }, 
							  { name: "张XX", user_id: 2, nickname: "上海气象下属公司XXX", address: "上海松江区XX路XX号", sex: "male"  }
							 ])

