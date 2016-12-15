json.extract! admin_appointment_item, :id, :state, :range_alias, :start_time, :end_time, :is_available,:created_at, :updated_at
# json.interface_document_title admin_appointment_item.interface_document.try(:title)
# json.url admin_appointment_item_url(admin_appointment_item, format: :json)

json.interface_document do
  @interface_document = admin_appointment_item.interface_document
  json.partial! "interface_documents/interface_document", interface_document: @interface_document
end