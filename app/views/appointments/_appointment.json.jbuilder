json.extract! appointment, :id, :state, :start_time, :end_time, :created_at, :updated_at
json.user_name appointment.user.user_info.try(:name)
json.interface_document_title appointment.interface_document.try(:title)
json.url appointment_url(appointment, format: :json)