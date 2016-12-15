json.extract! appointment_item, :id, :state, :range_alias, :start_time, :end_time, :is_available,:created_at, :updated_at
json.interface_document_title appointment_item.interface_document.try(:title)
json.url appointment_item_url(appointment_item, format: :json)
