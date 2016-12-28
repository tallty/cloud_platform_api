json.extract! appointment, :id, :appoint_time, :company_name, :state, :range_alias, :checke_count, :created_at, :updated_at
json.appointment_items appointment.appointment_items do |item|
	json.partial! "appointment_items/appointment_item", appointment_item: item
end
json.url appointment_url(appointment, format: :json)