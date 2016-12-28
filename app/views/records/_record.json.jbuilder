json.extract! record, :id, :range_alias, :start_time, :end_time, :state, :created_at, :updated_at
json.document record.interface_document.try(:title)
json.url record_url(record, format: :json)


json.interface_document do
  @interface_document = record.interface_document 
  json.partial! "interface_documents/interface_document", interface_document: @interface_document
end