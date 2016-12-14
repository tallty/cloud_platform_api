json.extract! user_info, :id, :name, :nickname, :address, :sex_alias, :created_at, :updated_at
json.phone user_info.user.try(:phone)
json.email user_info.user.try(:email)
json.url user_info_url(user_info, format: :json)