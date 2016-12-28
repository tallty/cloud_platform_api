json.extract! appointment_item, :id, :appointment_time, :refuse_time, :company_name, :state, :range_alias, :created_at, :updated_at
json.interface_document_title appointment_item.interface_document.try(:title)
json.url appointment_item_url(appointment_item, format: :json)

json.interface_document do
  @interface_document = appointment_item.interface_document 
  json.partial! "interface_documents/interface_document", interface_document: @interface_document
end