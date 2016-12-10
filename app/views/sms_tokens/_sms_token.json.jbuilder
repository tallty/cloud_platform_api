json.extract! sms_token, :id, :phone, :token, :created_at, :updated_at
json.url sms_token_url(sms_token, format: :json)