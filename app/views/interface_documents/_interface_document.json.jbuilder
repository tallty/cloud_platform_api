json.extract! interface_document, :id, :title, :description, :site, :created_at, :updated_at
json.url interface_document_url(interface_document, format: :json)