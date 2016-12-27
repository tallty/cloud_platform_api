json.extract! record, :id, :range_alias, :start_time, :end_time, :created_at, :updated_at
json.user_name record.user.try(:nickname)
json.document record.interface_document.try(:title)
json.url record_url(record, format: :json)