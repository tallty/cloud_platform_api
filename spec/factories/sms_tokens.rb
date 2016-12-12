# == Schema Information
#
# Table name: sms_tokens
#
#  id         :integer          not null, primary key
#  phone      :string(255)
#  token      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :sms_token do
    phone "13813813811"
    token "123456"
  end
end
