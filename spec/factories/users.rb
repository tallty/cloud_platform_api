# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  phone                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  authentication_token   :string(30)
#  appkey                 :string
#  appid                  :string
#  company_name           :string
#  name                   :string
#  email                  :string
#

FactoryGirl.define do
  factory :user do
    phone "13813813812"
    password "abcd.1234"
    sms_token "1981"
    authentication_token "qwertyuiop"

    appid "dSivOBxBRU6MJk4RY6sE" 
    appkey "FAtIStyhxtV5hH7DHECpF19XAfsYCS"

    company_name "公司名称"
    email "联系人邮箱"
    name "联系人姓名"
  end
end
