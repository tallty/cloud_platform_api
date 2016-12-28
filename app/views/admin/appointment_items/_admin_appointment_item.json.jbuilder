json.extract! admin_appointment_item, :id, :appointment_time, :refuse_time, :company_name, :state, :range_alias, :created_at, :updated_at
json.interface_document_title admin_appointment_item.interface_document.try(:title)
# json.url admin_appointment_item_url(admin_appointment_item, format: :json)