# == Schema Information
#
# Table name: user_infos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  nickname   :string(255)
#  address    :string(255)
#  sex        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :user_info do
    user nil
    name "MyString"
    nickname "MyString"
    address "MyString"
    sex "male"
  end
end
