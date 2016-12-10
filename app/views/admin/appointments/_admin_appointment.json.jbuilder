json.extract! admin_appointment, :id, :user_id, :interface_document_id, :aasm_state, :start_time, :end_time, :created_at, :updated_at
# json.user_name admin_appointment.user.try(:name)
json.interface_document_title admin_appointment.interface_document.try(:title)
json.url admin_appointment_url(admin_appointment, format: :json)