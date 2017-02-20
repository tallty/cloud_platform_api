json.extract! admin_appointment, :id, :appoint_time, :company_name, :state, :range_alias, :checke_count, :created_at, :updated_at
json.user admin_appointment.user, :id, :company_name, :phone, :email, :appid 
json.appointment_items admin_appointment.appointment_items do |item|
	json.partial! "admin/appointment_items/admin_appointment_item", admin_appointment_item:  item
end
json.url admin_appointment_url(admin_appointment, format: :json)