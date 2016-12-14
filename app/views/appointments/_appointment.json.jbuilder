json.extract! appointment, :id, :state, :range_alias, :start_time, :end_time, :is_available, :created_at, :updated_at
json.user_name appointment.user.user_info.try(:name)
json.appointment_items appointment.appointment_items do |item|
	json.partial! "appointment_items/appointment_item", appointment_item: item
end
json.url appointment_url(appointment, format: :json)