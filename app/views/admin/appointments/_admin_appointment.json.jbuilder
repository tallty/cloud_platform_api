json.extract! admin_appointment, :id, :state, :start_time, :end_time, :created_at, :updated_at
json.user_name admin_appointment.user.user_info.try(:name)
json.interface_document_title admin_appointment.interface_document.try(:title)
json.url admin_appointment_url(admin_appointment, format: :json)