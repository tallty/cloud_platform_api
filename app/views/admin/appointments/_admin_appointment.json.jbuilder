json.extract! admin_appointment, :id, :state, :range_alias, :start_time, :end_time, :created_at, :updated_at
json.user_name admin_appointment.user.user_info.try(:name)
json.appointment_items admin_appointment.appointment_items do |item|
	json.partial! "admin/appointment_items/admin_appointment_item", admin_appointment_item:  item
end
json.url admin_appointment_url(admin_appointment, format: :json)