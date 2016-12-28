json.extract! user_info, :id, :name, :nickname, :address, :email, :created_at, :updated_at
json.phone user_info.user.try(:phone)
json.appid user_info.user.try(:appid)
json.appkey user_info.user.try(:appkey)
json.url user_info_url(user_info, format: :json)