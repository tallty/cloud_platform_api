json.extract! admin_manager_api, :id, :company_name, :sign_time, :api_count, :will_count, :appid, :appkey, :created_at, :updated_at
json.apis admin_manager_api.records do |record|
	json.partial! "records/record", record: record
end
json.will_delay_apis admin_manager_api.records.will_delay do |record|
	json.partial! "records/record", record: record
end