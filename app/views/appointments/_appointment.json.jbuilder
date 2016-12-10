json.extract! appointment, :id, :user_id, :interface_document_id, :aasm_state, :start_time, :end_time, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)